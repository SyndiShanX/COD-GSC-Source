/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility.gsc
***********************************************/

_id_F0D6ACF93C15BD59() {
  if(isDefined(level._id_CD43EAFB24E2F684))
    return level._id_CD43EAFB24E2F684;

  return 1;
}

_giveweapon(weapon, _id_6794F7417ED0B5A2, _id_D509F41064F6C716, _id_2E5C1E9548E8884F) {
  return scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, _id_6794F7417ED0B5A2, _id_D509F41064F6C716, _id_2E5C1E9548E8884F);
}

setplayerstunned() {
  if(!isDefined(self.isstunned))
    self.isstunned = 1;
  else
    self.isstunned++;
}

setplayerunstunned() {
  self.isstunned--;
}

updatelaststandpistol(weapon) {
  if(isDefined(weapon)) {
    if(isDefined(level.last_stand_weapons)) {
      _id_491C4CC064C4F659 = getweaponbasename(weapon);

      if(scripts\engine\utility::array_contains(level.last_stand_weapons, _id_491C4CC064C4F659)) {
        self.last_stand_pistol = weapon;
        return;
      }
    }
  }

  allweapons = self getweaponslistall();
  _id_AC68B11337BD07EA = 0;

  if(isDefined(self.last_stand_pistol)) {
    _id_76FE5895A904870E = getweaponbasename(self.last_stand_pistol);

    foreach(_id_0EB7F4869595F550 in allweapons) {
      baseweapon = getweaponbasename(_id_0EB7F4869595F550);

      if(baseweapon == _id_76FE5895A904870E) {
        _id_AC68B11337BD07EA = 1;
        return;
      }
    }
  }

  if(!_id_AC68B11337BD07EA) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(_id_0EB7F4869595F550 in allweapons) {
        baseweapon = getweaponbasename(_id_0EB7F4869595F550);

        for(_id_AC0E594AC96AA3A8 = level.last_stand_weapons.size - 1; _id_AC0E594AC96AA3A8 > -1; _id_AC0E594AC96AA3A8--) {
          if(baseweapon == level.last_stand_weapons[_id_AC0E594AC96AA3A8]) {
            _id_AC68B11337BD07EA = 1;
            self.last_stand_pistol = _id_0EB7F4869595F550;
            return;
          }
        }
      }
    }

    _id_EA6BEFBE838B7BE0 = getrawbaseweaponname(self.default_starting_pistol);

    if(isDefined(self.weapon_build_models) && isDefined(self.weapon_build_models[_id_EA6BEFBE838B7BE0]))
      self.last_stand_pistol = makeweaponfromstring(self.weapon_build_models[_id_EA6BEFBE838B7BE0]);
    else
      self.last_stand_pistol = self.default_starting_pistol;
  }
}

giveperk(perkname) {
  if(issubstr(perkname, "specialty_weapon_")) {
    _setperk(perkname);
    return;
  }

  _setperk(perkname);
  _setextraperks(perkname);
}

_hasperk(perkname) {
  perks = self.perks;

  if(!isDefined(perks))
    return 0;

  if(isDefined(perks[perkname]))
    return 1;

  return 0;
}

takeperk(perkname) {
  if(issubstr(perkname, "specialty_weapon_")) {
    _unsetperk(perkname);
    return;
  }

  _unsetperk(perkname);
  _unsetextraperks(perkname);
}

_setperk(perkname) {
  self.perks[perkname] = 1;
  self.perksperkname[perkname] = perkname;
  _id_2E61A6A3A9244975 = level.perksetfuncs[perkname];

  if(isDefined(_id_2E61A6A3A9244975))
    self thread[[_id_2E61A6A3A9244975]]();

  self setperk(perkname, !isDefined(level.scriptperks[perkname]));
}

_setextraperks(perkname) {
  if(isDefined(level.extraperkmap[perkname])) {
    foreach(_id_43596460393338E5 in level.extraperkmap[perkname]) {
      _setperk(_id_43596460393338E5);
      _setextraperks(_id_43596460393338E5);
    }
  }
}

_unsetperk(perkname) {
  self.perks[perkname] = undefined;
  self.perksperkname[perkname] = undefined;

  if(isDefined(level.perkunsetfuncs[perkname]))
    self thread[[level.perkunsetfuncs[perkname]]]();

  self unsetperk(perkname, !isDefined(level.scriptperks[perkname]));
}

_unsetextraperks(perkname) {
  if(isDefined(level.extraperkmap[perkname])) {
    foreach(_id_43596460393338E5 in level.extraperkmap[perkname]) {
      _unsetperk(_id_43596460393338E5);
      _unsetextraperks(_id_43596460393338E5);
    }
  }
}

_clearperks() {
  foreach(perkname, _id_C9FBB2A46AE3886E in self.perks) {
    if(isDefined(level.perkunsetfuncs[perkname]))
      self[[level.perkunsetfuncs[perkname]]]();
  }

  self.perks = [];
  self.perksperkname = [];
  self clearperks();
}

_id_5A3FEF8CB39336B8(perkref) {
  self setclientomnvar("ui_perk_activation", perkref);
  self setclientomnvar("ui_perk_activation_notify", gettime());
}

clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.lowermessages.size; _id_AC0E594AC96AA3A8++)
      self.lowermessages[_id_AC0E594AC96AA3A8] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

setlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  if(!isDefined(priority))
    priority = 1;

  if(!isDefined(time))
    time = 0;

  if(!isDefined(showtimer))
    showtimer = 0;

  if(!isDefined(shouldfade))
    shouldfade = 0;

  if(!isDefined(fadetoalpha))
    fadetoalpha = 0.85;

  if(!isDefined(fadetoalphatime))
    fadetoalphatime = 3.0;

  if(!isDefined(hidewhenindemo))
    hidewhenindemo = 0;

  if(!isDefined(hidewheninmenu))
    hidewheninmenu = 1;

  addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu);
  updatelowermessage();
}

updatelowermessage() {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  message = getlowermessage();

  if(!isDefined(message)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage settext("");

      if(isDefined(self.lowertimer))
        self.lowertimer.alpha = 0;
    }
  } else {
    if(!isDefined(self.lowermessage)) {
      return;
    }
    self.lowermessage settext(message.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = message.hidewhenindemo;
    self.lowermessage.hidewheninmenu = message.hidewheninmenu;

    if(message.shouldfade) {
      self.lowermessage fadeovertime(min(message.fadetoalphatime, 60));
      self.lowermessage.alpha = message.fadetoalpha;
    }

    if(message.time > 0 && message.showtimer)
      self.lowertimer settimer(max(message.time - (gettime() - message.addtime) / 1000, 0.1));
    else {
      if(message.time > 0 && !message.showtimer) {
        self.lowertimer settext("");
        self.lowermessage fadeovertime(min(message.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(message);
        thread clearafterfade(message);
        return;
      }

      self.lowertimer settext("");
    }
  }
}

addlowermessage(name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu) {
  _id_28B0F661494FA67C = undefined;

  foreach(message in self.lowermessages) {
    if(message.name == name) {
      if(message.text == text && message.priority == priority) {
        return;
      }
      _id_28B0F661494FA67C = message;
      break;
    }
  }

  if(!isDefined(_id_28B0F661494FA67C)) {
    _id_28B0F661494FA67C = spawnStruct();
    self.lowermessages[self.lowermessages.size] = _id_28B0F661494FA67C;
  }

  _id_28B0F661494FA67C.name = name;
  _id_28B0F661494FA67C.text = text;
  _id_28B0F661494FA67C.time = time;
  _id_28B0F661494FA67C.addtime = gettime();
  _id_28B0F661494FA67C.priority = priority;
  _id_28B0F661494FA67C.showtimer = showtimer;
  _id_28B0F661494FA67C.shouldfade = shouldfade;
  _id_28B0F661494FA67C.fadetoalpha = fadetoalpha;
  _id_28B0F661494FA67C.fadetoalphatime = fadetoalphatime;
  _id_28B0F661494FA67C.hidewhenindemo = hidewhenindemo;
  _id_28B0F661494FA67C.hidewheninmenu = hidewheninmenu;
  sortlowermessages();
}

sortlowermessages() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self.lowermessages.size; _id_AC0E594AC96AA3A8++) {
    message = self.lowermessages[_id_AC0E594AC96AA3A8];
    priority = message.priority;

    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && priority > self.lowermessages[_id_AC0E5C4AC96AAA41].priority; _id_AC0E5C4AC96AAA41--)
      self.lowermessages[_id_AC0E5C4AC96AAA41 + 1] = self.lowermessages[_id_AC0E5C4AC96AAA41];

    self.lowermessages[_id_AC0E5C4AC96AAA41 + 1] = message;
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages))
    return undefined;

  return self.lowermessages[0];
}

clearondeath(message) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(message.name);
}

clearafterfade(message) {
  wait(message.time);
  clearlowermessage(message.name);
  self notify("message_cleared");
}

clearlowermessage(name) {
  removelowermessage(name);
  updatelowermessage();
}

removelowermessage(name) {
  if(isDefined(self.lowermessages)) {
    for(_id_AC0E594AC96AA3A8 = self.lowermessages.size; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
      if(self.lowermessages[_id_AC0E594AC96AA3A8 - 1].name != name) {
        continue;
      }
      message = self.lowermessages[_id_AC0E594AC96AA3A8 - 1];

      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41 < self.lowermessages.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(self.lowermessages[_id_AC0E5C4AC96AAA41]))
          self.lowermessages[_id_AC0E5C4AC96AAA41 - 1] = self.lowermessages[_id_AC0E5C4AC96AAA41];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

freezecontrolswrapper(frozen) {
  if(istrue(self._id_E5E63A2028402D60)) {
    return;
  }
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(frozen);
  self.controlsfrozen = frozen;
}

setthirdpersondof(_id_E60552DD6ABCC4AA) {
  if(_id_E60552DD6ABCC4AA)
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  else
    self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setusingremote(_id_7B0C72F7301EB1C4) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = _id_7B0C72F7301EB1C4;
  _id_3B64EB40368C1450::set("remote", "offhand_weapons", 0);
  self notify("using_remote");
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

updatesessionstate(sessionstate, statusicon) {
  self.sessionstate = sessionstate;

  if(!isDefined(statusicon))
    statusicon = "";

  self.statusicon = statusicon;
  self setclientomnvar("ui_session_state", sessionstate);
}

getuniqueid() {
  if(isDefined(self.pers["guid"]))
    return self.pers["guid"];

  _id_14EF0ACE56787531 = self getguid();

  if(_id_14EF0ACE56787531 == "0000000000000000") {
    if(isDefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    _id_14EF0ACE56787531 = "script" + level.guidgen;
  }

  self.pers["guid"] = _id_14EF0ACE56787531;
  return self.pers["guid"];
}

gameflagset(flagname) {
  game["flags"][flagname] = 1;
  level notify(flagname);
}

gameflaginit(flagname, _id_E60552DD6ABCC4AA) {
  game["flags"][flagname] = _id_E60552DD6ABCC4AA;
}

gameflag(flagname) {
  return game["flags"][flagname];
}

gameflagwait(flagname) {
  while(!gameflag(flagname))
    level waittill(flagname);
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

initlevelflags() {
  if(!isDefined(level.levelflags))
    level.levelflags = [];
}

initgameflags() {
  if(!isDefined(game["flags"]))
    game["flags"] = [];
}

isenemy(other) {
  if(level.teambased)
    return isplayeronenemyteam(other);
  else
    return isplayerffaenemy(other);
}

isplayeronenemyteam(other) {
  return other.team != self.team;
}

isplayerffaenemy(other) {
  if(isDefined(other.owner))
    return other.owner != self;
  else
    return other != self;
}

isgameplayteam(team) {
  return isDefined(team) && scripts\engine\utility::array_contains(level.teamnamelist, team);
}

notusableforjoiningplayers(owner) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");
  owner endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", player);

    if(isDefined(player) && player != owner)
      self disableplayeruse(player);
  }
}

setselfusable(caller) {
  self makeusable();

  foreach(player in level.players) {
    if(player != caller) {
      self disableplayeruse(player);
      continue;
    }

    self enableplayeruse(player);
  }
}

isenvironmentweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isweapon(weapon)) {
    if(weapon.basename == "turret_minigun_mp")
      return 1;
    else
      return 0;
  }

  if(weapon == "turret_minigun_mp")
    return 1;

  return 0;
}

issuperweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = getcompleteweaponname(weapon);
  else
    weaponname = weapon;

  if(isDefined(level.superweapons) && isDefined(level.superweapons[weaponname]))
    return 1;

  return 0;
}

strip_suffix(_id_A3C267C12168AE42, _id_7C7C8BEF8B9787B0) {
  if(_id_A3C267C12168AE42.size <= _id_7C7C8BEF8B9787B0.size)
    return _id_A3C267C12168AE42;

  if(getsubstr(_id_A3C267C12168AE42, _id_A3C267C12168AE42.size - _id_7C7C8BEF8B9787B0.size, _id_A3C267C12168AE42.size) == _id_7C7C8BEF8B9787B0)
    return getsubstr(_id_A3C267C12168AE42, 0, _id_A3C267C12168AE42.size - _id_7C7C8BEF8B9787B0.size);

  return _id_A3C267C12168AE42;
}

delayentdelete(time) {
  self endon("death");
  wait(time);

  if(isDefined(self))
    self delete();
}

deleteonplayerdeathdisconnect(player) {
  self endon("death");
  player scripts\engine\utility::waittill_any_2("death", "disconnect");
  self delete();
}

isstrstart(string, _id_DE8A45DD2BF968EC) {
  return getsubstr(string, 0, _id_DE8A45DD2BF968EC.size) == _id_DE8A45DD2BF968EC;
}

getbaseweaponname(weapon) {
  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  index = 0;

  if(_id_67F14F8315CB0F2F[0] == "alt")
    index++;

  if(_id_67F14F8315CB0F2F[index] == "iw7")
    weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1];
  else if(_id_67F14F8315CB0F2F[index] == "iw8") {
    _id_C0BB28E7846054F1 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la"];

    if(scripts\engine\utility::array_contains(_id_C0BB28E7846054F1, _id_67F14F8315CB0F2F[index + 1]))
      weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2];
    else
      weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1];
  }

  return weaponname;
}

is_weapon_purchase_disabled() {
  return istrue(level.weapon_purchase_disabled);
}

getrawbaseweaponname(weapon) {
  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  _id_67F14F8315CB0F2F = strtok(weaponname, "_");

  if(_id_67F14F8315CB0F2F[0] == "iw5" || _id_67F14F8315CB0F2F[0] == "iw6" || _id_67F14F8315CB0F2F[0] == "iw7")
    weaponname = _id_67F14F8315CB0F2F[1];
  else if(_id_67F14F8315CB0F2F[0] == "alt")
    weaponname = _id_67F14F8315CB0F2F[2];

  return weaponname;
}

getintproperty(dvar, _id_628828A6D842B1B9) {
  value = _id_628828A6D842B1B9;
  value = getdvarint(dvar, _id_628828A6D842B1B9);
  return value;
}

touchingbadtrigger() {
  _id_62A9E105632784D0 = getEntArray("trigger_hurt", "classname");

  foreach(trigger in _id_62A9E105632784D0) {
    if(self istouching(trigger))
      return 1;
  }

  radtriggers = getEntArray("radiation", "targetname");

  foreach(trigger in radtriggers) {
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

_id_496139DD736902CC(struct) {
  if(!isDefined(self))
    return 0;

  if(!isDefined(struct) || !isDefined(struct.radius) || !isDefined(struct.height))
    return 0;

  if(distance2d(self.origin, struct.origin) <= float(struct.radius)) {
    if(self.origin[2] >= struct.origin[2] && self.origin[2] <= struct.origin[2] + float(struct.height))
      return 1;
  }

  return 0;
}

playsoundinspace(alias, origin, wait_until_done) {
  if(isDefined(alias)) {
    if(isarray(alias))
      alias = scripts\engine\utility::random(alias);

    timer = lookupsoundlength(alias);
    playsoundatpos(origin, alias);

    if(isDefined(wait_until_done))
      wait(timer / 1000);

    return timer;
  }
}

playdeathsound() {
  _id_00AE14C5A8B1B582 = randomintrange(1, 8);
  type = "generic";

  if(self hasfemalecustomizationmodel())
    type = "female";

  if(self.team == "axis") {
    sound = type + "_death_russian_" + _id_00AE14C5A8B1B582;

    if(soundexists(sound))
      self playSound(sound);
  } else {
    sound = type + "_death_american_" + _id_00AE14C5A8B1B582;

    if(soundexists(sound))
      self playSound(sound);
  }
}

isfmjdamage(sweapon, smeansofdeath, attacker) {
  return isDefined(attacker) && attacker _hasperk("specialty_armorpiercing") && isDefined(smeansofdeath) && scripts\engine\utility::isbulletdamage(smeansofdeath);
}

getattachmenttype(_id_659F734FC2A248FF) {
  if(!isDefined(_id_659F734FC2A248FF))
    return "none";

  _id_F98BAFD67872A38C = tablelookup("mp/attachmenttable.csv", 4, _id_659F734FC2A248FF, 2);

  if(!isDefined(_id_F98BAFD67872A38C) || isDefined(_id_F98BAFD67872A38C) && _id_F98BAFD67872A38C == "") {
    gametype = getDvar("g_gametype");

    if(gametype == "zombie")
      _id_F98BAFD67872A38C = tablelookup("cp/zombies/zombie_attachmentTable.csv", 4, _id_659F734FC2A248FF, 2);
  }

  return _id_F98BAFD67872A38C;
}

weaponhasattachment(weaponname, _id_659F734FC2A248FF) {
  weaponattachments = getweaponattachments(weaponname);

  foreach(attachment in weaponattachments) {
    if(attachment == _id_659F734FC2A248FF)
      return 1;
  }

  return 0;
}

_id_8A4F25FB9D4C43C8(weapon) {
  if(!isDefined(weapon))
    return 0;

  group = _id_74502A9E0EF1F19C::getweapongroup(weapon);

  switch (group) {
    case "weapon_shotgun":
      if(weapon.basename == "iw9_sh_mviktor_mp")
        return 1;
      else
        return 0;
    case "weapon_melee2":
    case "weapon_melee":
    case "weapon_projectile":
      return 0;
  }

  if(isDefined(weapon.basename)) {
    switch (weapon.basename) {
      case "iw9_pi_swhiskey_mp":
      case "iw9_dm_sbeta_mp":
      case "iw9_la_mike32_mp":
      case "iw9_lm_dblmg_mp":
      case "iw9_dm_crossbow_mp":
        return 0;
    }
  }

  return 1;
}

isjuggernaut() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut")
    return 1;

  if(isDefined(self.aitype) && self.aitype == "juggernaut")
    return 1;

  if(isDefined(self.agent_type) && (self.agent_type == "actor_enemy_cp_jugg_aq" || self.agent_type == "actor_enemy_cp_jugg_cartel"))
    return 1;

  if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1)
    return 1;

  if(isDefined(self.isjuggernautdef) && self.isjuggernautdef == 1)
    return 1;

  if(isDefined(self.isjuggernautgl) && self.isjuggernautgl == 1)
    return 1;

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
    return 1;

  if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
    return 1;

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1)
    return 1;

  return 0;
}

allowridekillstreakplayerexit(_id_F275B3AFD12201BC, _id_A5884F86B119535E) {
  if(isDefined(_id_F275B3AFD12201BC))
    self endon(_id_F275B3AFD12201BC);

  if(isDefined(_id_A5884F86B119535E))
    owner = self;
  else {
    if(!isDefined(self.owner)) {
      return;
    }
    owner = self.owner;
  }

  level endon("game_ended");
  owner endon("disconnect");
  owner endon("end_remote");
  owner notify("watch_use_exit");
  owner endon("diable_use_exit");
  self endon("death");
  thread allow_force_player_exit();

  if(!isDefined(level.framedurationseconds))
    level.framedurationseconds = level.frameduration / 1000;

  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  holdtime = 3;
  _id_6A16936225A5A8CE = 1;

  for(;;) {
    _id_23B90B34FECC58CD = 0;

    if(_id_6A16936225A5A8CE == 1) {
      owner setclientomnvar("ui_exit_progress", 0);
      _id_6A16936225A5A8CE = 0;
    }

    while(owner useButtonPressed() && !istrue(owner._id_5D43389756907528)) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;
      _id_6A16936225A5A8CE = 1;
      owner setclientomnvar("ui_exit_progress", _id_23B90B34FECC58CD / holdtime);

      if(_id_23B90B34FECC58CD > holdtime) {
        self notify("killstreakExit");
        return;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    wait(_id_038FC7BD1495C4B2);
  }
}

allow_force_player_exit() {
  self endon("killstreakExit");
  level waittill("cp_force_killstreak_exit");
  self notify("killstreakExit");
}

killstreak_createobjective(shadername, team, _id_3E2EF879EE8848E2, _id_2231E5A0F940CAAE, _id_DBE22CD5D2A797AF, iconsize) {
  curobjid = nonobjective_requestobjectiveid(1);
  objective_position(curobjid, self.origin);
  objective_icon(curobjid, shadername);
  objective_state(curobjid, "active");
  objective_setbackground(curobjid, 1);

  if(!isDefined(self getlinkedparent()) && !istrue(_id_2231E5A0F940CAAE))
    update_objective_position(curobjid, self.origin);
  else if(istrue(_id_2231E5A0F940CAAE) && istrue(_id_DBE22CD5D2A797AF))
    update_objective_onentitywithrotation(curobjid, self);
  else
    update_objective_onentity(curobjid, self);

  scripts\mp\objidpoolmanager::_id_C3C6BFF089DFDD34(curobjid, iconsize);

  if(isDefined(team)) {
    objective_setownerteam(curobjid, team);

    if(!level.teambased && isDefined(self.owner)) {
      if(istrue(_id_3E2EF879EE8848E2))
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(curobjid, self.owner);
      else
        scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, team);
    }
  } else
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(curobjid);

  return curobjid;
}

killstreak_createobjective_engineer(shadername, _id_2231E5A0F940CAAE, _id_DBE22CD5D2A797AF) {
  curobjid = nonobjective_requestobjectiveid(1);

  if(curobjid == -1)
    return -1;

  objective_delete(curobjid);
  objective_state(curobjid, "invisible");
  objective_position(curobjid, (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(_id_2231E5A0F940CAAE))
    update_objective_position(curobjid, self.origin);
  else if(istrue(_id_2231E5A0F940CAAE) && istrue(_id_DBE22CD5D2A797AF))
    update_objective_onentitywithrotation(curobjid, self);
  else
    update_objective_onentity(curobjid, self);

  objective_state(curobjid, "active");
  objective_icon(curobjid, shadername);
  objective_setbackground(curobjid, 1);
  objective_setownerteam(curobjid, self.team);
  scripts\cp\cp_objectives::minimap_objective_playermask_hidefromall(curobjid);
  return curobjid;
}

update_objective_position(objid, position) {
  if(objid == -1) {
    return;
  }
  objective_position(objid, position);
}

update_objective_onentity(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
}

update_objective_onentitywithrotation(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
  objective_setrotateonminimap(objid, 1);
}

nonobjective_returnobjectiveid(objid) {
  scripts\cp\cp_objectives::freeworldidbyobjid(objid);
}

nonobjective_requestobjectiveid(priority) {
  return scripts\cp\cp_objectives::requestworldid("nonobj_marker", 1);
}

clearusingremote(_id_2C111F02D48E2671) {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remote");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isDefined(_id_2C111F02D48E2671))
    _freezecontrols(0);

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

cp_add_dialogue_line(msg) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(istrue(level.disabledebugdialogue)) {
    return;
  }
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  if(level.dialogue_huds.size == 5) {
    _id_DE5AAABD1AECB05F = level.dialogue_huds[0];
    level.dialogue_huds = scripts\engine\utility::array_remove_index(level.dialogue_huds, 0);
    update_dialogue_huds();
    _id_DE5AAABD1AECB05F thread destroy_dialogue_hud();
  }

  if(soundexists("cp_ui_menu_title_decode_text")) {
    foreach(player in level.players)
    player playlocalsound("cp_ui_menu_title_decode_text");
  }

  color = "^3";
  scale = 1;

  if(isDefined(level.dialoguelinescale))
    scale = level.dialoguelinescale;

  hud = newhudelem();
  hud.elemtype = "font";
  hud.font = "default";
  hud.fontscale = scale;
  hud.x = 0;
  hud.y = 0;
  hud.width = 0;
  hud.height = int(level.fontheight * scale);
  hud.xoffset = 0;
  hud.yoffset = 0;
  index = level.dialogue_huds.size;
  level.dialogue_huds[index] = hud;
  hud.foreground = 1;
  hud.sort = 20;
  hud.x = 40;
  hud.y = 260 + index * (12 * scale);
  hud.label = msg;
  hud.alpha = 0;
  hud fadeovertime(0.2);
  hud.alpha = 1;
  hud endon("death");
  wait 8;
  level.dialogue_huds = scripts\engine\utility::array_remove(level.dialogue_huds, hud);
  update_dialogue_huds();
  hud thread cp_destroy_dialogue_hud();
}

cp_destroy_dialogue_hud() {
  scale = 1;

  if(isDefined(level.dialoguelinescale))
    scale = level.dialoguelinescale;

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * scale;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

destroy_dialogue_hud() {
  scale = 1;

  if(isDefined(level.dialoguelinescale))
    scale = level.dialoguelinescale;

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * scale;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

update_dialogue_huds() {
  scale = 1;

  if(isDefined(level.dialoguelinescale))
    scale = level.dialoguelinescale;

  level.dialogue_huds = scripts\engine\utility::array_removeundefined(level.dialogue_huds);

  foreach(index, hud in level.dialogue_huds) {
    hud moveovertime(0.2);
    hud.y = 260 + index * 12 * scale;
  }
}

getfirstprimaryweapon() {
  _id_8CAC01EF5BCB1816 = self getweaponslistprimaries();
  return _id_8CAC01EF5BCB1816[0];
}

createfontstring(font, fontscale, _id_850AB69BFC46BCF6) {
  if(!isDefined(_id_850AB69BFC46BCF6) || !_id_850AB69BFC46BCF6)
    _id_372B658AEA9D2487 = newclienthudelem(self);
  else
    _id_372B658AEA9D2487 = newhudelem();

  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = font;
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  return _id_372B658AEA9D2487;
}

setparent(_id_F7806D4CF24AACD3) {
  if(isDefined(self.parent) && self.parent == _id_F7806D4CF24AACD3) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = _id_F7806D4CF24AACD3;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("TOPLEFT");
}

removechild(_id_F7806D4CF24AACD3) {
  _id_F7806D4CF24AACD3.parent = undefined;

  if(self.children[self.children.size - 1] != _id_F7806D4CF24AACD3) {
    self.children[_id_F7806D4CF24AACD3.index] = self.children[self.children.size - 1];
    self.children[_id_F7806D4CF24AACD3.index].index = _id_F7806D4CF24AACD3.index;
  }

  self.children[self.children.size - 1] = undefined;
  _id_F7806D4CF24AACD3.index = undefined;
}

addchild(_id_F7806D4CF24AACD3) {
  _id_F7806D4CF24AACD3.index = self.children.size;
  self.children[self.children.size] = _id_F7806D4CF24AACD3;
  removedestroyedchildren();
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  _id_3DDCDB8C8D35246A = [];

  foreach(_id_AC0E594AC96AA3A8, child in self.children) {
    if(!isDefined(child)) {
      continue;
    }
    child.index = _id_3DDCDB8C8D35246A.size;
    _id_3DDCDB8C8D35246A[_id_3DDCDB8C8D35246A.size] = child;
  }

  self.children = _id_3DDCDB8C8D35246A;
}

setpoint(point, relativepoint, xoffset, yoffset, movetime) {
  if(!isDefined(movetime))
    movetime = 0;

  _id_F7806D4CF24AACD3 = getparent();

  if(movetime)
    self moveovertime(movetime);

  if(!isDefined(xoffset))
    xoffset = 0;

  self.xoffset = xoffset;

  if(!isDefined(yoffset))
    yoffset = 0;

  self.yoffset = yoffset;
  self.point = point;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(point, "TOP"))
    self.aligny = "top";

  if(issubstr(point, "BOTTOM"))
    self.aligny = "bottom";

  if(issubstr(point, "LEFT"))
    self.alignx = "left";

  if(issubstr(point, "RIGHT"))
    self.alignx = "right";

  if(!isDefined(relativepoint))
    relativepoint = point;

  self.relativepoint = relativepoint;
  _id_32149D41AB89B2CB = "center_adjustable";
  _id_32149C41AB89B098 = "middle";

  if(issubstr(relativepoint, "TOP"))
    _id_32149C41AB89B098 = "top_adjustable";

  if(issubstr(relativepoint, "BOTTOM"))
    _id_32149C41AB89B098 = "bottom_adjustable";

  if(issubstr(relativepoint, "LEFT"))
    _id_32149D41AB89B2CB = "left_adjustable";

  if(issubstr(relativepoint, "RIGHT"))
    _id_32149D41AB89B2CB = "right_adjustable";

  if(_id_F7806D4CF24AACD3 == level.uiparent) {
    self.horzalign = _id_32149D41AB89B2CB;
    self.vertalign = _id_32149C41AB89B098;
  } else {
    self.horzalign = _id_F7806D4CF24AACD3.horzalign;
    self.vertalign = _id_F7806D4CF24AACD3.vertalign;
  }

  if(strip_suffix(_id_32149D41AB89B2CB, "_adjustable") == _id_F7806D4CF24AACD3.alignx) {
    offsetx = 0;
    _id_D92133D2D7B55484 = 0;
  } else if(_id_32149D41AB89B2CB == "center" || _id_F7806D4CF24AACD3.alignx == "center") {
    offsetx = int(_id_F7806D4CF24AACD3.width / 2);

    if(_id_32149D41AB89B2CB == "left_adjustable" || _id_F7806D4CF24AACD3.alignx == "right")
      _id_D92133D2D7B55484 = -1;
    else
      _id_D92133D2D7B55484 = 1;
  } else {
    offsetx = _id_F7806D4CF24AACD3.width;

    if(_id_32149D41AB89B2CB == "left_adjustable")
      _id_D92133D2D7B55484 = -1;
    else
      _id_D92133D2D7B55484 = 1;
  }

  self.x = _id_F7806D4CF24AACD3.x + offsetx * _id_D92133D2D7B55484;

  if(strip_suffix(_id_32149C41AB89B098, "_adjustable") == _id_F7806D4CF24AACD3.aligny) {
    offsety = 0;
    _id_F28981E9D5FBE3EB = 0;
  } else if(_id_32149C41AB89B098 == "middle" || _id_F7806D4CF24AACD3.aligny == "middle") {
    offsety = int(_id_F7806D4CF24AACD3.height / 2);

    if(_id_32149C41AB89B098 == "top_adjustable" || _id_F7806D4CF24AACD3.aligny == "bottom")
      _id_F28981E9D5FBE3EB = -1;
    else
      _id_F28981E9D5FBE3EB = 1;
  } else {
    offsety = _id_F7806D4CF24AACD3.height;

    if(_id_32149C41AB89B098 == "top_adjustable")
      _id_F28981E9D5FBE3EB = -1;
    else
      _id_F28981E9D5FBE3EB = 1;
  }

  self.y = _id_F7806D4CF24AACD3.y + offsety * _id_F28981E9D5FBE3EB;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(point, relativepoint, xoffset, yoffset);
      break;
  }

  updatechildren();
}

getparent() {
  return self.parent;
}

setpointbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left")
    self.bar.x = self.x;
  else if(self.alignx == "right")
    self.bar.x = self.x - self.width;
  else
    self.bar.x = self.x - int(self.width / 2);

  if(self.aligny == "top")
    self.bar.y = self.y;
  else if(self.aligny == "bottom")
    self.bar.y = self.y;

  updatebar(self.bar.frac);
}

updatebar(_id_144981CC6EB4B07A, rateofchange) {
  if(self.elemtype == "bar")
    updatebarscale(_id_144981CC6EB4B07A, rateofchange);
}

updatebarscale(_id_144981CC6EB4B07A, rateofchange) {
  _id_9017AC78A8DCE9DA = int(self.width * _id_144981CC6EB4B07A + 0.5);

  if(!_id_9017AC78A8DCE9DA)
    _id_9017AC78A8DCE9DA = 1;

  self.bar.frac = _id_144981CC6EB4B07A;
  self.bar setshader(self.bar.shader, _id_9017AC78A8DCE9DA, self.height);

  if(isDefined(rateofchange) && _id_9017AC78A8DCE9DA < self.width) {
    if(rateofchange > 0)
      self.bar scaleovertime((1 - _id_144981CC6EB4B07A) / rateofchange, self.width, self.height);
    else if(rateofchange < 0)
      self.bar scaleovertime(_id_144981CC6EB4B07A / (-1 * rateofchange), 1, self.height);
  }

  self.bar.rateofchange = rateofchange;
  self.bar.lastupdatetime = gettime();
}

updatechildren() {
  for(index = 0; index < self.children.size; index++) {
    child = self.children[index];
    child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
  }
}

createicon(shader, width, height, _id_850AB69BFC46BCF6) {
  if(!isDefined(_id_850AB69BFC46BCF6))
    _id_5B6A2597D526BD27 = newclienthudelem(self);
  else
    _id_5B6A2597D526BD27 = newhudelem();

  _id_5B6A2597D526BD27.elemtype = "icon";
  _id_5B6A2597D526BD27.x = 0;
  _id_5B6A2597D526BD27.y = 0;
  _id_5B6A2597D526BD27.width = width;
  _id_5B6A2597D526BD27.height = height;
  _id_5B6A2597D526BD27.basewidth = _id_5B6A2597D526BD27.width;
  _id_5B6A2597D526BD27.baseheight = _id_5B6A2597D526BD27.height;
  _id_5B6A2597D526BD27.xoffset = 0;
  _id_5B6A2597D526BD27.yoffset = 0;
  _id_5B6A2597D526BD27.children = [];
  _id_5B6A2597D526BD27 setparent(level.uiparent);
  _id_5B6A2597D526BD27.hidden = 0;

  if(isDefined(shader)) {
    _id_5B6A2597D526BD27 setshader(shader, width, height);
    _id_5B6A2597D526BD27.shader = shader;
  }

  return _id_5B6A2597D526BD27;
}

destroyelem() {
  _id_3D3334E0AD5D51F4 = [];

  if(isDefined(self.children)) {
    for(index = 0; index < self.children.size; index++) {
      if(isDefined(self.children[index]))
        _id_3D3334E0AD5D51F4[_id_3D3334E0AD5D51F4.size] = self.children[index];
    }

    for(index = 0; index < _id_3D3334E0AD5D51F4.size; index++)
      _id_3D3334E0AD5D51F4[index] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader")
    self.bar destroy();

  self destroy();
}

createprimaryprogressbartext(xoffset, yoffset, _id_780737A0C9EC4AB5, _id_76AC8A084F06EA85) {
  if(isagent(self))
    return undefined;

  if(!isDefined(xoffset))
    xoffset = 0;

  if(!isDefined(yoffset))
    yoffset = -25;

  if(self issplitscreenplayer())
    yoffset = yoffset + 20;

  _id_F0778934C2C7E788 = level.primaryprogressbarfontsize;
  font = "default";

  if(isDefined(_id_780737A0C9EC4AB5))
    _id_F0778934C2C7E788 = _id_780737A0C9EC4AB5;

  if(isDefined(_id_76AC8A084F06EA85))
    font = _id_76AC8A084F06EA85;

  text = createfontstring(font, _id_F0778934C2C7E788);
  text setpoint("CENTER", undefined, level.primaryprogressbartextx + xoffset, level.primaryprogressbartexty + yoffset);
  text.sort = -1;
  return text;
}

createprimaryprogressbar(xoffset, yoffset, width, height) {
  if(isagent(self))
    return undefined;

  if(!isDefined(xoffset))
    xoffset = 0;

  if(!isDefined(yoffset))
    yoffset = -25;

  if(self issplitscreenplayer())
    yoffset = yoffset + 20;

  if(!isDefined(width))
    width = level.primaryprogressbarwidth;

  if(!isDefined(height))
    height = level.primaryprogressbarheight;

  bar = createbar((1, 1, 1), width, height);
  bar setpoint("CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset);
  return bar;
}

createbar(color, width, height, flashfrac) {
  barelem = newclienthudelem(self);
  barelem.x = 0;
  barelem.y = 0;
  barelem.frac = 0;
  barelem.color = color;
  barelem.sort = -2;
  barelem.shader = "progress_bar_fill";
  barelem setshader("progress_bar_fill", width, height);
  barelem.hidden = 0;

  if(isDefined(flashfrac))
    barelem.flashfrac = flashfrac;

  _id_B27D6AD98ACD05BA = newclienthudelem(self);
  _id_B27D6AD98ACD05BA.elemtype = "bar";
  _id_B27D6AD98ACD05BA.width = width;
  _id_B27D6AD98ACD05BA.height = height;
  _id_B27D6AD98ACD05BA.xoffset = 0;
  _id_B27D6AD98ACD05BA.yoffset = 0;
  _id_B27D6AD98ACD05BA.bar = barelem;
  _id_B27D6AD98ACD05BA.children = [];
  _id_B27D6AD98ACD05BA.sort = -3;
  _id_B27D6AD98ACD05BA.color = (0, 0, 0);
  _id_B27D6AD98ACD05BA.alpha = 0.5;
  _id_B27D6AD98ACD05BA setparent(level.uiparent);
  _id_B27D6AD98ACD05BA setshader("progress_bar_bg", width + 4, height + 4);
  _id_B27D6AD98ACD05BA.hidden = 0;
  return _id_B27D6AD98ACD05BA;
}

getplayerforguid(guid) {
  foreach(player in level.players) {
    if(player.guid == guid)
      return player;
  }

  return undefined;
}

getplayersinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A) {
  if(radius <= 0)
    return [];

  _id_2649564EBA242B56 = undefined;

  if(isDefined(_id_24EE99FA6D091C2A)) {
    if(isarray(_id_24EE99FA6D091C2A))
      _id_2649564EBA242B56 = _id_24EE99FA6D091C2A;
    else
      _id_2649564EBA242B56 = [_id_24EE99FA6D091C2A];
  }

  results = physics_querypoint(origin, radius, physics_createcontents(["physicscontents_characterproxy"]), _id_2649564EBA242B56, "physicsquery_all");
  _id_815AAE0BD650B698 = [];

  if(!isDefined(_id_BEB392BBB338D308)) {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e))
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e) && isDefined(e.team) && e.team == _id_BEB392BBB338D308)
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  }

  return _id_815AAE0BD650B698;
}

getentitiesinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A, _id_D1BDD6B42771114C) {
  if(radius <= 0)
    return [];

  _id_2649564EBA242B56 = undefined;

  if(isDefined(_id_24EE99FA6D091C2A)) {
    if(isarray(_id_24EE99FA6D091C2A))
      _id_2649564EBA242B56 = _id_24EE99FA6D091C2A;
    else
      _id_2649564EBA242B56 = [_id_24EE99FA6D091C2A];
  }

  results = physics_querypoint(origin, radius, _id_D1BDD6B42771114C, _id_2649564EBA242B56, "physicsquery_all");
  _id_815AAE0BD650B698 = [];

  if(!isDefined(_id_BEB392BBB338D308)) {
    foreach(result in results) {
      e = result["entity"];
      _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isDefined(e.team) && e.team == _id_BEB392BBB338D308)
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  }

  return _id_815AAE0BD650B698;
}

_suicide() {
  if(!isusingremote() && !isDefined(self.fauxdead))
    self suicide();
}

player_lua_progressbar(player, _id_7C8064D6E9390B55, range, _id_3DE03BFA4E76B915, _id_CD512AD17C99DE9D, _id_C3A973EAFD37B75A) {
  result = lua_progress_bar_think(player, _id_7C8064D6E9390B55, range, _id_3DE03BFA4E76B915, _id_CD512AD17C99DE9D, _id_C3A973EAFD37B75A);
  return result;
}

lua_progress_bar_think(player, usetime, range, _id_3DE03BFA4E76B915, _id_CD512AD17C99DE9D, _id_C3A973EAFD37B75A) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = usetime;
  player thread create_lua_progress_bar(self, _id_3DE03BFA4E76B915);
  player.hasprogressbar = 1;
  result = lua_progress_bar_think_loop(player, self, range, _id_CD512AD17C99DE9D, _id_C3A973EAFD37B75A);

  if(isalive(player))
    player.hasprogressbar = 0;

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return result;
}

create_lua_progress_bar(object, _id_3DE03BFA4E76B915) {
  self endon("disconnect");
  _id_1DBC717085326045(_id_3DE03BFA4E76B915, undefined, undefined);
  _id_E66FDFC10212DC47 = -1;

  while(scripts\cp_mp\utility\player_utility::_isalive() && isDefined(object) && object.inuse && !level.gameended) {
    if(_id_E66FDFC10212DC47 != object.userate) {
      if(object.curprogress > object.usetime)
        object.curprogress = object.usetime;
    }

    _id_E66FDFC10212DC47 = object.userate;
    _id_1DBC717085326045(undefined, object.curprogress / object.usetime, undefined);
    wait 0.05;
  }

  wait 0.5;
  _id_1DBC717085326045(0, 0, undefined);
}

lua_progress_bar_think_loop(player, ent, _id_465A06BAE1ABB77E, _id_CD512AD17C99DE9D, _id_C3A973EAFD37B75A) {
  while(!level.gameended && isDefined(self) && player scripts\cp_mp\utility\player_utility::_isalive() && (player useButtonPressed() || isDefined(_id_CD512AD17C99DE9D) || player attackButtonPressed() && isDefined(_id_C3A973EAFD37B75A)) && should_continue_progress_bar_think(player)) {
    wait 0.05;

    if(isDefined(ent) && isDefined(_id_465A06BAE1ABB77E)) {
      if(distancesquared(player.origin, ent.origin) > _id_465A06BAE1ABB77E)
        return 0;
    }

    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      player _id_1DBC717085326045(undefined, 1, undefined);
      return player scripts\cp_mp\utility\player_utility::_isalive();
    }
  }

  return 0;
}

should_continue_progress_bar_think(player) {
  if(isDefined(level.should_continue_progress_bar_think))
    return [[level.should_continue_progress_bar_think]](player);
  else
    return !_id_0AFB7E332AEE4BF2::player_in_laststand(player);
}

isplayingsolo() {
  if(getmaxclients() == 1)
    return 1;

  return 0;
}

removefromspawnedgrouparray() {
  if(isDefined(self.group_name)) {
    if(isDefined(level.spawned_group) && isDefined(level.spawned_group[self.group_name]))
      level.spawned_group[self.group_name] = scripts\engine\utility::array_remove(level.spawned_group[self.group_name], self);
  }
}

createtimer(font, fontscale) {
  _id_4908CA330BDC48D1 = newclienthudelem(self);
  _id_4908CA330BDC48D1.elemtype = "timer";
  _id_4908CA330BDC48D1.font = font;
  _id_4908CA330BDC48D1.fontscale = fontscale;
  _id_4908CA330BDC48D1.basefontscale = fontscale;
  _id_4908CA330BDC48D1.x = 0;
  _id_4908CA330BDC48D1.y = 0;
  _id_4908CA330BDC48D1.width = 0;
  _id_4908CA330BDC48D1.height = int(level.fontheight * fontscale);
  _id_4908CA330BDC48D1.xoffset = 0;
  _id_4908CA330BDC48D1.yoffset = 0;
  _id_4908CA330BDC48D1.children = [];
  _id_4908CA330BDC48D1 setparent(level.uiparent);
  _id_4908CA330BDC48D1.hidden = 0;
  return _id_4908CA330BDC48D1;
}

_id_9A83883F756A4330(_id_8DD9F2EB8215A139) {
  if(_id_8DD9F2EB8215A139 >= 4)
    return "match_start_tick_in5";

  if(_id_8DD9F2EB8215A139 == 3)
    return "match_start_tick_in3";

  if(_id_8DD9F2EB8215A139 == 2)
    return "match_start_tick_in2";

  if(_id_8DD9F2EB8215A139 == 1)
    return "match_start_tick_in1";

  return "match_start_tick_in";
}

getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139) {
  if(_id_8DD9F2EB8215A139 > 20)
    return "ui_mp_timer_countdown";
  else if(_id_8DD9F2EB8215A139 > 10)
    return "ui_mp_timer_countdown_10";
  else if(_id_8DD9F2EB8215A139 > 5)
    return "ui_mp_timer_countdown_half_sec";
  else if(_id_8DD9F2EB8215A139 > 1.5)
    return "ui_mp_timer_countdown_quarter_sec";
  else
    return "ui_mp_timer_countdown_1";
}

getoverlordaliasfortimeleft(_id_8DD9F2EB8215A139, _id_323D131F19F161D0) {
  _id_A753AB6FC7F73FDC = 1;

  if(isDefined(_id_323D131F19F161D0))
    _id_A753AB6FC7F73FDC = _id_323D131F19F161D0;

  _id_18F2BB0DD309974C = undefined;

  switch (_id_8DD9F2EB8215A139) {
    case 300:
      if(istrue(_id_A753AB6FC7F73FDC) && scripts\engine\utility::cointoss())
        _id_18F2BB0DD309974C = "dx_cps_lass_timecheck_5min_10";
      else
        _id_18F2BB0DD309974C = "dx_cps_kama_timecheck_5min_10";

      break;
    case 120:
      if(istrue(_id_A753AB6FC7F73FDC) && scripts\engine\utility::cointoss())
        _id_18F2BB0DD309974C = "dx_cps_lass_timecheck_2min_20";
      else
        _id_18F2BB0DD309974C = "dx_cps_kama_timecheck_2min_20";

      break;
    case 60:
      if(istrue(_id_A753AB6FC7F73FDC) && scripts\engine\utility::cointoss())
        _id_18F2BB0DD309974C = "dx_cps_lass_timecheck_1min_30";
      else
        _id_18F2BB0DD309974C = "dx_cps_kama_timecheck_1min_30";

      break;
    case 30:
      if(istrue(_id_A753AB6FC7F73FDC) && scripts\engine\utility::cointoss())
        _id_18F2BB0DD309974C = "dx_cps_lass_timecheck_30sec_40";
      else
        _id_18F2BB0DD309974C = "dx_cps_kama_timecheck_30sec_40";

      break;
    case 10:
      if(istrue(_id_A753AB6FC7F73FDC) && scripts\engine\utility::cointoss())
        _id_18F2BB0DD309974C = "dx_cps_lass_timecheck_10sec_50";
      else
        _id_18F2BB0DD309974C = "dx_cps_kama_timecheck_10sec_50";

      break;
  }

  return _id_18F2BB0DD309974C;
}

_detachall(_id_BE69C03CAA346D6C) {
  if(!istrue(_id_BE69C03CAA346D6C))
    self.headmodel = undefined;

  if(isDefined(self.riotshieldmodel))
    riotshield_detach(1);

  if(isDefined(self.riotshieldmodelstowed))
    riotshield_detach(0);

  self.hasriotshieldequipped = 0;

  if(!istrue(_id_BE69C03CAA346D6C))
    self detachall();

  scripts\cp\equipment\nvg::clearnvg(istrue(_id_BE69C03CAA346D6C));
}

is_consumable_active(_id_CB325DDB4A764623) {
  if(isDefined(self.consumables) && isDefined(self.consumables[_id_CB325DDB4A764623]) && isDefined(self.consumables[_id_CB325DDB4A764623].on) && self.consumables[_id_CB325DDB4A764623].on == 1)
    return 1;
  else
    return 0;
}

notify_used_consumable(_id_5977D96DFD782D7E) {
  self notify(self.consumables[_id_5977D96DFD782D7E].usednotify);
}

drawline(start, end, _id_BC08E2B32A09AB5A, color) {
  _id_47D735016BAE708E = int(_id_BC08E2B32A09AB5A * 20);

  for(time = 0; time < _id_47D735016BAE708E; time++)
    wait 0.05;
}

is_upgrade_enabled(_id_CB325DDB4A764623) {
  if(!is_using_extinction_tokens())
    return 0;

  if(self getplayerdata("cp", "upgrades_enabled_flags", _id_CB325DDB4A764623))
    return 1;
  else
    return 0;
}

allow_player_teleport(_id_E3108E412AFB3811, _id_07B1CEF9C76D8332) {
  if(_id_E3108E412AFB3811) {
    if(!isDefined(self.teleportdisableflags) && isDefined(_id_07B1CEF9C76D8332)) {
      foreach(_id_F90358454413407F in self.teleportdisableflags) {
        if(_id_F90358454413407F == _id_07B1CEF9C76D8332)
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, _id_07B1CEF9C76D8332);
      }
    }

    self.disabledteleportation--;

    if(!self.disabledteleportation) {
      self.teleportdisableflags = [];
      self.can_teleport = 1;
      self notify("can_teleport");
    }
  } else {
    if(!isDefined(self.teleportdisableflags))
      self.teleportdisableflags = [];

    if(isDefined(_id_07B1CEF9C76D8332))
      self.teleportdisableflags[self.teleportdisableflags.size] = _id_07B1CEF9C76D8332;

    self.disabledteleportation++;
    self.can_teleport = 0;
  }
}

areinteractionsenabled() {
  return !istrue(self.interactions_disabled);
}

enable_infinite_ammo(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self.infiniteammocounter++;
    self setclientomnvar("zm_ui_unlimited_ammo", 1);
  } else {
    if(self.infiniteammocounter > 0)
      self.infiniteammocounter--;

    if(!self.infiniteammocounter)
      self setclientomnvar("zm_ui_unlimited_ammo", 0);
  }
}

allow_player_basejumping(_id_E3108E412AFB3811, _id_D4CC29E776820C4C) {
  debug_print = 1;

  if(!isDefined(_id_D4CC29E776820C4C))
    _id_D4CC29E776820C4C = "default";

  _id_35ABA55687F16600 = _id_E3108E412AFB3811;

  if(isDefined(level._id_F4A07073EC587E25))
    _id_35ABA55687F16600 = level._id_F4A07073EC587E25;

  _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "base_jumping", _id_35ABA55687F16600);
}

allow_player_minimapforcedisable(_id_E3108E412AFB3811) {
  if(!isDefined(self.enabledminimapdisable))
    self.enabledminimapdisable = 0;

  if(_id_E3108E412AFB3811) {
    self.enabledminimapdisable++;
    hideminimap(1);
  } else {
    self.enabledminimapdisable--;

    if(self.enabledminimapdisable < 0)
      self.enabledminimapdisable = 0;

    if(!self.enabledminimapdisable)
      showminimap();
  }
}

is_minimap_forcedisabled() {
  if(isDefined(self.enabledminimapdisable) && self.enabledminimapdisable > 0)
    return 1;

  return 0;
}

allow_player_ignore_me(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self.enabledignoreme++;
    self.ignoreme = 1;
  } else {
    self.enabledignoreme--;

    if(!self.enabledignoreme)
      self.ignoreme = 0;
  }
}

isignoremeenabled() {
  return self.enabledignoreme >= 1;
}

force_usability_enabled() {
  _id_3B64EB40368C1450::nuke("usability");
  self enableusability();
}

is_using_extinction_tokens() {
  return 0;

  if(getdvarint("extinction_tokens_enabled") > 0)
    return 1;

  return 0;
}

coop_getweaponclass(weapon) {
  if(!isDefined(weapon))
    return "none";

  if(isweapon(weapon) && isnullweapon(weapon))
    return "none";

  if(isstring(weapon) && weapon == "none")
    return "none";

  basename = getbaseweaponname(weapon);
  weapon_class = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(basename, "stat_DC57E42946F6E08C", "");

  if(weapon_class == "" && isDefined(level.game_mode_statstable)) {
    if(isDefined(weapon)) {
      basename = getbaseweaponname(weapon);
      weapon_class = tablelookup(level.game_mode_statstable, 4, basename, 2);
    }
  }

  if(isenvironmentweapon(weapon))
    weapon_class = "weapon_mg";
  else if(isweapon(weapon) && isnullweapon(weapon))
    weapon_class = "other";
  else if(isstring(weapon) && weapon == "none")
    weapon_class = "other";
  else if(weapon_class == "")
    weapon_class = "other";

  return weapon_class;
}

is_holding_deployable() {
  return istrue(self.is_holding_deployable);
}

has_special_weapon() {
  return istrue(self.has_special_weapon);
}

getequipmenttype(weapon) {
  switch (weapon) {
    case "arc_grenade_mp":
    case "zom_repulsor_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "impalement_spike_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncing_betty_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "frag_grenade_zm":
    case "molotov_cp":
    case "frag_grenade_cp":
    case "gas_mp":
    case "rock":
    case "throwingknife_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "claymore_mp":
    case "at_mine_mp":
    case "c4_mp":
    case "pop_rocket_mp":
    case "throwingknife":
    case "semtex":
    case "thermite_mp":
    case "frag":
    case "molotov_mp":
    case "molotov":
      _id_57C4945B399F53F4 = "lethal";
      break;
    case "ztransponder_mp":
    case "transponder_mp":
    case "blackout_grenade_mp":
    case "player_trophy_system_mp":
    case "proto_ricochet_device_mp":
    case "trophy_cp":
    case "trophy_mp":
    case "mobile_radar_mp":
    case "gravity_grenade_mp":
    case "alienflare_mp":
    case "smoke_grenadejugg_mp":
    case "thermobaric_grenade_mp":
    case "portal_generator_zm":
    case "portal_generator_mp":
    case "dud_grenade_zm":
    case "noisemaker":
    case "teargas":
    case "signal":
    case "smoke_tall":
    case "shock_stick_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
    case "emp_grenade_mp":
    case "smoke":
    case "flash":
      _id_57C4945B399F53F4 = "tactical";
      break;
    default:
      _id_57C4945B399F53F4 = undefined;
      break;
  }

  return _id_57C4945B399F53F4;
}

_launchgrenade(weaponname, origin, velocity, _id_C301D652D9A73075, notthrown, _id_997A34F6AB5CB7FC) {
  grenade = self launchgrenade(weaponname, origin, velocity, _id_C301D652D9A73075, _id_997A34F6AB5CB7FC);

  if(!isDefined(notthrown))
    grenade.notthrown = 1;
  else
    grenade.notthrown = notthrown;

  grenade setotherent(self);
  return grenade;
}

moveplayerperpendicularly(_id_B1ED041D34E01127, _id_B092096C70BCC8E4) {
  if(!isDefined(_id_B1ED041D34E01127))
    _id_B1ED041D34E01127 = 1200;

  if(isDefined(_id_B092096C70BCC8E4))
    _id_DF70F4E6D651BC52 = vectorNormalize(_id_B092096C70BCC8E4);
  else
    _id_DF70F4E6D651BC52 = anglesToForward(self.angles);

  _id_1CE8AF601EC4D316 = vectorcross((0, 0, 1), _id_DF70F4E6D651BC52);
  _id_435ED379095C43E8 = vectorNormalize(_id_1CE8AF601EC4D316);
  self knockback(_id_435ED379095C43E8, _id_B1ED041D34E01127);
}

getweaponclass(weapon) {
  basename = getbaseweaponname(weapon);

  if(isDefined(basename) && basename == "none")
    return "other";

  class = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(basename, "stat_DC57E42946F6E08C", "");

  if(class == "") {
    weaponname = strip_suffix(weapon.basename, "_zm");
    class = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(weaponname, "stat_DC57E42946F6E08C", "");
  }

  if(isenvironmentweapon(weapon.basename))
    class = "weapon_mg";
  else if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon.basename))
    class = "killstreak";
  else if(issuperweapon(weapon.basename))
    class = "super";
  else if(weapon.basename == "none")
    class = "other";
  else if(class == "")
    class = "other";

  return class;
}

removedamagemodifier(id, _id_B3D6E2C2DB2FB4A9) {
  if(!isDefined(_id_B3D6E2C2DB2FB4A9))
    _id_B3D6E2C2DB2FB4A9 = 1;

  if(_id_B3D6E2C2DB2FB4A9) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[id] = undefined;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[id] = undefined;
  }
}

adddamagemodifier(id, modifier, _id_B3D6E2C2DB2FB4A9) {
  if(!isDefined(_id_B3D6E2C2DB2FB4A9))
    _id_B3D6E2C2DB2FB4A9 = 1;

  if(_id_B3D6E2C2DB2FB4A9) {
    if(!isDefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[id] = modifier;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[id] = modifier;
  }
}

getdamagemodifiertotal(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  _id_C8E219B403B2E789 = 1.0;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(modifier in self.additivedamagemodifiers)
    _id_C8E219B403B2E789 = _id_C8E219B403B2E789 + (modifier - 1.0);
  }

  _id_1CBF01D0DF82CDE7 = 1.0;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(modifier in self.multiplicativedamagemodifiers)
    _id_1CBF01D0DF82CDE7 = _id_1CBF01D0DF82CDE7 * modifier;
  }

  return _id_C8E219B403B2E789 * _id_1CBF01D0DF82CDE7;
}

isinventoryprimaryweapon(weapon) {
  switch (weaponinventorytype(weapon)) {
    case "altmode":
    case "primary":
      return 1;
    default:
      return 0;
  }
}

has_tag(model, tag) {
  if(!isDefined(model))
    return 0;

  _id_CD148482D2898BE7 = getnumparts(model);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CD148482D2898BE7; _id_AC0E594AC96AA3A8++) {
    if(getpartname(model, _id_AC0E594AC96AA3A8) == tolower(tag))
      return 1;
  }

  return 0;
}

is_trap(ent, sweapon) {
  if(isDefined(sweapon) && (sweapon.basename == "iw7_beamtrap_zm" || sweapon.basename == "iw7_escapevelocity_zm" || sweapon.basename == "iw7_rockettrap_zm" || sweapon.basename == "iw7_discotrap_zm" || sweapon.basename == "iw7_chromosphere_zm" || sweapon.basename == "iw7_buffertrap_zm" || sweapon.basename == "iw7_electrictrap_zm" || sweapon.basename == "iw7_fantrap_zm" || sweapon.basename == "iw7_hydranttrap_zm" || sweapon.basename == "iw7_moshtrap_zm"))
    return 1;

  if(!isDefined(ent))
    return 0;

  if(isDefined(ent.tesla_type))
    return 1;

  if(!isDefined(ent.script_noteworthy) && !isDefined(ent.targetname))
    return 0;

  if(isDefined(ent.targetname) && (ent.targetname == "fence_generator" || ent.targetname == "puddle_generator"))
    return 1;

  if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "fire_trap")
    return 1;

  return 0;
}

istwohandedoffhand(grenade) {
  if(isDefined(grenade) && grenade.basename != "none") {
    if(issuperweapon(grenade.basename))
      return 1;

    _id_11D2F075E9A0E643 = getequipmenttype(grenade.basename);

    if(isDefined(_id_11D2F075E9A0E643) && _id_11D2F075E9A0E643 == "lethal")
      return 1;
  }

  return 0;
}

isaltmodeweapon(_id_C27E2A04BAB78C1F) {
  if(!isDefined(_id_C27E2A04BAB78C1F) || _id_C27E2A04BAB78C1F == "none")
    return 0;

  return weaponinventorytype(_id_C27E2A04BAB78C1F) == "altmode";
}

notifyafterframeend(_id_9FACC6F327E1E6B4, _id_7239F8830EF22B43) {
  self waittill(_id_9FACC6F327E1E6B4);
  waittillframeend;
  self notify(_id_7239F8830EF22B43);
}

isheadshot(weapon, shitloc, smeansofdeath, attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      if(attacker.code_classname == "script_vehicle")
        return 0;

      if(attacker.code_classname == "misc_turret")
        return 0;

      if(attacker.code_classname == "script_model")
        return 0;
    }

    if(isDefined(attacker.agent_type)) {
      if(attacker.agent_type == "dog" || attacker.agent_type == "alien")
        return 0;
    }
  }

  return (shitloc == "head" || shitloc == "helmet" || shitloc == "neck") && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_SCARAB" && smeansofdeath != "MOD_CRUSH" && smeansofdeath != "MOD_HEAD_SHOT" && !isenvironmentweapon(weapon.basename);
}

getteamarray(team, _id_DCC07FCC8A9BEB59) {
  _id_5A9CFC3686B1FD8D = [];

  if(!isDefined(_id_DCC07FCC8A9BEB59) || _id_DCC07FCC8A9BEB59) {
    foreach(player in level.characters) {
      if(player.team == team)
        _id_5A9CFC3686B1FD8D[_id_5A9CFC3686B1FD8D.size] = player;
    }
  } else {
    foreach(player in level.players) {
      if(player.team == team)
        _id_5A9CFC3686B1FD8D[_id_5A9CFC3686B1FD8D.size] = player;
    }
  }

  return _id_5A9CFC3686B1FD8D;
}

getotherteam(team) {
  if(level.multiteambased) {}

  if(team == "allies")
    return "axis";
  else if(team == "axis")
    return "allies";
  else
    return "none";
}

riotshield_hasweapon() {
  result = 0;
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      result = 1;
      break;
    }
  }

  return result;
}

riotshield_attach(_id_F8EE3E194415C066, _id_A6EF975DA2DDFF4B) {
  _id_8F79D15EFB6089C2 = undefined;

  if(_id_F8EE3E194415C066) {
    self.riotshieldmodel = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "tag_shield_back";
  }

  if(!isDefined(self.current_shield_tagattach) || self.current_shield_tagattach != _id_8F79D15EFB6089C2) {
    self.current_shield_tagattach = _id_8F79D15EFB6089C2;
    self attachshieldmodel(_id_A6EF975DA2DDFF4B, _id_8F79D15EFB6089C2);
  }

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(_id_F8EE3E194415C066) {
  _id_A6EF975DA2DDFF4B = undefined;
  _id_8053D7B86373D568 = undefined;

  if(_id_F8EE3E194415C066) {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodel;
    _id_8053D7B86373D568 = "j_shield_ri";
  } else {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodelstowed;
    _id_8053D7B86373D568 = "tag_shield_back";
  }

  if(isDefined(self.current_shield_tagattach) && self.current_shield_tagattach == _id_8053D7B86373D568) {
    self.current_shield_tagattach = undefined;
    self detachshieldmodel(_id_A6EF975DA2DDFF4B, _id_8053D7B86373D568);
  }

  if(_id_F8EE3E194415C066)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

launchshield(damage, meansofdeath) {
  if(riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel))
      riotshield_detach(1);

    if(isDefined(self.riotshieldmodelstowed))
      riotshield_detach(0);
  }
}

riotshield_move(_id_9A9844B3A758C1C9) {
  _id_2FB5A158F53218ED = undefined;
  _id_C5E1BE4D30CC7D74 = undefined;
  _id_A6EF975DA2DDFF4B = undefined;

  if(_id_9A9844B3A758C1C9) {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodel;
    _id_2FB5A158F53218ED = "j_shield_ri";
    _id_C5E1BE4D30CC7D74 = "tag_shield_back";
  } else {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodelstowed;
    _id_2FB5A158F53218ED = "tag_shield_back";
    _id_C5E1BE4D30CC7D74 = "j_shield_ri";
  }

  if(!isDefined(self.current_shield_tagattach) || self.current_shield_tagattach != _id_C5E1BE4D30CC7D74) {
    self.current_shield_tagattach = _id_C5E1BE4D30CC7D74;
    self moveshieldmodel(_id_A6EF975DA2DDFF4B, _id_2FB5A158F53218ED, _id_C5E1BE4D30CC7D74);
  }

  if(_id_9A9844B3A758C1C9) {
    self.riotshieldmodelstowed = _id_A6EF975DA2DDFF4B;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = _id_A6EF975DA2DDFF4B;
    self.riotshieldmodelstowed = undefined;
  }
}

remove_crafting_item() {
  self setclientomnvar("zombie_souvenir_piece_index", 0);

  if(isDefined(level.crafting_remove_func))
    self[[level.crafting_remove_func]]();

  self.current_crafting_struct = undefined;
}

store_weapons_status(_id_6876E99CA89B9A15, _id_59D694577D32FB2B) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, _id_59D694577D32FB2B);
  self.copy_weapon_level = [];
  self._id_0BFEBCD1C49C31E8 = _id_07C40FA80892A721::_id_0600F6CF462E983F();
  _id_39C57FEF72629573 = [];

  foreach(weapon in self.copy_fullweaponlist) {
    if(weapon.isalternate) {
      continue;
    }
    if(issubstr(weapon.basename, "iw8_execution_")) {
      continue;
    }
    _id_39C57FEF72629573[_id_39C57FEF72629573.size] = weapon;
  }

  self.copy_fullweaponlist = _id_39C57FEF72629573;

  foreach(weapon in self.copy_fullweaponlist) {
    weaponname = getcompleteweaponname(weapon);
    self.copy_weapon_ammo_clip[weaponname] = self getweaponammoclip(weapon);
    self.copy_weapon_ammo_stock[weaponname] = self getweaponammostock(weapon);

    if(issubstr(weapon.basename, "akimbo"))
      self.copy_weapon_ammo_clip_left[weaponname] = self getweaponammoclip(weapon, "left");

    _id_7B358DC23D8CE9E2 = getrawbaseweaponname(weapon);

    if(isDefined(self.pap[_id_7B358DC23D8CE9E2]))
      self.copy_weapon_level[weaponname] = self.pap[_id_7B358DC23D8CE9E2].lvl;
  }

  if(isDefined(_id_6876E99CA89B9A15)) {
    _id_6C93ABB5FC1F28A5 = [];

    foreach(weapon in self.copy_fullweaponlist) {
      if(getsubstr(weapon.basename, 0, weapon.basename.size) == "fists") {
        continue;
      }
      _id_887D42B1410C39FE = 0;

      foreach(_id_9F442CB94079A336 in _id_6876E99CA89B9A15) {
        if(weapon == _id_9F442CB94079A336) {
          _id_887D42B1410C39FE = 1;
          break;
        } else if(weapon getbaseweapon() == _id_9F442CB94079A336) {
          _id_887D42B1410C39FE = 1;
          break;
        }
      }

      if(_id_887D42B1410C39FE) {
        continue;
      }
      _id_6C93ABB5FC1F28A5[_id_6C93ABB5FC1F28A5.size] = weapon;
    }

    self.copy_fullweaponlist = _id_6C93ABB5FC1F28A5;

    foreach(_id_9F442CB94079A336 in _id_6876E99CA89B9A15) {
      if(self.copy_weapon_current == _id_9F442CB94079A336) {
        self.copy_weapon_current = nullweapon();
        break;
      }
    }
  }
}

get_current_weapon(player, _id_59D694577D32FB2B) {
  _id_89162A7340BA32F3 = player getcurrentweapon();

  if(istrue(_id_59D694577D32FB2B) && is_melee_weapon(_id_89162A7340BA32F3))
    _id_89162A7340BA32F3 = player getweaponslistall()[1];

  return _id_89162A7340BA32F3;
}

is_melee_weapon(_id_89162A7340BA32F3, _id_DEB079B105708D8B) {
  weaponname = undefined;

  if(isweapon(_id_89162A7340BA32F3))
    weaponname = _id_89162A7340BA32F3.basename;
  else
    weaponname = _id_89162A7340BA32F3;

  switch (weaponname) {
    case "iw7_knife_zm_disco":
    case "alt_iw7_knife_zm_survivor":
    case "alt_iw7_knife_zm_grunge":
    case "alt_iw7_knife_zm_hiphop":
    case "alt_iw7_knife_zm_raver":
    case "alt_iw7_knife_zm_chola":
    case "iw7_knife_zm_survivor":
    case "iw7_knife_zm_grunge":
    case "iw7_knife_zm_hiphop":
    case "iw7_knife_zm_raver":
    case "iw7_knife_zm_chola":
    case "alt_iw7_knife_zm_vgirl":
    case "alt_iw7_knife_zm_rapper":
    case "alt_iw7_knife_zm_nerd":
    case "alt_iw7_knife_zm_jock":
    case "alt_iw7_knife_zm":
    case "iw7_knife_zm_vgirl":
    case "iw7_knife_zm_rapper":
    case "iw7_knife_zm_nerd":
    case "iw7_knife_zm_jock":
    case "alt_iw7_knife_zm_hoff":
    case "iw7_knife_zm_hoff":
    case "iw8_knife_mp":
      return 1;
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_fists_zm_kevinsmith":
    case "iw7_fists_zm_raver":
    case "iw7_fists_zm_hiphop":
    case "iw7_fists_zm_grunge":
    case "iw7_fists_zm_chola":
    case "iw7_fists_zm":
    case "iw7_axe_zm":
      if(istrue(_id_DEB079B105708D8B))
        return 0;
      else
        return 1;
    default:
      return 0;
  }
}

is_primary_melee_weapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

restore_weapons_status(_id_F65A39D9E7391806) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {
    return;
  }
  _id_07408D0572E75D2C = self getweaponslistall();

  foreach(weapon in _id_07408D0572E75D2C) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, weapon) && !in_inclusion_list(_id_F65A39D9E7391806, weapon))
      self takeweapon(weapon);
  }

  if(istrue(self._id_2D1F8B5D21B0710A)) {
    allow_player_basejumping(1, "restore_weapons_status");
    self skydive_cutparachuteon();
    self setclientomnvar("ui_parachuteicon", 1);
  }

  if(isDefined(self.riotshield_return)) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.riotshield_return))
      self.copy_fullweaponlist[self.copy_fullweaponlist.size] = self.riotshield_return;

    self.riotshield_return = undefined;
  }

  foreach(weapon in self.copy_fullweaponlist) {
    if(!self hasweapon(weapon))
      scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, -1, 0, 1);

    weaponname = getcompleteweaponname(weapon);

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == weaponname)
      self assignweaponoffhandprimary(weapon);

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == weaponname)
      self assignweaponoffhandsecondary(weapon);

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == weaponname)
      self assignweaponoffhandspecial(weapon);

    if(isDefined(self.copy_weapon_ammo_clip[weaponname]))
      self setweaponammoclip(weapon, self.copy_weapon_ammo_clip[weaponname]);

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[weaponname]))
        self setweaponammoclip(weapon, self.copy_weapon_ammo_clip_left[weaponname], "left");
    }

    if(isDefined(self.copy_weapon_ammo_stock[weaponname]))
      self setweaponammostock(weapon, self.copy_weapon_ammo_stock[weaponname]);

    if(isDefined(self.copy_weapon_level[weaponname])) {
      struct = spawnStruct();
      struct.lvl = self.copy_weapon_level[weaponname];
      self.pap[getrawbaseweaponname(weapon)] = struct;
    }
  }

  _id_929E81472980EC28 = self.copy_weapon_current;

  if(isundefinedweapon(_id_929E81472980EC28)) {
    foreach(item in self.copy_fullweaponlist) {
      if(scripts\cp_mp\utility\weapon_utility::isbulletweapon(item)) {
        _id_929E81472980EC28 = item;
        break;
      }
    }
  }

  _id_12E2FB553EC1605E::_id_A01818AE9EDECBE6(1);
  _id_12E2FB553EC1605E::_id_A6EB74F88574F882();

  if(_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch"))
    self switchtoweaponimmediate(_id_929E81472980EC28);

  if(!istrue(self.bspawningviaac130)) {
    self.copy_fullweaponlist = undefined;
    self.copy_weapon_current = undefined;
    self.copy_weapon_ammo_clip = undefined;
    self.copy_weapon_ammo_stock = undefined;
    self.copy_weapon_ammo_clip_left = undefined;
  }

  if(isDefined(level.arcade_last_stand_power_func))
    self[[level.arcade_last_stand_power_func]]();
}

restore_primary_weapons_only(_id_F65A39D9E7391806) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  _id_AC0E594AC96AA3A8 = 0;

  foreach(weapon in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(weapon)) {
      self.primary_weapons[_id_AC0E594AC96AA3A8] = weapon;
      _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1;
    }
  }

  count = 0;

  foreach(weapon in self.primary_weapons) {
    if(count < 3) {
      if(weapon.isalternate) {
        continue;
      }
      if(!self hasweapon(weapon))
        self giveweapon(weapon, -1, 0, -1, 1);

      weaponname = getcompleteweaponname(weapon);
      self setweaponammoclip(weapon, self.copy_weapon_ammo_clip[weaponname]);
      self setweaponammostock(weapon, self.copy_weapon_ammo_stock[weaponname]);

      if(isDefined(self.copy_weapon_level[weaponname])) {
        struct = spawnStruct();
        struct.lvl = self.copy_weapon_level[weaponname];
        self.pap[getrawbaseweaponname(weapon)] = struct;
      }

      count++;
    }
  }

  _id_929E81472980EC28 = self.copy_weapon_current;

  if(!isDefined(_id_929E81472980EC28) || !self hasweapon(_id_929E81472980EC28) || isnullweapon(_id_929E81472980EC28))
    _id_929E81472980EC28 = getweapontoswitchbackto();

  self switchtoweaponimmediate(_id_929E81472980EC28);
  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
}

in_inclusion_list(_id_F65A39D9E7391806, _id_A7169FB1DDAF2A8C) {
  if(!isDefined(_id_F65A39D9E7391806))
    return 0;

  return scripts\engine\utility::array_contains(_id_F65A39D9E7391806, _id_A7169FB1DDAF2A8C);
}

vec_multiply(_id_16290C9DDA466BCE, number) {
  return (_id_16290C9DDA466BCE[0] * number, _id_16290C9DDA466BCE[1] * number, _id_16290C9DDA466BCE[2] * number);
}

restore_super_weapon() {
  self giveweapon("super_default_zm");
  self assignweaponoffhandspecial("super_default_zm");
  self.specialoffhandgrenade = "super_default_zm";

  if(istrue(self.consumable_meter_full))
    self setweaponammoclip("super_default_zm", 1);
}

getcloseststruct(org, noteworthy, maxdist) {
  _id_B63085DE741C1A2F = scripts\engine\utility::getStructArray(noteworthy, "script_noteworthy");
  _id_1EC880DDC2010338 = sortbydistance(_id_B63085DE741C1A2F, org)[0];

  if(isDefined(maxdist) && distancesquared(org, _id_1EC880DDC2010338.origin) > squared(maxdist))
    return undefined;

  return _id_1EC880DDC2010338;
}

getfarthest(org, array, maxdist) {
  if(!isDefined(maxdist))
    maxdist = 500000;

  dist = 0;
  ent = undefined;

  foreach(item in array) {
    _id_5C1EE5AB8012EA11 = distance(item.origin, org);

    if(_id_5C1EE5AB8012EA11 <= dist || _id_5C1EE5AB8012EA11 >= maxdist) {
      continue;
    }
    dist = _id_5C1EE5AB8012EA11;
    ent = item;
  }

  return ent;
}

get_average_origin(array) {
  origin = (0, 0, 0);

  foreach(_id_80EF668C09FFB70F in array)
  origin = origin + _id_80EF668C09FFB70F.origin;

  return origin * (1.0 / array.size);
}

is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && (self.species == "humanoid" || self.species == "zombie");
}

is_soldier_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "human";
}

make_entity_sentient_cp(team, _id_3A6FA490549F46D9, _id_F64560838FE13C2D) {
  if(!isDefined(_id_3A6FA490549F46D9))
    _id_3A6FA490549F46D9 = 1;

  if(_id_3A6FA490549F46D9)
    return self makeentitysentient(team, 1, _id_F64560838FE13C2D);
  else
    return self makeentitysentient(team, 0, _id_F64560838FE13C2D);
}

get_attacker_as_player(eattacker) {
  if(isDefined(eattacker)) {
    if(isPlayer(eattacker))
      return eattacker;

    if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
      return eattacker.owner;
  }

  return undefined;
}

getavailableattachments(weaponname, _id_2FBD0E943F095064, _id_1F822F090FFD1B10) {
  if(!isDefined(_id_1F822F090FFD1B10))
    _id_1F822F090FFD1B10 = 1;

  attachments = getweaponattachmentarrayfromstats(weaponname);
  _id_3A974E1DFD9D5CCC = [];

  foreach(attachment in attachments) {
    _id_F98BAFD67872A38C = getattachmenttype(attachment);

    if(!_id_1F822F090FFD1B10 && _id_F98BAFD67872A38C == "rail") {
      continue;
    }
    if(isDefined(_id_2FBD0E943F095064) && listhasattachment(_id_2FBD0E943F095064, attachment)) {
      continue;
    }
    _id_3A974E1DFD9D5CCC[_id_3A974E1DFD9D5CCC.size] = attachment;
  }

  return _id_3A974E1DFD9D5CCC;
}

listhasattachment(attachments, attachment) {
  foreach(attachmentcheck in attachments) {
    if(attachmentcheck == attachment)
      return 1;
  }

  return 0;
}

getweaponattachmentarrayfromstats(weapon) {
  weaponname = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

  if(!isDefined(level.weaponattachments))
    level.weaponattachments = [];

  if(!isDefined(level.weaponattachments[weaponname])) {
    attachments = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      attachment = tablelookup(_id_2669878CF5A1B6BC::_id_591EBA85202CFEB5(), 4, weaponname, 10 + _id_AC0E594AC96AA3A8);

      if(attachment == "") {
        break;
      }

      attachments[attachments.size] = attachment;
    }

    level.weaponattachments[weaponname] = attachments;
  }

  return level.weaponattachments[weaponname];
}

getweaponpaintjobid(_id_B2C6A8F579D4B207) {
  return -1;
}

getweaponcamo(_id_B2C6A8F579D4B207) {
  return "none";
}

getweaponcosmeticattachment(_id_B2C6A8F579D4B207) {
  return "none";
}

getweaponreticle(_id_B2C6A8F579D4B207) {
  return "none";
}

mpbuildweaponname(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_D1FD16429AB57618, _id_0FD85DA04B063943, _id_B022D4BB3C3772B3, cosmeticattachment) {
  attachdefaults = weaponattachdefaultmap(_id_AB501F397D3CD312);
  weaponname = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312, variantid);
  _id_0DD6BF5F9DBA888C = coop_getweaponclass(weaponname);

  if(isDefined(attachdefaults))
    attachments = scripts\engine\utility::array_combine_unique(attachments, attachdefaults);

  attachments = weaponattachremoveextraattachments(attachments);

  for(_id_DC470E9F96950CCF = 0; _id_DC470E9F96950CCF < attachments.size; _id_DC470E9F96950CCF++)
    attachments[_id_DC470E9F96950CCF] = attachments[_id_DC470E9F96950CCF];

  if(isDefined(attachdefaults)) {
    for(_id_DC470E9F96950CCF = 0; _id_DC470E9F96950CCF < attachdefaults.size; _id_DC470E9F96950CCF++)
      attachdefaults[_id_DC470E9F96950CCF] = attachdefaults[_id_DC470E9F96950CCF];
  }

  if(isDefined(attachdefaults))
    attachments = scripts\engine\utility::array_combine_unique(attachments, attachdefaults);

  attachments = scripts\engine\utility::array_remove(attachments, "none");

  if(isDefined(cosmeticattachment) && cosmeticattachment != "none")
    attachments[attachments.size] = cosmeticattachment;

  if(attachments.size > 0)
    attachments = filterattachments(attachments);

  _id_8B1AA9931D355839 = [];

  foreach(a in attachments) {
    extra = _id_2669878CF5A1B6BC::attachmentmap_toextra(a);

    if(isDefined(extra))
      _id_8B1AA9931D355839[_id_8B1AA9931D355839.size] = extra;
  }

  if(_id_8B1AA9931D355839.size > 0)
    attachments = scripts\engine\utility::array_combine_unique(attachments, _id_8B1AA9931D355839);

  if(attachments.size > 0)
    attachments = scripts\engine\utility::alphabetize(attachments);

  weaponname = reassign_weapon_name(weaponname, attachments);

  foreach(attachment in attachments)
  weaponname = weaponname + ("+" + attachment);

  return weaponname;
}

reassign_weapon_name(weaponname, attachments) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(weaponname)]))
    return weaponname;
  else {
    switch (weaponname) {
      case "iw7_machete_mp":
        if(istrue(self.base_weapon))
          weaponname = "iw7_machete_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_machete_mp";
          else
            weaponname = "iw7_machete_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 2) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_machete_mp_pap1";
          else
            weaponname = "iw7_machete_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 3)
          weaponname = "iw7_machete_mp_pap2";

        break;
      case "iw7_two_headed_axe_mp":
        if(istrue(self.base_weapon))
          weaponname = "iw7_two_headed_axe_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_two_headed_axe_mp";
          else
            weaponname = "iw7_two_headed_axe_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 2) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_two_headed_axe_mp_pap1";
          else
            weaponname = "iw7_two_headed_axe_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 3)
          weaponname = "iw7_two_headed_axe_mp_pap2";

        break;
      case "iw7_spiked_bat_mp":
        if(istrue(self.base_weapon))
          weaponname = "iw7_spiked_bat_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_spiked_bat_mp";
          else
            weaponname = "iw7_spiked_bat_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 2) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_spiked_bat_mp_pap1";
          else
            weaponname = "iw7_spiked_bat_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 3)
          weaponname = "iw7_spiked_bat_mp_pap2";

        break;
      case "iw7_golf_club_mp":
        if(istrue(self.base_weapon))
          weaponname = "iw7_golf_club_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_golf_club_mp";
          else
            weaponname = "iw7_golf_club_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 2) {
          if(istrue(self.bang_bangs))
            weaponname = "iw7_golf_club_mp_pap1";
          else
            weaponname = "iw7_golf_club_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(weaponname)]) && self.pap[getrawbaseweaponname(weaponname)].lvl == 3)
          weaponname = "iw7_golf_club_mp_pap2";

        break;
      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(attachments, "axepap1"))
          weaponname = "iw7_axe_zm_pap1";
        else if(scripts\engine\utility::array_contains(attachments, "axepap2"))
          weaponname = "iw7_axe_zm_pap2";

        break;
      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(attachments, "katanapap1"))
          weaponname = "iw7_katana_zm_pap1";
        else if(scripts\engine\utility::array_contains(attachments, "katanapap2"))
          weaponname = "iw7_katana_zm_pap2";

        break;
      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(attachments, "nunchuckspap1"))
          weaponname = "iw7_nunchucks_zm_pap1";
        else if(scripts\engine\utility::array_contains(attachments, "nunchuckspap2"))
          weaponname = "iw7_nunchucks_zm_pap2";

        break;
      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(attachments, "freezepap1"))
          weaponname = "iw7_forgefreeze_zm_pap1";
        else if(scripts\engine\utility::array_contains(attachments, "freezepap2"))
          weaponname = "iw7_forgefreeze_zm_pap2";

        break;
      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(attachments, "shredderpap1"))
          weaponname = "iw7_shredder_zm_pap1";

        break;
      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(attachments, "dischordpap1"))
          weaponname = "iw7_dischord_zm_pap1";

        break;
      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(attachments, "fmpap1"))
          weaponname = "iw7_facemelter_zm_pap1";

        break;
      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(attachments, "hcpap1"))
          weaponname = "iw7_headcutter_zm_pap1";

        break;
    }
  }

  return weaponname;
}

get_weapon_variant_id(player, weapon) {
  base_weapon = getbaseweaponname(weapon);
  return -1;
}

weaponhasvariants(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weapon) {
    case "iw8_la_rpapa7":
      return 0;
    default:
      return 1;
  }
}

weaponattachremoveextraattachments(attachments, weapon) {
  _id_79B6F061BE629059 = [];

  foreach(attachment in attachments) {
    _id_D76A3E9A51BB0F30 = _id_2669878CF5A1B6BC::attachmentmap_toextra(attachment);

    if(isDefined(_id_D76A3E9A51BB0F30))
      _id_79B6F061BE629059[_id_79B6F061BE629059.size] = _id_D76A3E9A51BB0F30;
  }

  _id_A7FA676E63077B06 = [];

  foreach(attachment in attachments) {
    _id_22CC204990BC10A0 = 0;

    foreach(_id_D76A3E9A51BB0F30 in _id_79B6F061BE629059) {
      if(attachment == _id_D76A3E9A51BB0F30) {
        _id_22CC204990BC10A0 = 1;
        break;
      }
    }

    if(!_id_22CC204990BC10A0)
      _id_A7FA676E63077B06[_id_A7FA676E63077B06.size] = attachment;
  }

  return _id_A7FA676E63077B06;
}

weaponattachdefaultmap(weaponname) {
  if(isDefined(level.weaponmapdata[weaponname]) && isDefined(level.weaponmapdata[weaponname].attachdefaults))
    return level.weaponmapdata[weaponname].attachdefaults;

  return undefined;
}

getweaponvariantattachments(weaponname, variantid) {
  attachments = [];
  passives = getweaponpassives(weaponname, variantid);

  if(isDefined(passives)) {
    foreach(_id_F8B2E6BF3F40AB02 in passives) {
      _id_077134C6DD01475F = getpassiveattachment(_id_F8B2E6BF3F40AB02);

      if(!isDefined(_id_077134C6DD01475F)) {
        continue;
      }
      attachments[attachments.size] = _id_077134C6DD01475F;
    }
  }

  return attachments;
}

getpassiveattachment(_id_F8B2E6BF3F40AB02) {
  struct = getpassivestruct(_id_F8B2E6BF3F40AB02);

  if(!isDefined(struct) || !isDefined(struct.attachmentref))
    return undefined;

  return struct.attachmentref;
}

getweaponpassives(weaponname, variantid) {
  return getpassivesforweapon(weaponname, variantid);
}

getpassivesforweapon(_id_5C3F9357F11D2223, variantid) {
  _id_60CE74182E7C83A7 = getlootinfoforweapon(_id_5C3F9357F11D2223, variantid);

  if(isDefined(_id_60CE74182E7C83A7))
    return _id_60CE74182E7C83A7.passives;

  return undefined;
}

getlootinfoforweapon(_id_5C3F9357F11D2223, variantid) {
  if(!isDefined(variantid))
    return undefined;

  if(isDefined(level.lootweaponcache[_id_5C3F9357F11D2223]) && isDefined(level.lootweaponcache[_id_5C3F9357F11D2223][variantid])) {
    weaponinfo = level.lootweaponcache[_id_5C3F9357F11D2223][variantid];
    return weaponinfo;
  }

  weaponinfo = cachelootweaponweaponinfo(_id_5C3F9357F11D2223, variantid);

  if(isDefined(weaponinfo))
    return weaponinfo;

  return undefined;
}

getdefaultweaponbasename(basename) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(basename);

  if(isDefined(level.weaponmapdata[_id_AB501F397D3CD312]) && isDefined(level.weaponmapdata[_id_AB501F397D3CD312].assetname))
    basename = level.weaponmapdata[_id_AB501F397D3CD312].assetname;

  return basename;
}

cachelootweaponweaponinfo(_id_5C3F9357F11D2223, variantid) {
  if(!isDefined(level.lootweaponcache[_id_5C3F9357F11D2223]))
    level.lootweaponcache[_id_5C3F9357F11D2223] = [];

  _id_0C6C779C138E8C65 = getweaponloottable(_id_5C3F9357F11D2223);
  weaponinfo = readweaponinfofromtable(_id_0C6C779C138E8C65, variantid, _id_5C3F9357F11D2223);
  level.lootweaponcache[_id_5C3F9357F11D2223][variantid] = weaponinfo;
  return weaponinfo;
}

readweaponinfofromtable(_id_0B2F2B716DA5389C, variantid, _id_5C3F9357F11D2223) {
  struct = spawnStruct();
  _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(_id_5C3F9357F11D2223);
  ref = _id_4BB9768282D4260D + "|" + variantid;
  struct.ref = ref;
  struct.weaponasset = level.weaponlootmapdata[ref].assetname;
  struct.variantid = variantid;
  return struct;
}

create_fake_loot_model_from_struct(struct) {
  _id_BD05768F71EA1725 = spawn("script_model", struct.origin);
  _id_BD05768F71EA1725 setModel("container_ammo_box_01_nophysics");
  _id_BD05768F71EA1725.angles = struct.angles;
  _id_BD05768F71EA1725.targetname = struct.targetname;
  return _id_BD05768F71EA1725;
}

create_fake_loot(_id_4AC65F89B80C4028) {
  if(istrue(self.available)) {
    return;
  }
  if(istrue(level.disable_map_munitions)) {
    return;
  }
  self show();
  self.available = 1;
  types = undefined;

  if(isDefined(_id_4AC65F89B80C4028)) {
    if(isstring(_id_4AC65F89B80C4028))
      types = [_id_4AC65F89B80C4028];
    else
      types = _id_4AC65F89B80C4028;
  } else if(istrue(level.disable_map_ammo_munitions))
    types = ["brloot_munition_grenade_crate", "brloot_munition_armor"];
  else
    types = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];

  self.loot_type = scripts\engine\utility::random(types);
  _id_C103BFC366A53063 = &"COOP_CRAFTING/AMMO_CRATE";

  switch (self.loot_type) {
    case "brloot_munition_grenade_crate":
      _id_C103BFC366A53063 = &"CP_BR/GRENADE_CRATE";
      break;
    case "brloot_munition_armor":
      _id_C103BFC366A53063 = &"CP_BR/ARMOR_CRATE";
      break;
    case "brloot_munition_deployable_cover":
      _id_C103BFC366A53063 = &"EQUIPMENT/TACTICAL_COVER";
      break;
  }

  self setModel("offhand_wm_supportbox_killstreak");
  self.origin = self.origin + (0, 0, 16);

  if(self tagexists("tag_use"))
    sethintobject("tag_use", "HINT_BUTTON", undefined, _id_C103BFC366A53063, 25, "duration_none", "show", 128, 80, 128, 80);
  else
    sethintobject(undefined, "HINT_BUTTON", undefined, _id_C103BFC366A53063, 25, "duration_none", "show", 128, 80, 128, 80);

  for(;;) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }
    if(!scripts\cp\loot_system::give_munition(self.loot_type, player)) {
      continue;
    }
    self playsoundtoplayer("scavenger_pack_pickup", player);
    self makeunusable();
    self hide();
    self.available = 0;
    return;
  }
}

filterattachments(attachments) {
  _id_7CB19F95DBC68942 = [];

  if(isDefined(attachments)) {
    for(_id_04830F0AB7107D9B = 0; _id_04830F0AB7107D9B < attachments.size; _id_04830F0AB7107D9B++) {
      attachment = attachments[_id_04830F0AB7107D9B];

      if(attachment == "none") {
        continue;
      }
      add = 1;

      for(_id_DDEBF4E10BB16DB6 = 0; _id_DDEBF4E10BB16DB6 < _id_7CB19F95DBC68942.size; _id_DDEBF4E10BB16DB6++) {
        if(attachment == _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6]) {
          add = 0;
          break;
        }

        _id_609C88FD5E06F606 = _id_2669878CF5A1B6BC::attachmentsconflict(attachment, _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6]);

        if(_id_609C88FD5E06F606 != "") {
          add = 0;
          _id_7CB19F95DBC68942 = scripts\engine\utility::array_remove_index(_id_7CB19F95DBC68942, _id_DDEBF4E10BB16DB6);
          _id_6D1E03F37D922BBB = [];
          _id_6D1E03F37D922BBB = strtok(_id_609C88FD5E06F606, " ");

          foreach(_id_AC0E594AC96AA3A8, _id_620A120986D0F82A in _id_6D1E03F37D922BBB)
          attachments = scripts\engine\utility::array_insert(attachments, _id_620A120986D0F82A, _id_04830F0AB7107D9B + 1 + _id_AC0E594AC96AA3A8);

          break;
        }
      }

      if(add)
        _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = attachment;
    }
  }

  return _id_7CB19F95DBC68942;
}

getpassivestruct(_id_F8B2E6BF3F40AB02) {
  if(!isDefined(level.passivemap[_id_F8B2E6BF3F40AB02]))
    return undefined;

  struct = level.passivemap[_id_F8B2E6BF3F40AB02];
  return struct;
}

map_check(_id_684DA0559BA7C79C) {
  if(!isDefined(_id_684DA0559BA7C79C))
    return 1;

  switch (_id_684DA0559BA7C79C) {
    case 0:
      if(level.script == "cp_zmb")
        return 1;
      else
        return 0;
    case 1:
      if(level.script == "cp_rave")
        return 1;
      else
        return 0;
    case 2:
      if(level.script == "cp_disco")
        return 1;
      else
        return 0;
    case 3:
      if(level.script == "cp_town")
        return 1;
      else
        return 0;
    default:
      return 1;
  }
}

buildweaponnamevariantid(weaponname, variantid) {
  if(!isDefined(variantid) || variantid < 0)
    return weaponname;

  weaponname = weaponname + ("+loot" + variantid);
  return weaponname;
}

isholidayweapon(weaponname, variantid) {
  if(!isDefined(variantid) || variantid < 0)
    return 0;

  if(variantid == 6) {
    _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
    return _id_4BB9768282D4260D == "iw7_ripper" || _id_4BB9768282D4260D == "iw7_lmg03" || _id_4BB9768282D4260D == "iw7_ar57";
  }

  return 0;
}

buildweaponnamecamo(weaponname, _id_5CFF225355038142, variantid) {
  if(!isDefined(_id_5CFF225355038142))
    return weaponname;

  if(_id_5CFF225355038142 == "none")
    return weaponname;

  return weaponname + "+camo|" + _id_5CFF225355038142;
}

buildweaponnamereticle(weaponname, _id_763BF17ADB1939E4) {
  if(!isDefined(_id_763BF17ADB1939E4))
    return weaponname;

  _id_7CD7A4C761684176 = int(tablelookup("mp/reticleTable.csv", 1, _id_763BF17ADB1939E4, 5));

  if(!isDefined(_id_7CD7A4C761684176) || _id_7CD7A4C761684176 == 0)
    return weaponname;

  weaponname = weaponname + ("+scope" + _id_7CD7A4C761684176);
  return weaponname;
}

has_zombie_perk(_id_D2769810C4BAD341) {
  if(!isDefined(self.zombies_perks))
    return 0;

  return istrue(self.zombies_perks[_id_D2769810C4BAD341]);
}

drawsphere(origin, radius, _id_BC08E2B32A09AB5A, color) {
  if(!isDefined(color))
    color = (1, 1, 1);

  _id_47D735016BAE708E = int(_id_BC08E2B32A09AB5A * 20);

  for(time = 0; time < _id_47D735016BAE708E; time++)
    wait 0.05;
}

_id_03EA84AB28DEA3F8() {
  return istrue(self.has_auto_revive) && istrue(self._id_0BBC9FFD2DF014C2);
}

has_auto_revive() {
  return istrue(self.has_auto_revive);
}

enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
}

get_closest_living_player(_id_45E808DC306D0926, _id_908ECECF1B52292E) {
  _id_07296729673615C7 = 1073741824;

  if(isDefined(_id_45E808DC306D0926))
    _id_07296729673615C7 = _id_45E808DC306D0926;

  _id_C729D49D406ACED8 = undefined;
  _id_2A29B237DCC66FE5 = level.players;

  if(isDefined(_id_908ECECF1B52292E))
    _id_2A29B237DCC66FE5 = _id_908ECECF1B52292E;

  foreach(player in _id_2A29B237DCC66FE5) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, player)) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    _id_A9B6B677F6D0A010 = distancesquared(self.origin, player.origin);

    if(player scripts\cp_mp\utility\player_utility::_isalive() && _id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_C729D49D406ACED8 = player;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_C729D49D406ACED8;
}

get_array_of_valid_players(_id_C0D8B4D847B4F723, _id_030A716428AC01EA) {
  _id_E031661B7146A294 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] is_valid_player())
      _id_E031661B7146A294[_id_E031661B7146A294.size] = level.players[_id_AC0E594AC96AA3A8];

    waitframe();
  }

  if(!isDefined(_id_C0D8B4D847B4F723) || !_id_C0D8B4D847B4F723)
    return _id_E031661B7146A294;

  return scripts\engine\utility::get_array_of_closest(_id_030A716428AC01EA, _id_E031661B7146A294);
}

is_valid_player(_id_873769D3E3EC0986, _id_9DBB64A4BD4C63BF) {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "spectator")
    return 0;

  if(!isDefined(_id_873769D3E3EC0986) && _id_0AFB7E332AEE4BF2::player_in_laststand(self))
    return 0;

  if(!isDefined(_id_9DBB64A4BD4C63BF))
    _id_9DBB64A4BD4C63BF = 1;

  if(!istrue(_id_9DBB64A4BD4C63BF) && (istrue(self.infreefall) || istrue(self.inparachute)))
    return 0;

  return 1;
}

any_player_nearby(origin, _id_A9B6B677F6D0A010) {
  if(!isDefined(_id_A9B6B677F6D0A010))
    _id_A9B6B677F6D0A010 = 40000;

  foreach(player in level.players) {
    if(distancesquared(player.origin, origin) < _id_A9B6B677F6D0A010)
      return 1;
  }

  return 0;
}

give_closest_player_nearby(origin, _id_A9B6B677F6D0A010, _id_99E096596CA0901F) {
  _id_927719C9F1B31B0F = [];

  foreach(player in level.players) {
    if(isDefined(_id_99E096596CA0901F) && player.team != _id_99E096596CA0901F) {
      continue;
    }
    if(distancesquared(player.origin, origin) < _id_A9B6B677F6D0A010)
      _id_927719C9F1B31B0F[_id_927719C9F1B31B0F.size] = player;
  }

  if(_id_927719C9F1B31B0F.size > 0) {
    _id_E8818CEF9E981E08 = sortbydistance(_id_927719C9F1B31B0F, origin);
    return _id_E8818CEF9E981E08[0];
  }

  return undefined;
}

are_all_players_nearby(origin, _id_A9B6B677F6D0A010) {
  waittime = undefined;

  if(level.players.size > 10)
    waittime = 0.05;

  foreach(player in level.players) {
    if(distancesquared(player.origin, origin) > _id_A9B6B677F6D0A010)
      return 0;

    if(isDefined(waittime))
      wait(waittime);
  }

  return 1;
}

give_all_players_nearby(origin, _id_A9B6B677F6D0A010) {
  _id_F47DD9D668CC52E2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, origin) < _id_A9B6B677F6D0A010)
      _id_F47DD9D668CC52E2[_id_F47DD9D668CC52E2.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  return _id_F47DD9D668CC52E2;
}

is_playing_pain_breathing_sfx(player) {
  return istrue(player.is_playing_pain_breathing_sfx);
}

get_pain_breathing_sfx_alias(player) {
  if(!level.gameended) {
    if(player.vo_prefix == "p1_")
      return "p1_plr_pain";
    else if(player.vo_prefix == "p2_")
      return "p2_plr_pain";
    else if(player.vo_prefix == "p3_")
      return "p3_plr_pain";
    else if(player.vo_prefix == "p4_")
      return "p4_plr_pain";
    else if(player.vo_prefix == "p5_")
      return "p5_plr_pain";
    else
      return "p3_plr_pain";
  }
}

get_within_range(org, array, dist) {
  guys = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(distance(array[_id_AC0E594AC96AA3A8].origin, org) <= dist)
      guys[guys.size] = array[_id_AC0E594AC96AA3A8];
  }

  return guys;
}

breathingmanager(_id_D8A5120850E80915, healthratio) {
  self notify("breathingManager");
  self endon("breathingManager");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(isusingremote()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self.breathingstoptime = _id_D8A5120850E80915 + 6000 * self.regenduration;
  wait(6 * self.regenduration);

  if(!level.gameended) {
    if(!isDefined(self.vo_prefix)) {
      return;
    }
    if(!istrue(self.vo_system_playing_vo)) {
      if(isfemale())
        playlocalsound_safe("Fem_breathing_better");
      else
        playlocalsound_safe("breathing_better");
    }
  }
}

getregendata(_id_7714B89C368A249E) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\cp_prestige::prestige_getslowhealthregenscalar();
  _id_DAB7912FAD3875BF = 1;

  if(isDefined(self.perk_data)) {
    if(isDefined(self.perk_data["regen_time_scalar"]))
      _id_DAB7912FAD3875BF = self.perk_data["regen_time_scalar"];
    else
      _id_DAB7912FAD3875BF = self.perk_data["health"].regen_time_scalar;
  }

  if(self.prestigehealthregennerfscalar == 1.0) {
    if(is_consumable_active("faster_health_regen_upgrade")) {
      _id_7714B89C368A249E.activatetime = 0.45;
      _id_7714B89C368A249E.waittimebetweenregen = 0.045;
      _id_7714B89C368A249E.regenamount = 0.1;
    } else {
      _id_7714B89C368A249E.activatetime = 6;
      _id_7714B89C368A249E.waittimebetweenregen = 0.05;
      _id_7714B89C368A249E.regenamount = 6 * _id_DAB7912FAD3875BF;
    }
  } else {
    _id_7714B89C368A249E.activatetime = 6 * self.prestigehealthregennerfscalar;
    _id_7714B89C368A249E.waittimebetweenregen = 0.05 * self.prestigehealthregennerfscalar;
    _id_7714B89C368A249E.regenamount = 6;
  }
}

resetattackerlist(_id_A2B85B5EBFE28C6B) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.75;
  resetattackerlist_internal();
}

resetattackerlist_internal() {
  self.attackers = [];
  self.attackerdata = [];
}

canregenhealth() {
  if(getdvarint("dvar_0C51A261DFE1EB96", 0) == 1)
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(_id_0AFB7E332AEE4BF2::player_in_laststand(self))
    return 0;

  if(istrue(self.fauxdead))
    return 0;

  if(istrue(self.disable_health_regen))
    return 0;

  if(istrue(self.relic_disable_health_regen))
    return 0;

  return 1;
}

ishealthregendisabled() {
  return isDefined(level.healthregendisabled) && level.healthregendisabled || isDefined(self.healthregendisabled) && self.healthregendisabled;
}

allow_secondary_offhand_weapons(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    if(!isDefined(self.disabledsecondaryoffhandweapons))
      self.disabledsecondaryoffhandweapons = 0;

    self.disabledsecondaryoffhandweapons--;

    if(!self.disabledsecondaryoffhandweapons)
      self enableoffhandsecondaryweapons();
  } else {
    if(!isDefined(self.disabledsecondaryoffhandweapons))
      self.disabledsecondaryoffhandweapons = 0;

    self.disabledsecondaryoffhandweapons++;
    self disableoffhandsecondaryweapons();
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", _id_C92EF281C1D335FC, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, _id_0B941BAEEBCA428D);

    if(isDefined(_id_C92EF281C1D335FC) && isDefined(_id_C92EF281C1D335FC.phys_sound_func))
      level thread[[_id_C92EF281C1D335FC.phys_sound_func]](_id_C92EF281C1D335FC, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, _id_0B941BAEEBCA428D);
  }
}

ent_is_near_equipment(ent) {
  _id_D43D6364668556C7 = 16384;

  if(level.turrets.size) {
    _id_DFDD438871090D04 = sortbydistance(level.turrets, ent.origin);

    if(distance2dsquared(_id_DFDD438871090D04[0].origin, ent.origin) < _id_D43D6364668556C7)
      return 1;
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(trap in level.placed_crafted_traps) {
      if(!isDefined(trap)) {
        continue;
      }
      if(distance2dsquared(trap.origin, ent.origin) < _id_D43D6364668556C7)
        return 1;
    }
  }

  if(isDefined(level.near_equipment_func))
    return [[level.near_equipment_func]](ent);

  return 0;
}

set_crafted_inventory_item(_id_A7169FB1DDAF2A8C, _id_E8188E6CADB7EA53, player) {
  if(isDefined(player.current_crafted_inventory))
    player.current_crafted_inventory = undefined;

  player.current_crafted_inventory = spawnStruct();
  player.current_crafted_inventory.item = _id_A7169FB1DDAF2A8C;
  player.current_crafted_inventory.restore_func = _id_E8188E6CADB7EA53;
}

remove_crafted_item_from_inventory(player) {
  player.current_crafted_inventory = undefined;
}

item_handleownerdisconnect(_id_BF850ADA23F636B0) {
  self endon("death");
  level endon("game_ended");
  self notify(_id_BF850ADA23F636B0);
  self endon(_id_BF850ADA23F636B0);
  self.owner waittill("disconnect");

  foreach(player in level.players) {
    if(player is_valid_player(1)) {
      self.owner = player;

      if(self.classname != "script_model")
        self setsentryowner(self.owner);

      break;
    }
  }

  thread item_handleownerdisconnect(_id_BF850ADA23F636B0);
}

restore_player_perk() {
  if(isDefined(self.restoreperk)) {
    giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

wait_restore_player_perk() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restore_player_perk();
}

remove_player_perks() {
  if(_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    _unsetperk("specialty_explosivebullets");
  }
}

item_timeout(lifespan, _id_2F58E0C81044AC85, _id_830905E5C2645826) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.lifespan))
    self.lifespan = _id_2F58E0C81044AC85;

  if(isDefined(lifespan))
    self.lifespan = lifespan;

  while(self.lifespan) {
    wait 1.0;
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      self.lifespan = max(0, self.lifespan - 1.0);
  }

  while(isDefined(self) && isDefined(self.inuseby))
    wait 0.05;

  if(isDefined(self.zap_model))
    self.zap_model delete();

  if(isDefined(_id_830905E5C2645826))
    self notify(_id_830905E5C2645826);
  else
    self notify("death");
}

item_oncarrierdeath(carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");
  result = carrier scripts\engine\utility::waittill_any_return_2("death", "last_stand");
  carrier notify("force_cancel_placement");
}

item_oncarrierdisconnect(carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("last_stand");
  carrier waittill("disconnect");

  if(isDefined(self.carriedgascan))
    self.carriedgascan delete();
  else if(isDefined(self.carriedmedusa))
    self.carriedmedusa delete();
  else if(isDefined(self.carried_trap))
    self.carried_trap delete();
  else if(isDefined(self.carriedboombox))
    self.carriedboombox delete();
  else if(isDefined(self.carried_fireworks_trap))
    self.carried_fireworks_trap delete();
  else if(isDefined(self.carriedrevocator))
    self.carriedrevocator delete();

  self delete();
}

item_ongameended(carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("last_stand");
  level waittill("game_ended");
  self delete();
}

should_be_affected_by_trap(ent, _id_4D0BD8CEE4C886B2, _id_B0C9E40DD558140F) {
  if(!isDefined(ent))
    return 0;

  if(!isalive(ent))
    return 0;

  if(!isagent(ent))
    return 0;

  if(!isDefined(ent.agent_type))
    return 0;

  if(!isDefined(ent.isactive) || !ent.isactive)
    return 0;

  if(!isDefined(_id_4D0BD8CEE4C886B2) && isDefined(ent.entered_playspace) && !ent.entered_playspace)
    return 0;

  if(istrue(ent.marked_for_death))
    return 0;

  if(!isDefined(ent.team))
    return 0;

  if(ent.agent_type == "zombie_brute" || ent.agent_type == "zombie_ghost" || ent.agent_type == "zombie_grey")
    return 0;

  if(!istrue(_id_B0C9E40DD558140F) && istrue(ent.is_suicide_bomber))
    return 0;

  if(istrue(ent.is_coaster_zombie))
    return 0;

  return 1;
}

roundup(_id_B4A0DB97EE6D9256) {
  if(_id_B4A0DB97EE6D9256 - int(_id_B4A0DB97EE6D9256) >= 0.5)
    return int(_id_B4A0DB97EE6D9256 + 1);
  else
    return int(_id_B4A0DB97EE6D9256);
}

damage_over_time(victim, attacker, duration, _id_48295D2521469737, smeansofdeath, sweapon, _id_1CB05AFCC5D57BBE, state, _id_F677D73AB46E88FC) {
  if(!should_apply_dot(victim)) {
    return;
  }
  victim endon("death");

  if(!isDefined(_id_48295D2521469737))
    _id_48295D2521469737 = 600;

  if(!isDefined(duration))
    duration = 5;

  if(!isDefined(smeansofdeath))
    smeansofdeath = "MOD_UNKNOWN";

  if(!isDefined(sweapon))
    sweapon = "iw7_dot_zm";

  if(isDefined(state)) {
    victim setscriptablestateflag(victim, state, 1);

    if(isDefined(level.scriptablestatefunc))
      victim thread[[level.scriptablestatefunc]](victim);
  }

  _id_6747992B3D918F29 = 0;
  _id_1FF426B6DE9CA538 = 6;
  _id_7F7CCFF7467A13B4 = duration / _id_1FF426B6DE9CA538;
  _id_3985150C8F1E8E34 = _id_48295D2521469737 / _id_1FF426B6DE9CA538;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1FF426B6DE9CA538; _id_AC0E594AC96AA3A8++) {
    wait(_id_7F7CCFF7467A13B4);

    if(isalive(victim)) {
      victim.flame_damage_time = gettime() + 500;

      if(victim.health - _id_3985150C8F1E8E34 <= 0) {
        if(isDefined(_id_F677D73AB46E88FC))
          level notify(_id_F677D73AB46E88FC);
      }

      if(isDefined(attacker)) {
        victim dodamage(_id_3985150C8F1E8E34, victim.origin, attacker, attacker, smeansofdeath, sweapon);
        continue;
      }

      victim dodamage(_id_3985150C8F1E8E34, victim.origin, undefined, undefined, smeansofdeath, sweapon);
    }
  }

  if(isDefined(state))
    victim setscriptablestateflag(victim, state);

  if(istrue(victim.marked_for_death))
    victim.marked_for_death = undefined;

  if(istrue(victim.flame_damage_time))
    victim.flame_damage_time = undefined;
}

setscriptablestateflag(victim, state, active) {
  switch (state) {
    case "combinedArcane":
    case "combinedarcane":
      if(istrue(active))
        victim.is_afflicted = 1;
      else
        victim.is_afflicted = undefined;

      break;
    case "burning":
      if(istrue(active))
        victim.is_burning = active;
      else
        victim.is_burning = undefined;

      break;
    case "electrified":
      if(istrue(active)) {
        victim.is_electrified = active;
        victim.allowpain = 1;
        victim.stun_hit_time = gettime() + 3000;
      } else {
        victim.is_electrified = undefined;
        victim.allowpain = 0;
      }

      break;
    case "shocked":
      if(istrue(active))
        victim.stunned = active;
      else
        victim.stunned = undefined;

      break;
    case "chemBurn":
    case "chemburn":
      if(istrue(active))
        victim.is_chem_burning = 1;
      else
        victim.is_chem_burning = undefined;

      break;
    default:
      break;
  }
}

should_apply_dot(victim) {
  if(isDefined(victim.agent_type) && (victim.agent_type == "c6" || victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "zombie_ghost"))
    return 0;

  return 1;
}

is_codxp() {
  return getDvar("scr_codxp", "") != "";
}

getweapontoswitchbackto() {
  _id_CCB5A3F6FCEE809E = undefined;

  if(isDefined(self.last_weapon))
    _id_CCB5A3F6FCEE809E = self.last_weapon;
  else
    _id_CCB5A3F6FCEE809E = self getcurrentweapon();

  _id_C19139AA4333CC8F = 0;
  _id_CD71448FD6B9EB3F = level.additional_laststand_weapon_exclusion;

  if(isnullweapon(_id_CCB5A3F6FCEE809E))
    _id_C19139AA4333CC8F = 1;
  else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E))
    _id_C19139AA4333CC8F = 1;
  else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E getbaseweapon()))
    _id_C19139AA4333CC8F = 1;
  else if(is_melee_weapon(_id_CCB5A3F6FCEE809E, 1))
    _id_C19139AA4333CC8F = 1;

  if(_id_C19139AA4333CC8F) {
    _id_8CAC01EF5BCB1816 = self getweaponslistall();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8CAC01EF5BCB1816.size; _id_AC0E594AC96AA3A8++) {
      if(isnullweapon(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8]))
        continue;
      else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8]))
        continue;
      else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8] getbaseweapon()))
        continue;
      else if(is_melee_weapon(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8], 1))
        continue;
      else if(!_id_74502A9E0EF1F19C::isprimaryweapon(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8]))
        continue;
      else {
        _id_C19139AA4333CC8F = 0;
        _id_CCB5A3F6FCEE809E = _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  if(_id_C19139AA4333CC8F) {
    _id_CCB5A3F6FCEE809E = makeweapon("iw9_me_fists_mp");

    if(!self hasweapon(_id_CCB5A3F6FCEE809E))
      _giveweapon(_id_CCB5A3F6FCEE809E, undefined, undefined, 1);
  }

  return _id_CCB5A3F6FCEE809E;
}

getvalidtakeweapon(_id_19E2338FA9DC0523) {
  _id_CCB5A3F6FCEE809E = self getcurrentweapon();
  _id_C19139AA4333CC8F = 0;
  _id_CD71448FD6B9EB3F = level.additional_laststand_weapon_exclusion;

  if(isDefined(_id_19E2338FA9DC0523))
    _id_CD71448FD6B9EB3F = scripts\engine\utility::array_combine(_id_19E2338FA9DC0523, _id_CD71448FD6B9EB3F);

  if(isnullweapon(_id_CCB5A3F6FCEE809E))
    _id_C19139AA4333CC8F = 1;
  else if(isDefined(_id_CCB5A3F6FCEE809E.inventorytype) && _id_CCB5A3F6FCEE809E.inventorytype == "model_only")
    _id_C19139AA4333CC8F = 1;
  else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E))
    _id_C19139AA4333CC8F = 1;
  else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E getbaseweapon()))
    _id_C19139AA4333CC8F = 1;
  else if(!is_wave_gametype() && is_melee_weapon(_id_CCB5A3F6FCEE809E, 1))
    _id_C19139AA4333CC8F = 1;

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && _id_C19139AA4333CC8F) {
    _id_CCB5A3F6FCEE809E = self.last_valid_weapon;

    if(isnullweapon(_id_CCB5A3F6FCEE809E))
      _id_C19139AA4333CC8F = 1;
    else if(isDefined(_id_CCB5A3F6FCEE809E.inventorytype) && _id_CCB5A3F6FCEE809E.inventorytype == "model_only")
      _id_C19139AA4333CC8F = 1;
    else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E))
      _id_C19139AA4333CC8F = 1;
    else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_CCB5A3F6FCEE809E getbaseweapon()))
      _id_C19139AA4333CC8F = 1;
    else if(is_melee_weapon(_id_CCB5A3F6FCEE809E, 1))
      _id_C19139AA4333CC8F = 1;
    else
      _id_C19139AA4333CC8F = 0;
  }

  if(_id_C19139AA4333CC8F) {
    _id_8CAC01EF5BCB1816 = self getweaponslistall();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8CAC01EF5BCB1816.size; _id_AC0E594AC96AA3A8++) {
      if(isnullweapon(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8]))
        continue;
      else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8]))
        continue;
      else if(scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8] getbaseweapon()))
        continue;
      else if(is_melee_weapon(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8], 1))
        continue;
      else if(isDefined(_id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8].inventorytype) && _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8].inventorytype == "model_only")
        continue;
      else {
        _id_C19139AA4333CC8F = 0;
        _id_CCB5A3F6FCEE809E = _id_8CAC01EF5BCB1816[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  return _id_CCB5A3F6FCEE809E;
}

add_to_notify_queue(_id_7239F8830EF22B43, param1, param2, param3, param4, param5, param6, param7, param8) {
  if(!isDefined(self.notify_queue))
    self.notify_queue = [];

  if(!isDefined(self.notify_queue[_id_7239F8830EF22B43]))
    self.notify_queue[_id_7239F8830EF22B43] = 0;
  else
    self.notify_queue[_id_7239F8830EF22B43]++;

  if(self.notify_queue[_id_7239F8830EF22B43] > 0)
    wait(0.05 * self.notify_queue[_id_7239F8830EF22B43]);

  if(isDefined(self))
    self notify(_id_7239F8830EF22B43, param1, param2, param3, param4, param5, param6, param7, param8);

  waittillframeend;

  if(isDefined(self)) {
    if(isDefined(self.notify_queue[_id_7239F8830EF22B43])) {
      self.notify_queue[_id_7239F8830EF22B43]--;

      if(self.notify_queue[_id_7239F8830EF22B43] < 1)
        self.notify_queue[_id_7239F8830EF22B43] = undefined;
    }
  }
}

playlocalsound_safe(_id_A077D48535D8EC67) {
  if(soundexists(_id_A077D48535D8EC67))
    self playlocalsound(_id_A077D48535D8EC67);
}

playsoundatpos_safe(pos, _id_A077D48535D8EC67) {
  if(soundexists(_id_A077D48535D8EC67))
    playsoundatpos(pos, _id_A077D48535D8EC67);
}

playsoundtoplayer_safe(_id_A077D48535D8EC67, player) {
  if(soundexists(_id_A077D48535D8EC67))
    player playsoundtoplayer(_id_A077D48535D8EC67, player);
}

agentisfnfimmune() {
  return isDefined(self.agent_type) && isDefined(level.fnfimmune) && scripts\engine\utility::array_contains(level.fnfimmune, self.agent_type);
}

agentisinstakillimmune() {
  return isDefined(self.agent_type) && isDefined(level.instakillimmune) && scripts\engine\utility::array_contains(level.instakillimmune, self.agent_type);
}

firegesturegrenade(player, gestureweapon) {
  currentweapon = player getcurrentweapon();

  if(cangiveandfireoffhand(currentweapon)) {
    player setweaponammostock(gestureweapon, 1);
    player giveandfireoffhand(gestureweapon);
  }
}

cangiveandfireoffhand(currentweapon) {
  if(!isDefined(currentweapon))
    return 1;

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(currentweapon)]))
      return 0;
    else
      return 1;
  } else
    return 1;
}

playerplaypickupanim(_id_DFC0F79FA9CB692E) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || isplayerads()) {
    return;
  }
  if(!isDefined(_id_DFC0F79FA9CB692E))
    _id_DFC0F79FA9CB692E = "iw9_ges_pickup";

  _id_13516EF685B23D13 = makeweapon("none");
  _id_04A8F5643E919524 = self getcurrentprimaryweapon();

  if(issameweapon(_id_04A8F5643E919524, _id_13516EF685B23D13)) {
    return;
  }
  if(self isgestureplaying(_id_DFC0F79FA9CB692E)) {
    self stopgestureviewmodel(_id_DFC0F79FA9CB692E, 0, 1);
    wait 0.05;
  }

  self forceplaygestureviewmodel(_id_DFC0F79FA9CB692E);
}

playerplaytakephotoanim() {
  _id_D5958F44DF33323A = "intel_take_photo";
  _id_81846C5D601875EF = self getcurrentweapon();
  _id_DE88CD14114C1E24 = makeweapon(_id_D5958F44DF33323A);
  thread _freeze_until_phototaken();
  _giveweapon(_id_DE88CD14114C1E24);
  self switchtoweapon(_id_DE88CD14114C1E24);
  self setclientomnvar("ui_tablet_usb", 7);
  wait_time = 3;
  wait(wait_time);

  if(isPlayer(self)) {
    self takeweapon(_id_DE88CD14114C1E24);
    self switchtoweapon(_id_81846C5D601875EF);
    self setclientomnvar("ui_tablet_usb", 0);
    return 1;
  }

  return 0;
}

_freeze_until_phototaken() {
  _id_6497396FB64EA3B9 = self getstance();
  _togglecellphoneallows(1);
  restrict_player_stance_to_this("photo", 1, _id_6497396FB64EA3B9);
  wait_time = 1.6;
  wait(wait_time);
  _togglecellphoneallows(0);
  restrict_player_stance_to_this("photo", 0, _id_6497396FB64EA3B9);
}

_togglecellphoneallows(_id_7CF474A446AF159D) {
  _freezelookcontrols(_id_7CF474A446AF159D);

  if(_id_7CF474A446AF159D) {
    _id_3B64EB40368C1450::set("cellphone", "allow_movement", 0);
    _id_3B64EB40368C1450::set("cellphone", "allow_jump", 0);
    _id_3B64EB40368C1450::set("cellphone", "usability", 0);
    _id_3B64EB40368C1450::set("cellphone", "melee", 0);
    _id_3B64EB40368C1450::set("cellphone", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("cellphone", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("cellphone", "sprint", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cellphone");
}

_id_5D353EF59919F42C(_id_C4AD7E98D18B64DF, _id_E8934BB303B521F8) {
  self endon("death_or_disconnect");

  if(!isDefined(_id_C4AD7E98D18B64DF))
    _id_C4AD7E98D18B64DF = 1.25;

  thread playerplaypickupanim("ges_radio");

  if(isDefined(_id_E8934BB303B521F8))
    scripts\engine\utility::flag_wait(_id_E8934BB303B521F8);
  else
    wait(_id_C4AD7E98D18B64DF);

  self stopgestureviewmodel("ges_radio");
}

restrict_player_stance_to_this(_id_401C3A2E68AAB0FD, _id_41D8BF229CF29051, stance) {
  if(istrue(_id_41D8BF229CF29051))
    _player_allowed_stances(_id_401C3A2E68AAB0FD, 1, stance);
  else
    _player_allowed_stances(_id_401C3A2E68AAB0FD, 0, stance);
}

_player_allowed_stances(_id_401C3A2E68AAB0FD, _id_41D8BF229CF29051, stance) {
  if(istrue(_id_41D8BF229CF29051)) {
    switch (stance) {
      case "stand":
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "crouch", 0);
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "prone", 0);
        break;
      case "crouch":
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "stand", 0);
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "prone", 0);
        break;
      case "prone":
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "crouch", 0);
        _id_3B64EB40368C1450::set(_id_401C3A2E68AAB0FD, "stand", 0);
        break;
    }
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00(_id_401C3A2E68AAB0FD);
}

rankingenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinegame && !self.usingonlinedataoffline;
}

debugprintline(message) {}

_id_DE4D04211EF12E03(dvar, _id_D0C7F0C8C36FAF82) {
  level endon("host_migration_begin");

  for(;;) {
    result = getDvar(dvar);

    if(result != "") {
      [[_id_D0C7F0C8C36FAF82]](result);
      wait 0.05;
      setDvar(dvar, "");
      continue;
    }

    wait 0.25;
  }
}

ent_createheadicon(entity, offset, team, headicon, _id_E8FDB557F10C30E9) {
  if(!level.teambased)
    return undefined;

  if(!isDefined(team))
    team = "allies";

  headiconid = createheadicon(entity);
  setheadiconfriendlyimage(headiconid, headicon);
  setheadiconzoffset(headiconid, offset);
  setheadiconnaturaldistance(headiconid, 0);
  setheadiconmaxdistance(headiconid, 2250);
  setheadiconteam(headiconid, team);

  if(istrue(level._id_32FE21B3C5052471))
    _func_CE9D0299637C2C24(headiconid, 1);

  if(isDefined(_id_E8FDB557F10C30E9))
    setheadicondrawthroughgeo(headiconid, _id_E8FDB557F10C30E9);

  addteamtoheadiconmask(headiconid, team);
  showheadicontoplayersinmask(headiconid);
  thread watchheadicon(entity, headiconid);
  return headiconid;
}

watchheadicon(entity, headiconid) {
  entity endon("head_icon_deleted_" + headiconid);
  entity waittill("death");
  thread ent_deleteheadicon(entity, headiconid);
}

ent_deleteheadicon(entity, headiconid) {
  entity notify("head_icon_deleted_" + headiconid);

  if(isDefined(headiconid) && headiconid != -1)
    deleteheadicon(headiconid);
}

getlastweapon() {
  return self.lastweaponobj;
}

isnmlactive() {
  return istrue(level.nml_proto);
}

addtostructarray(key, value, item) {
  switch (key) {
    case "targetname":
      if(!isDefined(item.targetname))
        item.targetname = value;

      break;
    case "target":
      if(!isDefined(item.target))
        item.target = value;

      break;
    case "script_noteworthy":
      if(!isDefined(item.script_noteworthy))
        item.script_noteworthy = value;

      break;
    case "script_linkname":
      if(!isDefined(item.script_linkname))
        item.script_linkname = value;

      break;
    case "variantname":
      if(!isDefined(item._id_13DF181474836A29))
        item._id_13DF181474836A29 = value;

      break;
  }

  scripts\engine\utility::_id_1F6C1A9B7564DC61(item);
}

is_in_active_volume(_id_066691A6C8FDBBD8) {
  if(!isDefined(level.active_spawn_volumes))
    return 1;

  _id_82ADE947F8992573 = sortbydistance(level.active_spawn_volumes, _id_066691A6C8FDBBD8);

  foreach(volume in _id_82ADE947F8992573) {
    if(ispointinvolume(_id_066691A6C8FDBBD8, volume))
      return 1;
  }

  return 0;
}

objective_update(_id_7E4818482CACA9B2, time, _id_02A373C148BEA63F, _id_D087EB5608985A9C, nofailontimeout, _id_BE5D009C804D64A2, _id_0159FA119BE87C25, _id_29AE2DE1F604BC2F) {
  scripts\cp\cp_objectives::objective_update_internal(_id_7E4818482CACA9B2, time, _id_02A373C148BEA63F, _id_D087EB5608985A9C, nofailontimeout, _id_BE5D009C804D64A2, _id_0159FA119BE87C25, _id_29AE2DE1F604BC2F);
}

_id_CC38DDC890D2BB22() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  if(isDefined(game["star_rewards_times"]))
    level.timerstarttime = int(gettime() - game["star_rewards_times"] * 1000);
  else
    level.timerstarttime = gettime();

  if(getdvarint("dvar_A6C62479B8550953"))
    _id_DEDC3A4BE4FB4E1E();
  else
    _id_7A294A03559CF85E();

  starttime = level.starttime;

  for(;;) {
    level.timeelapsed = gettime() - level.timerstarttime;
    setomnvar("cp_mission_timer", level.timeelapsed);
    wait 0.05;
  }
}

_id_DEDC3A4BE4FB4E1E() {
  setomnvar("cp_mission_timer_alpha", 1);
}

_id_7A294A03559CF85E() {
  setomnvar("cp_mission_timer_alpha", 0);
}

_id_2C08BE5ADB8B60F4() {
  if(isDefined(level.timerstarttime))
    level.starttime = level.timerstarttime;

  starttime = level.starttime;

  if(isDefined(level.missionstarttime))
    starttime = level.missionstarttime;

  if(isDefined(game["star_rewards_times"]))
    level.time_survived = int((gettime() - starttime) / 1000) + game["star_rewards_times"];
  else
    level.time_survived = int((gettime() - starttime) / 1000);

  game["star_rewards_times"] = level.time_survived;
}

hint_prompt(_id_7E4818482CACA9B2, _id_40C374E7355F9029, waittime, _id_3B846E197F180922) {
  self endon("disconnect");
  self notify("new_hint_prompt");
  self endon("new_hint_prompt");

  if(istrue(_id_40C374E7355F9029))
    _id_6427DA22A2830C8E = int(tablelookup("cp/cp_hints.csv", 1, _id_7E4818482CACA9B2, 0));
  else
    _id_6427DA22A2830C8E = 0;

  self setclientomnvar("zm_hint_index", _id_6427DA22A2830C8E);

  if(istrue(_id_3B846E197F180922))
    thread _id_FA06F0ACF2524C61();

  if(isDefined(waittime)) {
    wait(waittime);
    self setclientomnvar("zm_hint_index", 0);

    if(istrue(_id_3B846E197F180922))
      self notify("end_hint_prompt_onDeath");
  }
}

_id_FA06F0ACF2524C61() {
  self endon("disconnect");
  self endon("end_hint_prompt_onDeath");
  self endon("new_hint_prompt");
  scripts\engine\utility::waittill_any_2("last_stand_start", "death");
  self setclientomnvar("zm_hint_index", 0);
}

_id_C2963CDB537E31A0() {
  self notify("end_hint_prompt_onDeath");
  self setclientomnvar("zm_hint_index", 0);
}

_id_28AB2855171F96F0(start, end, point) {
  _id_CE47F378F59DF1AF = distancesquared(start, end);

  if(_id_CE47F378F59DF1AF == 0.0)
    return distance(start, point);

  t = max(0, min(1, vectordot(point - start, end - start) / _id_CE47F378F59DF1AF));
  _id_A6C6221A1040F454 = start + t * (end - start);
  return distance(point, _id_A6C6221A1040F454);
}

get_carry_item_omnvar(carry_ref) {
  _id_6427DA22A2830C8E = tablelookup("cp/carry_items.csv", 1, carry_ref, 0);

  if(isDefined(_id_6427DA22A2830C8E))
    return _id_6427DA22A2830C8E;
  else
    return 0;
}

set_carry_item(player, carry_ref) {
  _id_6427DA22A2830C8E = get_carry_item_omnvar(carry_ref);
  slot = 1;

  if(!isDefined(player.carryitemomnvar) || player.carryitemomnvar == 0)
    player.carryitemomnvar = int(_id_6427DA22A2830C8E);
  else if(!isDefined(player.carryitem2omnvar) || player.carryitem2omnvar == 0) {
    player.carryitem2omnvar = int(_id_6427DA22A2830C8E);
    slot = 2;
  } else if(!isDefined(player._id_70E7C265A77E6DBF) || player._id_70E7C265A77E6DBF == 0) {
    player._id_70E7C265A77E6DBF = int(_id_6427DA22A2830C8E);
    slot = 3;
  } else {
    player._id_FE09B9D92140B766 = int(_id_6427DA22A2830C8E);
    slot = 4;
  }

  struct = spawnStruct();
  struct.carry_ref = carry_ref;
  struct.slot = slot;
  _id_116171939929AF39::broadcast_carry_items(player);
  return struct;
}

_id_C16DC4BA20E6DB6D() {
  player = self;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    remove_carry_item(player, _id_AC0E594AC96AA3A8);
}

_id_98F7CA3781DAC77C(player, carry_ref) {
  _id_6427DA22A2830C8E = int(get_carry_item_omnvar(carry_ref));

  if(isDefined(player.carryitemomnvar) && player.carryitemomnvar == _id_6427DA22A2830C8E)
    remove_carry_item(player, 1);

  if(isDefined(player.carryitem2omnvar) && player.carryitem2omnvar == _id_6427DA22A2830C8E)
    remove_carry_item(player, 2);

  if(isDefined(player._id_70E7C265A77E6DBF) && player._id_70E7C265A77E6DBF == _id_6427DA22A2830C8E)
    remove_carry_item(player, 3);

  if(isDefined(player._id_FE09B9D92140B766) && player._id_FE09B9D92140B766 == _id_6427DA22A2830C8E)
    remove_carry_item(player, 4);
}

remove_carry_item(player, _id_93C2531ABECB92E3) {
  if(!isDefined(_id_93C2531ABECB92E3))
    _id_93C2531ABECB92E3 = 1;

  if(_id_93C2531ABECB92E3 == 1)
    player.carryitemomnvar = 0;
  else if(_id_93C2531ABECB92E3 == 2)
    player.carryitem2omnvar = 0;
  else if(_id_93C2531ABECB92E3 == 3)
    player._id_70E7C265A77E6DBF = 0;
  else if(_id_93C2531ABECB92E3 == 4)
    player._id_FE09B9D92140B766 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    result = _id_6B74D581A9FAAA41(player);

    if(!result) {
      break;
    }
  }

  _id_116171939929AF39::broadcast_carry_items(player);
}

_id_6B74D581A9FAAA41(player) {
  if(player._id_FE09B9D92140B766 > 0 && player._id_70E7C265A77E6DBF == 0) {
    player._id_70E7C265A77E6DBF = player._id_FE09B9D92140B766;
    player._id_FE09B9D92140B766 = 0;
    return 1;
  }

  if(player._id_70E7C265A77E6DBF > 0 && player.carryitem2omnvar == 0) {
    player.carryitem2omnvar = player._id_70E7C265A77E6DBF;
    player._id_70E7C265A77E6DBF = 0;
    return 1;
  }

  if(player.carryitem2omnvar > 0 && player.carryitemomnvar == 0) {
    player.carryitemomnvar = player.carryitem2omnvar;
    player.carryitem2omnvar = 0;
    return 1;
  }

  return 0;
}

addentrytodevgui(_id_10D8148F3496F8DE) {
  level thread addentrytodevgui_internal(_id_10D8148F3496F8DE);
}

addentrytodevgui_internal(_id_10D8148F3496F8DE) {
  if(!isDefined(_id_10D8148F3496F8DE)) {
    return;
  }
  wait 5;

  if(isDefined(game["state"]) && game["state"] == "postgame") {
    return;
  }
  _id_94899EE0671E1C5D = "";
  _id_F077ADF688122C36 = strtok(_id_10D8148F3496F8DE, "/");
  space = " ";
  _id_295AB3A52EFB020F = 0;

  foreach(_id_E97377032A878881 in _id_F077ADF688122C36) {
    _id_AF9C9DF381F94999 = strtok(_id_E97377032A878881, " ");
    count = 1;
    _id_A61C75B156FC1EE0 = _id_AF9C9DF381F94999.size;

    foreach(_id_1A598A8191BCB170 in _id_AF9C9DF381F94999) {
      if(count < _id_A61C75B156FC1EE0)
        _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + _id_1A598A8191BCB170 + space;
      else
        _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + _id_1A598A8191BCB170;

      count++;
    }

    _id_295AB3A52EFB020F++;

    if(_id_295AB3A52EFB020F < _id_F077ADF688122C36.size)
      _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + "/";
  }
}

array_sort_by_handler(array, _id_D35FC50E2F1F14DF, _id_A366E9C50D651873) {
  if(!isDefined(_id_D35FC50E2F1F14DF))
    _id_D35FC50E2F1F14DF = ::defaultsortfunc;

  _id_A366E9C50D651873 = istrue(_id_A366E9C50D651873);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size - 1; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < array.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_A366E9C50D651873) {
        if(array[_id_AC0E5C4AC96AAA41][[_id_D35FC50E2F1F14DF]]() > array[_id_AC0E594AC96AA3A8][[_id_D35FC50E2F1F14DF]]()) {
          ref = array[_id_AC0E5C4AC96AAA41];
          array[_id_AC0E5C4AC96AAA41] = array[_id_AC0E594AC96AA3A8];
          array[_id_AC0E594AC96AA3A8] = ref;
        }

        continue;
      }

      if(array[_id_AC0E5C4AC96AAA41][[_id_D35FC50E2F1F14DF]]() < array[_id_AC0E594AC96AA3A8][[_id_D35FC50E2F1F14DF]]()) {
        ref = array[_id_AC0E5C4AC96AAA41];
        array[_id_AC0E5C4AC96AAA41] = array[_id_AC0E594AC96AA3A8];
        array[_id_AC0E594AC96AA3A8] = ref;
      }
    }
  }

  return array;
}

array_compare(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  if(_id_4F6FF34F222B0271.size != _id_4F6FF04F222AFBD8.size)
    return 0;

  foreach(key, _id_80EF668C09FFB70F in _id_4F6FF34F222B0271) {
    if(!isDefined(_id_4F6FF04F222AFBD8[key]))
      return 0;

    _id_8E35C2F9FD5FFB27 = _id_4F6FF04F222AFBD8[key];

    if(_id_8E35C2F9FD5FFB27 != _id_80EF668C09FFB70F)
      return 0;
  }

  return 1;
}

defaultsortfunc(left, right) {
  return randomint(100);
}

set_segmented_health_regen_parameters(max_health_cap, min_health_cap, segment_size, pre_regen_wait, per_regen_amount, between_regen_wait) {
  segmented_health_regen_parameters = spawnStruct();
  segmented_health_regen_parameters.max_health_cap = max_health_cap / 100;
  segmented_health_regen_parameters.min_health_cap = min_health_cap / 100;
  segmented_health_regen_parameters.segment_size = segment_size / 100;
  segmented_health_regen_parameters.pre_regen_wait = pre_regen_wait;
  segmented_health_regen_parameters.per_regen_amount = per_regen_amount / 100;
  segmented_health_regen_parameters.between_regen_wait = between_regen_wait;
  level.segmented_health_regen_parameters = segmented_health_regen_parameters;
}

set_current_health_regen_segment(player, _id_C95D6437E34F366D) {
  player.current_health_regen_segment_ceiling = int(_id_C95D6437E34F366D);
  player.current_health_regen_segment_floor = int(_id_C95D6437E34F366D - player.segment_size);
}

find_new_health_regen_segment_ceiling(player) {
  _id_143931AA9AB1430D = int((player.max_health_cap - player.min_health_cap) / player.segment_size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_143931AA9AB1430D + 1; _id_AC0E594AC96AA3A8++) {
    _id_A0332848F259820C = player.min_health_cap + _id_AC0E594AC96AA3A8 * player.segment_size;

    if(_id_A0332848F259820C >= player.health)
      return int(min(_id_A0332848F259820C, player.maxhealth));
  }
}

is_friendly_damage(agent, inflictor, attacker) {
  if(isDefined(inflictor)) {
    if(isDefined(inflictor.model) && inflictor.model == "offhand_wm_at_mine_bomb_cp")
      return 0;

    if(isDefined(attacker)) {
      if(isDefined(attacker.owner) && isDefined(attacker.owner.team)) {
        if(attacker.owner.team != agent.team)
          return 0;
        else
          return 1;
      }

      if(isDefined(attacker.team) && isDefined(inflictor.team)) {
        if(attacker.team != inflictor.team)
          return 0;
      }
    }

    if(isDefined(inflictor.team) && inflictor.team == agent.team)
      return 1;

    if(isDefined(inflictor.owner) && isDefined(inflictor.owner.team) && inflictor.owner.team == agent.team)
      return 1;
  }

  return 0;
}

vehicle_gethealthbarid() {
  if(!isDefined(level.healthbars))
    level.healthbars = [];

  id = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.healthbars[_id_AC0E594AC96AA3A8])) {
      id = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  return id;
}

vehicle_freehealthbarui() {
  if(isDefined(self.healthbarid)) {
    _id_5838B9CDFB37E6F1 = level.healthbars[self.healthbarid];
    _id_5838B9CDFB37E6F1 delete();
    setomnvar("ui_ingame_light_tank_ent_" + self.healthbarid, undefined);
    setomnvar("ui_ingame_light_tank_health_" + self.healthbarid, 0);
    setomnvar("ui_ingame_light_tank_team_" + self.healthbarid, 0);
    level.healthbars[self.healthbarid] = undefined;
    self.healthbarid = undefined;
  }
}

create_waypoint(index, origin, team, shader, alpha, scale) {
  if(!isDefined(scale))
    scale = 1.0;

  waypoint = undefined;

  if(team != "all")
    waypoint = newteamhudelem(team);
  else
    waypoint = newhudelem();

  waypoint.id = index;
  waypoint.x = origin[0];
  waypoint.y = origin[1];
  waypoint.z = origin[2];
  waypoint.team = team;
  waypoint.isflashing = 0;
  waypoint.isshown = 1;

  if(issplitscreen())
    waypoint setshader(shader, 8, 8);
  else
    waypoint setshader(shader, 15, 15);

  waypoint setwaypoint(0, 1, 1);

  if(isDefined(alpha))
    waypoint.alpha = alpha;
  else
    waypoint.alpha = 0.75;

  waypoint.basealpha = waypoint.alpha;
  return waypoint;
}

waypoint_delete(waypoint) {
  waypoint destroy();
}

_freezecontrols(frozen, _id_F8048727716242B0, debug) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"]))
    self.pers["controllerFreezeStack"] = 0;

  if(frozen)
    self.pers["controllerFreezeStack"]++;
  else if(istrue(_id_F8048727716242B0))
    self.pers["controllerFreezeStack"] = 0;
  else
    self.pers["controllerFreezeStack"]--;

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
  } else {
    self freezecontrols(1);
    self.controlsfrozen = 1;
  }
}

_freezelookcontrols(frozen, _id_F8048727716242B0) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerLookFreezeStack"]))
    self.pers["controllerLookFreezeStack"] = 0;

  if(frozen)
    self.pers["controllerLookFreezeStack"]++;
  else if(istrue(_id_F8048727716242B0))
    self.pers["controllerLookFreezeStack"] = 0;
  else
    self.pers["controllerLookFreezeStack"]--;

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self.lookcontrolsfrozen = 0;
  } else {
    self freezelookcontrols(1);
    self.lookcontrolsfrozen = 1;
  }
}

_setdof_internal(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur) {
  if(!isDefined(self)) {
    return;
  }
  _id_E0AF59BA48C8CB09 = max(_id_E0AF59BA48C8CB09, 0.0);
  _id_FF6B46DA0D04E078 = clamp(_id_FF6B46DA0D04E078, 1.0, 9994.0);
  _id_2FE3DC2F1289D072 = clamp(_id_2FE3DC2F1289D072, 2.0, 9998.0);
  _id_7A6976D1E774FE57 = clamp(_id_7A6976D1E774FE57, 3.0, 9999);

  if(_id_2FE3DC2F1289D072 > 9994.0)
    farblur = 0.0;

  self setdepthoffield(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur);
}

setdof_killer() {
  self endon("disconnect");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

setdof_killer_update() {
  self endon("disconnect");
  self endon("death_delay_finished");
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_844B0A6CCABE8587 = vectorNormalize(self.origin - self.lastkilledby.origin);
  startpos = self.origin + (0, 0, 42);
  endpos = startpos + _id_844B0A6CCABE8587 * 120.0;
  trace = scripts\engine\trace::sphere_trace(startpos, endpos, 2.0, self, contentoverride, 0);
  _id_A5ED8689CA0DDDBB = trace["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    _id_1AC96A06E64C75CD = distance(_id_A5ED8689CA0DDDBB, self.lastkilledby.origin);
    _id_E0AF59BA48C8CB09 = 0.0;
    _id_FF6B46DA0D04E078 = max(_id_1AC96A06E64C75CD - 12.0, 1.0);
    _id_2FE3DC2F1289D072 = _id_1AC96A06E64C75CD + 12.0;
    _id_7A6976D1E774FE57 = _id_2FE3DC2F1289D072 + 50.0;
    nearblur = 8.0;
    farblur = 4.5;
    _setdof_internal(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur);
    waitframe();
  }
}

setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

draw_line_until_endons(_id_6C12713F33727294, r, g, b, _id_0618807E8CD83EF8, org2) {
  self endon("death");

  if(isDefined(_id_0618807E8CD83EF8)) {
    if(isarray(_id_0618807E8CD83EF8)) {
      foreach(_id_AAE9816CBF26FA0E in _id_0618807E8CD83EF8)
      self endon(_id_AAE9816CBF26FA0E);
    } else
      self endon(_id_0618807E8CD83EF8);
  }

  if(!isDefined(org2))
    org2 = _id_6C12713F33727294 + (0, 0, 256);

  for(;;)
    waitframe();
}

_id_90DD1585EC7C1F21(color, time) {
  if(!isDefined(color))
    color = (1, 1, 1);

  if(!isDefined(time))
    time = 600;

  thread scripts\engine\utility::draw_line_for_time(self.origin, self.origin + (0, 0, 128), color[0], color[1], color[2], time, "game_ended");
}

play_sound_on_tag(alias, tag, _id_49FDBA4C56715050, _id_B426F32755673BA6, _id_510AF7464E264F89) {
  if(isDefined(tag))
    playsoundatpos(self gettagorigin(tag), alias);
  else
    playsoundatpos(self.origin, alias);
}

play_sound_on_entity(alias, _id_B426F32755673BA6) {
  play_sound_on_tag(alias);
}

get_point_in_local_ent_space(_id_DF845BFEF23F16CE, offset) {
  _id_5D6805EF12F78AE7 = _id_DF845BFEF23F16CE.origin;
  _id_616A6ECC2C2A4EB0 = anglestoup(_id_DF845BFEF23F16CE.angles);
  _id_66B10616A68F00F9 = anglestoleft(_id_DF845BFEF23F16CE.angles);
  _id_B842CC1147BDB416 = anglesToForward(_id_DF845BFEF23F16CE.angles);
  _id_F7CD955C75C5D1BF = offset[0] * _id_B842CC1147BDB416[0] + offset[1] * _id_66B10616A68F00F9[0] + offset[2] * _id_616A6ECC2C2A4EB0[0] + _id_5D6805EF12F78AE7[0];
  _id_F7CD945C75C5CF8C = offset[0] * _id_B842CC1147BDB416[1] + offset[1] * _id_66B10616A68F00F9[1] + offset[2] * _id_616A6ECC2C2A4EB0[1] + _id_5D6805EF12F78AE7[1];
  _id_F7CD975C75C5D625 = offset[0] * _id_B842CC1147BDB416[2] + offset[1] * _id_66B10616A68F00F9[2] + offset[2] * _id_616A6ECC2C2A4EB0[2] + _id_5D6805EF12F78AE7[2];
  _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_F7CD975C75C5D625);
  return _id_6C53D859D582A421;
}

remove_cursor_hint() {
  _id_52145FC3D0FAB939 = self;

  if(isDefined(self.cursor_hint_ent)) {
    _id_52145FC3D0FAB939 = self.cursor_hint_ent;
    _id_52145FC3D0FAB939 scripts\engine\utility::delaycall(0.5, ::delete);
  }

  if(isDefined(_id_52145FC3D0FAB939) && !isstruct(_id_52145FC3D0FAB939))
    _id_52145FC3D0FAB939 makeunusable();

  if(isDefined(self))
    notify_delay("hint_destroyed", 0.05);
}

notify_delay(_id_89D1FFD39DF87556, _id_3447DD0CDCD69308) {
  self endon("death");

  if(_id_3447DD0CDCD69308 > 0)
    wait(_id_3447DD0CDCD69308);

  if(!isDefined(self)) {
    return;
  }
  self notify(_id_89D1FFD39DF87556);
}

create_cursor_hint(_id_4CADAFE0DB5700B3, _id_1E2F2224127D2990, hintstring, _id_DF024A1642F13910, _id_1D15541035909A45, _id_2312D6385AE695A8, _id_0BCA9B971F3BB97C, _id_A437BC9A2005DF60, _id_9E9B6D24B7A157F0, _id_64E9E1F9BECAB35F, _id_F61019386E1B1034, usecommand, _id_E077514A6FF04ACF, _id_40D4D7A8AD6420E3) {
  _id_52145FC3D0FAB939 = self;

  if(isstruct(_id_52145FC3D0FAB939) || _id_52145FC3D0FAB939.classname == "script_origin" || isDefined(_id_1E2F2224127D2990)) {
    _id_52145FC3D0FAB939 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = _id_52145FC3D0FAB939;
    thread hint_ent_notify_trigger();
  }

  _id_52145FC3D0FAB939 makeusable();

  if(isDefined(_id_1E2F2224127D2990)) {
    tag = "tag_origin";

    if(isDefined(_id_4CADAFE0DB5700B3)) {
      tag = _id_4CADAFE0DB5700B3;
      _id_52145FC3D0FAB939.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, tag))
      _id_52145FC3D0FAB939 linkTo(self, tag, _id_1E2F2224127D2990, (0, 0, 0));
    else if(isDefined(_id_4CADAFE0DB5700B3))
      _id_52145FC3D0FAB939 linkTo(self, tag, _id_1E2F2224127D2990, (0, 0, 0));
    else if(isDefined(self.angles)) {
      _id_52145FC3D0FAB939.origin = _id_52145FC3D0FAB939.origin + rotatevector(_id_1E2F2224127D2990, self.angles);

      if(isent(self))
        _id_52145FC3D0FAB939 linkTo(self);
    } else {
      _id_52145FC3D0FAB939.origin = _id_52145FC3D0FAB939.origin + _id_1E2F2224127D2990;

      if(isent(self))
        _id_52145FC3D0FAB939 linkTo(self);
    }
  } else if(isDefined(_id_4CADAFE0DB5700B3))
    _id_52145FC3D0FAB939 sethinttag(_id_4CADAFE0DB5700B3);

  if(isDefined(_id_9E9B6D24B7A157F0) && _id_9E9B6D24B7A157F0)
    _id_52145FC3D0FAB939 setCursorHint("HINT_NOICON");
  else
    _id_52145FC3D0FAB939 setCursorHint("HINT_BUTTON");

  if(isDefined(hintstring))
    _id_52145FC3D0FAB939 setHintString(hintstring);

  _id_CF1DDA7C717E1BE0 = 360;

  if(isDefined(_id_DF024A1642F13910))
    _id_CF1DDA7C717E1BE0 = _id_DF024A1642F13910;

  _id_52145FC3D0FAB939 sethintdisplayfov(_id_CF1DDA7C717E1BE0);
  usefov = 65;

  if(isDefined(_id_40D4D7A8AD6420E3))
    usefov = _id_40D4D7A8AD6420E3;

  _id_52145FC3D0FAB939 setusefov(usefov);
  _id_1DAF42081ED5D776 = 500;

  if(isDefined(_id_1D15541035909A45))
    _id_1DAF42081ED5D776 = _id_1D15541035909A45;

  _id_52145FC3D0FAB939 sethintdisplayrange(_id_1DAF42081ED5D776);
  userange = 80;

  if(isDefined(_id_2312D6385AE695A8))
    userange = _id_2312D6385AE695A8;

  _id_52145FC3D0FAB939 setuserange(userange);

  if(isDefined(_id_0BCA9B971F3BB97C) && _id_0BCA9B971F3BB97C)
    _id_52145FC3D0FAB939 sethintonobstruction("show");
  else
    _id_52145FC3D0FAB939 sethintonobstruction("hide");

  if(isDefined(_id_A437BC9A2005DF60) && _id_A437BC9A2005DF60)
    _id_52145FC3D0FAB939 sethintrequiresmashing(_id_A437BC9A2005DF60);

  if(!isDefined(_id_F61019386E1B1034))
    _id_F61019386E1B1034 = "duration_short";

  _id_52145FC3D0FAB939 setuseholdduration(_id_F61019386E1B1034);

  if(_id_F61019386E1B1034 == "duration_medium" || _id_F61019386E1B1034 == "duration_long")
    _id_52145FC3D0FAB939 sethintrequiresholding(1);

  thread hint_delete_on_trigger();

  if(isDefined(_id_64E9E1F9BECAB35F))
    _id_52145FC3D0FAB939 sethinticon(_id_64E9E1F9BECAB35F);

  if(isDefined(usecommand))
    _id_52145FC3D0FAB939 setusecommand(usecommand);

  if(isDefined(_id_E077514A6FF04ACF))
    _id_52145FC3D0FAB939 sethintlockplayermovement(1);
  else
    _id_52145FC3D0FAB939 sethintlockplayermovement(0);

  return _id_52145FC3D0FAB939;
}

hint_ent_notify_trigger() {
  self endon("death");
  self endon("hint_destroyed");
  self.cursor_hint_ent waittill("trigger", _id_FA8D840338038893);
  self notify("trigger", _id_FA8D840338038893);
}

hint_delete_on_trigger() {
  self endon("hint_destroyed");
  _id_52145FC3D0FAB939 = self;

  if(isDefined(self.cursor_hint_ent))
    _id_52145FC3D0FAB939 = self.cursor_hint_ent;

  hint_delete_on_trigger_waittill(_id_52145FC3D0FAB939);
  thread remove_cursor_hint();
}

hint_delete_on_trigger_waittill(_id_52145FC3D0FAB939) {
  self endon("entitydeleted");
  _id_52145FC3D0FAB939 waittill("trigger");
}

outline_fade_alpha_for_index(index, alpha, time) {
  thread outline_fade_alpha_for_index_internal(index, alpha, time);
}

outline_fade_alpha_for_index_internal(index, alpha, time) {
  level notify("hud_outline_alpha_fade_" + index);
  level endon("hud_outline_alpha_fade_" + index);
  index++;
  _id_B98E2BDB3119A0E3 = _func_2EF675C13CA1C4AF("dvar_1429C8E20321BBCD", index);
  _id_4486FF9D1102F083 = getDvar(_id_B98E2BDB3119A0E3);
  _id_4486FF9D1102F083 = strtok(_id_4486FF9D1102F083, " ");
  _id_C046A44006364CBF = _id_4486FF9D1102F083[0] + " " + _id_4486FF9D1102F083[1] + " " + _id_4486FF9D1102F083[2] + " ";
  _id_3C89771E6B31AD56 = float(_id_4486FF9D1102F083[3]);
  range = alpha - _id_3C89771E6B31AD56;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    for(_id_3777ECE6A73EADA5 = range / count; count; count--) {
      _id_3C89771E6B31AD56 = _id_3C89771E6B31AD56 + _id_3777ECE6A73EADA5;
      _id_3C89771E6B31AD56 = clamp(_id_3C89771E6B31AD56, 0, 1);
      wait(interval);
    }
  }
}

add_wait(func, parm1, parm2, parm3) {
  init_waits();
  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = [];

  if(isDefined(parm1))
    ent.parms[ent.parms.size] = parm1;

  if(isDefined(parm2))
    ent.parms[ent.parms.size] = parm2;

  if(isDefined(parm3))
    ent.parms[ent.parms.size] = parm3;

  if(!isDefined(level.waits.wait_any_func_array))
    level.waits.wait_any_func_array = [ent];
  else
    level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = ent;
}

init_waits() {
  if(!scripts\engine\utility::add_init_script("waits", ::init_waits)) {
    return;
  }
  level.waits = spawnStruct();
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
}

add_wait_asserter() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 20; _id_AC0E594AC96AA3A8++)
    waittillframeend;
}

do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

do_wait(_id_FF009ED2DEBC01C4) {
  init_waits();

  if(!isDefined(_id_FF009ED2DEBC01C4))
    _id_FF009ED2DEBC01C4 = 0;

  ent = spawnStruct();
  array = level.waits.wait_any_func_array;
  _id_BA7E8AD2868EF874 = level.waits.do_wait_endons_array;
  _id_0F9AA72A24A1A927 = level.waits.run_func_after_wait_array;
  _id_502521F8FF044027 = level.waits.run_call_after_wait_array;
  _id_953B218366C91A88 = level.waits.run_noself_call_after_wait_array;
  _id_837C864FF77FCFDF = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  ent.count = array.size;
  ent scripts\engine\utility::array_levelthread(array, ::waittill_func_ends, _id_BA7E8AD2868EF874);
  ent thread do_abort(_id_837C864FF77FCFDF);
  ent endon("any_funcs_aborted");

  for(;;) {
    if(ent.count <= _id_FF009ED2DEBC01C4) {
      break;
    }

    ent waittill("func_ended");
  }

  ent notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(_id_0F9AA72A24A1A927, ::exec_func, []);
  scripts\engine\utility::array_levelthread(_id_502521F8FF044027, ::exec_call);
  scripts\engine\utility::array_levelthread(_id_953B218366C91A88, ::exec_call_noself);
}

exec_call(func) {
  if(func.parms.size == 0)
    func.caller call[[func.func]]();
  else if(func.parms.size == 1)
    func.caller call[[func.func]](func.parms[0]);
  else if(func.parms.size == 2)
    func.caller call[[func.func]](func.parms[0], func.parms[1]);
  else if(func.parms.size == 3)
    func.caller call[[func.func]](func.parms[0], func.parms[1], func.parms[2]);

  if(func.parms.size == 4)
    func.caller call[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3]);

  if(func.parms.size == 5)
    func.caller call[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3], func.parms[4]);
}

exec_call_noself(func) {
  if(func.parms.size == 0)
    call[[func.func]]();
  else if(func.parms.size == 1)
    call[[func.func]](func.parms[0]);
  else if(func.parms.size == 2)
    call[[func.func]](func.parms[0], func.parms[1]);
  else if(func.parms.size == 3)
    call[[func.func]](func.parms[0], func.parms[1], func.parms[2]);

  if(func.parms.size == 4)
    call[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3]);

  if(func.parms.size == 5)
    call[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3], func.parms[4]);
}

exec_func(func, _id_BA7E8AD2868EF874) {
  if(!isDefined(func.caller)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BA7E8AD2868EF874.size; _id_AC0E594AC96AA3A8++)
    _id_BA7E8AD2868EF874[_id_AC0E594AC96AA3A8].caller endon(_id_BA7E8AD2868EF874[_id_AC0E594AC96AA3A8].ender);

  if(func.parms.size == 0)
    func.caller[[func.func]]();
  else if(func.parms.size == 1)
    func.caller[[func.func]](func.parms[0]);
  else if(func.parms.size == 2)
    func.caller[[func.func]](func.parms[0], func.parms[1]);
  else if(func.parms.size == 3)
    func.caller[[func.func]](func.parms[0], func.parms[1], func.parms[2]);

  if(func.parms.size == 4)
    func.caller[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3]);

  if(func.parms.size == 5)
    func.caller[[func.func]](func.parms[0], func.parms[1], func.parms[2], func.parms[3], func.parms[4]);
}

do_abort(array) {
  self endon("all_funcs_ended");

  if(!array.size) {
    return;
  }
  _id_FF009ED2DEBC01C4 = 0;
  self.abort_count = array.size;
  _id_BA7E8AD2868EF874 = [];
  scripts\engine\utility::array_levelthread(array, ::waittill_abort_func_ends, _id_BA7E8AD2868EF874);

  for(;;) {
    if(self.abort_count <= _id_FF009ED2DEBC01C4) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

waittill_abort_func_ends(func, _id_BA7E8AD2868EF874) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(func, _id_BA7E8AD2868EF874);
  self.abort_count--;
  self notify("abort_func_ended");
}

waittill_func_ends(func, _id_BA7E8AD2868EF874) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(func, _id_BA7E8AD2868EF874);
  self.count--;
  self notify("func_ended");
}

waittill_msg(msg) {
  self waittill(msg);
}

create_client_overlay(_id_2193FDE10BF4B43A, _id_2A423FC276D9F388, player) {
  if(isDefined(player))
    overlay = newclienthudelem(player);
  else
    overlay = newhudelem();

  overlay.x = 0;
  overlay.y = 0;
  overlay setshader(_id_2193FDE10BF4B43A, 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = _id_2A423FC276D9F388;
  overlay.foreground = 1;
  return overlay;
}

createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, _id_DBCE45A33308630D) {
  hintobj = undefined;

  if(isDefined(_id_DBCE45A33308630D))
    hintobj = _id_DBCE45A33308630D;
  else
    hintobj = spawn("script_model", _id_963953C3478BF4FE);

  hintobj sethintobject(undefined, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);

  if(!isDefined(priority))
    hintobj setusepriority(0);

  if(!isDefined(_id_DBCE45A33308630D))
    return hintobj;
}

clearhintobject(_id_DBCE45A33308630D) {}

get_actual_time_from_civil(_id_3E15975815788EF2, _id_8CC6D68123AB5EBC, _id_AC934600955E8206) {
  level endon("game_ended");

  if(isDefined(_id_8CC6D68123AB5EBC))
    _id_CC748B6D457627FE = _id_8CC6D68123AB5EBC;
  else {
    _id_CC748B6D457627FE = getsystemtime();

    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings)
      _id_CC748B6D457627FE = _id_CC748B6D457627FE + 3600;
  }

  if(isDefined(_id_3E15975815788EF2))
    _id_CC748B6D457627FE = _id_CC748B6D457627FE - 3600 * _id_3E15975815788EF2;

  _id_1374A33ADEBB2120 = 1970;
  _id_84A44D77D58A4989 = floor(_id_CC748B6D457627FE / 31536000);

  if(_id_84A44D77D58A4989 != 0)
    _id_EED48D9A89E19294 = floor((_id_84A44D77D58A4989 + 2) / 4);
  else
    _id_EED48D9A89E19294 = 0;

  _id_CC748B6D457627FE = _id_CC748B6D457627FE - _id_84A44D77D58A4989 * 31536000;
  _id_CC748B6D457627FE = _id_CC748B6D457627FE - _id_EED48D9A89E19294 * 86400;
  _id_1374A33ADEBB2120 = _id_1374A33ADEBB2120 + _id_84A44D77D58A4989;

  if(!is_divisible_by(_id_1374A33ADEBB2120, 4)) {
    _id_4C8BF90E649EED71 = floor(_id_84A44D77D58A4989 / 4);
    _id_3B07193517647DD1 = _id_84A44D77D58A4989 / 4;
    _id_3663584BF2376542 = _id_3B07193517647DD1 - _id_4C8BF90E649EED71;

    if(_id_3663584BF2376542 >= 0.75)
      _id_3C190BBE9CBB729A = 1;
    else
      _id_3C190BBE9CBB729A = 0;
  } else
    _id_3C190BBE9CBB729A = 0;

  if(_id_CC748B6D457627FE != 0) {
    _id_B88CDD72B1D7D08E = floor(_id_CC748B6D457627FE / 86400);
    _id_CC748B6D457627FE = _id_CC748B6D457627FE - _id_B88CDD72B1D7D08E * 86400;
  } else
    _id_B88CDD72B1D7D08E = 0;

  if(_id_CC748B6D457627FE != 0) {
    hours = floor(_id_CC748B6D457627FE / 3600);
    _id_CC748B6D457627FE = _id_CC748B6D457627FE - hours * 3600;
  } else
    hours = 0;

  if(_id_CC748B6D457627FE != 0) {
    _id_6C681AD49BE4496A = floor(_id_CC748B6D457627FE / 60);
    _id_CC748B6D457627FE = _id_CC748B6D457627FE - _id_6C681AD49BE4496A * 60;
  } else
    _id_6C681AD49BE4496A = 0;

  info = determine_correct_month(_id_B88CDD72B1D7D08E + 1, _id_3C190BBE9CBB729A);
  info["year"] = _id_1374A33ADEBB2120;
  info["hours"] = hours;
  info["minutes"] = _id_6C681AD49BE4496A;
  info["seconds"] = _id_CC748B6D457627FE;

  if(isDefined(_id_AC934600955E8206))
    return info;

  if(isDefined(level.isdaylightsavings)) {
    level notify("time_check", _id_1374A33ADEBB2120, info["month_string"], info["days"], hours, _id_6C681AD49BE4496A, _id_CC748B6D457627FE);
    return info;
  } else {
    info = is_daylight_savings(info, _id_3E15975815788EF2, _id_8CC6D68123AB5EBC);
    level notify("time_check", _id_1374A33ADEBB2120, info["month_string"], info["days"], hours, _id_6C681AD49BE4496A, _id_CC748B6D457627FE);
    return info;
  }
}

is_daylight_savings(info, _id_3E15975815788EF2, _id_8CC6D68123AB5EBC) {
  _id_8EF55833DA748CC6 = 0;

  if(info["month_string"] == "March" && info["year"] == 2017)
    _id_8EF55833DA748CC6 = 1;
  else if(info["month_string"] == "December" || info["month_string"] == "January" || info["month_string"] == "February")
    _id_8EF55833DA748CC6 = 0;
  else if(info["month_string"] != "March" && info["month_string"] != "April")
    _id_8EF55833DA748CC6 = 1;
  else if(info["month_string"] == "March" && info["days"] >= 14)
    _id_8EF55833DA748CC6 = 1;
  else if(info["month_string"] == "November" && info["days"] <= 6)
    _id_8EF55833DA748CC6 = 0;
  else
    _id_8EF55833DA748CC6 = 0;

  if(_id_8EF55833DA748CC6) {
    level.isdaylightsavings = 1;
    info = get_actual_time_from_civil(_id_3E15975815788EF2, _id_8CC6D68123AB5EBC, 1);
  } else
    level.isdaylightsavings = 0;

  return info;
}

determine_correct_month(_id_B88CDD72B1D7D08E, _id_3C190BBE9CBB729A) {
  info = [];
  info["month"] = undefined;
  info["month_string"] = undefined;
  info["days"] = undefined;
  _id_555894A437CB7632 = int(istrue(_id_3C190BBE9CBB729A));

  if(_id_B88CDD72B1D7D08E <= 31) {
    info["month"] = 1;
    info["month_string"] = "January";
    info["days"] = _id_B88CDD72B1D7D08E;
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 59 + _id_555894A437CB7632) {
    info["month"] = 2;
    info["month_string"] = "February";
    info["days"] = _id_B88CDD72B1D7D08E - 31;
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 90 + _id_555894A437CB7632) {
    info["month"] = 3;
    info["month_string"] = "March";
    info["days"] = _id_B88CDD72B1D7D08E - (59 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 120 + _id_555894A437CB7632) {
    info["month"] = 4;
    info["month_string"] = "April";
    info["days"] = _id_B88CDD72B1D7D08E - (90 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 151 + _id_555894A437CB7632) {
    info["month"] = 5;
    info["month_string"] = "May";
    info["days"] = _id_B88CDD72B1D7D08E - (120 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 182 + _id_555894A437CB7632) {
    info["month"] = 6;
    info["month_string"] = "June";
    info["days"] = _id_B88CDD72B1D7D08E - (151 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 212 + _id_555894A437CB7632) {
    info["month"] = 7;
    info["month_string"] = "July";
    info["days"] = _id_B88CDD72B1D7D08E - (182 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 243 + _id_555894A437CB7632) {
    info["month"] = 8;
    info["month_string"] = "August";
    info["days"] = _id_B88CDD72B1D7D08E - (212 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 273 + _id_555894A437CB7632) {
    info["month"] = 9;
    info["month_string"] = "September";
    info["days"] = _id_B88CDD72B1D7D08E - (243 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 304 + _id_555894A437CB7632) {
    info["month"] = 10;
    info["month_string"] = "Octobor";
    info["days"] = _id_B88CDD72B1D7D08E - (273 + _id_555894A437CB7632);
    return info;
  } else if(_id_B88CDD72B1D7D08E <= 335 + _id_555894A437CB7632) {
    info["month"] = 11;
    info["month_string"] = "November";
    info["days"] = _id_B88CDD72B1D7D08E - (304 + _id_555894A437CB7632);
    return info;
  } else {
    info["month"] = 12;
    info["month_string"] = "December";
    info["days"] = _id_B88CDD72B1D7D08E - (335 + _id_555894A437CB7632);
    return info;
  }
}

set_friendlyfire_warnings(state) {
  if(state)
    self.friendlyfire_warnings_disable = undefined;
  else
    self.friendlyfire_warnings_disable = 1;
}

battlechatter_off(team) {
  if(!isDefined(team))
    level._id_91A8C7ABDF195C70 = 1;
  else {
    if(!isDefined(level._id_EDCE163BBAB4F0CE))
      level._id_EDCE163BBAB4F0CE = [];

    level._id_EDCE163BBAB4F0CE[team] = 1;
  }
}

battlechatter_on(team) {
  if(!isDefined(level.battlechatter))
    _id_35DE402EFC5ACFB3::init_battlechatter();

  if(!isDefined(team))
    level._id_91A8C7ABDF195C70 = undefined;
  else if(isDefined(level._id_EDCE163BBAB4F0CE))
    level._id_EDCE163BBAB4F0CE[team] = undefined;
}

getvehiclearray() {
  return vehicle_getarray();
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.players[0];
}

player_looking_at(start, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  if(!isDefined(dot))
    dot = 0.8;

  player = get_player_from_self();
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  _id_DEE6508B0BA437C5 = player getplayerangles();
  _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
  _id_334AF980E8C1A3AD = vectordot(forward, _id_70222FBC47330166);

  if(_id_334AF980E8C1A3AD < dot)
    return 0;

  if(isDefined(_id_95BFA6EAF973D593))
    return 1;

  return scripts\engine\trace::ray_trace_detail_passed(start, end, _id_75BEA58D65510615, scripts\engine\trace::create_default_contents(1));
}

is_divisible_by(_id_A860076E6B45DB06, _id_F1563935AEEB5199) {
  if(floor(_id_A860076E6B45DB06 / _id_F1563935AEEB5199) > _id_A860076E6B45DB06 / _id_F1563935AEEB5199)
    return 1;
  else
    return 0;
}

array_merge(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  if(_id_4F6FF34F222B0271.size == 0)
    return _id_4F6FF04F222AFBD8;

  if(_id_4F6FF04F222AFBD8.size == 0)
    return _id_4F6FF34F222B0271;

  _id_BFC65A378A6D8EFE = _id_4F6FF34F222B0271;

  foreach(_id_3840497A74A156FA in _id_4F6FF04F222AFBD8) {
    _id_31C64B5C5485BAFC = 0;

    foreach(_id_48D4CA1D57B450E7 in _id_4F6FF34F222B0271) {
      if(_id_48D4CA1D57B450E7 == _id_3840497A74A156FA) {
        _id_31C64B5C5485BAFC = 1;
        break;
      }
    }

    if(_id_31C64B5C5485BAFC)
      continue;
    else
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_3840497A74A156FA;
  }

  return _id_BFC65A378A6D8EFE;
}

vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

createuseent(pos) {
  _id_DBCE45A33308630D = spawn("script_origin", pos);
  _id_DBCE45A33308630D.curprogress = 0;
  _id_DBCE45A33308630D.usetime = 0;
  _id_DBCE45A33308630D.userate = 8000;
  _id_DBCE45A33308630D.inuse = 0;
  return _id_DBCE45A33308630D;
}

getinteractionbynoteworthy(script_noteworthy) {
  foreach(interactionstruct in level.current_interaction_structs) {
    if(interactionstruct.script_noteworthy == script_noteworthy)
      return interactionstruct;
  }

  return undefined;
}

quicksort(array, _id_D35FC50E2F1F14DF) {
  return quicksortmid(array, 0, array.size - 1, _id_D35FC50E2F1F14DF);
}

quicksortmid(array, start, end, _id_D35FC50E2F1F14DF) {
  _id_AC0E594AC96AA3A8 = start;
  _id_AC0E5B4AC96AA80E = end;

  if(!isDefined(_id_D35FC50E2F1F14DF))
    _id_D35FC50E2F1F14DF = ::quicksort_compare;

  if(end - start >= 1) {
    pivot = array[start];

    while(_id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8) {
      while([[_id_D35FC50E2F1F14DF]](array[_id_AC0E594AC96AA3A8].patrolscore, pivot.patrolscore) && _id_AC0E594AC96AA3A8 <= end && _id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8)
        _id_AC0E594AC96AA3A8++;

      while(![[_id_D35FC50E2F1F14DF]](array[_id_AC0E5B4AC96AA80E].patrolscore, pivot.patrolscore) && _id_AC0E5B4AC96AA80E >= start && _id_AC0E5B4AC96AA80E >= _id_AC0E594AC96AA3A8)
        _id_AC0E5B4AC96AA80E--;

      if(_id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8)
        array = swap(array, _id_AC0E594AC96AA3A8, _id_AC0E5B4AC96AA80E);
    }

    array = swap(array, start, _id_AC0E5B4AC96AA80E);
    array = quicksortmid(array, start, _id_AC0E5B4AC96AA80E - 1, _id_D35FC50E2F1F14DF);
    array = quicksortmid(array, _id_AC0E5B4AC96AA80E + 1, end, _id_D35FC50E2F1F14DF);
  } else
    return array;

  return array;
}

quicksort_compare(left, right) {
  return left <= right;
}

swap(array, _id_5A488D6BAE780D02, _id_5A488C6BAE780ACF) {
  temp = array[_id_5A488D6BAE780D02];
  array[_id_5A488D6BAE780D02] = array[_id_5A488C6BAE780ACF];
  array[_id_5A488C6BAE780ACF] = temp;
  return array;
}

hideminimap(_id_CB4F608693686CB0) {
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  _id_5546BBD6B68A186D = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0)
    self.minimapstatetracker = 0;

  if(istrue(_id_CB4F608693686CB0) || self.minimapstatetracker == 0 && _id_5546BBD6B68A186D > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(_id_CB4F608693686CB0))
      self.minimapstatetracker = 0;
  }
}

showminimap() {
  if(is_minimap_forcedisabled()) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  _id_5546BBD6B68A186D = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && _id_5546BBD6B68A186D < self.minimapstatetracker)
    self setclientomnvar("ui_hide_minimap", 0);
}

getplayerdataloadoutgroup() {
  return "cploadouts";
}

getplayersinteam(team) {
  if(!isDefined(team))
    team = "allies";

  _id_3995EC6A46BD14DF = [];

  foreach(player in level.players) {
    if(player.team == team)
      _id_3995EC6A46BD14DF[_id_3995EC6A46BD14DF.size] = player;
  }

  return _id_3995EC6A46BD14DF;
}

_id_95E3A48DBAF38216() {
  foreach(player in level.players) {
    if(player _id_98CCAB873F262DBE())
      return 1;
  }

  return 0;
}

_id_98CCAB873F262DBE() {
  return !self haslastgroundorigin();
}

teleportallplayersinteamtostructs(team, _id_1391EEBE8EBE2CBC, _id_82E908EBD15BA4CC) {
  _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray(_id_1391EEBE8EBE2CBC, "targetname");

  if(!isDefined(_id_1925D24D0AE333E6) || _id_1925D24D0AE333E6.size < 4) {
    return;
  }
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  index = 0;

  foreach(player in getplayersinteam(team)) {
    _id_1925D24D0AE333E6[index].angles = scripts\engine\utility::ter_op(isDefined(_id_1925D24D0AE333E6[index].angles), _id_1925D24D0AE333E6[index].angles, (0, 0, 0));
    player setOrigin(_id_1925D24D0AE333E6[index].origin);
    player setplayerangles(_id_1925D24D0AE333E6[index].angles);
    player dontinterpolate();
    index++;
  }

  if(!istrue(_id_82E908EBD15BA4CC)) {
    return;
  }
  level thread thread_teleportplayertoteamstructs_latejoin(team, _id_1391EEBE8EBE2CBC);
}

thread_teleportplayertoteamstructs_latejoin(team, _id_1391EEBE8EBE2CBC) {
  level endon("game_ended");
  level notify("waiting_for_team_teleports_" + team);
  level endon("waiting_for_team_teleports_" + team);

  for(;;) {
    level waittill("connected", _id_B7B0DBFE5E343D18);
    level thread teleportplayertoteamstructs_latejoin(_id_B7B0DBFE5E343D18, _id_1391EEBE8EBE2CBC);
  }
}

teleportplayertoteamstructs_latejoin(_id_B7B0DBFE5E343D18, _id_1391EEBE8EBE2CBC) {
  _id_B7B0DBFE5E343D18 endon("disconnect");
  _id_B7B0DBFE5E343D18 waittill("spawned_player");
  waitframe();
  teleportplayertoteamstructs(_id_B7B0DBFE5E343D18, _id_1391EEBE8EBE2CBC);
}

teleportplayertoteamstructs(player, _id_1391EEBE8EBE2CBC) {
  _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray(_id_1391EEBE8EBE2CBC, "targetname");

  if(!isDefined(_id_1925D24D0AE333E6) || _id_1925D24D0AE333E6.size < 4) {
    return;
  }
  index = randomintrange(0, _id_1925D24D0AE333E6.size);
  _id_1925D24D0AE333E6[index].angles = scripts\engine\utility::ter_op(isDefined(_id_1925D24D0AE333E6[index].angles), _id_1925D24D0AE333E6[index].angles, (0, 0, 0));
  player setOrigin(_id_1925D24D0AE333E6[index].origin);
  player setplayerangles(_id_1925D24D0AE333E6[index].angles);
  player dontinterpolate();
}

init_vehicle_omnvars() {
  self setclientomnvar("ui_veh_vehicle", -1);
  self setclientomnvar("ui_veh_occupant_0", -1);
  self setclientomnvar("ui_veh_occupant_1", -1);
  self setclientomnvar("ui_veh_occupant_2", -1);
  self setclientomnvar("ui_veh_occupant_3", -1);
  self setclientomnvar("ui_veh_occupant_4", -1);
}

printgameaction(msg, player) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }
  _id_4FF53C0F1206C71D = "";

  if(isDefined(player))
    _id_4FF53C0F1206C71D = "[" + player getentitynumber() + ":" + player.name + "] ";
}

isplayerads() {
  return self playerads() > 0.5;
}

isairdenied() {
  if(isai(self))
    return 0;

  if(self.team == "spectator")
    return 0;

  return 0;
}

get_center_point_of_array(array) {
  center = (0, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    center = (center[0] + array[_id_AC0E594AC96AA3A8].origin[0], center[1] + array[_id_AC0E594AC96AA3A8].origin[1], center[2] + array[_id_AC0E594AC96AA3A8].origin[2]);

  return (center[0] / array.size, center[1] / array.size, center[2] / array.size);
}

sethintobject(_id_5E8EB3C31F9C265C, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  self makeusable();

  if(isDefined(_id_5E8EB3C31F9C265C))
    self sethinttag(_id_5E8EB3C31F9C265C);

  if(isDefined(_id_EE1F571F85C89C5C))
    self setCursorHint(_id_EE1F571F85C89C5C);
  else
    self setCursorHint("HINT_NOICON");

  if(isDefined(_id_EFE526BF6A23D275))
    self sethinticon(_id_EFE526BF6A23D275);

  if(isDefined(hintstring))
    self setHintString(hintstring);

  if(isDefined(priority)) {
    priority = int(clamp(priority, -10, 1));
    self setusepriority(priority);
  } else
    self setusepriority(-10);

  if(isDefined(duration)) {
    self setuseholdduration(duration);

    if(duration == "duration_medium" || duration == "duration_long")
      self sethintrequiresholding(1);
  } else
    self setuseholdduration("duration_short");

  if(isDefined(onobstruction))
    self sethintonobstruction(onobstruction);
  else
    self sethintonobstruction("hide");

  if(isDefined(hintdist))
    self sethintdisplayrange(hintdist);
  else
    self sethintdisplayrange(200);

  if(isDefined(hintfov))
    self sethintdisplayfov(hintfov);
  else
    self sethintdisplayfov(160);

  if(isDefined(usedist))
    self setuserange(usedist);
  else
    self setuserange(50);

  if(isDefined(usefov))
    self setusefov(usefov);
  else
    self setusefov(120);
}

is_indoors(target) {
  _id_E3D3DF168F5AFC37 = 0;
  targetpos = (0, 0, 0);

  if(isent(target))
    targetpos = target.origin;
  else if(isvector(target))
    targetpos = target;
  else if(isstruct(target))
    targetpos = target.origin;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(targetpos, targetpos + (0, 0, 10000), undefined, contents))
    _id_E3D3DF168F5AFC37 = 1;

  return _id_E3D3DF168F5AFC37;
}

is_indoors_vehicleignored(target) {
  _id_E3D3DF168F5AFC37 = 0;
  targetpos = (0, 0, 0);

  if(isent(target))
    targetpos = target.origin;
  else if(isvector(target))
    targetpos = target;
  else if(isstruct(target))
    targetpos = target.origin;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(targetpos, targetpos + (0, 0, 10000), undefined, contents))
    _id_E3D3DF168F5AFC37 = 1;

  return _id_E3D3DF168F5AFC37;
}

isgesture(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(issubstr(weaponname, "ges_plyr"))
    return 1;
  else if(issubstr(weaponname, "devilhorns_mp"))
    return 1;
  else
    return 0;
}

demo_button_combo_debug_watcher() {
  self endon("disconnect");

  if(!isDefined(self.debug_button_combos))
    setup_debug_button_combos_for_player();

  self notifyonplayercommand("up", "+actionslot 1");
  self notifyonplayercommand("up_release", "-actionslot 1");
  self notifyonplayercommand("down", "+actionslot 2");
  self notifyonplayercommand("down_release", "-actionslot 2");
  self notifyonplayercommand("use", "+usereload");
  self notifyonplayercommand("use", "+activate");
  self notifyonplayercommand("use_release", "-usereload");
  self notifyonplayercommand("use_release", "-activate");
  self notifyonplayercommand("stance", "+stance");
  self notifyonplayercommand("stance_release", "-stance");
  self notifyonplayercommand("ads", "+speed_throw");
  self notifyonplayercommand("ads_release", "-speed_throw");
  self notifyonplayercommand("attack", "+attack");
  self notifyonplayercommand("attack_release", "-attack");
  self notifyonplayercommand("touchpad", "+focus");
  self notifyonplayercommand("touchpad", "+togglescores");
  self notifyonplayercommand("touchpad", "togglescores");
  self notifyonplayercommand("touchpad_release", "-focus");
  self notifyonplayercommand("touchpad_release", "-togglescores");
  self notifyonplayercommand("swap_weapon", "+weapnext");
  self notifyonplayercommand("swap_weapon_release", "-weapnext");
  self notifyonplayercommand("A", "+gostand");
  self notifyonplayercommand("A_release", "-gostand");
  self notifyonplayercommand("RIGHT", "+actionslot 4");
  _id_AD1B1ABE4E839CF9 = ["up", "up_release", "down", "down_release", "use", "use_release", "stance", "stance_release", "A", "A_release", "right", "ads", "ads_release", "attack", "attack_release", "touchpad", "touchpad_release", "swap_weapon", "swap_weapon_release"];
  _id_9DAAA59B01E8CDAF = [];
  max_time = 2;
  _id_83AF904929099C18 = undefined;

  for(;;) {
    _id_5E5A12680C656171 = level.demo_button_combos;
    result = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_AD1B1ABE4E839CF9);

    if(getdvarint("dvar_C021E81D04F69F38", 0)) {
      time = gettime();

      if(!isDefined(_id_83AF904929099C18))
        _id_83AF904929099C18 = time + max_time * 1000;

      _id_9DAAA59B01E8CDAF[_id_9DAAA59B01E8CDAF.size] = result;

      if(time >= _id_83AF904929099C18) {
        _id_83AF904929099C18 = undefined;
        _id_9DAAA59B01E8CDAF = [];
        continue;
      } else {
        _id_83AF904929099C18 = time + max_time * 1000;
        _id_9DAAA59B01E8CDAF = validate_button_combo(_id_9DAAA59B01E8CDAF);

        if(_id_9DAAA59B01E8CDAF.size < 1)
          _id_83AF904929099C18 = undefined;
      }
    }
  }
}

setup_debug_button_combos_for_player() {}

add_demo_button_combo(button_combo, func, message, timeout) {
  struct = spawnStruct();
  struct.button_combo = button_combo;
  struct.func = func;
  struct.message = message;
  struct.timeout = timeout;
  level.demo_button_combos[level.demo_button_combos.size] = struct;
}

validate_button_combo(_id_9DAAA59B01E8CDAF) {
  _id_4FB3F5B8B87FF230 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.demo_button_combos.size; _id_AC0E594AC96AA3A8++) {
    data = level.demo_button_combos[_id_AC0E594AC96AA3A8];
    _id_927B3199642B75FC = level.demo_button_combos[_id_AC0E594AC96AA3A8].button_combo;

    if(_id_9DAAA59B01E8CDAF.size <= _id_927B3199642B75FC.size) {
      if(_id_9DAAA59B01E8CDAF[_id_9DAAA59B01E8CDAF.size - 1] == _id_927B3199642B75FC[_id_9DAAA59B01E8CDAF.size - 1]) {
        if(_id_9DAAA59B01E8CDAF.size == _id_927B3199642B75FC.size) {
          if(isDefined(data.message))
            announcement(data.message);

          _id_9DAAA59B01E8CDAF = [];
          self thread[[data.func]]();
        }

        _id_4FB3F5B8B87FF230 = _id_9DAAA59B01E8CDAF;
        break;
      }
    }
  }

  return _id_4FB3F5B8B87FF230;
}

getenemyteams(_id_68BB1F110EC06A58) {
  teams = level.teamnamelist;
  teams = scripts\engine\utility::array_remove(teams, _id_68BB1F110EC06A58);
  return teams;
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

getgametype() {
  return level.gametype;
}

getsubgametype() {
  gametype = getgametype();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return getDvar("dvar_7611A2790A0BF7FE", "br");

  return gametype;
}

register_create_script(script, _id_365929041E4386ED, index, func) {
  if(isDefined(script))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = script;

  if(isDefined(_id_365929041E4386ED))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = _id_365929041E4386ED;

  if(isDefined(index))
    level.create_script_file_ids[script] = "cs" + index;

  if(isDefined(func))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = func;
}

array_notify(ents, _id_B3D834019B5EA83F, _id_AA9F4C033D62BC8A) {
  foreach(key, value in ents)
  value notify(_id_B3D834019B5EA83F, _id_AA9F4C033D62BC8A);
}

addtoactivekillstreaklist(streakname, threatbiasgroup, owner, outline, teamheadicon, _id_81DBFC1D134BF264, _id_CFB9E6D8091C048B) {
  if(istrue(teamheadicon)) {
    ownerinvisible = 0;

    if(owner isusingremote())
      ownerinvisible = 1;

    icon = undefined;

    if(level.teambased)
      icon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, _id_81DBFC1D134BF264, 1, 10000, undefined, undefined, 1, ownerinvisible);
    else
      icon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(owner, "hud_icon_head_equipment_friendly", _id_81DBFC1D134BF264, 1, 10000, undefined, undefined, 1);

    thread removeteamheadicononnotify(icon, _id_CFB9E6D8091C048B);
  }
}

removeteamheadicononnotify(icon, _id_CFB9E6D8091C048B) {
  _id_819382A0FC083B42 = ["death"];

  if(isDefined(_id_CFB9E6D8091C048B))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_CFB9E6D8091C048B;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_819382A0FC083B42);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
}

killstreak_make_vehicle(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.vehiclename = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
  self enableplayermarks("killstreak");
  self filteroutplayermarks(self.team);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);

  if(isDefined(self.owner))
    self.owner notify("killstreak_vehicle_made", self);
}

_id_73AE764F6D95E017(_id_2B7CF61AF0CB9960, _id_5806C73139E2A5E3) {
  _id_1002CEB046A0D0F8 = _func_1823FF50BB28148D(_id_2B7CF61AF0CB9960);
  game["dialog"][_id_1002CEB046A0D0F8] = _id_5806C73139E2A5E3._id_F6F44AE79C7EB44D;
  game["dialog"]["allies_friendly_" + _id_2B7CF61AF0CB9960 + "_inbound"] = _id_5806C73139E2A5E3._id_CC5128455E1A40D4 + "_friendly_use";
  game["dialog"]["allies_enemy_" + _id_2B7CF61AF0CB9960 + "_inbound"] = _id_5806C73139E2A5E3._id_CC5128455E1A40D4 + "_enemy_use";
  game["dialog"]["axis_friendly_" + _id_2B7CF61AF0CB9960 + "_inbound"] = _id_5806C73139E2A5E3._id_6E25C01B88FC2F76 + "_friendly_use";
  game["dialog"]["axis_enemy_" + _id_2B7CF61AF0CB9960 + "_inbound"] = _id_5806C73139E2A5E3._id_6E25C01B88FC2F76 + "_enemy_use";
  game["dialog"]["use_" + _id_2B7CF61AF0CB9960] = _id_5806C73139E2A5E3._id_CC5128455E1A40D4 + "_use";
  game["dialog"]["destroyed_" + _id_2B7CF61AF0CB9960] = _id_5806C73139E2A5E3._id_CC5128455E1A40D4 + "_destroyed";
  game["dialog"]["timeout_" + _id_2B7CF61AF0CB9960] = _id_5806C73139E2A5E3._id_CC5128455E1A40D4 + "_timeout";
}

killstreak_set_pre_mod_damage_callback(streakname, _id_BACC6DD14316758C) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback(streakname, level.kspremoddamagecallback);
  self.kspremoddamagecallback = _id_BACC6DD14316758C;
}

killstreak_set_post_mod_damage_callback(streakname, _id_7DA88D9C69433487) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback(streakname, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = _id_7DA88D9C69433487;
}

killstreak_set_death_callback(streakname, deathcallback) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_death_callback(streakname, level.ksdeathcallback);
  self.ksdeathcallback = deathcallback;
}

killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = ::killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = ::killstreak_post_mod_damage_callback;
    level.ksdeathcallback = ::killstreak_death_callback;
  }
}

killstreak_pre_mod_damage_callback(data) {
  damage = data.damage;
  attacker = data.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(attacker) && isDefined(self.owner) && attacker == self.owner)
      damage = int(ceil(damage * 0.5));

    data.damage = damage;
  }

  _id_35AB2DABE0210D0F = 1;
  _id_BACC6DD14316758C = self.kspremoddamagecallback;

  if(isDefined(_id_BACC6DD14316758C))
    _id_35AB2DABE0210D0F = self[[_id_BACC6DD14316758C]](data);

  return _id_35AB2DABE0210D0F;
}

killstreak_post_mod_damage_callback(data) {
  killstreakhit(data.attacker, data.objweapon, self, data.meansofdeath, data.damage);
  _id_35AB2DABE0210D0F = 1;
  _id_7DA88D9C69433487 = self.kspostmoddamagecallback;

  if(isDefined(_id_7DA88D9C69433487))
    _id_35AB2DABE0210D0F = self[[_id_7DA88D9C69433487]](data);

  return _id_35AB2DABE0210D0F;
}

killstreak_death_callback(data) {
  onkillstreakkilled(self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  _id_35AB2DABE0210D0F = 1;
  deathcallback = self.ksdeathcallback;

  if(isDefined(deathcallback))
    _id_35AB2DABE0210D0F = self[[deathcallback]](data);

  return _id_35AB2DABE0210D0F;
}

killstreakhit(attacker, objweapon, vehicle, meansofdeath, damage) {
  if(isDefined(objweapon) && isPlayer(attacker) && isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, vehicle.owner)) {
      if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
        return;
      }
      _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

      if(!isDefined(attacker.lasthittime[_id_366B0ECC2F28AEAD]))
        attacker.lasthittime[_id_366B0ECC2F28AEAD] = 0;

      if(attacker.lasthittime[_id_366B0ECC2F28AEAD] == gettime()) {
        return;
      }
      attacker.lasthittime[_id_366B0ECC2F28AEAD] = gettime();

      if(onlinestatsenabled()) {}

      if(isDefined(meansofdeath) && scripts\engine\utility::isbulletdamage(meansofdeath) || isprojectiledamage(meansofdeath)) {
        attacker.lastdamagetime = gettime();
        _id_CF4209C200F8BBF4 = _id_74502A9E0EF1F19C::getweapongroup(objweapon.basename);

        if(_id_CF4209C200F8BBF4 == "weapon_lmg") {
          if(!isDefined(attacker.shotslandedlmg))
            attacker.shotslandedlmg = 1;
          else
            attacker.shotslandedlmg++;
        }
      }
    }
  }
}

setkillstreakcontrolpriority(owner, hintstring, _id_DAF100468D8A5E15, _id_0A68F5A8AED5A3DE, _id_5B37B3F49E242039, userange, usepriority, _id_A4C898CA05DF4D4C) {
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self sethintonobstruction("show");
  self setHintString(hintstring);
  self sethintdisplayfov(_id_DAF100468D8A5E15);
  self setusefov(_id_0A68F5A8AED5A3DE);
  self sethintdisplayrange(_id_5B37B3F49E242039);
  self setuserange(userange);
  self setusepriority(1);
  level thread applyplayercontrolonconnect(self);

  foreach(player in level.players) {
    if(player == owner && !istrue(_id_A4C898CA05DF4D4C)) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

applyplayercontrolonconnect(_id_92C89B8FAA10B85F) {
  _id_92C89B8FAA10B85F endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    _id_92C89B8FAA10B85F disableplayeruse(player);
  }
}

isprojectiledamage(meansofdeath) {
  _id_7C02104B4AA99077 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(_id_7C02104B4AA99077, meansofdeath))
    return 1;

  return 0;
}

onkillstreakkilled(_id_D8061F26B5ECA018, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, _id_92D090CE35588AD2, leaderdialog, _id_6342E2DA1DC12454, _id_DC695757F69ED065) {
  _id_40EA91E2825FA07A = 0;
  _id_2D113E958C753976 = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner))
      attacker = attacker.owner;
  } else if(isDefined(attacker) && isDefined(self.team) && isDefined(attacker.team)) {
    if(isenemy(attacker) && isPlayer(attacker))
      _id_2D113E958C753976 = attacker;
  }

  if(isDefined(_id_2D113E958C753976)) {
    if(isDefined(_id_6342E2DA1DC12454))
      _id_2D113E958C753976 scripts\cp\cp_player_battlechatter::killstreakdestroyed(_id_D8061F26B5ECA018);

    if(getgametype() == "incursion")
      thread _id_293BC33BD79CABD1::killedkillstreak(_id_D8061F26B5ECA018, _id_2D113E958C753976, objweapon);
    else
      thread _id_293BC33BD79CABD1::killedkillstreak(_id_D8061F26B5ECA018, _id_2D113E958C753976, objweapon);

    if(!is_specops_gametype())
      thread scripts\cp\cp_challenge::killstreakkilled(_id_D8061F26B5ECA018, self.owner, self, _id_2D113E958C753976, damage, _id_D95DA0355CF4CCB4, objweapon, _id_92D090CE35588AD2);

    scripts\cp_mp\gestures::processcalloutdeath(self, _id_2D113E958C753976);
    _id_40EA91E2825FA07A = 1;
  }

  if(isDefined(self.owner) && isDefined(leaderdialog)) {}

  if(!istrue(_id_DC695757F69ED065))
    self notify("death");

  return _id_40EA91E2825FA07A;
}

heli_starts_restrict_to(_id_7215F6BDF6079327) {
  heli_starts_clear();
  heli_starts_addstart(_id_7215F6BDF6079327 + "_heli_entrance", _id_7215F6BDF6079327 + "_heli_goal");
}

heli_starts_addstart(_id_110A822F8804AC3F, _id_B6D48B11446F1C58) {
  if(!isDefined(level.heli_structs_entrances))
    level.heli_structs_entrances = [];

  if(!isDefined(level.heli_structs_goals))
    level.heli_structs_goals = [];

  _id_B2F2CBEB5539EFA6 = scripts\engine\utility::getStruct(_id_110A822F8804AC3F, "script_noteworthy");
  goalstruct = scripts\engine\utility::getStruct(_id_B6D48B11446F1C58, "script_noteworthy");
  level.heli_structs_entrances[level.heli_structs_entrances.size] = _id_B2F2CBEB5539EFA6;
  level.heli_structs_goals[level.heli_structs_goals.size] = goalstruct;
}

heli_starts_clear() {
  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size >= 1)
    level.heli_structs_entrances = [];

  if(isDefined(level.heli_structs_goals) && level.heli_structs_goals.size >= 1)
    level.heli_structs_goals = [];
}

is_raid_gamemode() {
  if(getdvarint("dvar_FE379B650D9837FB", 0))
    return 1;

  return level.script == "cp_raid1" || level.script == "cp_raid1_trap" || level.script == "cp_raid1test" || level.script == "cp_jugg_maze" || level.script == "cp_capture_jugg" || level.script == "cp_raid1_boss1";
}

_id_93D685AC42F15C61() {
  if(getdvarint("dvar_F241138DC4147E30", 0))
    return 1;

  if(level.script == "cp_observatory")
    return 1;

  return 0;
}

_id_F993F83A21FC44B2() {
  if(_id_DDAFEF2154FD19BB() || _id_93D685AC42F15C61())
    return 1;

  return 0;
}

is_wave_gametype() {
  if(level.gametype == "cp_wave_sv")
    return 1;

  return 0;
}

_id_A3577E8E6C88A56B() {
  if(level.gametype == "missions")
    return 1;

  return 0;
}

_id_F620E996A1D7D81A() {
  if(level.gametype == "cqc")
    return 1;

  return 0;
}

_id_DDAFEF2154FD19BB() {
  if(level.gametype == "incursion")
    return 1;

  return 0;
}

is_specops_gametype() {
  return level.gametype == "cp_specops";
}

is_operations_gametype() {
  if(level.gametype == "cp_survival")
    return 1;

  return 0;
}

is_cp_raid() {
  mapname = getDvar("ui_mapname");

  if(mapname == "cp_raid_complex" || mapname == "cp_dntsk_raid")
    return 1;

  return 0;
}

issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled))
    level.simultaneouskillenabled = getdvarint("dvar_0AA96B1E9C9809B8", 0) == 0;

  return level.simultaneouskillenabled;
}

onlinestatsenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("xblive_privatematch");
}

play_music_to_team(_id_DB0AF3B332459B0F, _id_908ECECF1B52292E) {
  if(!isDefined(_id_DB0AF3B332459B0F) || _id_DB0AF3B332459B0F == "") {
    return;
  }
  _id_2A29B237DCC66FE5 = level.players;

  if(isDefined(_id_908ECECF1B52292E)) {
    if(!isarray(_id_908ECECF1B52292E))
      _id_2A29B237DCC66FE5 = [_id_908ECECF1B52292E];
    else
      _id_2A29B237DCC66FE5 = _id_908ECECF1B52292E;
  }

  foreach(player in _id_2A29B237DCC66FE5)
  player setplayermusicstate(_id_DB0AF3B332459B0F);
}

watch_and_open_scriptable_doors_in_radius(radius) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  player = self;
  radius = scripts\engine\utility::ter_op(isDefined(radius), radius, 64);
  _id_284908EDB3C3318D = 1.5;
  _id_36F2D54BCBAAE65A = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    _id_9BC823CAB1BB2862 = [];
    _id_913576E1DC1762B5 = getentitylessscriptablearray(undefined, undefined, player.origin, radius);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_913576E1DC1762B5.size; _id_AC0E594AC96AA3A8++) {
      if(_id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] scriptableisdoor() && !_id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] _id_F8B5985C95ABF390())
        _id_9BC823CAB1BB2862[_id_9BC823CAB1BB2862.size] = _id_913576E1DC1762B5[_id_AC0E594AC96AA3A8];
    }

    for(x = 0; x < _id_9BC823CAB1BB2862.size; x++)
      _id_9BC823CAB1BB2862[x] setscriptablepartstate("door", "left_30", 0);

    wait(_id_284908EDB3C3318D);
  }
}

_id_F8B5985C95ABF390() {
  if(self _meth_FAC544C98A3D9EB4())
    return 1;

  if(istrue(self.blocked) || istrue(self.locked))
    return 1;

  return 0;
}

get_num_of_valid_players() {
  _id_3E4003108CC20CE5 = 0;

  foreach(player in level.players) {
    if(player is_valid_player())
      _id_3E4003108CC20CE5++;
  }

  return _id_3E4003108CC20CE5;
}

track_last_good_position(_id_564065B333A4D983, _id_E2A5E9ED59B3FDC0) {
  self endon("death");
  self notify("track_last_good_position");
  self endon("track_last_good_position");

  if(!isDefined(_id_E2A5E9ED59B3FDC0))
    _id_E2A5E9ED59B3FDC0 = 0.1;

  for(;;) {
    wait(_id_E2A5E9ED59B3FDC0);

    if(!isDefined(self)) {
      continue;
    }
    if(!isDefined(self.origin)) {
      continue;
    }
    if(isDefined(self.last_good_pos) && self.origin == self.last_good_pos) {
      continue;
    }
    if(!isalive(self)) {
      continue;
    }
    if(self isjumping()) {
      continue;
    }
    if(self isparachuting()) {
      continue;
    }
    if(self isonladder()) {
      continue;
    }
    if(!self isonground()) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      continue;
    }
    if(isDefined(level.outofboundstriggers)) {
      foreach(trigger in level.outofboundstriggers) {
        if(self istouching(trigger))
          continue;
      }
    }

    if(isDefined(level.landmine_trig) && self istouching(level.landmine_trig)) {
      continue;
    }
    if(istrue(self.spectating)) {
      continue;
    }
    if(istrue(self.hurt_trigger_active)) {
      continue;
    }
    if(istrue(self.landmine_active)) {
      continue;
    }
    if(istrue(_id_564065B333A4D983) && !ispointonnavmesh(self.origin)) {
      continue;
    }
    self.last_good_pos = self.origin;
  }
}

coop_mode_has(_id_79C25880C20BA9E5) {
  if(!isDefined(level.coop_mode_feature))
    return 0;

  if(_id_1772811F5B613303(_id_79C25880C20BA9E5))
    return 0;

  return isDefined(level.coop_mode_feature[_id_79C25880C20BA9E5]) && istrue(level.coop_mode_feature[_id_79C25880C20BA9E5]);
}

_id_1772811F5B613303(_id_79C25880C20BA9E5) {
  if(!isDefined(level._id_8C70B00C48E8BD20))
    return 0;

  return istrue(level._id_8C70B00C48E8BD20[_id_79C25880C20BA9E5]);
}

coop_mode_enable(_id_8BD840D9E73DB823) {
  if(isDefined(_id_8BD840D9E73DB823)) {
    if(isarray(_id_8BD840D9E73DB823)) {
      foreach(_id_E8614B97C15BDA69 in _id_8BD840D9E73DB823)
      level.coop_mode_feature[_id_E8614B97C15BDA69] = 1;
    } else
      level.coop_mode_feature[_id_8BD840D9E73DB823] = 1;
  }
}

_id_223A423CF3851491(_id_8BD840D9E73DB823) {
  _id_8BD840D9E73DB823 = force_var_to_array(_id_8BD840D9E73DB823);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8BD840D9E73DB823.size; _id_AC0E594AC96AA3A8++) {
    level._id_8C70B00C48E8BD20[_id_8BD840D9E73DB823[_id_AC0E594AC96AA3A8]] = 1;

    if(isDefined(level.coop_mode_feature[_id_8BD840D9E73DB823[_id_AC0E594AC96AA3A8]]))
      level.coop_mode_feature[_id_8BD840D9E73DB823[_id_AC0E594AC96AA3A8]] = undefined;
  }
}

force_var_to_array(_id_79C25880C20BA9E5) {
  _id_6D906809844C7CB1 = _id_79C25880C20BA9E5;

  if(!isarray(_id_79C25880C20BA9E5))
    _id_6D906809844C7CB1 = [_id_79C25880C20BA9E5];

  return _id_6D906809844C7CB1;
}

_id_6AAFBDD00B977115() {
  if(istrue(level.disable_nvg))
    return 0;

  return 1;
}

_id_7BB9F9B4DC700888() {
  level.disable_nvg = 1;
}

_id_B4CA8A0FC3169F35() {
  level.disable_nvg = 0;
}

_id_C0D2C91F2688ECE4(_id_E3108E412AFB3811, locked) {
  if(!istrue(level._id_7B52AA5A0569211C)) {
    level._id_7B52AA5A0569211C = locked;
    level._id_624BA233506A543E = !_id_E3108E412AFB3811;
  }
}

_id_042B1F4ECAC37172(_id_7926DDB0FC735820) {
  self endon("disconnect");
  _id_66122A002AFF5D57::takerevivepickup();

  if(!istrue(_id_7926DDB0FC735820))
    self._id_0BBC9FFD2DF014C2 = 1;
}

_id_ACE2CA7720DDEDAC(_id_7926DDB0FC735820) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive");
  self endon("revive_success");

  if(!isDefined(_id_7926DDB0FC735820))
    _id_7926DDB0FC735820 = 0;

  if(self usinggamepad())
    self notifyonplayercommand("pressed_autorevive", "+usereload");
  else
    self notifyonplayercommand("pressed_autorevive", "+activate");

  if(!_id_7926DDB0FC735820)
    thread _id_B94DF25AA73F60A0();

  wait 0.1;
  thread _id_5A7185EA887BC9D4();
  self._id_235EDEF1B3F12286 = 0;

  while(!self._id_235EDEF1B3F12286) {
    if(!_id_7926DDB0FC735820)
      self waittill("pressed_autorevive");

    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      if(!isDefined(self.dogtag)) {
        if(_id_0AFB7E332AEE4BF2::getbeingrevivedinternal()) {
          waitframe();
          continue;
        }

        self.using_self_revive = 1;
        self giveandfireoffhand("adrenaline_mp");

        if(isDefined(self.reviveiconent))
          _id_0AFB7E332AEE4BF2::set_revive_icon_color(self.reviveiconent);

        self._id_235EDEF1B3F12286 = _id_06D974261DA967F6(_id_7926DDB0FC735820);
        self.using_self_revive = undefined;

        if(istrue(self._id_235EDEF1B3F12286)) {
          foreach(player in level.players) {
            if(player != self)
              player thread scripts\cp\cp_hud_message::showsplash("cp_used_self_revive", undefined, self);
          }

          thread scripts\cp\cp_hud_message::showsplash("cp_self_revive");
          thread _id_0AFB7E332AEE4BF2::instant_revive(self);
        }
      }

      continue;
    }

    break;
  }

  return 1;
}

_id_B94DF25AA73F60A0() {
  self endon("disconnect");

  for(;;) {
    if(!_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      break;
    }

    if(!_id_0AFB7E332AEE4BF2::getbeingrevivedinternal())
      scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/USE_SELF_REVIVE", 2);

    wait 2;
  }
}

_id_5A7185EA887BC9D4() {
  level endon("game_ended");
  self endon("disconnect");
  msg = scripts\engine\utility::waittill_any_return_3("revive", "revive_success");
  self.curprogress = 0;

  if(self._id_235EDEF1B3F12286) {
    if(isDefined(self.dogtag))
      self.dogtag delete();

    if(self usinggamepad())
      self notifyonplayercommandremove("pressed_autorevive", "+usereload");
    else
      self notifyonplayercommandremove("pressed_autorevive", "+activate");

    self notify("clear_tutorial_messages");
    self clearhudtutorialmessage();
    self.self_revive--;

    if(self.self_revive < 1) {
      self.self_revive = undefined;
      self.has_auto_revive = 0;
      self._id_0BBC9FFD2DF014C2 = undefined;
    }

    if(isDefined(self._id_9F4E140E6DCBC55D)) {
      index = self._id_9F4E140E6DCBC55D.size - 1;
      item = self._id_9F4E140E6DCBC55D[index];
      slot = item.slot;
      remove_carry_item(self, slot);
      self._id_9F4E140E6DCBC55D[index] = undefined;
    }
  }

  self setclientomnvar("ui_self_revive", 0);
}

_id_06D974261DA967F6(_id_7926DDB0FC735820) {
  _id_22F7E3F7E360775B = self;
  reviver = self;

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  if(!isDefined(self.userate))
    self.userate = 1;

  if(!isDefined(self.usetime))
    self.usetime = _id_0AFB7E332AEE4BF2::get_normal_revive_time();

  level endon("game_ended");
  _id_22F7E3F7E360775B endon("death_or_disconnect");
  _id_22F7E3F7E360775B endon("last_stand_finished");

  for(;;) {
    if(_id_0AFB7E332AEE4BF2::getbeingrevivedinternal(self)) {
      if(isDefined(self.reviveiconent))
        _id_0AFB7E332AEE4BF2::set_revive_icon_color(self.reviveiconent);

      self.curprogress = self.curprogress - level.frameduration * self.userate;
      waitframe();
    }

    if(!istrue(_id_7926DDB0FC735820)) {
      if(!reviver useButtonPressed()) {
        break;
      }
    }

    self.curprogress = self.curprogress + level.frameduration * self.userate;
    self.userate = 1;
    self.id = "self_revive";
    reviver updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      _id_22F7E3F7E360775B notify("use_hold_think_success");
      reviver updateuiprogress(self, 0);
      return 1;
    }

    waitframe();
  }

  _id_22F7E3F7E360775B notify("use_hold_think_fail");
  reviver updateuiprogress(self, 0);
  return 0;
}

updateuiprogress(object, _id_9828F1535ACBC937) {
  if(!isDefined(level.hostmigrationtimer)) {
    if(isDefined(object.interactteam) && object.interactteam == "none") {
      self setclientomnvar("ui_objective_pinned_text_param", 0);
      return;
    }

    objid = undefined;

    if(isDefined(object.objidnum))
      objid = object.objidnum;

    progress = 0;

    if(isDefined(object.teamprogress) && isDefined(object.claimteam)) {
      if(object.teamprogress[object.claimteam] > object.usetime)
        object.teamprogress[object.claimteam] = object.usetime;

      progress = object.teamprogress[object.claimteam] / object.usetime;
    } else {
      if(object.curprogress > object.usetime)
        object.curprogress = object.usetime;

      progress = object.curprogress / object.usetime;

      if(object.usetime <= 1000)
        progress = min(progress + 0.05, 1);
      else
        progress = min(progress + 0.01, 1);
    }

    if(isDefined(object.id)) {
      _id_FE8F7703F6313ED4 = 0;

      switch (object.id) {
        case "care_package":
        case "bradley":
          _id_FE8F7703F6313ED4 = 1;
          break;
        case "intel":
          _id_FE8F7703F6313ED4 = 2;
          break;
        case "support_box":
          _id_FE8F7703F6313ED4 = 3;
          break;
        case "deployable_weapon_crate":
          _id_FE8F7703F6313ED4 = 4;
          break;
        case "laststand_reviver":
          _id_FE8F7703F6313ED4 = 5;
          break;
        case "laststand_revivee":
          _id_FE8F7703F6313ED4 = 6;
          break;
        case "breach":
          _id_FE8F7703F6313ED4 = 7;
          break;
        case "use":
          _id_FE8F7703F6313ED4 = 8;
          break;
        case "breach_defuse":
          _id_FE8F7703F6313ED4 = 9;
          break;
        case "bounty":
          _id_FE8F7703F6313ED4 = 10;
          break;
        case "hack":
          _id_FE8F7703F6313ED4 = 13;
          break;
        case "hvt_search":
          _id_FE8F7703F6313ED4 = 15;
          break;
        case "self_revive":
          _id_FE8F7703F6313ED4 = 16;
          break;
        case "laststand_interrogator":
          _id_FE8F7703F6313ED4 = 19;
          break;
      }

      updateuisecuring(progress, _id_9828F1535ACBC937, _id_FE8F7703F6313ED4, object, object.usetime);
    }
  }
}

isrevivetrigger() {
  if(isDefined(self.id) && self.id == "laststand_reviver")
    return 1;

  return 0;
}

_id_1DBC717085326045(ui_securing, _id_F2E7F69724265F30, _id_B3F74F756B90FF1F) {
  _id_1DAB4A6BAD01C509 = self getentitynumber();

  if(isDefined(ui_securing)) {
    self setclientomnvar("ui_securing", ui_securing);
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_securing", ui_securing);
  }

  if(isDefined(_id_F2E7F69724265F30)) {
    self setclientomnvar("ui_securing_progress", _id_F2E7F69724265F30);
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_securing_progress", _id_F2E7F69724265F30);
  }

  if(isDefined(_id_B3F74F756B90FF1F))
    self setclientomnvar("ui_reviver_id", _id_B3F74F756B90FF1F);
}

updateuisecuring(progress, _id_9828F1535ACBC937, _id_FE8F7703F6313ED4, object, usetime) {
  objid = undefined;

  if(_id_9828F1535ACBC937) {
    if(!isDefined(object.usedby))
      object.usedby = [];

    if(!scripts\engine\utility::array_contains(object.usedby, self))
      object.usedby[object.usedby.size] = self;

    if(!isDefined(self.ui_securing)) {
      _id_1DBC717085326045(_id_FE8F7703F6313ED4);
      self.ui_securing = 1;

      if(isDefined(object.trigger) && object.trigger isrevivetrigger()) {
        if(isDefined(object.trigger.owner) && object.trigger.owner != self)
          object.trigger.owner _id_1DBC717085326045(6, undefined, self getentitynumber());
      }
    }
  } else {
    if(isDefined(object.usedby) && scripts\engine\utility::array_contains(object.usedby, self))
      object.usedby = scripts\engine\utility::array_remove(object.usedby, self);

    _id_1DBC717085326045(0);
    self.ui_securing = undefined;

    if(isDefined(object.trigger) && object.trigger isrevivetrigger()) {
      if(isDefined(object.trigger.owner))
        object.trigger.owner _id_1DBC717085326045(0, undefined, -1);
    }

    progress = 0.01;

    if(isDefined(object.objidnum))
      objid = object.objidnum;
  }

  if(usetime == 500)
    progress = min(progress + 0.15, 1);

  if(progress != 0) {
    _id_1DBC717085326045(undefined, progress, undefined);

    if(isDefined(object.trigger) && object.trigger isrevivetrigger()) {
      if(isDefined(object.trigger.owner))
        object.trigger.owner _id_1DBC717085326045(undefined, progress, undefined);
    }

    if(isDefined(object.objidnum))
      objective_setprogress(object.objidnum, progress);
  }
}

_id_AD3CE5E1679DF13D(weaponobj) {
  if(isDefined(level._id_A1099F1A44938DA3))
    self[[level._id_A1099F1A44938DA3]](weaponobj);
  else
    self givemaxammo(weaponobj);
}

_id_ED18A118C6FA5C4F(weapon) {
  if(isDefined(level._id_A636C794CDB0B43B))
    return [[level._id_A636C794CDB0B43B]](weapon);
  else
    return weaponmaxammo(weapon);
}

_id_ED8121366A308031(ent) {
  ent endon("death");
  self waittill("death");

  if(isDefined(ent)) {
    ent scripts\common\utility::_id_CEFC758E6B25A243();
    ent freescriptable();
  }
}

add_start(_id_9B08CC0CA316E788, _id_D0E49134703DA0D5, _id_032566017AA4406B, _id_7A3C1094F38EC7D2) {
  _id_3FEEC618E51A6291::add_start_assert();
  msg = tolower(_id_9B08CC0CA316E788);
  array = _id_3FEEC618E51A6291::add_start_construct(msg, _id_D0E49134703DA0D5, _id_032566017AA4406B, _id_7A3C1094F38EC7D2);
  level.start_functions[level.start_functions.size] = array;
  level.start_arrays[msg] = array;
}

is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
    return 0;

  if(isDefined(level.default_start_override)) {
    if(level.default_start_override == level.start_point)
      return 1;
  } else if(_id_3FEEC618E51A6291::level_has_start_points())
    return level.start_point == level.start_functions[0]["name"];

  return level.start_point == "default";
}

set_default_start(start) {
  level.default_start_override = start;
}

_id_9EC4754A395BCC2D() {
  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);
}

_id_AE99616202575E39(_id_CFFBE4EB883CE63B, _id_195927E09B405481) {
  self endon("death");
  zoffset = (0, 0, 30);
  scripts\asm\asm_mp::asm_setanimScripted();
  self orientmode("face angle", vectortoangles(_id_CFFBE4EB883CE63B - self.origin)[1]);
  animname = "grenade_throw";
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", animname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);
  self aisetanim("animscripted", animindex);
  _id_20343D86382EC753 = animlength / 2;
  wait(_id_20343D86382EC753);
  _id_06A3A1033FFC2699 = (_id_CFFBE4EB883CE63B[0], _id_CFFBE4EB883CE63B[1], self.origin[2]) - (self.origin + zoffset);
  _id_06A3A1033FFC2699 = vectorNormalize(_id_06A3A1033FFC2699);
  _id_3EB0E5F5F61F0A10 = self.origin + zoffset + _id_06A3A1033FFC2699 * 20;
  _id_F8048727716242B0 = distance2d(_id_3EB0E5F5F61F0A10, _id_CFFBE4EB883CE63B);
  velocity = _id_F8048727716242B0 * _id_06A3A1033FFC2699;
  _id_E020078567E41613 = self launchgrenade(_id_195927E09B405481, _id_3EB0E5F5F61F0A10, velocity);
  _id_E020078567E41613.owner = self;
  wait(_id_20343D86382EC753);
  scripts\asm\asm_bb::bb_clearanimScripted();
}

ifcanseeplayer(soldier, player) {
  if(!isDefined(player))
    return 0;

  if(istrue(player.ignoreme))
    return 0;

  _id_B72BDF4AD529C791 = isPlayer(player);
  dist = distance(player.origin, soldier.origin);
  _id_3497D6AC3151641C = istrue(soldier.damaged);
  _id_9540D52E669B0713 = 1;
  _id_1D0DFDFEE6CACB97 = player getvelocity();
  _id_A8F6A48BE8F34C73 = length(_id_1D0DFDFEE6CACB97);

  if(_id_A8F6A48BE8F34C73 < 128)
    _id_9540D52E669B0713 = 0.75;
  else if(_id_A8F6A48BE8F34C73 < 200 || _id_B72BDF4AD529C791 && player.perk_data["stealth_velocity_override"])
    _id_9540D52E669B0713 = 1;
  else
    _id_9540D52E669B0713 = 1.25;

  if(dist > 1500 * _id_9540D52E669B0713)
    return 0;

  _id_17BF930968A3057D = soldier cansee(player);

  if(_id_17BF930968A3057D) {
    _id_2F97851DDA9B1547 = cos(75);
    _id_5EF9B5A1FB992A8D = scripts\engine\utility::within_fov(soldier getEye(), soldier getplayerangles(1), player.origin + (0, 0, 40), _id_2F97851DDA9B1547);

    if(!_id_5EF9B5A1FB992A8D)
      return 0;

    passed = sighttracepassed(soldier getEye(), player getEye(), 0, soldier, _id_3497D6AC3151641C);

    if(!passed)
      return 0;

    contents = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(soldier getEye(), player getEye(), soldier, contents))
      return 0;

    _id_5B94F282F7C090C5 = scripts\engine\math::get_dot(soldier.origin, anglesToForward(soldier.angles), player.origin);
    _id_9540D52E669B0713 = 1;

    if(_id_5B94F282F7C090C5 >= 0.573576)
      _id_9540D52E669B0713 = _id_9540D52E669B0713 - 0.34;

    if(_id_3497D6AC3151641C)
      _id_9540D52E669B0713 = _id_9540D52E669B0713 - 0.34;

    stance = player getstance();

    if(dist <= int(350 / _id_9540D52E669B0713)) {
      if(stance == "prone")
        return 0;

      return 1;
    } else if(dist <= int(500 / _id_9540D52E669B0713)) {
      if(stance == "prone")
        return 0;

      return 1;
    } else if(dist <= int(950 / _id_9540D52E669B0713)) {
      if(stance == "prone" || stance == "crouch")
        return 0;

      return 1;
    }
  }

  return 0;
}

_id_0C72FF775CD61B11(dvar, value, _id_74EC7A474B47B41C) {
  setDvar(dvar, value);

  if(!isDefined(level._id_94C009BD348D6AA6))
    level._id_94C009BD348D6AA6 = [];

  level._id_94C009BD348D6AA6[dvar] = _id_74EC7A474B47B41C;
}

_id_3A14BBE88E409EDF() {
  return level._id_AD231D0DAAE0BAD9 == 1;
}

_id_138028CA2B958511() {
  if(issubstr(level.mapname, "raid"))
    return 1;

  switch (level.mapname) {
    case "cp_capture_jugg":
    case "cp_jugg_maze":
      return 1;
    default:
      return 0;
  }
}

_id_AAE723485E3B0E9D() {
  return level.mapname == "cp_jugg_maze";
}

_id_BB3E0C926B0667C4(value) {
  foreach(player in level.players)
  player setclientdvar("dvar_C4B5F7005920FC31", value);

  setDvar("dvar_C4B5F7005920FC31", value);
}

_id_3069B525E1C98FAF(_id_901E1E9A8DBED7C9) {
  level._id_54CDEBB25CEEEA16 = _id_901E1E9A8DBED7C9;
}

_id_6721512A3AFF2E3B() {
  return level._id_54CDEBB25CEEEA16;
}

_id_61A3391D3AB5FAF7(func, _id_FF8E35622C1CD1C3) {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(func);
  level waittill(_id_FF8E35622C1CD1C3);
  scripts\cp\utility\spawn_event_aggregator::_id_DE35280460AE9411(func);
}

_id_97196D9C69A91E2B(_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6) {
  return 1;
}

sun_light_fade(_id_277EDE8250943CED, _id_8300EF7E24B53984, _id_E69C0FDE567784B4) {
  if(!isDefined(_id_277EDE8250943CED))
    _id_277EDE8250943CED = getmapsuncolorandintensity();
  else if(isvector(_id_277EDE8250943CED)) {
    _id_AC2355C44EBC2D89 = getmapsuncolorandintensity();
    _id_277EDE8250943CED = [_id_277EDE8250943CED[0], _id_277EDE8250943CED[1], _id_277EDE8250943CED[2], _id_AC2355C44EBC2D89[3]];
  }

  if(isvector(_id_8300EF7E24B53984)) {
    _id_AC2355C44EBC2D89 = getmapsuncolorandintensity();
    _id_8300EF7E24B53984 = [_id_8300EF7E24B53984[0], _id_8300EF7E24B53984[1], _id_8300EF7E24B53984[2], _id_AC2355C44EBC2D89[3]];
  }

  _id_E69C0FDE567784B4 = int(_id_E69C0FDE567784B4 * 20);
  _id_2F977E27FA739602 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_2F977E27FA739602[_id_AC0E594AC96AA3A8] = (_id_277EDE8250943CED[_id_AC0E594AC96AA3A8] - _id_8300EF7E24B53984[_id_AC0E594AC96AA3A8]) / _id_E69C0FDE567784B4;

  _id_80BBCD5EFB3983A3 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E69C0FDE567784B4; _id_AC0E594AC96AA3A8++) {
    wait 0.05;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 4; _id_AC0E5C4AC96AAA41++)
      _id_80BBCD5EFB3983A3[_id_AC0E5C4AC96AAA41] = _id_277EDE8250943CED[_id_AC0E5C4AC96AAA41] - _id_2F977E27FA739602[_id_AC0E5C4AC96AAA41] * _id_AC0E594AC96AA3A8;

    setsuncolorandintensity(_id_80BBCD5EFB3983A3[0], _id_80BBCD5EFB3983A3[1], _id_80BBCD5EFB3983A3[2], _id_80BBCD5EFB3983A3[3]);
  }

  setsuncolorandintensity(_id_8300EF7E24B53984[0], _id_8300EF7E24B53984[1], _id_8300EF7E24B53984[2], _id_8300EF7E24B53984[3]);
}

#using_animtree("script_model");

_id_BD4D8A169D79E52B() {
  level endon("game_ended");
  self endon("disconnect");
  _id_5C3F9357F11D2223 = "ks_remote_device_mp";
  _id_42ED8636FB8C4A12 = self getcurrentweapon();
  weaponobj = makeweapon(_id_5C3F9357F11D2223);
  _id_5F6056D7176B7103 = % vm_ks_tablet_tap_raise;

  if(_id_5C3F9357F11D2223 == "ks_remote_nuke_mp")
    _id_5F6056D7176B7103 = % vm_ks_tablet_tac_nuke_raise;

  _id_2ED8C4E06182FD14 = getanimlength(_id_5F6056D7176B7103) - 1;
  _id_3B64EB40368C1450::set("TabletDeployAnim", "allow_movement", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "allow_jump", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "usability", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "melee", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "supers", 0);
  _id_3B64EB40368C1450::set("TabletDeployAnim", "killstreaks", 0);
  _id_41BF9BF4918115AC = _id_F9E80F1FE925CDC0(weaponobj);

  if(isDefined(self) && isalive(self))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("TabletDeployAnim");

  if(!istrue(_id_41BF9BF4918115AC))
    return 0;

  _id_0EABF81B5BE8DDB5 = scripts\engine\utility::waittill_any_timeout_2(_id_2ED8C4E06182FD14, "death", "weapon_change");
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_42ED8636FB8C4A12);
  self takeweapon(weaponobj);
  return;
}

_id_F9E80F1FE925CDC0(deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(deployweaponobj))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      self notify("switched_from_minigun");

      while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp")
        waitframe();
    }
  }

  _giveweapon(deployweaponobj, 0, 0, 1);
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(deployweaponobj);
  waitframe();

  if(!_id_41BF9BF4918115AC)
    _id_819C14E9DC86B8C8 = undefined;

  if(!isalive(self))
    return 0;

  return _id_41BF9BF4918115AC;
}

_id_4CBAED764C116A25(_id_E3108E412AFB3811) {
  self setclientomnvar("ui_disable_inventory", _id_E3108E412AFB3811);
}

_id_76BA4ACF14679724() {
  level endon("game_ended");

  while(!scripts\engine\utility::flag_exist("scriptables_ready"))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_644C18834356D9DC::remove_munitions_globally();
  level notify("lootHackComplete");
}

_id_F2BEAAEA12D4F510() {
  level endon("game_ended");
  _id_43AA5A35DFE9C585("br_loot_cache_gulag");
  _id_43AA5A35DFE9C585("br_loot_cache");
  _id_43AA5A35DFE9C585("br_loot_cache_lege");
  _id_43AA5A35DFE9C585("br_quest_safe");
  _id_43AA5A35DFE9C585("br_scavenger_quest_cache");
  _id_43AA5A35DFE9C585("brloot_access_card_blue");
  _id_43AA5A35DFE9C585("brloot_access_card_blue_stadium_concourse");
  _id_43AA5A35DFE9C585("brloot_access_card_blue_stadium_executive");
  _id_43AA5A35DFE9C585("brloot_access_card_blue_stadium_parking");
  _id_43AA5A35DFE9C585("brloot_access_card_green");
  _id_43AA5A35DFE9C585("brloot_access_card_red");
  _id_43AA5A35DFE9C585("brloot_activity_starter_combat");
  _id_43AA5A35DFE9C585("brloot_activity_starter_hunt");
  _id_43AA5A35DFE9C585("brloot_activity_starter_recon");
  _id_43AA5A35DFE9C585("brloot_activity_starter_recover");
  _id_43AA5A35DFE9C585("brloot_activity_starter_rescue");
  _id_43AA5A35DFE9C585("brloot_activity_starter_sabotage");
  _id_43AA5A35DFE9C585("brloot_assassination_tablet");
  _id_43AA5A35DFE9C585("brloot_attachment_back");
  _id_43AA5A35DFE9C585("brloot_attachment_front");
  _id_43AA5A35DFE9C585("brloot_attachment_mag");
  _id_43AA5A35DFE9C585("brloot_attachment_muzzle");
  _id_43AA5A35DFE9C585("brloot_attachment_other");
  _id_43AA5A35DFE9C585("brloot_attachment_reargrip");
  _id_43AA5A35DFE9C585("brloot_attachment_scope");
  _id_43AA5A35DFE9C585("brloot_attachment_underbarrel");
  _id_43AA5A35DFE9C585("brloot_backpack");
  _id_43AA5A35DFE9C585("brloot_backpack_large");
  _id_43AA5A35DFE9C585("brloot_backpack_medium");
  _id_43AA5A35DFE9C585("brloot_backpack_player_large");
  _id_43AA5A35DFE9C585("brloot_backpack_player_medium");
  _id_43AA5A35DFE9C585("brloot_backpack_player_small");
  _id_43AA5A35DFE9C585("brloot_balloon_extract");
  _id_43AA5A35DFE9C585("brloot_blueprintextract_tablet");
  _id_43AA5A35DFE9C585("brloot_dead_agent_radio");
  _id_43AA5A35DFE9C585("brloot_demolition_tablet");
  _id_43AA5A35DFE9C585("brloot_dogtag");
  _id_43AA5A35DFE9C585("brloot_domination_tablet");
  _id_43AA5A35DFE9C585("brloot_weaponcase");
  _id_43AA5A35DFE9C585("brloot_equip_gasmask");
  _id_43AA5A35DFE9C585("brloot_equip_gasmask_durable");
  _id_43AA5A35DFE9C585("brloot_equip_iodine_pills");
  _id_43AA5A35DFE9C585("brloot_gascan");
  _id_43AA5A35DFE9C585("brloot_health_adrenaline");
  _id_43AA5A35DFE9C585("brloot_intel_tablet");
  _id_43AA5A35DFE9C585("brloot_killstreak_assaultdrone");
  _id_43AA5A35DFE9C585("brloot_killstreak_auav");
  _id_43AA5A35DFE9C585("brloot_killstreak_chopper_gunner");
  _id_43AA5A35DFE9C585("brloot_killstreak_circle_peek");
  _id_43AA5A35DFE9C585("brloot_killstreak_clusterstrike");
  _id_43AA5A35DFE9C585("brloot_killstreak_gunship");
  _id_43AA5A35DFE9C585("brloot_killstreak_hover_jet");
  _id_43AA5A35DFE9C585("brloot_killstreak_juggernaut");
  _id_43AA5A35DFE9C585("brloot_killstreak_pac_sentry");
  _id_43AA5A35DFE9C585("brloot_killstreak_precision_airstrike");
  _id_43AA5A35DFE9C585("brloot_killstreak_recondrone");
  _id_43AA5A35DFE9C585("brloot_killstreak_scramblerdrone");
  _id_43AA5A35DFE9C585("brloot_killstreak_shieldturret");
  _id_43AA5A35DFE9C585("brloot_killstreak_uav");
  _id_43AA5A35DFE9C585("brloot_nvg");
  _id_43AA5A35DFE9C585("brloot_offhand_advancedsupplydrop");
  _id_43AA5A35DFE9C585("brloot_offhand_advancedvehicledrop");
  _id_43AA5A35DFE9C585("brloot_personal_brokenglasses");
  _id_43AA5A35DFE9C585("brloot_personal_cancermedication");
  _id_43AA5A35DFE9C585("brloot_personal_heartlocket");
  _id_43AA5A35DFE9C585("brloot_personal_oldwatch");
  _id_43AA5A35DFE9C585("brloot_personal_origamihorse");
  _id_43AA5A35DFE9C585("brloot_personal_pictureofacat");
  _id_43AA5A35DFE9C585("brloot_personal_pictureofachild");
  _id_43AA5A35DFE9C585("brloot_personal_pictureofadog");
  _id_43AA5A35DFE9C585("brloot_personal_pictureofaman");
  _id_43AA5A35DFE9C585("brloot_personal_pictureofawoman");
  _id_43AA5A35DFE9C585("brloot_personal_smalldoll");
  _id_43AA5A35DFE9C585("brloot_personal_toyknife");
  _id_43AA5A35DFE9C585("brloot_personal_vialofinsulin");
  _id_43AA5A35DFE9C585("brloot_personal_wornnecklace");
  _id_43AA5A35DFE9C585("brloot_plate_carrier_2");
  _id_43AA5A35DFE9C585("brloot_plate_carrier_3");
  _id_43AA5A35DFE9C585("brloot_plate_pouch");
  _id_43AA5A35DFE9C585("brloot_plunder_extract");
  _id_43AA5A35DFE9C585("brloot_quest_tablet");
  _id_43AA5A35DFE9C585("brloot_rock");
  _id_43AA5A35DFE9C585("brloot_safecracker_tablet");
  _id_43AA5A35DFE9C585("brloot_scavenger_tablet");
  _id_43AA5A35DFE9C585("brloot_self_revive");
  _id_43AA5A35DFE9C585("brloot_specialist_bonus");
  _id_43AA5A35DFE9C585("brloot_super_armorbox");
  _id_43AA5A35DFE9C585("brloot_super_battlerage");
  _id_43AA5A35DFE9C585("brloot_super_deadsilence");
  _id_43AA5A35DFE9C585("brloot_super_emppulse");
  _id_43AA5A35DFE9C585("brloot_super_munitionsbox");
  _id_43AA5A35DFE9C585("brloot_super_stimpistol");
  _id_43AA5A35DFE9C585("brloot_super_stoppingpower");
  _id_43AA5A35DFE9C585("brloot_super_tacticalcamera");
  _id_43AA5A35DFE9C585("brloot_timedrun_tablet");
  _id_43AA5A35DFE9C585("brloot_valuable_comicbook");
  _id_43AA5A35DFE9C585("brloot_valuable_goldbar");
  _id_43AA5A35DFE9C585("brloot_valuable_harddrive");
  _id_43AA5A35DFE9C585("brloot_valuable_laptop");
  _id_43AA5A35DFE9C585("brloot_valuable_liquor");
  _id_43AA5A35DFE9C585("brloot_vip_tablet");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_akilo47_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_akilo47_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_akilo47_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_falpha_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_falpha_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_galima_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_kilo433_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_mcharlie_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_mcharlie_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_mike4_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_mike4_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_mike4_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_scharlie_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_scharlie_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_scharlie_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_sierra552_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_ar_tango21_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_bp_reward_sm_mpapa7_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_ar");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_dm");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_kn");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_la");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_lm");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_me");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_pi");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_sh");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_sm");
  _id_43AA5A35DFE9C585("brloot_weapon_generic_sn");
  _id_43AA5A35DFE9C585("brloot_weapon_la_gromeo_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_la_juliet_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_la_mike32_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_la_rpapa7_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_dblmg_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_kilo121_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_kilo121_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_kilo121_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_mkilo3_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_mkilo3_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_mkilo3_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_lm_mkilo3_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_pi_golf17_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_pi_papa320_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_pi_papa320_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sh_charlie725_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sh_dpapa12_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sh_romeo870_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sh_romeo870_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_sh_romeo870_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_augolf_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_augolf_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_augolf_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_beta_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_beta_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_mpapa5_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_mpapa5_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_mpapa7_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_mpapa7_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_papa90_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_papa90_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_papa90_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_uzulu_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_uzulu_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_uzulu_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_uzulu_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_sm_victor_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_alpha50_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_alpha50_lege");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_delta_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_mike14_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_mike14_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_mike14_rare");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_mike14_unco");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_mromeo_comm");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_sbeta_epic");
  _id_43AA5A35DFE9C585("brloot_weapon_sn_sbeta_lege");
  _id_43AA5A35DFE9C585("brloot_xp_dufflebag");
  _id_43AA5A35DFE9C585("brloot_xp_purse");
  _id_43AA5A35DFE9C585("dmz_boss_supply_drop");
  _id_43AA5A35DFE9C585("dmz_crate_wood");
  _id_43AA5A35DFE9C585("dmz_geiger_counter_cache");
  _id_43AA5A35DFE9C585("dmz_geiger_intel");
  _id_43AA5A35DFE9C585("dmz_hidden_container");
  _id_43AA5A35DFE9C585("dmz_hidden_container_common");
  _id_43AA5A35DFE9C585("dmz_intel_laptop");
  _id_43AA5A35DFE9C585("dmz_safe");
  _id_43AA5A35DFE9C585("dmz_secret_stash");
  _id_43AA5A35DFE9C585("dmz_supply_drop");
  _id_43AA5A35DFE9C585("dmz_supply_drop_samsite");
  _id_43AA5A35DFE9C585("interactable_notebook_base");
  _id_43AA5A35DFE9C585("loot_key_biolab_door");
  _id_43AA5A35DFE9C585("loot_key_firefighttest01");
  _id_43AA5A35DFE9C585("loot_key_fortress");
  _id_43AA5A35DFE9C585("loot_key_fortress_interior");
  _id_43AA5A35DFE9C585("loot_key_gulag");
  _id_43AA5A35DFE9C585("loot_key_spectator_gulag");
  _id_43AA5A35DFE9C585("loot_key_hydro_apt");
  _id_43AA5A35DFE9C585("loot_key_hydro_storage");
  _id_43AA5A35DFE9C585("loot_key_hydro_weapondrop");
  _id_43AA5A35DFE9C585("loot_key_quarry_control");
  _id_43AA5A35DFE9C585("loot_key_quarry_office");
  _id_43AA5A35DFE9C585("loot_key_quarry_storage");
  _id_43AA5A35DFE9C585("loot_key_resort_entrance");
  _id_43AA5A35DFE9C585("loot_key_resort_entrance_shelf");
  _id_43AA5A35DFE9C585("loot_key_trapper_door");
  _id_43AA5A35DFE9C585("loot_multi_key_fortress");
  _id_43AA5A35DFE9C585("brloot_plunder_cash_uncommon_1");
  _id_43AA5A35DFE9C585("brloot_plunder_cash_uncommon_2");
  _id_43AA5A35DFE9C585("brloot_plunder_cash_uncommon_3");
  _id_43AA5A35DFE9C585("loot_key_fortress");
  _id_43AA5A35DFE9C585("loot_key_quarry_storage");
  _id_43AA5A35DFE9C585("loot_key_quarry_office");
  _id_43AA5A35DFE9C585("loot_key_quarry_control");
  _id_43AA5A35DFE9C585("loot_key_hydro_storage");
  _id_43AA5A35DFE9C585("loot_key_hydro_apt");
  _id_43AA5A35DFE9C585("loot_key_hydro_weapondrop");
  _id_43AA5A35DFE9C585("loot_key_trapper_door");
  _id_43AA5A35DFE9C585("loot_key_resort_entrance");
  _id_43AA5A35DFE9C585("loot_multi_key_fortress");
  _id_43AA5A35DFE9C585("brloot_access_card_blue");
  _id_43AA5A35DFE9C585("brloot_access_card_green");
  _id_43AA5A35DFE9C585("brloot_access_card_red");
  _id_43AA5A35DFE9C585("brloot_quest_tablet");
  _id_43AA5A35DFE9C585("brloot_assassination_tablet");
  _id_43AA5A35DFE9C585("brloot_domination_tablet");
  _id_43AA5A35DFE9C585("brloot_scavenger_tablet");
  _id_43AA5A35DFE9C585("brloot_vip_tablet");
  _id_43AA5A35DFE9C585("brloot_timedrun_tablet");
  _id_43AA5A35DFE9C585("brloot_blueprintextract_tablet");
  _id_43AA5A35DFE9C585("brloot_armor_helmet_1");
  _id_43AA5A35DFE9C585("brloot_armor_helmet_2");
  _id_43AA5A35DFE9C585("brloot_armor_helmet_3");
  _id_43AA5A35DFE9C585("brloot_armor_plate");
  _id_43AA5A35DFE9C585("brloot_plate_pouch");
  _id_43AA5A35DFE9C585("brloot_plate_carrier_2");
  _id_43AA5A35DFE9C585("brloot_plate_carrier_3");
  _id_43AA5A35DFE9C585("brloot_super_battlerage");
  _id_43AA5A35DFE9C585("brloot_super_deadsilence");
  _id_43AA5A35DFE9C585("brloot_super_emppulse");
  _id_43AA5A35DFE9C585("brloot_super_munitionsbox");
  _id_43AA5A35DFE9C585("brloot_super_armorbox");
  _id_43AA5A35DFE9C585("brloot_super_stoppingpower");
  _id_43AA5A35DFE9C585("brloot_super_weapondrop");
  _id_43AA5A35DFE9C585("brloot_super_tacticalcamera");
  _id_43AA5A35DFE9C585("brloot_super_tacinsert");
  _id_43AA5A35DFE9C585("brloot_super_stimpistol");
  _id_43AA5A35DFE9C585("brloot_offhand_advancedsupplydrop");
  _id_43AA5A35DFE9C585("brloot_offhand_advancedvehicledrop");
  _id_43AA5A35DFE9C585("brloot_offhand_heartbeatsensor");
  _id_43AA5A35DFE9C585("brloot_offhand_trophysystem");
  _id_43AA5A35DFE9C585("brloot_offhand_geigercounter");
  _id_43AA5A35DFE9C585("brloot_offhand_shockstick");
  _id_43AA5A35DFE9C585("brloot_offhand_deployed_decoy");
  _id_43AA5A35DFE9C585("brloot_offhand_taccover");
  _id_43AA5A35DFE9C585("brloot_offhand_trophysystem");
}

_id_43AA5A35DFE9C585(_id_A1093166DE09E6B8) {
  if(isDefined(level._id_C511DF4AAA679C10) && scripts\engine\utility::array_contains(level._id_C511DF4AAA679C10, _id_A1093166DE09E6B8)) {
    return;
  }
  loot = getlootscriptablearray(_id_A1093166DE09E6B8);

  foreach(item in loot) {
    if(item getscriptableparthasstate(item.type, "hidden"))
      item setscriptablepartstate(item.type, "hidden", 1);
  }
}

removepatchablecollision_delayed() {
  wait 10;
  _id_5C2C9D034EBE9DCD = [];
  _id_5C2C9D034EBE9DCD[1] = "tactical_ladder_col";
  _id_5C2C9D034EBE9DCD[2] = "clip8x8x256";
  _id_5C2C9D034EBE9DCD[3] = "player8x8x256";
  _id_5C2C9D034EBE9DCD[4] = "ladderMetal264";
  _id_5C2C9D034EBE9DCD[5] = "ladderWood192";
  _id_5C2C9D034EBE9DCD[6] = "ladderMetal192";
  _id_5C2C9D034EBE9DCD[7] = "mount128";
  _id_5C2C9D034EBE9DCD[8] = "mount64";
  _id_5C2C9D034EBE9DCD[9] = "mount32";
  _id_5C2C9D034EBE9DCD[10] = "mount256";
  _id_5C2C9D034EBE9DCD[11] = "ladderWood264";
  _id_5C2C9D034EBE9DCD[12] = "nosight256x256x8";
  _id_5C2C9D034EBE9DCD[13] = "nosight128x128x8";
  _id_5C2C9D034EBE9DCD[14] = "mountCorner128";
  _id_5C2C9D034EBE9DCD[15] = "mantle256";
  _id_5C2C9D034EBE9DCD[16] = "mantle128";
  _id_5C2C9D034EBE9DCD[17] = "mantle64";
  _id_5C2C9D034EBE9DCD[18] = "mantle32";
  _id_5C2C9D034EBE9DCD[19] = "stairsHalfFlight128";
  _id_5C2C9D034EBE9DCD[20] = "stairsFullFlight128";

  foreach(name in _id_5C2C9D034EBE9DCD)
  scripts\cp_mp\utility\game_utility::removematchingents_bykey(name, "targetname");
}

_id_C772AC7ADC6A4637(_id_9F279646ED66AB76, struct) {
  if(!isDefined(level.cs_object_container))
    level.cs_object_container = [];

  if(isDefined(_id_9F279646ED66AB76) && !isDefined(level.cs_object_container[_id_9F279646ED66AB76]))
    level.cs_object_container[_id_9F279646ED66AB76] = self;
}

_id_363A8CF87098E10A() {
  level._id_DDDFAEFA2E3FF7BC = [];
}

_id_119B3F1336549DDB(identifier, entity) {
  if(!isDefined(level._id_DDDFAEFA2E3FF7BC[identifier]))
    level._id_DDDFAEFA2E3FF7BC[identifier] = [];

  level._id_DDDFAEFA2E3FF7BC[identifier] = scripts\engine\utility::array_add(level._id_DDDFAEFA2E3FF7BC[identifier], entity);
}

_id_E930E06230376B96(identifier, entity) {
  if(!isDefined(level._id_DDDFAEFA2E3FF7BC[identifier]))
    level._id_DDDFAEFA2E3FF7BC[identifier] = [];

  level._id_DDDFAEFA2E3FF7BC[identifier] = scripts\engine\utility::array_remove(level._id_DDDFAEFA2E3FF7BC[identifier], entity);
}

_id_9EE08F0499763465(identifier) {
  if(!isDefined(level._id_DDDFAEFA2E3FF7BC[identifier]))
    level._id_DDDFAEFA2E3FF7BC[identifier] = [];

  level._id_DDDFAEFA2E3FF7BC[identifier] = scripts\engine\utility::array_removeundefined(level._id_DDDFAEFA2E3FF7BC[identifier]);

  foreach(index, entity in level._id_DDDFAEFA2E3FF7BC[identifier]) {
    if(isstruct(entity))
      scripts\engine\utility::deletestruct_ref(entity);

    if(isent(entity))
      entity delete();
  }

  level._id_DDDFAEFA2E3FF7BC[identifier] = scripts\engine\utility::array_removeundefined(level._id_DDDFAEFA2E3FF7BC[identifier]);
}

_id_7B28CE88F4CA7A43() {
  if(getdvarint("dvar_03A25F2D5A820AD8", 0))
    return 1;

  return 0;
}

_id_2597E428C03B341C() {
  if(getdvarint("online_is_devmapping") || getdvarint("dvar_2C5FD9A021A736EF"))
    return 1;

  return 0;
}
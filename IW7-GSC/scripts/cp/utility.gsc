/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\utility.gsc
*********************************************/

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(issubstr(var_0, "+akimbo") || issubstr(var_0, "+g18pap2") || isDefined(var_2) && var_2 == 1) {
    self giveweapon(var_0, var_1, 1, -1, var_3);
  } else {
    self giveweapon(var_0, var_1, 0, -1, var_3);
  }

  thread updatelaststandpistol(var_0);
  return var_0;
}

updatelaststandpistol(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.last_stand_weapons)) {
      var_1 = getweaponbasename(var_0);
      if(scripts\engine\utility::array_contains(level.last_stand_weapons, var_1)) {
        self.last_stand_pistol = var_0;
        return;
      }
    }
  }

  var_2 = self getweaponslistall();
  var_3 = getweaponbasename(self.last_stand_pistol);
  var_4 = 0;
  foreach(var_6 in var_2) {
    var_7 = getweaponbasename(var_6);
    if(var_7 == var_3) {
      var_4 = 1;
      return;
    }
  }

  if(!var_4) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(var_6 in var_2) {
        var_7 = getweaponbasename(var_6);
        for(var_0A = level.last_stand_weapons.size - 1; var_0A > -1; var_0A--) {
          if(var_7 == level.last_stand_weapons[var_0A]) {
            var_4 = 1;
            self.last_stand_pistol = var_6;
            return;
          }
        }
      }
    }

    var_0C = getrawbaseweaponname(self.default_starting_pistol);
    if(isDefined(self.weapon_build_models[var_0C])) {
      self.last_stand_pistol = self.weapon_build_models[var_0C];
      return;
    }

    self.last_stand_pistol = self.default_starting_pistol;
  }
}

giveperk(var_0) {
  if(issubstr(var_0, "specialty_weapon_")) {
    _setperk(var_0);
    return;
  }

  _setperk(var_0);
  _setextraperks(var_0);
}

_hasperk(var_0) {
  var_1 = self.perks;
  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_1[var_0])) {
    return 1;
  }

  return 0;
}

_setperk(var_0) {
  self.perks[var_0] = 1;
  self.perksperkname[var_0] = var_0;
  var_1 = level.perksetfuncs[var_0];
  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_unsetperk(var_0) {
  self.perks[var_0] = undefined;
  self.perksperkname[var_0] = undefined;
  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_setextraperks(var_0) {
  if(var_0 == "specialty_stun_resistance") {
    giveperk("specialty_empimmune");
  }

  if(var_0 == "specialty_hardline") {
    giveperk("specialty_assists");
  }

  if(var_0 == "specialty_incog") {
    giveperk("specialty_spygame");
    giveperk("specialty_coldblooded");
    giveperk("specialty_noscopeoutline");
    giveperk("specialty_heartbreaker");
  }

  if(var_0 == "specialty_blindeye") {
    giveperk("specialty_noplayertarget");
  }

  if(var_0 == "specialty_sharp_focus") {
    giveperk("specialty_reducedsway");
  }

  if(var_0 == "specialty_quickswap") {
    giveperk("specialty_fastoffhand");
  }
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }
  }

  self.perks = [];
  self.perksperkname = [];
  self getplayerlookattarget();
}

clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(var_0 = 0; var_0 < self.lowermessages.size; var_0++) {
      self.lowermessages[var_0] = undefined;
    }
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }

  updatelowermessage();
}

setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  if(!isDefined(var_9)) {
    var_9 = 1;
  }

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  updatelowermessage();
}

play_bink_video(var_0, var_1, var_2) {
  level thread play_bink_video_internal(var_0, var_1, var_2);
}

play_bink_video_internal(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 freezecontrolswrapper(1);
  }

  setomnvar("bink_video_active", 1);
  playcinematicforall(var_0);
  wait(var_1);
  setomnvar("bink_video_active", 0);
  foreach(var_4 in level.players) {
    var_4 freezecontrolswrapper(0);
    if(!isDefined(var_2) || !var_2) {
      var_4 thread player_black_screen(0, 1, 0.5, 1);
    }
  }
}

updatelowermessage() {
  self endon("disconnect");
  if(!isDefined(self)) {
    return;
  }

  var_0 = getlowermessage();
  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage settext("");
      if(isDefined(self.lowertimer)) {
        self.lowertimer.alpha = 0;
      }
    }

    return;
  }

  self.lowermessage settext(var_0.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
  self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;
  if(var_0.shouldfade) {
    self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
    self.lowermessage.alpha = var_0.fadetoalphatime;
  }

  if(var_0.time > 0 && var_0.showtimer) {
    self.lowertimer settimer(max(var_0.time - gettime() - var_0.addtime / 1000, 0.1));
    return;
  }

  if(var_0.time > 0 && !var_0.showtimer) {
    self.lowertimer settext("");
    self.lowermessage fadeovertime(min(var_0.time, 60));
    self.lowermessage.alpha = 0;
    thread clearondeath(var_0);
    thread clearafterfade(var_0);
    return;
  }

  self.lowertimer settext("");
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = undefined;
  foreach(var_0C in self.lowermessages) {
    if(var_0C.name == var_0) {
      if(var_0C.text == var_1 && var_0C.priority == var_3) {
        return;
      }

      var_0A = var_0C;
      break;
    }
  }

  if(!isDefined(var_0A)) {
    var_0A = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_0A;
  }

  var_0A.name = var_0;
  var_0A.text = var_1;
  var_0A.time = var_2;
  var_0A.addtime = gettime();
  var_0A.priority = var_3;
  var_0A.showtimer = var_4;
  var_0A.shouldfade = var_5;
  var_0A.fadetoalphatime = var_6;
  var_0A.fadetoalphatime = var_7;
  var_0A.hidewhenindemo = var_8;
  var_0A.hidewheninmenu = var_9;
  sortlowermessages();
}

sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;
    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--) {
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];
    }

    self.lowermessages[var_3 + 1] = var_1;
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages)) {
    return undefined;
  }

  return self.lowermessages[0];
}

clearondeath(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

clearafterfade(var_0) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }

      var_2 = self.lowermessages[var_1 - 1];
      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3])) {
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

freezecontrolswrapper(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self.controlsfrozen = var_0;
}

setthirdpersondof(var_0) {
  if(var_0) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
    return;
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var_0;
  if(scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(0);
  }

  self notify("using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

updatesessionstate(var_0, var_1) {
  self.sessionstate = var_0;
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self.getgrenadefusetime = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();
  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

gameflag(var_0) {
  return game["flags"][var_0];
}

gameflagwait(var_0) {
  while(!gameflag(var_0)) {
    level waittill(var_0);
  }
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
  }
}

initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }

  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  }

  if(!isDefined(level.var_13E0F)) {
    level.var_13E0F = getdvar("xenonGame") == "true";
  }

  if(!isDefined(level.var_DADB)) {
    level.var_DADB = getdvar("ps3Game") == "true";
  }

  if(!isDefined(level.var_13E0E)) {
    level.var_13E0E = getdvar("xb3Game") == "true";
  }

  if(!isDefined(level.var_DADC)) {
    level.var_DADC = getdvar("ps4Game") == "true";
  }
}

isenemy(var_0) {
  if(level.teambased) {
    return isplayeronenemyteam(var_0);
  }

  return isplayerffaenemy(var_0);
}

isplayeronenemyteam(var_0) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_0) {
  if(isDefined(var_0.triggerportableradarping)) {
    return var_0.triggerportableradarping != self;
  }

  return var_0 != self;
}

notusableforjoiningplayers(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");
  for(;;) {
    level waittill("player_spawned", var_1);
    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
  }
}

setselfusable(var_0) {
  self makeusable();
  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

isenvironmentweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "turret_minigun_mp") {
    return 1;
  }

  return 0;
}

issuperweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(level.superweapons) && isDefined(level.superweapons[var_0])) {
    return 1;
  }

  return 0;
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

playteamfxforclient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  if(self.team != var_0) {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_3), var_1, self);
  } else {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_2), var_1, self);
  }

  if(isDefined(var_6)) {
    triggerfx(var_6);
  }

  var_6 thread delayentdelete(var_4);
  if(isDefined(var_5) && var_5) {
    var_6 thread deleteonplayerdeathdisconnect(self);
  }

  return var_6;
}

delayentdelete(var_0) {
  self endon("death");
  wait(var_0);
  if(isDefined(self)) {
    self delete();
  }
}

deleteonplayerdeathdisconnect(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self delete();
}

isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdeath)) {
    return 1;
  }

  return 0;
}

getbaseweaponname(var_0) {
  var_1 = strtok(var_0, "_");
  if(var_1[0] == "iw5" || var_1[0] == "iw6" || var_1[0] == "iw7") {
    var_0 = var_1[0] + "_" + var_1[1];
  } else if(var_1[0] == "alt") {
    var_0 = var_1[1] + "_" + var_1[2];
  }

  return var_0;
}

getzbaseweaponname(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[0] + "_z" + var_2[1] + var_1;
    } else {
      var_0 = var_2[0] + "_z" + var_2[1];
    }
  } else if(var_2[0] == "alt") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[1] + "_z" + var_2[2] + var_1;
    } else {
      var_0 = var_2[1] + "_z" + var_2[2];
    }
  }

  return var_0;
}

get_closest_entrance(var_0) {
  var_1 = sortbydistance(level.window_entrances, var_0);
  foreach(var_3 in var_1) {
    if(var_3.enabled) {
      return var_3;
    }
  }

  return undefined;
}

entrance_is_fully_repaired(var_0) {
  if(!isDefined(var_0.barrier)) {
    return 1;
  }

  var_1 = scripts\cp\zombies\zombie_entrances::func_7B13(var_0);
  if(!isDefined(var_1)) {
    return 1;
  }

  return 0;
}

is_weapon_purchase_disabled() {
  return scripts\engine\utility::istrue(level.weapon_purchase_disabled);
}

get_attachment_from_interaction(var_0) {
  var_1 = var_0.randomintrange.model;
  var_2 = "arkblue";
  var_3 = "stun_ammo";
  switch (var_1) {
    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_2 = "arcane_base";
      break;

    default:
      break;
  }

  return var_2;
}

are_any_consumables_active() {
  foreach(var_1 in self.consumables) {
    if(var_1.on == 1) {
      return 1;
    }
  }

  return 0;
}

getrawbaseweaponname(var_0) {
  var_1 = strtok(var_0, "_");
  if(var_1[0] == "iw5" || var_1[0] == "iw6" || var_1[0] == "iw7") {
    var_0 = var_1[1];
  } else if(var_1[0] == "alt") {
    var_0 = var_1[2];
  }

  return var_0;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

leaderdialogonplayer(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = self.pers["team"];
  if(isDefined(var_4) && var_4 == "axis" || var_4 == "allies") {
    var_5 = game["voice"][var_4] + game["dialog"][var_0];
    self func_8252(var_5, var_0, 2, var_1, var_2, var_3);
  }
}

_setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0].randomintrange = var_2;
  self setactionslot(var_0, var_1, var_2);
}

getkillstreakweapon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_0, level.global_tables["killstreakTable"].weapon_col);
}

_objective_delete(var_0) {
  objective_delete(var_0);
  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_0;
    return;
  }

  level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_0;
}

touchingbadtrigger(var_0) {
  var_1 = getEntArray("trigger_hurt", "classname");
  foreach(var_3 in var_1) {
    if(self istouching(var_3) && level.mapname != "mp_mine" || var_3.var_F5 > 0) {
      return 1;
    }
  }

  var_5 = getEntArray("radiation", "targetname");
  foreach(var_3 in var_5) {
    if(self istouching(var_3)) {
      return 1;
    }
  }

  if(isDefined(var_0) && var_0 == "gryphon") {
    var_8 = getEntArray("gryphonDeath", "targetname");
    foreach(var_3 in var_8) {
      if(self istouching(var_3)) {
        return 1;
      }
    }
  }

  return 0;
}

playsoundinspace(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      var_0 = scripts\engine\utility::random(var_0);
    }

    var_3 = lookupsoundlength(var_0);
    playsoundatpos(var_1, var_0);
    if(isDefined(var_2)) {
      wait(var_3 / 1000);
    }

    return var_3;
  }
}

play_random_sound_in_space(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(!isarray(var_0)) {
      var_3 = [];
      var_3[0] = var_0;
      var_0 = var_3[0];
    }

    var_4 = scripts\engine\utility::random(var_0);
    var_5 = lookupsoundlength(var_4);
    playsoundatpos(var_1, var_4);
    if(isDefined(var_2)) {
      wait(var_5);
    }

    return var_5;
  }
}

play_looping_sound_on_ent(var_0) {
  if(soundexists(var_0)) {
    self playLoopSound(var_0);
  }
}

stop_looping_sound_on_ent(var_0) {
  if(soundexists(var_0)) {
    self stoploopsound(var_0);
  }
}

playdeathsound() {
  var_0 = randomintrange(1, 8);
  var_1 = "generic";
  if(self getstruct_delete()) {
    var_1 = "female";
  }

  if(self.team == "axis") {
    var_2 = var_1 + "_death_russian_" + var_0;
    if(soundexists(var_2)) {
      self playSound(var_2);
      return;
    }

    return;
  }

  var_2 = var_2 + "_death_american_" + var_1;
  if(soundexists(var_2)) {
    self playSound(var_2);
  }
}

isfmjdamage(var_0, var_1, var_2) {
  return isDefined(var_2) && var_2 _hasperk("specialty_bulletpenetration") && isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1);
}

ischangingweapon() {
  return isDefined(self.changingweapon);
}

getattachmenttype(var_0) {
  if(!isDefined(var_0)) {
    return "none";
  }

  var_1 = tablelookup("mp\attachmentTable.csv", 4, var_0, 2);
  if(!isDefined(var_1) || isDefined(var_1) && var_1 == "") {
    var_2 = getdvar("g_gametype");
    if(var_2 == "zombie") {
      var_1 = tablelookup("cp\zombies\zombie_attachmentTable.csv", 4, var_0, 2);
    }
  }

  return var_1;
}

weaponhasattachment(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "") {
    return 0;
  }

  var_2 = getweaponattachmentsbasenames(var_0);
  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

getweaponattachmentsbasenames(var_0) {
  var_1 = getweaponattachments(var_0);
  foreach(var_4, var_3 in var_1) {
    var_1[var_4] = attachmentmap_tobase(var_3);
  }

  return var_1;
}

attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0])) {
    var_0 = level.attachmentmap_uniquetobase[var_0];
  }

  return var_0;
}

bot_is_fireteam_mode() {
  var_0 = botautoconnectenabled() == 2;
  if(var_0) {
    if(!level.teambased || level.gametype != "war" && level.gametype != "dom") {
      return 0;
    }

    return 1;
  }

  return 0;
}

isjuggernaut() {
  if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautdef) && self.isjuggernautdef == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautgl) && self.isjuggernautgl == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1) {
    return 1;
  }

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1) {
    return 1;
  }

  return 0;
}

attachmentmap_tounique(var_0, var_1) {
  var_2 = getweaponrootname(var_1);
  if(var_2 != var_1) {
    var_3 = getweaponbasename(var_1);
    var_4 = strtok(var_3, "_");
    var_5 = "mp" + getsubstr(var_4[2], 2, var_4[2].size);
    var_6 = var_4[0];
    for(var_7 = 1; var_7 < var_4.size; var_7++) {
      if(var_7 == 2) {
        var_6 = var_6 + "_" + var_5;
        continue;
      }

      var_6 = var_6 + "_" + var_4[var_7];
    }

    if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_3][level.attachmentmap_uniquetobase[var_0]])) {
      var_8 = level.attachmentmap_uniquetobase[var_0];
      return level.attachmentmap_basetounique[var_3][var_8];
    } else if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_uniquetobase[var_1]) && isDefined(level.attachmentmap_basetounique[var_7][level.attachmentmap_uniquetobase[var_1]])) {
      var_8 = level.attachmentmap_uniquetobase[var_1];
      return level.attachmentmap_basetounique[var_6][var_8];
    } else if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_1])) {
      return level.attachmentmap_basetounique[var_4][var_1];
    } else if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_1])) {
      return level.attachmentmap_basetounique[var_7][var_1];
    } else if(var_5.size > 3) {
      var_9 = var_5[0] + "_" + var_5[1] + "_" + var_5[2];
      if(isDefined(level.attachmentmap_basetounique[var_9]) && isDefined(level.attachmentmap_basetounique[var_9][var_1])) {
        return level.attachmentmap_basetounique[var_9][var_1];
      } else {
        var_0A = strtok(var_7, "_");
        var_0B = var_0A[0] + "_" + var_0A[1] + "_" + var_0A[2];
        if(isDefined(level.attachmentmap_basetounique[var_0B]) && isDefined(level.attachmentmap_basetounique[var_0B][var_1])) {
          return level.attachmentmap_basetounique[var_0B][var_1];
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_basetounique[var_3][var_1])) {
    return level.attachmentmap_basetounique[var_3][var_1];
  } else {
    var_0C = weapongroupmap(var_3);
    if(isDefined(var_0C) && isDefined(level.attachmentmap_basetounique[var_0C]) && isDefined(level.attachmentmap_basetounique[var_0C][var_1])) {
      return level.attachmentmap_basetounique[var_0C][var_1];
    }
  }

  return var_1;
}

weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group)) {
    return level.weaponmapdata[var_0].group;
  }

  return undefined;
}

iskillstreakweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(scripts\engine\utility::isdestructibleweapon(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "killstreak")) {
    return 1;
  }

  if(issubstr(var_0, "remote_tank_projectile")) {
    return 1;
  }

  if(issubstr(var_0, "minijackal_")) {
    return 1;
  }

  if(isDefined(level.killstreakweildweapons) && isDefined(level.killstreakweildweapons[var_0])) {
    return 1;
  }

  if(scripts\engine\utility::isairdropmarker(var_0)) {
    return 1;
  }

  var_1 = weaponinventorytype(var_0);
  if(isDefined(var_1) && var_1 == "exclusive") {
    return 1;
  }

  return 0;
}

clearusingremote() {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  if(!scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }

  var_0 = self getcurrentweapon();
  if(var_0 == "none" || iskillstreakweapon(var_0)) {
    var_1 = scripts\engine\utility::getlastweapon();
    if(isreallyalive(self)) {
      if(!self hasweapon(var_1)) {
        var_1 = getfirstprimaryweapon();
      }

      self switchtoweapon(var_1);
    }
  }

  freezecontrolswrapper(0);
  self notify("stopped_using_remote");
}

getfirstprimaryweapon() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);
  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");
    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      var_8 thread reset_visionset_on_team_change(self, var_1 + var_2);
      var_8 thread reset_visionset_on_disconnect(self);
      if(var_8 isinkillcam()) {
        var_8 thread reset_visionset_on_spawn();
      }
    }
  }
}

get_players_watching(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];
  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }

    var_6 = 0;
    if(!var_1) {
      if(var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();
        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5.missile_createrepulsorent == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.setclientmatchdatadef == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

reset_visionset_on_team_change(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;
  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    wait(0.05);
  }
}

reset_visionset_on_disconnect(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");
  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0);
    return;
  }

  self visionsetnakedforplayer("", 0);
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0);
    return;
  }

  self visionsetnakedforplayer("", 0);
}

isinkillcam() {
  return self.clearstartpointtransients;
}

func_F6DB(var_0, var_1, var_2) {
  if(!isDefined(level.console) || !isDefined(level.var_13E0E) || !isDefined(level.var_DADC)) {
    func_F305();
  }

  if(func_9BEE()) {
    setdvar(var_0, var_2);
    return;
  }

  setdvar(var_0, var_1);
}

func_9BEE() {
  if(level.var_13E0E || level.var_DADC || !level.console) {
    return 1;
  }

  return 0;
}

createfontstring(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !var_2) {
    var_3 = newclienthudelem(self);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }

  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = var_0;
  self.parent addchild(self);
  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("TOPLEFT");
}

removechild(var_0) {
  var_0.parent = undefined;
  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  var_0 = [];
  foreach(var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = getparent();
  if(var_4) {
    self moveovertime(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self.xoffset = var_2;
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";
  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";
  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }

  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }

  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }

  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_8 == "center" || var_7.alignx == "center") {
    var_8 = int(var_7.width / 2);
    if(var_7 == "left_adjustable" || var_6.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_7.width;
    if(var_7 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;
  if(strip_suffix(var_7, "_adjustable") == var_5.aligny) {
    var_0A = 0;
    var_0B = 0;
  } else if(var_9 == "middle" || var_7.aligny == "middle") {
    var_0A = int(var_7.height / 2);
    if(var_8 == "top_adjustable" || var_6.aligny == "bottom") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  } else {
    var_0A = var_7.height;
    if(var_8 == "top_adjustable") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  }

  self.y = var_5.y + var_0A * var_0B;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;
  switch (self.elemtype) {
    case "bar":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  updatechildren();
}

getparent() {
  return self.parent;
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;
  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }

  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }

  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);
  if(!var_2) {
    var_2 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);
  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime(1 - var_0 / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / -1 * var_1, 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

createicon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_4 = newclienthudelem(self);
  } else {
    var_4 = newhudelem();
  }

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_1;
  var_4.height = var_2;
  var_4.basewidth = var_4.width;
  var_4.baseheight = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_4 setparent(level.uiparent);
  var_4.hidden = 0;
  if(isDefined(var_0)) {
    var_4 setshader(var_0, var_1, var_2);
    var_4.shader = var_0;
  }

  return var_4;
}

destroyelem() {
  var_0 = [];
  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

showelem() {
  if(!self.hidden) {
    return;
  }

  self.hidden = 0;
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self.bar.hidden = 0;
    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
      return;
    }

    return;
  }

  if(self.alpha != 1) {
    self.alpha = 1;
  }
}

hideelem() {
  if(self.hidden) {
    return;
  }

  self.hidden = 1;
  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;
    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

createprimaryprogressbartext(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 = var_1 + 20;
  }

  var_4 = level.primaryprogressbarfontsize;
  var_5 = "default";
  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = createfontstring(var_5, var_4);
  var_6 setpoint("CENTER", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_6.sort = -1;
  return var_6;
}

createprimaryprogressbar(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 = var_1 + 20;
  }

  if(!isDefined(var_2)) {
    var_2 = level.primaryprogressbarwidth;
  }

  if(!isDefined(var_3)) {
    var_3 = level.primaryprogressbarheight;
  }

  var_4 = createbar((1, 1, 1), var_2, var_3);
  var_4 setpoint("CENTER", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_4;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;
  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
  }

  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

isgameparticipant(var_0) {
  if(isaigameparticipant(var_0)) {
    return 1;
  }

  if(isplayer(var_0)) {
    return 1;
  }

  return 0;
}

isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

setteamheadicon(var_0, var_1) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_2 = game["entity_headicon_" + var_0];
  self.entityheadiconteam = var_0;
  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");
  if(var_0 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_3 = newteamhudelem(var_0);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_3.alpha = 0.8;
  var_3 setshader(var_2, 10, 10);
  var_3 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_3;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(var_0, var_1) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");
  if(!isDefined(var_0)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_2 = var_0.team;
  self.entityheadiconteam = var_2;
  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var_3 = game["entity_headicon_" + var_2];
  var_4 = newclienthudelem(var_0);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_4 setshader(var_3, 10, 10);
  var_4 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_4;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

keepiconpositioned() {
  self.entityheadicon linkwaypointtotargetwithoffset(self, self.entityheadiconoffset);
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");
  if(!isDefined(self.entityheadicon)) {
    return;
  }

  self.entityheadicon destroy();
}

setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(isgameparticipant(var_0) && !isplayer(var_0)) {
    return;
  }

  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.05;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!isDefined(var_0A)) {
    var_0A = 1;
  }

  if(!isplayer(var_0) && var_0 == "none") {
    foreach(var_0D, var_0C in self.entityheadicons) {
      if(isDefined(var_0C)) {
        var_0C destroy();
      }

      self.entityheadicons[var_0D] = undefined;
    }

    return;
  }

  if(isplayer(var_3)) {
    if(isDefined(self.entityheadicons[var_3.guid])) {
      self.entityheadicons[var_3.guid] destroy();
      self.entityheadicons[var_3.guid] = undefined;
    }

    if(var_4 == "") {
      return;
    }

    if(isDefined(var_3.team)) {
      if(isDefined(self.entityheadicons[var_3.team])) {
        self.entityheadicons[var_3.team] destroy();
        self.entityheadicons[var_3.team] = undefined;
      }
    }

    var_0C = newclienthudelem(var_3);
    self.entityheadicons[var_2.guid] = var_0D;
  } else {
    if(isDefined(self.entityheadicons[var_3])) {
      self.entityheadicons[var_3] destroy();
      self.entityheadicons[var_3] = undefined;
    }

    if(var_4 == "") {
      return;
    }

    foreach(var_0E in self.entityheadicons) {
      if(var_10 == "axis" || var_10 == "allies") {
        continue;
      }

      var_0F = getplayerforguid(var_10);
      if(var_0F.team == var_1) {
        self.entityheadicons[var_10] destroy();
        self.entityheadicons[var_10] = undefined;
      }
    }

    var_0C = newteamhudelem(var_1);
    self.entityheadicons[var_1] = var_0C;
  }

  if(!isDefined(var_4) || !isDefined(var_5)) {
    var_4 = 10;
    var_5 = 10;
  }

  var_0C.archived = var_6;
  var_0C.x = self.origin[0] + var_3[0];
  var_0C.y = self.origin[1] + var_3[1];
  var_0C.var_3A6 = self.origin[2] + var_3[2];
  var_0C.alpha = 0.85;
  var_0C setshader(var_2, var_4, var_5);
  var_0C setwaypoint(var_8, var_9, var_0A, var_0B);
  var_0C thread keeppositioned(self, var_3, var_7);
  thread destroyiconsondeath();
  if(isplayer(var_1)) {
    var_0C thread destroyonownerdisconnect(var_1);
  }

  if(isplayer(self)) {
    var_0C thread destroyonownerdisconnect(self);
  }

  return var_0C;
}

showheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0.85;
    }
  }
}

hideheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0;
    }
  }
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

keeppositioned(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = isDefined(var_0.classname) && !isownercarepakage(var_0);
  if(var_3) {
    self linkwaypointtotargetwithoffset(var_0, var_1);
  }

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!var_3) {
      var_4 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.var_3A6 = var_4[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

isownercarepakage(var_0) {
  return isDefined(var_0.var_336) && var_0.var_336 == "care_package";
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  if(!isDefined(self.entityheadicons)) {
    return;
  }

  foreach(var_1 in self.entityheadicons) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 destroy();
  }
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self destroy();
}

_suicide() {
  if(!isusingremote() && !isDefined(self.fauxdeath)) {
    self suicide();
  }
}

player_lua_progressbar(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5);
  return var_6;
}

lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = var_1;
  var_0 thread create_lua_progress_bar(self, var_3);
  var_0.hasprogressbar = 1;
  var_6 = lua_progress_bar_think_loop(var_0, self, var_2, var_4, var_5);
  if(isalive(var_0)) {
    var_0.hasprogressbar = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var_6;
}

create_lua_progress_bar(var_0, var_1) {
  self endon("disconnect");
  self setclientomnvar("ui_securing", var_1);
  var_2 = -1;
  while(isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }
    }

    var_2 = var_0.userate;
    self setclientomnvar("ui_securing_progress", var_0.curprogress / var_0.usetime);
    wait(0.05);
  }

  wait(0.5);
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_securing", 0);
}

lua_progress_bar_think_loop(var_0, var_1, var_2, var_3, var_4) {
  while(!level.gameended && isDefined(self) && isreallyalive(var_0) && var_0 usebuttonpressed() || isDefined(var_3) || var_0 attackbuttonpressed() && isDefined(var_4) && should_continue_progress_bar_think(var_0)) {
    wait(0.05);
    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2) {
        return 0;
      }
    }

    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;
    if(self.curprogress >= self.usetime) {
      var_0 setclientomnvar("ui_securing_progress", 1);
      return isreallyalive(var_0);
    }
  }

  return 0;
}

should_continue_progress_bar_think(var_0) {
  if(isDefined(level.should_continue_progress_bar_think)) {
    return [[level.should_continue_progress_bar_think]](var_0);
  }

  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 1;
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

isplayingsolo() {
  if(getmaxclients() == 1) {
    return 1;
  }

  return 0;
}

removefromparticipantsarray() {
  var_0 = 0;
  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      var_0 = 1;
      while(var_1 < level.participants.size - 1) {
        level.participants[var_1] = level.participants[var_1 + 1];
        var_1++;
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

removefromcharactersarray() {
  var_0 = 0;
  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      var_0 = 1;
      while(var_1 < level.characters.size - 1) {
        level.characters[var_1] = level.characters[var_1 + 1];
        var_1++;
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

removefromspawnedgrouparray() {
  if(isDefined(self.group_name)) {
    if(isDefined(level.spawned_group) && isDefined(level.spawned_group[self.group_name])) {
      level.spawned_group[self.group_name] = scripts\engine\utility::array_remove(level.spawned_group[self.group_name], self);
    }
  }
}

createtimer(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

_detachall() {
  self detachall();
}

is_valid_perk(var_0) {
  var_1 = getarraykeys(level.alien_perks["perk_0"]);
  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  var_2 = getarraykeys(level.alien_perks["perk_1"]);
  if(scripts\engine\utility::array_contains(var_2, var_0)) {
    return 1;
  }

  var_3 = getarraykeys(level.alien_perks["perk_2"]);
  return scripts\engine\utility::array_contains(var_3, var_0);
}

is_consumable_active(var_0) {
  if(isDefined(level.consumable_active_override)) {
    return [[level.consumable_active_override]](var_0);
  }

  if(isDefined(self.consumables) && isDefined(self.consumables[var_0]) && isDefined(self.consumables[var_0].on) && self.consumables[var_0].on == 1) {
    return 1;
  }

  return 0;
}

notify_used_consumable(var_0) {
  self notify(self.consumables[var_0].usednotify);
}

notify_timeup_consumable(var_0) {
  self notify(level.consumables[var_0].timeupnotify);
}

drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait(0.05);
  }
}

is_upgrade_enabled(var_0) {
  if(!is_using_extinction_tokens()) {
    return 0;
  }

  if(self getplayerdata("cp", "upgrades_enabled_flags", var_0)) {
    return 1;
  }

  return 0;
}

allow_player_teleport(var_0, var_1) {
  if(var_0) {
    if(!isDefined(self.teleportdisableflags) && isDefined(var_1)) {
      foreach(var_3 in self.teleportdisableflags) {
        if(var_3 == var_1) {
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, var_1);
        }
      }
    }

    self.disabledteleportation--;
    if(!self.disabledteleportation) {
      self.teleportdisableflags = [];
      self.can_teleport = 1;
      self notify("can_teleport");
      return;
    }

    return;
  }

  if(!isDefined(self.teleportdisableflags)) {
    self.teleportdisableflags = [];
  }

  if(isDefined(var_1)) {
    self.teleportdisableflags[self.teleportdisableflags.size] = var_1;
  }

  if(!isDefined(self.disabledteleportation)) {
    self.disabledteleportation = 0;
  }

  self.disabledteleportation++;
  self.can_teleport = 0;
}

issprintenabled() {
  return !isDefined(self.disabledsprint) || !self.disabledsprint;
}

isweaponfireenabled() {
  return !isDefined(self.disabledfire) || !self.disabledfire;
}

ismeleeenabled() {
  return !isDefined(self.disabledmelee) || !self.disabledmelee;
}

isteleportenabled() {
  return !isDefined(self.disabledteleportation) || !self.disabledteleportation;
}

allow_player_interactions(var_0) {
  if(var_0) {
    self.disabledinteractions--;
    if(!self.disabledinteractions) {
      self.interactions_disabled = undefined;
      return;
    }

    return;
  }

  self.disabledinteractions++;
  self.interactions_disabled = 1;
}

areinteractionsenabled() {
  return self.disabledinteractions < 1;
}

_linkto(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = "tag_origin";
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  if(!isDefined(self.playerlinkedcounter)) {
    self.playerlinkedcounter = 0;
  }

  self.playerlinkedcounter++;
  if(self.playerlinkedcounter == 1) {
    self linkto(var_1, var_2, var_3, var_4);
  }
}

_unlink() {
  if(isplayerlinked()) {
    self.playerlinkedcounter--;
    if(self.playerlinkedcounter <= 0) {
      self.playerlinkedcounter = 0;
      self unlink();
    }
  }
}

isplayerlinked() {
  return isDefined(self.playerlinkedcounter) && self.playerlinkedcounter > 0;
}

enable_infinite_ammo(var_0) {
  if(var_0) {
    self.infiniteammocounter++;
    self setclientomnvar("zm_ui_unlimited_ammo", 1);
    return;
  }

  if(self.infiniteammocounter > 0) {
    self.infiniteammocounter--;
  }

  if(!self.infiniteammocounter) {
    self setclientomnvar("zm_ui_unlimited_ammo", 0);
  }
}

isinfiniteammoenabled() {
  return self.infiniteammocounter >= 1;
}

allow_player_ignore_me(var_0) {
  if(var_0) {
    self.ignorme_count++;
    self.ignoreme = 1;
    return;
  }

  self.ignorme_count--;
  if(!self.ignorme_count) {
    self.ignoreme = 0;
  }
}

isignoremeenabled() {
  return self.ignorme_count >= 1;
}

force_usability_enabled() {
  self.disabledusability = 0;
  self enableusability();
}

is_using_extinction_tokens() {
  return 0;
  if(getdvarint("extinction_tokens_enabled") > 0) {
    return 1;
  }

  return 0;
}

coop_getweaponclass(var_0) {
  if(!isDefined(var_0) || isDefined(var_0) && var_0 == "none") {
    return "none";
  }

  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup(level.statstable, 4, var_1, 1);
  if(var_2 == "" && isDefined(level.game_mode_statstable)) {
    if(isDefined(var_0)) {
      var_1 = getbaseweaponname(var_0);
      var_2 = tablelookup(level.game_mode_statstable, 4, var_1, 2);
    }
  }

  if(isenvironmentweapon(var_0)) {
    var_2 = "weapon_mg";
  } else if(var_0 == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  return var_2;
}

is_holding_deployable() {
  return self.is_holding_deployable;
}

has_special_weapon() {
  return self.has_special_weapon;
}

filloffhandweapons(var_0, var_1) {
  var_2 = self getweaponslistoffhands();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;
  foreach(var_7 in var_2) {
    if(var_7 != var_0) {
      if(var_7 != "none" && var_7 != "alienthrowingknife_mp" && var_7 != "alientrophy_mp" && var_7 != "iw6_aliendlc21_mp") {
        self takeweapon(var_7);
      }

      continue;
    }

    if(isDefined(var_7) && var_7 != "none") {
      var_5 = self getrunningforwardpainanim(var_7);
      self setweaponammostock(var_7, var_5 + var_1);
      var_3 = 1;
      break;
    }
  }

  if(var_3 == 0) {
    _giveweapon(var_0);
    self setweaponammostock(var_0, var_1);
  }
}

getequipmenttype(var_0) {
  switch (var_0) {
    case "arc_grenade_mp":
    case "zom_repulsor_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "impalement_spike_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncingbetty_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifec4_mp":
    case "throwingknife_mp":
    case "claymore_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "semtex_mp":
    case "c4_zm":
    case "frag_grenade_mp":
    case "frag_grenade_zm":
      var_1 = "lethal";
      break;

    case "ztransponder_mp":
    case "transponder_mp":
    case "blackout_grenade_mp":
    case "player_trophy_system_mp":
    case "proto_ricochet_device_mp":
    case "emp_grenade_mp":
    case "trophy_mp":
    case "mobile_radar_mp":
    case "gravity_grenade_mp":
    case "alienflare_mp":
    case "concussion_grenade_mp":
    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
    case "thermobaric_grenade_mp":
    case "portal_generator_zm":
    case "portal_generator_mp":
    case "flash_grenade_mp":
      var_1 = "tactical";
      break;

    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

giveperkoffhand(var_0) {
  if(var_0 == "none" || var_0 == "specialty_null") {
    self give_player_xp("none");
    return;
  }

  self.secondarygrenade = var_0;
  if(issubstr(var_0, "_mp")) {
    switch (var_0) {
      case "splash_grenade_zm":
      case "splash_grenade_mp":
      case "mortar_shelljugg_mp":
      case "cluster_grenade_zm":
      case "semtex_zm":
      case "semtex_mp":
      case "frag_grenade_mp":
      case "frag_grenade_zm":
        self give_player_xp("frag");
        break;

      case "throwingknifejugg_mp":
      case "throwingknifesmokewall_mp":
      case "throwingknifec4_mp":
      case "throwingknife_mp":
      case "c4_zm":
        self give_player_xp("throwingknife");
        break;

      case "player_trophy_system_mp":
      case "proto_ricochet_device_mp":
      case "emp_grenade_mp":
      case "trophy_mp":
      case "mobile_radar_mp":
      case "alienflare_mp":
      case "thermobaric_grenade_mp":
      case "flash_grenade_mp":
        self give_player_xp("flash");
        break;

      case "concussion_grenade_mp":
      case "smoke_grenadejugg_mp":
      case "smoke_grenade_mp":
        self give_player_xp("smoke");
        break;

      case "ztransponder_mp":
      case "transponder_mp":
      case "zom_repulsor_mp":
      default:
        self give_player_xp("other");
        break;
    }

    _giveweapon(var_0, 0);
    switch (var_0) {
      case "ztransponder_mp":
      case "transponder_mp":
      case "player_trophy_system_mp":
      case "proto_ricochet_device_mp":
      case "emp_grenade_mp":
      case "trophy_mp":
      case "mobile_radar_mp":
      case "gravity_grenade_mp":
      case "alienflare_mp":
      case "concussion_grenade_mp":
      case "smoke_grenade_mp":
      case "thermobaric_grenade_mp":
      case "flash_grenade_mp":
        self setweaponammoclip(var_0, 1);
        break;

      default:
        self givestartammo(var_0);
        break;
    }

    _setperk(var_0);
    return;
  }

  _setperk(var_0);
}

_launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);
  if(!isDefined(var_4)) {
    var_6.notthrown = 1;
  } else {
    var_6.notthrown = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    foreach(var_6, var_2 in level.extraperkmap) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self.perksblocked[var_4])) {
            self.perksblocked[var_4] = 1;
            continue;
          }

          self.perksblocked[var_4]++;
          if(self.perksblocked[var_4] == 1) {}
        }

        break;
      }
    }
  }
}

unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;
  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;
    if(_hasperk(var_0)) {
      foreach(var_6, var_2 in level.extraperkmap) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self.perksblocked[var_4]--;
            if(self.perksblocked[var_4] == 0) {
              self.perksblocked[var_4] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

getweaponclass(var_0) {
  var_1 = getbaseweaponname(var_0);
  var_2 = level.statstable;
  var_3 = tablelookup(var_2, 4, var_1, 1);
  if(var_3 == "") {
    var_4 = strip_suffix(var_0, "_zm");
    var_3 = tablelookup(var_2, 4, var_4, 1);
  }

  if(var_3 == "" && isDefined(level.game_mode_statstable)) {
    var_4 = strip_suffix(var_0, "_zm");
    var_3 = tablelookup(level.game_mode_statstable, 4, var_4, 1);
  }

  if(isenvironmentweapon(var_0)) {
    var_3 = "weapon_mg";
  } else if(iskillstreakweapon(var_0)) {
    var_3 = "killstreak";
  } else if(issuperweapon(var_0)) {
    var_3 = "super";
  } else if(var_0 == "none") {
    var_3 = "other";
  } else if(var_3 == "") {
    var_3 = "other";
  }

  return var_3;
}

removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var_0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var_0] = undefined;
}

adddamagemodifier(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var_0] = var_1;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var_0] = var_1;
}

getdamagemodifiertotal() {
  var_0 = 1;
  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_2 in self.additivedamagemodifiers) {
      var_0 = var_0 + var_2 - 1;
    }
  }

  var_4 = 1;
  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_2 in self.multiplicativedamagemodifiers) {
      var_4 = var_4 * var_2;
    }
  }

  return var_0 * var_4;
}

isinventoryprimaryweapon(var_0) {
  switch (weaponinventorytype(var_0)) {
    case "altmode":
    case "primary":
      return 1;

    default:
      return 0;
  }
}

_enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1) {
      self enablecollisionnotifies(0);
    }

    self.enabledcollisionnotifies--;
  }
}

has_tag(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = getnumparts(var_0);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1)) {
      return 1;
    }
  }

  return 0;
}

is_trap(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 == "iw7_beamtrap_zm" || var_1 == "iw7_escapevelocity_zm" || var_1 == "iw7_rockettrap_zm" || var_1 == "iw7_discotrap_zm" || var_1 == "iw7_chromosphere_zm" || var_1 == "iw7_buffertrap_zm" || var_1 == "iw7_electrictrap_zm" || var_1 == "iw7_fantrap_zm" || var_1 == "iw7_hydranttrap_zm" || var_1 == "iw7_lasertrap_zm" || var_1 == "iw7_raintrap_zm" || var_1 == "iw7_theatertrap_zm" || var_1 == "iw7_fridgetrap_zm" || var_1 == "iw7_electrotrap_zm") {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_2) && scripts\engine\utility::istrue(var_2.fridge_trap_marked)) {
    return 1;
  }

  if(isDefined(var_0.tesla_type)) {
    return 1;
  }

  if(!isDefined(var_0.script_noteworthy) && !isDefined(var_0.var_336)) {
    return 0;
  }

  if(isDefined(var_0.var_336) && var_0.var_336 == "fence_generator" || var_0.var_336 == "puddle_generator") {
    return 1;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "fire_trap") {
    return 1;
  }

  return 0;
}

riotshieldname() {
  var_0 = self getweaponslist("primary");
  if(!self.hasriotshield) {
    return;
  }

  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      return var_2;
    }
  }
}

player_has_special_ammo(var_0, var_1) {
  return isDefined(var_0.special_ammo_type) && var_0.special_ammo_type == var_1;
}

has_stun_ammo(var_0) {
  if(isDefined(self.special_ammo_type)) {
    return player_has_special_ammo(self, "stun_ammo");
  }

  if(!isDefined(var_0)) {
    var_1 = self getcurrentweapon();
  } else {
    var_1 = var_1;
  }

  if(var_1 == "none") {
    var_1 = self getweaponslistprimaries()[0];
  }

  var_2 = getrawbaseweaponname(var_1);
  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_2]) && self.special_ammocount[var_2] > 0) {
    return 1;
  }

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[var_2]) && self.special_ammocount_comb[var_2] > 0) {
    return 1;
  }

  return 0;
}

is_ricochet_damage() {
  return level.ricochetdamage;
}

is_hardcore_mode() {
  return level.hardcoremode;
}

is_casual_mode() {
  return level.casualmode == 1;
}

isriotshield(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

isaltmodeweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "altmode";
}

hasriotshield() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

is_empty_string(var_0) {
  return var_0 == "";
}

func_F225(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
    return;
  }

  self notify(var_0);
}

notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

player_last_death_pos() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.last_death_pos = self.origin;
  for(;;) {
    self waittill("damage");
    self.last_death_pos = self.origin;
  }
}

isheadshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.triggerportableradarping)) {
      if(var_3.var_9F == "script_vehicle") {
        return 0;
      }

      if(var_3.var_9F == "misc_turret") {
        return 0;
      }

      if(var_3.var_9F == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien") {
        return 0;
      }
    }
  }

  return (var_1 == "head" || var_1 == "helmet" || var_1 == "neck") && var_2 != "MOD_MELEE" && var_2 != "MOD_IMPACT" && var_2 != "MOD_SCARAB" && var_2 != "MOD_CRUSH" && !isenvironmentweapon(var_0);
}

getteamarray(var_0, var_1) {
  var_2 = [];
  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in level.players) {
      if(var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

getotherteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "allies") {
    return "axis";
  } else if(var_0 == "axis") {
    return "allies";
  } else {
    return "none";
  }
}

waittill_any_ents_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  self endon("death");
  var_0E = spawnStruct();
  var_0 childthread scripts\engine\utility::waittill_string(var_1, var_0E);
  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 childthread scripts\engine\utility::waittill_string(var_3, var_0E);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 childthread scripts\engine\utility::waittill_string(var_5, var_0E);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 childthread scripts\engine\utility::waittill_string(var_7, var_0E);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 childthread scripts\engine\utility::waittill_string(var_9, var_0E);
  }

  if(isDefined(var_0A) && isDefined(var_0B)) {
    var_0A childthread scripts\engine\utility::waittill_string(var_0B, var_0E);
  }

  if(isDefined(var_0C) && isDefined(var_0D)) {
    var_0C childthread scripts\engine\utility::waittill_string(var_0D, var_0E);
  }

  var_0E waittill("returned", var_0F);
  var_0E notify("die");
  return var_0F;
}

waittill_any_ents_or_timeout_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E) {
  self endon("death");
  var_0F = spawnStruct();
  var_1 childthread scripts\engine\utility::waittill_string(var_2, var_0F);
  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 childthread scripts\engine\utility::waittill_string(var_4, var_0F);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 childthread scripts\engine\utility::waittill_string(var_6, var_0F);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 childthread scripts\engine\utility::waittill_string(var_8, var_0F);
  }

  if(isDefined(var_9) && isDefined(var_0A)) {
    var_9 childthread scripts\engine\utility::waittill_string(var_0A, var_0F);
  }

  if(isDefined(var_0B) && isDefined(var_0C)) {
    var_0B childthread scripts\engine\utility::waittill_string(var_0C, var_0F);
  }

  if(isDefined(var_0D) && isDefined(var_0E)) {
    var_0D childthread scripts\engine\utility::waittill_string(var_0E, var_0F);
  }

  var_0F childthread scripts\engine\utility::_timeout(var_0);
  var_0F waittill("returned", var_10);
  var_0F notify("die");
  return var_10;
}

player_black_screen(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("intermission");
  self endon("death");
  var_5 = "black";
  if(scripts\engine\utility::istrue(var_4)) {
    var_5 = "white";
  }

  self.player_black_screen = newclienthudelem(self);
  self.player_black_screen.x = 0;
  self.player_black_screen.y = 0;
  self.player_black_screen setshader(var_5, 640, 480);
  self.player_black_screen.alignx = "left";
  self.player_black_screen.aligny = "top";
  self.player_black_screen.sort = 1;
  self.player_black_screen.horzalign = "fullscreen";
  self.player_black_screen.vertalign = "fullscreen";
  self.player_black_screen.alpha = 0;
  self.player_black_screen.foreground = 1;
  if(!scripts\engine\utility::istrue(var_3)) {
    self.player_black_screen fadeovertime(var_0);
  }

  self.player_black_screen.alpha = 1;
  if(!scripts\engine\utility::istrue(var_3)) {
    wait(var_0 + 0.05);
  }

  wait(var_1);
  self.player_black_screen fadeovertime(var_2);
  self.player_black_screen.alpha = 0;
  wait(var_2 + 0.05);
  self.player_black_screen destroy();
}

riotshield_hasweapon() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

riotshield_attach(var_0, var_1) {
  var_2 = undefined;
  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "tag_shield_back";
  }

  self attachshieldmodel(var_1, var_2);
  self.hasriotshield = riotshield_hasweapon();
}

launchshield(var_0, var_1) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    if(isDefined(self.riotshieldmodel)) {
      riotshield_detach(1);
      return;
    }

    if(isDefined(self.riotshieldmodelstowed)) {
      riotshield_detach(0);
      return;
    }
  }
}

riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "tag_weapon_right";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "tag_shield_back";
  }

  self detachshieldmodel(var_1, var_2);
  if(var_0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "tag_weapon_right";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "tag_shield_back";
    var_2 = "tag_weapon_right";
  }

  self moveshieldmodel(var_3, var_1, var_2);
  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var_3;
  self.riotshieldmodelstowed = undefined;
}

riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

remove_crafting_item() {
  self setclientomnvar("zombie_souvenir_piece_index", 0);
  if(isDefined(level.crafting_remove_func)) {
    self[[level.crafting_remove_func]]();
  }

  self.current_crafting_struct = undefined;
}

store_weapons_status(var_0, var_1) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, var_1);
  self.copy_weapon_level = [];
  var_2 = [];
  foreach(var_4 in self.copy_fullweaponlist) {
    if(!isstrstart(var_4, "alt_")) {
      var_2[var_2.size] = var_4;
    }
  }

  self.copy_fullweaponlist = var_2;
  foreach(var_4 in self.copy_fullweaponlist) {
    self.copy_weapon_ammo_clip[var_4] = self getweaponammoclip(var_4);
    self.copy_weapon_ammo_stock[var_4] = self getweaponammostock(var_4);
    if(issubstr(var_4, "akimbo")) {
      self.copy_weapon_ammo_clip_left[var_4] = self getweaponammoclip(var_4, "left");
    }

    if(isDefined(self.pap[getrawbaseweaponname(var_4)])) {
      self.copy_weapon_level[var_4] = self.pap[getrawbaseweaponname(var_4)].lvl;
    }
  }

  if(isDefined(var_0)) {
    var_8 = [];
    foreach(var_4 in self.copy_fullweaponlist) {
      var_0A = 0;
      foreach(var_0C in var_0) {
        if(var_4 == var_0C) {
          var_0A = 1;
          break;
        } else if(getweaponbasename(var_4) == var_0C) {
          var_0A = 1;
          break;
        }
      }

      if(var_0A) {
        continue;
      }

      var_8[var_8.size] = var_4;
    }

    self.copy_fullweaponlist = var_8;
    foreach(var_0C in var_0) {
      if(self.copy_weapon_current == var_0C) {
        self.copy_weapon_current = "none";
        break;
      }
    }
  }
}

get_current_weapon(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();
  if(scripts\engine\utility::istrue(var_1) && is_melee_weapon(var_2)) {
    var_2 = var_0 getweaponslistall()[1];
  }

  return var_2;
}

is_melee_weapon(var_0, var_1) {
  switch (var_0) {
    case "iw7_knife_zm_disco":
    case "iw7_knife_zm_cleaver":
    case "iw7_knife_zm_crowbar":
    case "iw7_knife_zm_elvira":
    case "iw7_knife_zm_rebel":
    case "iw7_knife_zm_soldier":
    case "iw7_knife_zm_scientist":
    case "iw7_knife_zm_schoolgirl":
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
    case "iw7_knife_zm_wyler":
    case "iw7_knife_zm":
      return 1;

    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
    case "iw7_fists_zm_kevinsmith":
    case "iw7_fists_zm_raver":
    case "iw7_fists_zm_hiphop":
    case "iw7_fists_zm_grunge":
    case "iw7_fists_zm_chola":
    case "iw7_fists_zm":
      if(scripts\engine\utility::istrue(var_1)) {
        return 0;
      } else {
        return 1;
      }

      break;

    default:
      return 0;
  }
}

is_primary_melee_weapon(var_0) {
  switch (var_0) {
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

restore_weapons_status(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  var_1 = self getweaponslistall();
  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_3) && !in_inclusion_list(var_0, var_3)) {
      self takeweapon(var_3);
    }
  }

  foreach(var_3 in self.copy_fullweaponlist) {
    if(!self hasweapon(var_3)) {
      var_6 = getweaponattachments(var_3);
      var_7 = getcurrentcamoname(var_3);
      self giveweapon(scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_6, undefined, var_7), -1, 0, -1, 1);
    }

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_3) {
      self assignweaponoffhandprimary(var_3);
    }

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_3) {
      self assignweaponoffhandsecondary(var_3);
    }

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_3) {
      self assignweaponoffhandspecial(var_3);
    }

    if(isDefined(self.copy_weapon_ammo_clip[var_3])) {
      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_3]);
    }

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[var_3])) {
        self setweaponammoclip(var_3, self.copy_weapon_ammo_clip_left[var_3], "left");
      }
    }

    if(isDefined(self.copy_weapon_ammo_stock[var_3])) {
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_3]);
    }

    if(isDefined(self.copy_weapon_level[var_3])) {
      var_8 = spawnStruct();
      var_8.lvl = self.copy_weapon_level[var_3];
      self.pap[getrawbaseweaponname(var_3)] = var_8;
    }
  }

  var_0A = self.copy_weapon_current;
  if(!isDefined(var_0A) || var_0A == "none") {
    foreach(var_0C in self.copy_fullweaponlist) {
      if(scripts\cp\cp_weapon::isbulletweapon(var_0C)) {
        var_0A = var_0C;
        break;
      }
    }
  }

  if(scripts\engine\utility::isweaponswitchallowed()) {
    self switchtoweaponimmediate(var_0A);
  }

  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
  self.copy_weapon_ammo_clip_left = undefined;
  if(isDefined(level.arcade_last_stand_power_func)) {
    self[[level.arcade_last_stand_power_func]]();
  }
}

restore_primary_weapons_only(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  var_1 = 0;
  foreach(var_3 in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(var_3)) {
      self.primary_weapons[var_1] = var_3;
      var_1 = var_1 + 1;
    }
  }

  var_5 = 0;
  foreach(var_3 in self.primary_weapons) {
    if(var_5 < 3) {
      if(isstrstart(var_3, "alt_")) {
        continue;
      }

      if(!self hasweapon(var_3)) {
        if(issubstr(var_3, "knife_")) {
          self giveweapon(var_3, -1, 0, -1, 1);
        } else {
          var_7 = getcurrentcamoname(var_3);
          var_8 = getweaponattachments(var_3);
          self giveweapon(scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_8, undefined, var_7), -1, 0, -1, 1);
        }
      }

      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_3]);
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_3]);
      if(isDefined(self.copy_weapon_level[var_3])) {
        var_9 = spawnStruct();
        var_9.lvl = self.copy_weapon_level[var_3];
        self.pap[getrawbaseweaponname(var_3)] = var_9;
      }

      var_5++;
    }
  }

  var_0B = self.copy_weapon_current;
  if(!isDefined(var_0B) || !self hasweapon(var_0B) || var_0B == "none") {
    var_0B = getweapontoswitchbackto();
  }

  self switchtoweaponimmediate(var_0B);
  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
}

clear_weapons_status() {
  self.copy_fullweaponlist = [];
  self.copy_weapon_current = "none";
  self.copy_weapon_ammo_clip = [];
  self.copy_weapon_ammo_clip_left = [];
  self.copy_weapon_ammo_stock = [];
  self.copy_weapon_level = [];
}

add_to_weapons_status(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_5;
    self.copy_weapon_ammo_clip[var_5] = var_1[var_5];
    self.copy_weapon_ammo_stock[var_5] = var_2[var_5];
  }

  self.copy_weapon_current = var_3;
}

in_inclusion_list(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_0, var_1);
}

vec_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

restore_super_weapon() {
  self giveweapon("super_default_zm");
  self assignweaponoffhandspecial("super_default_zm");
  self.specialoffhandgrenade = "super_default_zm";
  if(scripts\engine\utility::istrue(self.consumable_meter_full)) {
    self setweaponammoclip("super_default_zm", 1);
  }
}

is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "humanoid" || self.species == "zombie";
}

is_zombies_mode() {
  return level.gametype == "zombie";
}

coop_mode_has(var_0) {
  if(!isDefined(level.coop_mode_feature)) {
    return 0;
  }

  return isDefined(level.coop_mode_feature[var_0]);
}

coop_mode_enable(var_0) {
  if(!isDefined(level.coop_mode_feature)) {
    level.coop_mode_feature = [];
  }

  foreach(var_2 in var_0) {
    level.coop_mode_feature[var_2] = 1;
  }
}

make_entity_sentient_cp(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    return self makeentitysentient(var_0, 1);
  }

  return self makeentitysentient(var_0);
}

get_attacker_as_player(var_0) {
  if(isDefined(var_0)) {
    if(isplayer(var_0)) {
      return var_0;
    }

    if(isDefined(var_0.triggerportableradarping) && isplayer(var_0.triggerportableradarping)) {
      return var_0.triggerportableradarping;
    }
  }

  return undefined;
}

removeexcludedattachments(var_0) {
  if(isDefined(level.excludedattachments)) {
    foreach(var_2 in level.excludedattachments) {
      foreach(var_4 in var_0) {
        if(attachmentmap_tobase(var_4) == var_2) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_4);
        }
      }
    }
  }

  return var_0;
}

getrandomweaponattachments(var_0, var_1, var_2) {
  var_3 = [];
  if(weaponhaspassive(var_0, var_1, "passive_random_attachments")) {
    if(0) {
      var_4 = getavailableattachments(var_0, var_2, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_5 = int(max(0, 5 - var_2.size));
      if(var_5 > 0) {
        var_6 = randomintrange(1, var_5 + 1);
        var_3 = buildrandomattachmentarray(var_0, var_6, var_2);
      }
    }
  }

  return var_3;
}

weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);
  if(!isDefined(var_3) || var_3.size <= 0) {
    return 0;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return 1;
    }
  }

  return 0;
}

buildrandomattachmentarray(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\cp\cp_weapon::getattachmenttypeslist(var_0, var_2);
  if(var_4.size > 0) {
    var_3 = [];
    var_5 = scripts\engine\utility::array_randomize_objects(var_4);
    foreach(var_0A, var_7 in var_5) {
      if(var_1 <= 0) {
        break;
      }

      var_8 = 1;
      switch (var_0A) {
        case "undermount":
        case "barrel":
          var_8 = 1;
          break;

        case "rail":
        case "pap":
        case "perk":
          var_8 = 0;
          break;

        default:
          var_8 = randomintrange(1, var_1 + 1);
          break;
      }

      if(var_8 > 0) {
        if(var_8 > var_7.size) {
          var_8 = var_7.size;
        }

        var_1 = var_1 - var_8;
        var_7 = scripts\engine\utility::array_randomize_objects(var_7);
        while(var_8 > 0) {
          var_9 = var_7[var_7.size - var_8];
          if(!issubstr(var_9, "ark") && !issubstr(var_9, "arcane")) {
            var_3[var_3.size] = var_9;
          }

          var_8--;
        }
      }
    }
  }

  return var_3;
}

getavailableattachments(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = getweaponattachmentarrayfromstats(var_0);
  var_4 = [];
  foreach(var_6 in var_3) {
    var_7 = getattachmenttype(var_6);
    if(!var_2 && var_7 == "rail") {
      continue;
    }

    if(isDefined(var_1) && listhasattachment(var_1, var_6)) {
      continue;
    }

    var_4[var_4.size] = var_6;
  }

  return var_4;
}

listhasattachment(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

getweaponattachmentarrayfromstats(var_0) {
  var_0 = getweaponrootname(var_0);
  if(!isDefined(level.weaponattachments)) {
    level.weaponattachments = [];
  }

  if(!isDefined(level.weaponattachments[var_0])) {
    var_1 = [];
    for(var_2 = 0; var_2 <= 19; var_2++) {
      var_3 = tablelookup("mp\statsTable.csv", 4, var_0, 10 + var_2);
      if(var_3 == "") {
        break;
      }

      var_1[var_1.size] = var_3;
    }

    level.weaponattachments[var_0] = var_1;
  }

  return level.weaponattachments[var_0];
}

getweaponpaintjobid(var_0) {
  return -1;
}

getweaponcamo(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "camo");
  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

getweaponcosmeticattachment(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "cosmeticAttachment");
  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

getweaponreticle(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "reticle");
  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

excludeweaponfromregularweaponchecks(var_0) {
  if(var_0 == "iw7_entangler_zm" || var_0 == "iw7_entangler2_zm") {
    return 1;
  }

  if(issubstr(var_0, "venomx") || issubstr(var_0, "nunchucks") || issubstr(var_0, "katana")) {
    return 1;
  }

  return 0;
}

mpbuildweaponname(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = weaponattachdefaultmap(var_0);
  var_0A = buildweaponassetname(var_0, var_4);
  if(isDefined(var_4) && var_4 >= 0 && !excludeweaponfromregularweaponchecks(var_0A)) {
    var_0B = getrandomweaponattachments(var_0A, var_4, var_1);
    if(var_0B.size > 0) {
      var_1 = scripts\engine\utility::array_combine_unique(var_1, var_0B);
    }
  }

  var_0C = coop_getweaponclass(var_0A);
  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);
  }

  var_1 = weaponattachremoveextraattachments(var_1);
  var_1 = removeexcludedattachments(var_1);
  for(var_0D = 0; var_0D < var_1.size; var_0D++) {
    var_1[var_0D] = attachmentmap_tounique(var_1[var_0D], var_0A);
  }

  if(isDefined(var_9)) {
    for(var_0D = 0; var_0D < var_9.size; var_0D++) {
      var_9[var_0D] = attachmentmap_tounique(var_9[var_0D], var_0A);
    }
  }

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);
  }

  if(isDefined(var_4) && var_4 >= 0 && !excludeweaponfromregularweaponchecks(var_0A)) {
    var_0E = getweaponvariantattachments(var_0A, var_4);
    if(var_0E.size > 0) {
      var_1 = scripts\engine\utility::array_combine_unique(var_1, var_0E);
    }
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  if(isDefined(var_8) && var_8 != "none") {
    var_1[var_1.size] = var_8;
  }

  if(var_1.size > 0) {
    var_1 = filterattachments(var_1);
  }

  var_0F = [];
  foreach(var_11 in var_1) {
    var_12 = attachmentmap_toextra(var_11);
    if(isDefined(var_12)) {
      var_0F[var_0F.size] = attachmentmap_tounique(var_12, var_0A);
    }
  }

  if(var_0F.size > 0) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_0F);
  }

  if(var_1.size > 0) {
    var_1 = scripts\engine\utility::alphabetize(var_1);
  }

  var_0A = reassign_weapon_name(var_0A, var_1);
  foreach(var_15 in var_1) {
    var_0A = var_0A + "+" + var_15;
  }

  if(issubstr(var_0A, "iw7")) {
    var_0A = buildweaponnamecamo(var_0A, var_2, var_4);
    var_17 = 0;
    if(isholidayweapon(var_0A, var_4) || issummerholidayweapon(var_0A, var_4)) {
      var_17 = isholidayweaponusingdefaultscope(var_0A, var_1);
    }

    if(var_17) {
      var_0A = var_0A + "+scope1";
    } else {
      var_0A = buildweaponnamereticle(var_0A, var_3);
    }

    var_0A = buildweaponnamevariantid(var_0A, var_4);
  }

  return var_0A;
}

reassign_weapon_name(var_0, var_1) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return var_0;
  } else {
    switch (var_0) {
      case "iw7_machete_mp":
        if(scripts\engine\utility::istrue(self.base_weapon)) {
          var_0 = "iw7_machete_mp";
        } else if((isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1) || scripts\engine\utility::istrue(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_machete_mp";
          } else {
            var_0 = "iw7_machete_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_machete_mp_pap1";
          } else {
            var_0 = "iw7_machete_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_machete_mp_pap2";
        }
        break;

      case "iw7_two_headed_axe_mp":
        if(scripts\engine\utility::istrue(self.base_weapon)) {
          var_0 = "iw7_two_headed_axe_mp";
        } else if((isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1) || scripts\engine\utility::istrue(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_two_headed_axe_mp";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_two_headed_axe_mp_pap2";
        }
        break;

      case "iw7_spiked_bat_mp":
        if(scripts\engine\utility::istrue(self.base_weapon)) {
          var_0 = "iw7_spiked_bat_mp";
        } else if((isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1) || scripts\engine\utility::istrue(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_spiked_bat_mp";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_spiked_bat_mp_pap1";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_spiked_bat_mp_pap2";
        }
        break;

      case "iw7_golf_club_mp":
        if(scripts\engine\utility::istrue(self.base_weapon)) {
          var_0 = "iw7_golf_club_mp";
        } else if((isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1) || scripts\engine\utility::istrue(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_golf_club_mp";
          } else {
            var_0 = "iw7_golf_club_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(scripts\engine\utility::istrue(self.bang_bangs)) {
            var_0 = "iw7_golf_club_mp_pap1";
          } else {
            var_0 = "iw7_golf_club_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_golf_club_mp_pap2";
        }
        break;

      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(var_1, "axepap1")) {
          var_0 = "iw7_axe_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "axepap2")) {
          var_0 = "iw7_axe_zm_pap2";
        }
        break;

      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(var_1, "katanapap1")) {
          var_0 = "iw7_katana_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "katanapap2")) {
          var_0 = "iw7_katana_zm_pap2";
        }
        break;

      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(var_1, "nunchuckspap1")) {
          var_0 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "nunchuckspap2")) {
          var_0 = "iw7_nunchucks_zm_pap2";
        }
        break;

      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(var_1, "freezepap1")) {
          var_0 = "iw7_forgefreeze_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "freezepap2")) {
          var_0 = "iw7_forgefreeze_zm_pap2";
        }
        break;

      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(var_1, "shredderpap1")) {
          var_0 = "iw7_shredder_zm_pap1";
        }
        break;

      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(var_1, "dischordpap1")) {
          var_0 = "iw7_dischord_zm_pap1";
        }
        break;

      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(var_1, "fmpap1")) {
          var_0 = "iw7_facemelter_zm_pap1";
        }
        break;

      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(var_1, "hcpap1")) {
          var_0 = "iw7_headcutter_zm_pap1";
        }
        break;
    }
  }

  return var_0;
}

get_weapon_variant_id(var_0, var_1) {
  var_2 = getbaseweaponname(var_1);
  if(isenumvaluevalid("mp", "LoadoutWeapon", var_2) && weaponhasvariants(var_2)) {
    return var_0 getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_2, "variantID");
  }

  return -1;
}

weaponhasvariants(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw7_glprox":
    case "iw7_lockon":
    case "iw7_chargeshot":
    case "iw7_axe":
    case "iw7_g18c":
    case "iw7_arclassic":
    case "iw7_spasc":
    case "iw7_cheytacc":
    case "iw7_ump45c":
    case "iw7_m1c":
      return 0;

    default:
      return 1;
  }
}

weaponattachremoveextraattachments(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(level.attachmentextralist[var_3])) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

weaponattachdefaultmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaults)) {
    return level.weaponmapdata[var_0].attachdefaults;
  }

  return undefined;
}

buildweaponassetname(var_0, var_1) {
  if(excludeweaponfromregularweaponchecks(var_0) || !isDefined(var_1) || var_1 < 0) {
    switch (var_0) {
      case "iw7_two_headed_axe":
      case "iw7_spiked_bat":
      case "iw7_machete":
      case "iw7_golf_club":
        return var_0 + "_mp";

      case "iw7_golf_club_mp":
      case "iw7_spiked_bat_mp":
      case "iw7_two_headed_axe_mp":
      case "iw7_machete_mp":
      case "super_default_zm":
        return var_0;

      case "iw7_ake":
        return var_0 + "_zml";

      case "iw7_crb":
        return var_0 + "_zml";

      case "iw7_sonic":
        return var_0 + "_zmr";

      case "iw7_ump45":
        return var_0 + "_zml";

      case "iw7_ripper":
        return var_0 + "_zmr";

      case "iw7_g18":
        return var_0 + "_zmr";

      case "iw7_spas":
        return var_0 + "_zmr";

      case "iw7_cheytac":
        return var_0 + "_zmr";

      case "iw7_venomx_zm_pap2":
      case "iw7_venomx_zm_pap1":
      case "iw7_venomx_zm":
      case "iw7_katana_zm_pap2":
      case "iw7_katana_zm_pap1":
      case "iw7_nunchucks_zm_pap2":
      case "iw7_nunchucks_zm_pap1":
      case "iw7_katana_zm":
      case "iw7_nunchucks_zm":
        return var_0;
    }

    return var_0 + "_zm";
  }

  switch (var_0) {
    case "iw7_venomx_zm_pap2":
    case "iw7_venomx_zm_pap1":
    case "iw7_venomx_zm":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
      return var_0;

    default:
      var_2 = getweaponassetfromrootweapon(var_0, var_1);
      return var_2;
  }
}

getweaponassetfromrootweapon(var_0, var_1) {
  var_2 = "mp\loot\weapon\" + var_0 + ".csv ";
  var_3 = tablelookup(var_2, 0, var_1, 20);
  return var_3;
}

getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);
  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = getpassiveattachment(var_5);
      if(!isDefined(var_6)) {
        continue;
      }

      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);
  if(!isDefined(var_1) || !isDefined(var_1.attachmentroll)) {
    return undefined;
  }

  return var_1.attachmentroll;
}

getweaponpassives(var_0, var_1) {
  return getpassivesforweapon(var_0, var_1);
}

getpassivesforweapon(var_0, var_1) {
  var_2 = getlootinfoforweapon(var_0, var_1);
  if(isDefined(var_2)) {
    return var_2.passives;
  }

  return undefined;
}

getlootinfoforweapon(var_0, var_1) {
  var_2 = getweaponrootname(var_0);
  if(!isDefined(level.lootweaponcache)) {
    level.lootweaponcache = [];
  }

  if(isDefined(level.lootweaponcache[var_2]) && isDefined(level.lootweaponcache[var_2][var_1])) {
    var_3 = level.lootweaponcache[var_2][var_1];
    return var_3;
  }

  var_3 = cachelootweaponweaponinfo(var_1, var_3, var_2);
  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

getweaponrootname(var_0) {
  var_1 = strtok(var_0, "_");
  if(weapon_is_dlc_melee(var_0)) {
    var_0 = var_1[0];
    for(var_2 = 1; var_2 < var_1.size - 1; var_2++) {
      var_0 = var_0 + "_" + var_1[var_2];
    }
  } else if(weapon_is_dlc2_melee(var_0)) {
    return var_0;
  } else if(weapon_is_venomx(var_0)) {
    return var_0;
  } else if(var_1[0] == "iw6" || var_1[0] == "iw7") {
    var_0 = var_1[0] + "_" + var_1[1];
  } else if(var_1[0] == "alt") {
    var_0 = var_1[1] + "_" + var_1[2];
  }

  return var_0;
}

weapon_is_venomx(var_0) {
  return issubstr(var_0, "venomx");
}

weapon_is_dlc2_melee(var_0) {
  return issubstr(var_0, "katana") || issubstr(var_0, "nunchucks");
}

weapon_is_dlc_melee(var_0) {
  return issubstr(var_0, "two_headed") || issubstr(var_0, "spiked_bat") || issubstr(var_0, "machete") || issubstr(var_0, "golf_club");
}

cachelootweaponweaponinfo(var_0, var_1, var_2) {
  if(!isDefined(level.lootweaponcache[var_1])) {
    level.lootweaponcache[var_1] = [];
  }

  var_3 = getweaponloottable(var_0);
  var_4 = readweaponinfofromtable(var_3, var_2);
  level.lootweaponcache[var_1][var_2] = var_4;
  return var_4;
}

readweaponinfofromtable(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_0, var_2, 1);
  var_3.weaponasset = tablelookupbyrow(var_0, var_2, 20);
  var_3.passives = [];
  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 21 + var_4);
    if(isDefined(var_5) && var_5 != "") {
      var_3.passives[var_3.passives.size] = var_5;
    }
  }

  return var_3;
}

filterattachments(var_0) {
  var_1 = [];
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      var_4 = 1;
      foreach(var_6 in var_1) {
        if(var_3 == var_6) {
          var_4 = 0;
          break;
        }

        if(!attachmentscompatible(var_3, var_6)) {
          var_4 = 0;
          break;
        }
      }

      if(var_4) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

attachmentscompatible(var_0, var_1) {
  var_0 = attachmentmap_tobase(var_0);
  var_1 = attachmentmap_tobase(var_1);
  var_2 = 1;
  if(var_0 == var_1) {
    var_2 = 0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var_3 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_2 = !isDefined(level.attachmentmap_conflicts[var_3[0] + "_" + var_3[1]]);
  } else if(var_0 != "none" && var_1 != "none") {
    var_4 = tablelookuprownum("mp\attachmentcombos.csv", 0, var_1);
    if(tablelookup("mp\attachmentcombos.csv", 0, var_0, var_4) == "no") {
      var_2 = 0;
    }
  }

  return var_2;
}

attachmentmap_toextra(var_0) {
  var_1 = undefined;
  if(isDefined(level.attachmentmap_uniquetoextra[var_0])) {
    var_1 = level.attachmentmap_uniquetoextra[var_0];
  }

  return var_1;
}

getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0])) {
    return undefined;
  }

  var_1 = level.passivemap[var_0];
  return var_1;
}

map_check(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
    case 0:
      if(level.script == "cp_zmb") {
        return 1;
      } else {
        return 0;
      }

      break;

    case 1:
      if(level.script == "cp_rave") {
        return 1;
      } else {
        return 0;
      }

      break;

    case 2:
      if(level.script == "cp_disco") {
        return 1;
      } else {
        return 0;
      }

      break;

    case 3:
      if(level.script == "cp_town") {
        return 1;
      } else {
        return 0;
      }

      break;

    case 4:
      if(level.script == "cp_final") {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 1;
  }
}

buildweaponname(var_0, var_1, var_2, var_3, var_4) {
  if(isstrstart(var_0, "iw7_")) {
    var_2 = 0;
  }

  var_5 = [];
  foreach(var_7 in var_1) {
    var_5[var_5.size] = attachmentmap_tounique(var_7, var_0);
  }

  var_9 = getrawbaseweaponname(var_0);
  var_0A = var_0;
  var_0B = var_9 == "kbs" || var_9 == "cheytac" || var_9 == "m8" || var_9 == "ripper" || var_9 == "erad" || var_9 == "ar57";
  if(var_0B) {
    var_0C = 0;
    foreach(var_7 in var_5) {
      if(getattachmenttype(var_7) == "rail") {
        var_0C = 1;
        break;
      }
    }

    if(!var_0C) {
      var_5[var_5.size] = var_9 + "scope";
    }
  }

  if(var_5.size > 0) {
    var_0F = scripts\engine\utility::array_remove_duplicates(var_5);
    var_5 = scripts\engine\utility::alphabetize(var_0F);
  }

  foreach(var_7 in var_5) {
    var_0A = var_0A + "+" + var_7;
  }

  if(issubstr(var_0A, "iw6") || issubstr(var_0A, "iw7")) {
    var_0A = buildweaponnamecamo(var_0A, var_2);
    if(var_4 != "weapon_sniper" && isDefined(var_3)) {
      var_0A = buildweaponnamereticle(var_0A, var_3);
    }
  } else if(!scripts\cp\cp_weapon::isvalidzombieweapon(var_0A + "_zm")) {
    var_0A = var_0 + "_zm";
  } else {
    var_0A = buildweaponnamecamo(var_0A, var_2);
    var_0A = buildweaponnamereticle(var_0A, var_3);
    var_0A = var_0A + "_zm";
  }

  return var_0A;
}

buildweaponnamevariantid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return var_0;
  }

  if(excludeweaponfromregularweaponchecks(var_0)) {
    return var_0;
  }

  var_0 = var_0 + "+loot" + var_1;
  return var_0;
}

isholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  if(var_1 == 6) {
    var_2 = getweaponrootname(var_0);
    return var_2 == "iw7_ripper" || var_2 == "iw7_lmg03" || var_2 == "iw7_ar57";
  }

  return 0;
}

issummerholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = getweaponrootname(var_0);
  if(var_1 == 8) {
    return var_2 == "iw7_erad" || var_2 == "iw7_ake" || var_2 == "iw7_sdflmg";
  }

  if(var_1 == 5) {
    return var_2 == "iw7_mod2187" || var_2 == "iw7_longshot";
  }

  return 0;
}

ishalloweenholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = getweaponrootname(var_0);
  if(var_1 == 9) {
    return var_2 == "iw7_kbs" || var_2 == "iw7_ripper" || var_2 == "iw7_m4";
  }

  if(var_1 == 8) {
    return var_2 == "iw7_mod2187";
  }

  if(var_1 == 7) {
    return var_2 == "iw7_mag";
  }

  if(var_1 == 6) {
    return var_2 == "iw7_minilmg";
  }

  return 0;
}

ismark2weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 >= 32;
}

isholidayweaponusingdefaultscope(var_0, var_1) {
  var_2 = attachmentmap_tounique("scope", getweaponbasename(var_0));
  return isDefined(var_2) && scripts\engine\utility::array_contains(var_1, var_2);
}

is_pap_camo(var_0) {
  if(isDefined(level.pap_1_camo) && var_0 == level.pap_1_camo) {
    return 1;
  } else if(isDefined(level.pap_2_camo) && var_0 == level.pap_2_camo) {
    return 1;
  }

  return 0;
}

buildweaponnamecamo(var_0, var_1, var_2) {
  var_3 = -1;
  var_4 = isDefined(var_1) && is_pap_camo(var_1);
  if(var_0 == "iw7_nunchucks_zm_pap1" || var_0 == "iw7_nunchucks_zm_pap2") {
    return var_0 + "+camo" + 222;
  }

  if(excludeweaponfromregularweaponchecks(var_0)) {
    if(var_0 == "iw7_nunchucks_zm" || var_0 == "iw7_katana_zm") {
      return var_0;
    }
  }

  if(!var_4) {
    if(isholidayweapon(var_0, var_2)) {
      var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo89", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_0 + "+camo" + var_3;
    } else if(issummerholidayweapon(var_0, var_2)) {
      var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo230", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_0 + "+camo" + var_3;
    } else if(ishalloweenholidayweapon(var_0, var_2)) {
      var_3 = int(tablelookup("mp\camoTable.csv", 1, "camo242", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_0 + "+camo" + var_3;
    } else if((!isDefined(var_1) || var_1 == "none") && ismark2weapon(var_2)) {
      var_5 = getweaponqualitybyid(var_0, var_2);
      var_6 = undefined;
      switch (var_5) {
        case 1:
          var_6 = "camo99";
          break;

        case 2:
          var_6 = "camo101";
          break;

        case 3:
          var_6 = "camo102";
          break;

        case 4:
          var_6 = "camo103";
          break;

        default:
          break;
      }

      var_3 = int(tablelookup("mp\camoTable.csv", 1, var_6, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_0 + "+camo" + var_3;
    }
  }

  if(!isDefined(var_3)) {
    var_5 = 0;
  } else {
    var_5 = int(tablelookup("mp\camoTable.csv", 1, var_3, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
  }

  if(var_5 <= 0) {
    var_5 = getweaponqualitybyid(var_2, var_4);
    var_6 = undefined;
    switch (var_5) {
      case 1:
        var_6 = "camo24";
        break;

      case 2:
        var_6 = "camo19";
        break;

      case 3:
        var_6 = "camo18";
        break;

      default:
        break;
    }

    if(isDefined(var_6)) {
      var_3 = int(tablelookup("mp\camoTable.csv", 1, var_6, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    } else {
      return var_0;
    }
  }

  return var_0 + "+camo" + var_3;
}

getweaponqualitybyid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0 || excludeweaponfromregularweaponchecks(var_0)) {
    return 0;
  }

  var_2 = getweaponloottable(var_0);
  var_3 = int(tablelookup(var_2, 0, var_1, 4));
  return var_3;
}

buildweaponnamereticle(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(excludeweaponfromregularweaponchecks(var_0)) {
    return var_0;
  }

  var_2 = int(tablelookup("mp\reticleTable.csv", 1, var_1, 5));
  if(!isDefined(var_2) || var_2 == 0) {
    return var_0;
  }

  var_0 = var_0 + "+scope" + var_2;
  return var_0;
}

has_zombie_perk(var_0) {
  if(!isDefined(self.zombies_perks)) {
    return 0;
  }

  return scripts\engine\utility::istrue(self.zombies_perks[var_0]);
}

drawsphere(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait(0.05);
  }
}

set_alien_emissive(var_0, var_1) {
  var_2 = self.maxemissive - self.defaultemissive;
  var_3 = var_1 * var_2 + self.defaultemissive;
  self getrandomhovernodesaroundtargetpos(var_0, var_3);
}

get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var_0 + level.deployablebox_vest_rank[var_1];
}

alien_mode_has(var_0) {
  var_0 = tolower(var_0);
  if(!isDefined(level.alien_mode_feature)) {
    return 0;
  }

  if(!isDefined(level.alien_mode_feature[var_0])) {
    return 0;
  }

  return level.alien_mode_feature[var_0];
}

enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
}

array_remove_index(var_0, var_1, var_2) {
  var_3 = [];
  foreach(var_7, var_5 in var_0) {
    if(var_7 == var_1) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2)) {
      var_6 = var_7;
    } else {
      var_6 = var_3.size;
    }

    var_3[var_6] = var_5;
  }

  return var_3;
}

is_normal_upright(var_0) {
  var_1 = (0, 0, 1);
  var_2 = 0.85;
  return vectordot(var_0, var_1) > var_2;
}

get_synch_direction_list(var_0) {
  if(!isDefined(self.synch_attack_setup)) {
    return [];
  }

  if(!isDefined(self.synch_attack_setup.synch_directions)) {
    return [];
  }

  if(!self.synch_attack_setup.type_specific) {
    return self.synch_attack_setup.synch_directions;
  }

  var_1 = scripts\cp\cp_agent_utils::get_agent_type(var_0);
  if(!isDefined(self.synch_attack_setup.synch_directions[var_1])) {
    var_2 = "Synch attack on " + self.synch_attack_setup.identifier + " doesn\'t handle type: " + var_1;
  }

  return self.synch_attack_setup.synch_directions[var_1];
}

getrandomindex(var_0) {
  var_1 = 0;
  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  var_5 = randomintrange(0, var_1);
  var_1 = 0;
  foreach(var_7, var_3 in var_0) {
    var_1 = var_1 + var_3;
    if(var_5 <= var_1) {
      return var_7;
    }
  }

  return 0;
}

get_closest_living_player() {
  var_0 = 1073741824;
  var_1 = undefined;
  foreach(var_3 in level.players) {
    var_4 = distancesquared(self.origin, var_3.origin);
    if(isreallyalive(var_3) && var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}

get_array_of_valid_players(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in level.players) {
    if(var_4 is_valid_player()) {
      var_2[var_2.size] = var_4;
    }
  }

  if(!isDefined(var_0) || !var_0) {
    return var_2;
  }

  return scripts\engine\utility::get_array_of_closest(var_1, var_2);
}

is_valid_player(var_0) {
  if(!isplayer(self)) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isDefined(var_0) && scripts\cp\cp_laststand::player_in_laststand(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(self.sessionstate == "spectator") {
    return 0;
  }

  return 1;
}

any_player_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

timeoutvofunction_pain(var_0, var_1) {
  wait(var_1);
  level notify(var_0 + "_timed_out");
}

player_pain_vo(var_0) {
  self endon("disconnect");
  level endon("pain_vo_timed_out");
  level thread timeoutvofunction_pain("pain_vo", 3.5);
  var_1 = 5500;
  var_2 = gettime();
  if(!isDefined(self.next_pain_vo_time)) {
    self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < self.next_pain_vo_time) {
    return;
  }

  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  if(isDefined(self.vo_prefix)) {
    if(soundexists(self.vo_prefix + "plr_pain")) {
      self playlocalsound(self.vo_prefix + "plr_pain");
    } else if(soundexists(self.vo_prefix + "pain")) {
      self playlocalsound(self.vo_prefix + "pain");
    }
  }

  var_3 = "injured_pain_vocal";
  if(isDefined(var_0)) {
    if(isDefined(var_0.agent_type)) {
      switch (var_0.agent_type) {
        case "crab_mini":
          var_3 = "injured_pain_crabgoon";
          break;

        case "crab_brute":
          var_3 = "injured_pain_radactivecrab";
          break;

        case "crab_boss":
          var_3 = "injured_pain_radboss";
          break;

        case "skater":
          var_3 = "injured_pain_skater";
          break;

        case "ratking":
          var_3 = scripts\engine\utility::random(["injured_pain_ratking1", "injured_pain_ratking2", "injured_pain_ratking3"]);
          break;

        case "zombie_clown":
          var_3 = "injured_pain_clown";
          break;

        case "alien_rhino":
          var_3 = scripts\engine\utility::random(["injured_pain_rhino1", "injured_pain_rhino2", "injured_pain_rhino3"]);
          break;

        case "alien_phantom":
        case "alien_goon":
          var_3 = "injured_pain_crytpid";
          break;

        default:
          var_3 = "injured_pain_vocal";
          break;
      }
    }
  }

  if(self.vo_prefix == "p6_" && var_3 == "injured_pain_clown") {
    scripts\cp\cp_vo::try_to_play_vo(var_3, "zmb_comment_vo");
  } else {
    scripts\cp\cp_vo::try_to_play_vo(var_3, "zmb_comment_vo");
  }

  self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
}

player_pain_breathing_sfx() {
  level endon("game_ended");
  self endon("disconnect");
  if(is_playing_pain_breathing_sfx(self)) {
    return;
  }

  if(above_pain_breathing_sfx_threshold(self)) {
    return;
  }

  set_is_playing_pain_breathing_sfx(self, 1);
  var_0 = get_pain_breathing_sfx_alias(self);
  if(isDefined(var_0)) {
    if(soundexists(var_0)) {
      while(!above_pain_breathing_sfx_threshold(self) && !level.gameended) {
        if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
          self playlocalsound(var_0);
        }

        wait(1.5);
      }
    }

    set_is_playing_pain_breathing_sfx(self, 0);
  }
}

is_playing_pain_breathing_sfx(var_0) {
  return scripts\engine\utility::istrue(var_0.is_playing_pain_breathing_sfx);
}

above_pain_breathing_sfx_threshold(var_0) {
  var_1 = 0.3;
  return var_0.health / var_0.maxhealth > var_1;
}

set_is_playing_pain_breathing_sfx(var_0, var_1) {
  var_0.is_playing_pain_breathing_sfx = var_1;
}

get_pain_breathing_sfx_alias(var_0) {
  if(!level.gameended) {
    if(var_0.vo_prefix == "p1_") {
      return "p1_plr_pain";
    }

    if(var_0.vo_prefix == "p2_") {
      return "p2_plr_pain";
    }

    if(var_0.vo_prefix == "p3_") {
      return "p3_plr_pain";
    }

    if(var_0.vo_prefix == "p4_") {
      return "p4_plr_pain";
    }

    if(var_0.vo_prefix == "p5_") {
      return "p5_plr_pain";
    }

    if(var_0.vo_prefix == "p6_") {
      return "p5_plr_pain";
    }

    return "p3_plr_pain";
  }
}

pointvscone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 - var_1;
  var_9 = vectordot(var_8, var_2);
  var_0A = vectordot(var_8, var_3);
  if(var_9 > var_4) {
    return 0;
  }

  if(var_9 < var_5) {
    return 0;
  }

  if(isDefined(var_7)) {
    if(abs(var_0A) > var_7) {
      return 0;
    }
  }

  if(scripts\engine\utility::anglebetweenvectors(var_2, var_8) > var_6) {
    return 0;
  }

  return 1;
}

playvoforpillage(var_0) {
  var_1 = var_0.vo_prefix + "good_loot";
  if(scripts\cp\cp_vo::alias_2d_version_exists(var_0, var_1)) {
    var_0 playlocalsound(scripts\cp\cp_vo::get_alias_2d_version(var_0, var_1));
    return;
  }

  if(soundexists(var_1)) {
    var_0 playlocalsound(var_1);
  }
}

deployable_box_onuse_message(var_0) {
  var_1 = "";
  if(isDefined(var_0) && isDefined(var_0.boxtype) && isDefined(level.boxsettings[var_0.boxtype].eventstring)) {
    var_1 = level.boxsettings[var_0.boxtype].eventstring;
  }

  thread setlowermessage("deployable_use", var_1, 3);
}

is_goon(var_0) {
  switch (var_0) {
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;

    default:
      return 0;
  }
}

mark_dangerous_nodes(var_0, var_1, var_2) {
  markdangerousnodes(var_0, var_1, 1);
  wait(var_2);
  markdangerousnodes(var_0, var_1, 0);
}

healthregeninit(var_0) {
  level.healthregendisabled = var_0;
}

alien_health_per_player_init() {
  level.alien_health_per_player_scalar = [];
  level.alien_health_per_player_scalar[1] = 0.9;
  level.alien_health_per_player_scalar[2] = 1;
  level.alien_health_per_player_scalar[3] = 1.3;
  level.alien_health_per_player_scalar[4] = 1.8;
}

playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    scripts\engine\utility::waittill_any_3("damage", "health_perk_upgrade");
    if(!canregenhealth()) {
      continue;
    }

    var_0 = scripts\cp\cp_laststand::gethealthcap();
    var_1 = self.health / var_0;
    if(var_1 >= 1) {
      self.health = var_0;
      continue;
    }

    thread healthregen(gettime(), var_1);
    thread breathingmanager(gettime(), var_1);
  }
}

healthregen(var_0, var_1) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  while(isDefined(self.selfdamaging) && self.selfdamaging) {
    wait(0.2);
  }

  if(ishealthregendisabled()) {
    return;
  }

  var_2 = spawnStruct();
  getregendata(var_2);
  scripts\engine\utility::waittill_any_timeout_1(var_2.activatetime, "force_regeneration");
  for(;;) {
    var_3 = scripts\cp\cp_laststand::gethealthcap();
    var_2 = spawnStruct();
    getregendata(var_2);
    if(!scripts\cp\perks\perkfunctions::has_fragile_relic_and_is_sprinting()) {
      var_1 = self.health / self.maxhealth;
      if(self.health < int(var_3)) {
        if(var_1 + var_2.regenamount > int(1)) {
          self.health = int(var_3);
        } else {
          self.health = int(self.maxhealth * var_1 + var_2.regenamount);
        }
      } else {
        break;
      }
    }

    scripts\engine\utility::waittill_any_timeout_1(var_2.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");
  scripts\cp\cp_globallogic::player_init_invulnerability();
  resetattackerlist();
}

breathingmanager(var_0, var_1) {
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

  if(!isplayer(self)) {
    return;
  }

  self.breathingstoptime = var_0 + 6000 * self.regenspeed;
  wait(6 * self.regenspeed);
  if(!level.gameended) {
    if(self.vo_prefix == "p1_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p1_breathing_better");
        return;
      }

      return;
    }

    if(self.vo_prefix == "p2_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p2_breathing_better");
        return;
      }

      return;
    }

    if(self.vo_prefix == "p3_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p3_breathing_better");
        return;
      }

      return;
    }

    if(self.vo_prefix == "p4_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p4_breathing_better");
        return;
      }

      return;
    }

    if(self.vo_prefix == "p5_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p5_breathing_better");
        return;
      }

      return;
    }

    if(self.vo_prefix == "p6_") {
      if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
        self playlocalsound("p5_breathing_better");
        return;
      }

      return;
    }

    if(!scripts\engine\utility::istrue(self.vo_system_playing_vo)) {
      self playlocalsound("p3_breathing_better");
      return;
    }

    return;
  }
}

getregendata(var_0) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\prestige::prestige_getslowhealthregenscalar();
  if(self.prestigehealthregennerfscalar == 1) {
    if(is_consumable_active("faster_health_regen_upgrade") || isDefined(level.purify_active) && level.purify_active >= 1) {
      var_0.activatetime = 0.45;
      var_0.waittimebetweenregen = 0.045;
      var_0.regenamount = 0.1;
      return;
    }

    if(self.health <= 45) {
      var_0.activatetime = 5;
      var_0.waittimebetweenregen = 0.05;
      var_0.regenamount = 0.1;
      return;
    }

    var_0.activatetime = 2.4;
    var_0.waittimebetweenregen = 0.1;
    var_0.regenamount = 0.1;
    return;
  }

  var_0.activatetime = 2.4 * self.prestigehealthregennerfscalar;
  var_0.waittimebetweenregen = 0.1 * self.prestigehealthregennerfscalar;
  var_0.regenamount = 0.1;
}

resetattackerlist(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(1.75);
  resetattackerlist_internal();
}

resetattackerlist_internal() {
  self.attackers = [];
  self.attackerdata = [];
}

canregenhealth() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return 0;
  }

  return 1;
}

playerpainbreathingsound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  wait(2);
  for(;;) {
    wait(0.2);
    if(shouldplaypainbreathingsound()) {
      if(self.vo_prefix == "p1_") {
        if(soundexists("Fem_breathing_hurt")) {
          self playlocalsound("Fem_breathing_hurt");
        }
      } else {
        self playlocalsound("breathing_hurt");
      }

      wait(0.784);
      wait(0.1 + randomfloat(0.8));
    }
  }
}

shouldplaypainbreathingsound() {
  if(ishealthregendisabled() || isusingremote() || isDefined(self.breathingstoptime) && gettime() < self.breathingstoptime || self.health > self.maxhealth * 0.55 || level.gameended) {
    return 0;
  }

  return 1;
}

ishealthregendisabled() {
  return (isDefined(level.healthregendisabled) && level.healthregendisabled) || isDefined(self.healthregendisabled) && self.healthregendisabled;
}

playerarmor() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("game_ended");
  if(!isDefined(self.bodyarmorhp)) {
    self.bodyarmorhp = 0;
  }

  self setplayerdata("cp", "alienSession", "armor", 0);
  var_0 = 0;
  for(;;) {
    scripts\engine\utility::waittill_any_3("player_damaged", "enable_armor");
    if(!isDefined(self.bodyarmorhp)) {
      if(var_0 > 0) {
        self setplayerdata("cp", "alienSession", "armor", 0);
        var_0 = 0;
      }

      continue;
    }

    if(var_0 != self.bodyarmorhp) {
      var_1 = int(self.bodyarmorhp);
      self setplayerdata("cp", "alienSession", "armor", var_1);
      var_0 = self.bodyarmorhp;
    }
  }
}

allow_secondary_offhand_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledsecondaryoffhandweapons)) {
      self.disabledsecondaryoffhandweapons = 0;
    }

    self.disabledsecondaryoffhandweapons--;
    if(!self.disabledsecondaryoffhandweapons) {
      self enableoffhandsecondaryweapons();
      return;
    }

    return;
  }

  if(!isDefined(self.disabledsecondaryoffhandweapons)) {
    self.disabledsecondaryoffhandweapons = 0;
  }

  self.disabledsecondaryoffhandweapons++;
  self disableoffhandsecondaryweapons();
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");
  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");
  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    if(isDefined(var_0) && isDefined(var_0.phys_sound_func)) {
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

addtotraplist() {
  if(!scripts\engine\utility::array_contains(level.placed_crafted_traps, self)) {
    level.placed_crafted_traps = scripts\engine\utility::array_add_safe(level.placed_crafted_traps, self);
  }

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

removefromtraplist() {
  if(scripts\engine\utility::array_contains(level.placed_crafted_traps, self)) {
    level.placed_crafted_traps = scripts\engine\utility::array_remove(level.placed_crafted_traps, self);
  }

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

ent_is_near_equipment(var_0) {
  var_1 = 16384;
  if(level.turrets.size) {
    var_2 = sortbydistance(level.turrets, var_0.origin);
    if(distance2dsquared(var_2[0].origin, var_0.origin) < var_1) {
      return 1;
    }
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(var_4 in level.placed_crafted_traps) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(distance2dsquared(var_4.origin, var_0.origin) < var_1) {
        return 1;
      }
    }
  }

  if(isDefined(level.near_equipment_func)) {
    return [[level.near_equipment_func]](var_0);
  }

  return 0;
}

set_crafted_inventory_item(var_0, var_1, var_2) {
  if(isDefined(var_2.current_crafted_inventory)) {
    var_2.current_crafted_inventory = undefined;
  }

  var_2.current_crafted_inventory = spawnStruct();
  var_2.current_crafted_inventory.randomintrange = var_0;
  var_2.current_crafted_inventory.restore_func = var_1;
}

remove_crafted_item_from_inventory(var_0) {
  var_0 setclientomnvar("zom_crafted_weapon", 0);
  var_0.current_crafted_inventory = undefined;
}

is_escape_gametype() {
  return level.gametype == "escape";
}

item_handleownerdisconnect(var_0) {
  self endon("death");
  level endon("game_ended");
  self notify(var_0);
  self endon(var_0);
  self.triggerportableradarping waittill("disconnect");
  foreach(var_2 in level.players) {
    if(var_2 is_valid_player(1)) {
      self.triggerportableradarping = var_2;
      if(self.classname != "script_model") {
        self setsentryowner(self.triggerportableradarping);
      }

      break;
    }
  }

  thread item_handleownerdisconnect(var_0);
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
  wait(0.05);
  restore_player_perk();
}

remove_player_perks() {
  if(_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    _unsetperk("specialty_explosivebullets");
  }
}

item_timeout(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(self.lifespan)) {
    self.lifespan = var_1;
  }

  if(isDefined(var_0)) {
    self.lifespan = var_0;
  }

  while(self.lifespan) {
    wait(1);
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      self.lifespan = max(0, self.lifespan - 1);
    }
  }

  while(isDefined(self) && isDefined(self.inuseby)) {
    wait(0.05);
  }

  if(isDefined(self.zap_model)) {
    self.zap_model delete();
  }

  if(isDefined(var_2)) {
    self notify(var_2);
    return;
  }

  self notify("death");
}

item_oncarrierdeath(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_1 = var_0 scripts\engine\utility::waittill_any_return("death", "last_stand");
  var_0 notify("force_cancel_placement");
}

item_oncarrierdisconnect(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");
  if(isDefined(self.carriedgascan)) {
    self.carriedgascan delete();
  } else if(isDefined(self.carriedmedusa)) {
    self.carriedmedusa delete();
  } else if(isDefined(self.carried_trap)) {
    self.carried_trap delete();
  } else if(isDefined(self.carriedboombox)) {
    self.carriedboombox delete();
  } else if(isDefined(self.carried_fireworks_trap)) {
    self.carried_fireworks_trap delete();
  } else if(isDefined(self.carriedrevocator)) {
    self.carriedrevocator delete();
  }

  self delete();
}

item_ongameended(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  self delete();
}

should_be_affected_by_trap(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(!isagent(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.agent_type)) {
    return 0;
  }

  if(!isDefined(var_0.isactive) || !var_0.isactive) {
    return 0;
  }

  if(!isDefined(var_1) && isDefined(var_0.entered_playspace) && !var_0.entered_playspace) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.marked_for_death)) {
    return 0;
  }

  if(!isDefined(var_0.team)) {
    return 0;
  }

  if(var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_ghost" || var_0.agent_type == "zombie_grey") {
    return 0;
  }

  if(var_0.agent_type == "alien_phantom" || var_0.agent_type == "alien_rhino") {
    return 0;
  }

  if(!scripts\engine\utility::istrue(var_2) && scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.is_coaster_zombie)) {
    return 0;
  }

  return 1;
}

set_quest_icon(var_0) {
  increment_num_of_quest_piece_completed();
  set_quest_icon_internal(var_0);
}

set_quest_icon_internal(var_0) {
  setomnvarbit("zombie_quest_piece", var_0, 1);
  setclientmatchdata("questPieces", "quest_piece_" + var_0, 1);
}

unset_zm_quest_icon(var_0) {
  unset_quest_icon_internal(var_0);
}

unset_quest_icon_internal(var_0) {
  setomnvarbit("zombie_quest_piece", var_0, 0);
}

set_completed_quest_mark(var_0) {
  setomnvarbit("zm_completed_quest_marks", var_0, 1);
}

increment_num_of_quest_piece_completed() {
  if(!isDefined(level.num_of_quest_pieces_completed)) {
    level.num_of_quest_pieces_completed = 0;
  }

  level.num_of_quest_pieces_completed++;
  if(level.script == "cp_zmb") {
    if(level.num_of_quest_pieces_completed == level.cp_zmb_number_of_quest_pieces) {
      foreach(var_1 in level.players) {
        var_1 scripts\cp\zombies\achievement::update_achievement("STICKER_COLLECTOR", 24);
      }
    }
  }
}

playplayerandnpcsounds(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playsoundtoteam(var_2, "allies", var_0);
  var_0 playsoundtoteam(var_2, "axis", var_0);
}

roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5) {
    return int(var_0 + 1);
  }

  return int(var_0);
}

damage_over_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!should_apply_dot(var_0)) {
    return;
  }

  var_0 endon("death");
  if(!isDefined(var_3)) {
    var_3 = 600;
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(!isDefined(var_4)) {
    var_4 = "MOD_UNKNOWN";
  }

  if(!isDefined(var_5)) {
    var_5 = "iw7_dot_zm";
  }

  if(isDefined(var_7)) {
    var_0 setscriptablestateflag(var_0, var_7, 1);
    if(isDefined(level.scriptablestatefunc)) {
      var_0 thread[[level.scriptablestatefunc]](var_0);
    }
  }

  var_9 = 0;
  var_0A = 6;
  var_0B = var_2 / var_0A;
  var_0C = var_3 / var_0A;
  for(var_0D = 0; var_0D < var_0A; var_0D++) {
    wait(var_0B);
    if(isalive(var_0)) {
      var_0.flame_damage_time = gettime() + 500;
      if(var_0.health - var_0C <= 0) {
        if(isDefined(var_8)) {
          level notify(var_8);
        }
      }

      if(isDefined(var_1)) {
        var_0 dodamage(var_0C, var_0.origin, var_1, var_1, var_4, var_5);
        continue;
      }

      var_0 dodamage(var_0C, var_0.origin, undefined, undefined, var_4, var_5);
    }
  }

  if(isDefined(var_7)) {
    var_0 setscriptablestateflag(var_0, var_7);
  }

  if(scripts\engine\utility::istrue(var_0.marked_for_death)) {
    var_0.marked_for_death = undefined;
  }

  if(scripts\engine\utility::istrue(var_0.flame_damage_time)) {
    var_0.flame_damage_time = undefined;
  }
}

setscriptablestateflag(var_0, var_1, var_2) {
  switch (var_1) {
    case "combinedArcane":
    case "combinedarcane":
      if(scripts\engine\utility::istrue(var_2)) {
        var_0.is_afflicted = 1;
      } else {
        var_0.is_afflicted = undefined;
      }
      break;

    case "burning":
      if(scripts\engine\utility::istrue(var_2)) {
        var_0.is_burning = var_2;
      } else {
        var_0.is_burning = undefined;
      }
      break;

    case "electrified":
      if(scripts\engine\utility::istrue(var_2)) {
        var_0.is_electrified = var_2;
        var_0.allowpain = 1;
        var_0.stun_hit_time = gettime() + 3000;
      } else {
        var_0.is_electrified = undefined;
        var_0.allowpain = 0;
      }
      break;

    case "shocked":
      if(scripts\engine\utility::istrue(var_2)) {
        var_0.stunned = var_2;
      } else {
        var_0.stunned = undefined;
      }
      break;

    case "chemBurn":
    case "chemburn":
      if(scripts\engine\utility::istrue(var_2)) {
        var_0.is_chem_burning = 1;
      } else {
        var_0.is_chem_burning = undefined;
      }
      break;

    default:
      break;
  }
}

should_apply_dot(var_0) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "c6" || var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost") {
    return 0;
  }

  return 1;
}

update_trap_placement_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("force_cancel_placement");
  self endon("disconnect");
  level endon("game_ended");
  var_5 = var_2.carriedtrapoffset;
  var_6 = var_2.carriedtrapangles;
  var_7 = var_2.placementradius;
  var_8 = var_2.placementheighttolerance;
  var_9 = var_2.modelplacement;
  var_0A = var_2.modelplacementfailed;
  var_0B = var_2.placecancelablestring;
  var_0C = var_2.placestring;
  var_0D = var_2.cannotplacestring;
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_0E = -1;
  for(;;) {
    var_0F = self canplayerplacesentry(1, var_7);
    var_0.origin = var_0F["origin"];
    var_0.angles = var_0F["angles"];
    var_1.origin = var_0.origin + var_5;
    var_1.angles = var_0.angles + var_6;
    if(isDefined(self.onslide)) {
      var_0.canbeplaced = 0;
    } else {
      var_0.canbeplaced = self isonground() && var_0F["result"] && abs(var_0.origin[2] - self.origin[2]) < var_8;
    }

    if(ent_is_near_equipment(var_0)) {
      var_0.canbeplaced = 0;
    }

    if(isDefined(var_3) && isDefined(level.discotrap_active) && isDefined(level.dance_floor_volume)) {
      if(var_0 istouching(level.dance_floor_volume)) {
        var_0.canbeplaced = 0;
      }
    }

    if(isDefined(var_0F["entity"])) {
      var_0.moving_platform = var_0F["entity"];
    } else {
      var_0.moving_platform = undefined;
    }

    if(var_0.canbeplaced != var_0E) {
      if(var_0.canbeplaced) {
        if(!isDefined(var_4)) {
          var_1 setModel(var_9);
        }

        if(isDefined(var_0.firstplacement)) {
          self forceusehinton(var_0B);
        } else {
          self forceusehinton(var_0C);
        }
      } else {
        if(!isDefined(var_4)) {
          var_1 setModel(var_0A);
        }

        self forceusehinton(var_0D);
      }
    }

    var_0E = var_0.canbeplaced;
    wait(0.05);
  }
}

usegrenadegesture(var_0, var_1) {
  if(var_0 cangiveandfireoffhand(var_0 getvalidtakeweapon()) && !var_0 isgestureplaying()) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
  }
}

is_codxp() {
  return getdvar("scr_codxp", "") != "";
}

too_close_to_other_interactions(var_0) {
  var_1 = sortbydistance(level.current_interaction_structs, var_0);
  if(distancesquared(var_1[0].origin, var_0) < 9216) {
    return 1;
  }

  return 0;
}

getweapontoswitchbackto() {
  if(isDefined(self.last_weapon)) {
    var_0 = self.last_weapon;
  } else {
    var_0 = self getcurrentweapon();
  }

  var_1 = 0;
  var_2 = level.additional_laststand_weapon_exclusion;
  if(var_0 == "none") {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, getweaponbasename(var_0))) {
    var_1 = 1;
  } else if(is_melee_weapon(var_0, 1) || isDefined(level.primary_melee_weapons) && scripts\engine\utility::array_contains(level.primary_melee_weapons, var_0)) {
    var_1 = 1;
  }

  if(var_1) {
    var_3 = self getweaponslistall();
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_3[var_4] == "none") {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, var_3[var_4])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, getweaponbasename(var_3[var_4]))) {
        continue;
      } else if(is_melee_weapon(var_3[var_4], 1) || isDefined(level.primary_melee_weapons) && scripts\engine\utility::array_contains(level.primary_melee_weapons, var_3[var_4])) {
        continue;
      } else if(!scripts\cp\cp_weapon::isprimaryweapon(var_3[var_4])) {
        continue;
      } else {
        var_1 = 0;
        var_0 = var_3[var_4];
        break;
      }
    }
  }

  if(var_1) {
    var_0 = "iw7_fists_zm";
    if(!self hasweapon(var_0)) {
      _giveweapon(var_0, undefined, undefined, 1);
    }
  }

  return var_0;
}

getvalidtakeweapon(var_0) {
  var_1 = self getcurrentweapon();
  var_2 = 0;
  var_3 = level.additional_laststand_weapon_exclusion;
  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::array_combine(var_0, var_3);
  }

  if(var_1 == "none") {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, getweaponbasename(var_1))) {
    var_2 = 1;
  } else if(is_melee_weapon(var_1, 1)) {
    var_2 = 1;
  }

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_2) {
    var_1 = self.last_valid_weapon;
    if(var_1 == "none") {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, getweaponbasename(var_1))) {
      var_2 = 1;
    } else if(is_melee_weapon(var_1, 1)) {
      var_2 = 1;
    } else {
      var_2 = 0;
    }
  }

  if(var_2) {
    var_4 = self getweaponslistall();
    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(var_4[var_5] == "none") {
        continue;
      } else if(scripts\engine\utility::array_contains(var_3, var_4[var_5])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_3, getweaponbasename(var_4[var_5]))) {
        continue;
      } else if(is_melee_weapon(var_4[var_5], 1)) {
        continue;
      } else {
        var_2 = 0;
        var_1 = var_4[var_5];
        break;
      }
    }
  }

  return var_1;
}

getcurrentcamoname(var_0) {
  var_1 = getweaponcamoname(var_0);
  if(!isDefined(var_1)) {
    return undefined;
  }

  switch (var_1) {
    case "camo0":
      return "camo00";

    case "camo1":
      return "camo01";

    case "camo2":
      return "camo02";

    case "camo3":
      return "camo03";

    case "camo4":
      return "camo04";

    case "camo5":
      return "camo05";

    case "camo6":
      return "camo06";

    case "camo7":
      return "camo07";

    case "camo8":
      return "camo08";

    case "camo9":
      return "camo09";

    default:
      return var_1;
  }

  return undefined;
}

add_to_notify_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self.notify_queue)) {
    self.notify_queue = [];
  }

  if(!isDefined(self.notify_queue[var_0])) {
    self.notify_queue[var_0] = 0;
  } else {
    if(var_0 == "weapon_hit_enemy") {
      var_9 = gettime();
      if(isDefined(self.last_notify_time) && self.last_notify_time == var_9) {
        return;
      } else {
        self.last_notify_time = var_9;
      }
    }

    self.notify_queue[var_0]++;
  }

  if(self.notify_queue[var_0] > 0) {
    wait(0.05 * self.notify_queue[var_0]);
  }

  self notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  waittillframeend;
  if(isDefined(self.notify_queue[var_0])) {
    self.notify_queue[var_0]--;
    if(self.notify_queue[var_0] < 1) {
      self.notify_queue[var_0] = undefined;
    }
  }
}

take_fists_weapon(var_0) {
  foreach(var_2 in var_0 getweaponslistall()) {
    if(issubstr(var_2, "iw7_fists")) {
      var_0 takeweapon(var_2);
    }
  }
}

playlocalsound_safe(var_0) {
  if(soundexists(var_0)) {
    self playlocalsound(var_0);
  }
}

stoplocalsound_safe(var_0) {
  if(soundexists(var_0)) {
    self stoplocalsound(var_0);
  }
}

playsoundatpos_safe(var_0, var_1) {
  if(soundexists(var_1)) {
    playsoundatpos(var_0, var_1);
  }
}

agentcantbeignored() {
  return isDefined(self.agent_type) && isDefined(level.ignoreimmune) && scripts\engine\utility::array_contains(level.ignoreimmune, self.agent_type);
}

agentisfnfimmune() {
  return isDefined(self.agent_type) && isDefined(level.fnfimmune) && scripts\engine\utility::array_contains(level.fnfimmune, self.agent_type);
}

agentisinstakillimmune() {
  return isDefined(self.agent_type) && isDefined(level.instakillimmune) && scripts\engine\utility::array_contains(level.instakillimmune, self.agent_type);
}

agentisspecialzombie() {
  return isDefined(self.agent_type) && isDefined(level.specialzombie) && scripts\engine\utility::array_contains(level.specialzombie, self.agent_type);
}

firegesturegrenade(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();
  if(cangiveandfireoffhand(var_2)) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
  }
}

cangiveandfireoffhand(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(var_0)])) {
      return 0;
    }

    return 1;
  }

  return 1;
}

play_interaction_gesture(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "iw7_powerlever_zm";
  }

  if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp") {
    thread firegesturegrenade(self, var_0);
  }
}

deactivatebrushmodel(var_0, var_1) {
  var_0 notsolid();
  if(scripts\engine\utility::istrue(var_1)) {
    var_0 hide();
  }
}

rankingenabled() {
  if(!isplayer(self)) {
    return 0;
  }

  return level.onlinegame && !self.usingonlinedataoffline;
}

bufferednotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");
  level endon("game_ended");
  var_0A = "bufferedNotify_" + var_0;
  self notify(var_0A);
  self endon(var_0A);
  if(!isDefined(self.bufferednotifications)) {
    self.bufferednotifications = [];
  }

  if(!isDefined(self.bufferednotifications[var_0])) {
    self.bufferednotifications[var_0] = [];
  }

  var_0B = spawnStruct();
  var_0B.var_C8E5 = var_1;
  var_0B.var_C8E6 = var_2;
  var_0B.var_C8E7 = var_3;
  var_0B.var_C8E8 = var_4;
  var_0B.var_C8E9 = var_5;
  var_0B.var_C8EA = var_6;
  var_0B.var_C8EB = var_7;
  var_0B.var_C8EC = var_8;
  var_0B.param9 = var_9;
  self.bufferednotifications[var_0][self.bufferednotifications[var_0].size] = var_0B;
  waittillframeend;
  while(self.bufferednotifications[var_0].size > 0) {
    var_0B = self.bufferednotifications[var_0][0];
    self notify(var_0, var_0B.var_C8E5, var_0B.var_C8E6, var_0B.var_C8E7, var_0B.var_C8E8, var_0B.var_C8E9, var_0B.var_C8EA, var_0B.var_C8EB, var_0B.var_C8EC, var_0B.param9);
    self.bufferednotifications[var_0] = array_remove_index(self.bufferednotifications[var_0], 0);
    wait(0.05);
  }
}

debugprintline(var_0) {}
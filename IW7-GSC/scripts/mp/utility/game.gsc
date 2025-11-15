/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\utility\game.gsc
***************************************/

_giveweapon(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01))
    var_01 = -1;

  if(!isDefined(var_03))
    var_03 = 0;

  if(issubstr(var_00, "+akimbo") || issubstr(var_00, "+g18pap2") || isDefined(var_02) && var_02 == 1)
    self giveweapon(var_00, var_01, 1, -1, var_03);
  else
    self giveweapon(var_00, var_01, 0, -1, var_03);

  thread updatelaststandpistol(var_00);
  return var_00;
}

updatelaststandpistol(var_00) {
  if(isDefined(var_00)) {
    if(isDefined(level.last_stand_weapons)) {
      var_01 = getweaponbasename(var_00);

      if(scripts\engine\utility::array_contains(level.last_stand_weapons, var_01)) {
        self.last_stand_pistol = var_00;
        return;
      }
    }
  }

  var_02 = self getweaponslistall();
  var_03 = getweaponbasename(self.last_stand_pistol);
  var_04 = 0;

  foreach(var_06 in var_02) {
    var_07 = getweaponbasename(var_06);

    if(var_07 == var_03) {
      var_04 = 1;
      return;
    }
  }

  if(!var_04) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(var_06 in var_02) {
        var_07 = getweaponbasename(var_06);

        for(var_10 = level.last_stand_weapons.size - 1; var_10 > -1; var_10--) {
          if(var_07 == level.last_stand_weapons[var_10]) {
            var_04 = 1;
            self.last_stand_pistol = var_06;
            return;
          }
        }
      }
    }

    var_12 = getrawbaseweaponname(self.default_starting_pistol);

    if(isDefined(self.weapon_build_models[var_12]))
      self.last_stand_pistol = self.weapon_build_models[var_12];
    else
      self.last_stand_pistol = self.default_starting_pistol;
  }
}

giveperk(var_00) {
  if(issubstr(var_00, "specialty_weapon_")) {
    _setperk(var_00);
    return;
  }

  _setperk(var_00);
  _setextraperks(var_00);
}

_hasperk(var_00) {
  var_01 = self.perks;

  if(!isDefined(var_01))
    return 0;

  if(isDefined(var_1[var_00]))
    return 1;

  return 0;
}

_setperk(var_00) {
  self.perks[var_00] = 1;
  self.perksperkname[var_00] = var_00;
  var_01 = level.perksetfuncs[var_00];

  if(isDefined(var_01))
    self thread[[var_01]]();

  self setperk(var_00, !isDefined(level.scriptperks[var_00]));
}

_unsetperk(var_00) {
  self.perks[var_00] = undefined;
  self.perksperkname[var_00] = undefined;

  if(isDefined(level.perkunsetfuncs[var_00]))
    self thread[[level.perkunsetfuncs[var_00]]]();

  self unsetperk(var_00, !isDefined(level.scriptperks[var_00]));
}

_setextraperks(var_00) {
  if(var_00 == "specialty_stun_resistance")
    giveperk("specialty_empimmune");

  if(var_00 == "specialty_hardline")
    giveperk("specialty_assists");

  if(var_00 == "specialty_incog") {
    giveperk("specialty_spygame");
    giveperk("specialty_coldblooded");
    giveperk("specialty_noscopeoutline");
    giveperk("specialty_heartbreaker");
  }

  if(var_00 == "specialty_blindeye")
    giveperk("specialty_noplayertarget");

  if(var_00 == "specialty_sharp_focus")
    giveperk("specialty_reducedsway");

  if(var_00 == "specialty_quickswap")
    giveperk("specialty_fastoffhand");
}

_clearperks() {
  foreach(var_02, var_01 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_02]))
      self[[level.perkunsetfuncs[var_02]]]();
  }

  self.perks = [];
  self.perksperkname = [];
  self getplayerlookattarget();
}

clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(var_00 = 0; var_00 < self.lowermessages.size; var_0++)
      self.lowermessages[var_00] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

setlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isDefined(var_03))
    var_03 = 1;

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_04))
    var_04 = 0;

  if(!isDefined(var_05))
    var_05 = 0;

  if(!isDefined(var_06))
    var_06 = 0.85;

  if(!isDefined(var_07))
    var_07 = 3.0;

  if(!isDefined(var_08))
    var_08 = 0;

  if(!isDefined(var_09))
    var_09 = 1;

  addlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  updatelowermessage();
}

play_bink_video(var_00, var_01, var_02) {
  level thread play_bink_video_internal(var_00, var_01, var_02);
}

play_bink_video_internal(var_00, var_01, var_02) {
  foreach(var_04 in level.players)
  var_04 freezecontrolswrapper(1);

  setomnvar("bink_video_active", 1);
  _playcinematicforall(var_00);
  wait(var_01);
  setomnvar("bink_video_active", 0);

  foreach(var_04 in level.players) {
    var_04 freezecontrolswrapper(0);

    if(!isDefined(var_02) || !var_02)
      var_04 thread player_black_screen(0, 1, 0.5, 1);
  }
}

updatelowermessage() {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  var_00 = getlowermessage();

  if(!isDefined(var_00)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage give_zap_perk("");

      if(isDefined(self.lowertimer))
        self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage give_zap_perk(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
    self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0.shouldfade) {
      self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
      self.lowermessage.alpha = var_0.fadetoalpha;
    }

    if(var_0.time > 0 && var_0.showtimer)
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    else {
      if(var_0.time > 0 && !var_0.showtimer) {
        self.lowertimer give_zap_perk("");
        self.lowermessage fadeovertime(min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(var_00);
        thread clearafterfade(var_00);
        return;
      }

      self.lowertimer give_zap_perk("");
    }
  }
}

addlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_10 = undefined;

  foreach(var_12 in self.lowermessages) {
    if(var_12.name == var_00) {
      if(var_12.text == var_01 && var_12.priority == var_03) {
        return;
      }
      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_10;
  }

  var_10.name = var_00;
  var_10.text = var_01;
  var_10.time = var_02;
  var_10.addtime = gettime();
  var_10.priority = var_03;
  var_10.showtimer = var_04;
  var_10.shouldfade = var_05;
  var_10.fadetoalpha = var_06;
  var_10.fadetoalphatime = var_07;
  var_10.hidewhenindemo = var_08;
  var_10.hidewheninmenu = var_09;
  sortlowermessages();
}

sortlowermessages() {
  for(var_00 = 1; var_00 < self.lowermessages.size; var_0++) {
    var_01 = self.lowermessages[var_00];
    var_02 = var_1.priority;

    for(var_03 = var_00 - 1; var_03 >= 0 && var_02 > self.lowermessages[var_03].priority; var_3--)
      self.lowermessages[var_03 + 1] = self.lowermessages[var_03];

    self.lowermessages[var_03 + 1] = var_01;
  }
}

getlowermessage() {
  if(!isDefined(self.lowermessages))
    return undefined;

  return self.lowermessages[0];
}

clearondeath(var_00) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

clearafterfade(var_00) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

clearlowermessage(var_00) {
  removelowermessage(var_00);
  updatelowermessage();
}

removelowermessage(var_00) {
  if(isDefined(self.lowermessages)) {
    for(var_01 = self.lowermessages.size; var_01 > 0; var_1--) {
      if(self.lowermessages[var_01 - 1].name != var_00) {
        continue;
      }
      var_02 = self.lowermessages[var_01 - 1];

      for(var_03 = var_01; var_03 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_03]))
          self.lowermessages[var_03 - 1] = self.lowermessages[var_03];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

freezecontrolswrapper(var_00) {
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self getroundswon(1);
    return;
  }

  self getroundswon(var_00);
  self.controlsfrozen = var_00;
}

setthirdpersondof(var_00) {
  if(var_00)
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  else
    self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setusingremote(var_00) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_00;

  if(scripts\engine\utility::isoffhandweaponsallowed())
    scripts\engine\utility::allow_offhand_weapons(0);

  self notify("using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

updatesessionstate(var_00, var_01) {
  self.sessionstate = var_00;

  if(!isDefined(var_01))
    var_01 = "";

  self.statusicon = var_01;
  self setclientomnvar("ui_session_state", var_00);
}

getuniqueid() {
  if(isDefined(self.pers["guid"]))
    return self.pers["guid"];

  var_00 = self getguid();

  if(var_00 == "0000000000000000") {
    if(isDefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    var_00 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_00;
  return self.pers["guid"];
}

gameflagset(var_00) {
  game["flags"][var_00] = 1;
  level notify(var_00);
}

gameflaginit(var_00, var_01) {
  game["flags"][var_00] = var_01;
}

gameflag(var_00) {
  return game["flags"][var_00];
}

gameflagwait(var_00) {
  while(!gameflag(var_00))
    level waittill(var_00);
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

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }
  if(!isDefined(level.console))
    level.console = getdvar("consoleGame") == "true";
  else {}

  if(!isDefined(level.func_13E0F))
    level.func_13E0F = getdvar("xenonGame") == "true";
  else {}

  if(!isDefined(level.func_DADB))
    level.func_DADB = getdvar("ps3Game") == "true";
  else {}

  if(!isDefined(level.func_13E0E))
    level.func_13E0E = getdvar("xb3Game") == "true";
  else {}

  if(!isDefined(level.func_DADC))
    level.func_DADC = getdvar("ps4Game") == "true";
  else {}
}

isenemy(var_00) {
  if(level.teambased)
    return isplayeronenemyteam(var_00);
  else
    return isplayerffaenemy(var_00);
}

isplayeronenemyteam(var_00) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_00) {
  if(isDefined(var_0.owner))
    return var_0.owner != self;
  else
    return var_00 != self;
}

notusableforjoiningplayers(var_00) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var_01);

    if(isDefined(var_01) && var_01 != var_00)
      self disableplayeruse(var_01);
  }
}

setselfusable(var_00) {
  self makeusable();

  foreach(var_02 in level.players) {
    if(var_02 != var_00) {
      self disableplayeruse(var_02);
      continue;
    }

    self enableplayeruse(var_02);
  }
}

isenvironmentweapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(var_00 == "turret_minigun_mp")
    return 1;

  return 0;
}

issuperweapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(isDefined(level.superweapons) && isDefined(level.superweapons[var_00]))
    return 1;

  return 0;
}

strip_suffix(var_00, var_01) {
  if(var_0.size <= var_1.size)
    return var_00;

  if(getsubstr(var_00, var_0.size - var_1.size, var_0.size) == var_01)
    return getsubstr(var_00, 0, var_0.size - var_1.size);

  return var_00;
}

playteamfxforclient(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = undefined;

  if(self.team != var_00)
    var_06 = spawnfxforclient(scripts\engine\utility::getfx(var_03), var_01, self);
  else
    var_06 = spawnfxforclient(scripts\engine\utility::getfx(var_02), var_01, self);

  if(isDefined(var_06))
    triggerfx(var_06);

  var_06 thread delayentdelete(var_04);

  if(isDefined(var_05) && var_05)
    var_06 thread deleteonplayerdeathdisconnect(self);

  return var_06;
}

delayentdelete(var_00) {
  self endon("death");
  wait(var_00);

  if(isDefined(self))
    self delete();
}

deleteonplayerdeathdisconnect(var_00) {
  self endon("death");
  var_00 scripts\engine\utility::waittill_any("death", "disconnect");
  self delete();
}

isstrstart(var_00, var_01) {
  return getsubstr(var_00, 0, var_1.size) == var_01;
}

isreallyalive(var_00) {
  if(isalive(var_00) && !isDefined(var_0.fauxdeath))
    return 1;

  return 0;
}

getbaseweaponname(var_00) {
  var_01 = strtok(var_00, "_");

  if(var_1[0] == "iw5" || var_1[0] == "iw6" || var_1[0] == "iw7")
    var_00 = var_1[0] + "_" + var_1[1];
  else if(var_1[0] == "alt")
    var_00 = var_1[1] + "_" + var_1[2];

  return var_00;
}

getzbaseweaponname(var_00, var_01) {
  var_02 = strtok(var_00, "_");

  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    if(isDefined(var_01) && var_01 > 1)
      var_00 = var_2[0] + "_z" + var_2[1] + var_01;
    else
      var_00 = var_2[0] + "_z" + var_2[1];
  } else if(var_2[0] == "alt") {
    if(isDefined(var_01) && var_01 > 1)
      var_00 = var_2[1] + "_z" + var_2[2] + var_01;
    else
      var_00 = var_2[1] + "_z" + var_2[2];
  }

  return var_00;
}

get_closest_entrance(var_00) {
  var_01 = sortbydistance(level.window_entrances, var_00);

  foreach(var_03 in var_01) {
    if(var_3.enabled)
      return var_03;
  }

  return undefined;
}

entrance_is_fully_repaired(var_00) {
  if(!isDefined(var_0.barrier))
    return 1;

  var_01 = scripts\cp\zombies\zombie_entrances::func_7B13(var_00);

  if(!isDefined(var_01))
    return 1;

  return 0;
}

is_weapon_purchase_disabled() {
  return scripts\engine\utility::is_true(level.weapon_purchase_disabled);
}

get_attachment_from_interaction(var_00) {
  var_01 = var_0.item.model;
  var_02 = "arkblue";
  var_03 = "stun_ammo";

  switch (var_01) {
    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_02 = "arcane_base";
      break;
    default:
      break;
  }

  return var_02;
}

are_any_consumables_active() {
  foreach(var_02, var_01 in self.consumables) {
    if(var_1.on == 1)
      return 1;
  }

  return 0;
}

getrawbaseweaponname(var_00) {
  var_01 = strtok(var_00, "_");

  if(var_1[0] == "iw5" || var_1[0] == "iw6" || var_1[0] == "iw7")
    var_00 = var_1[1];
  else if(var_1[0] == "alt")
    var_00 = var_1[2];

  return var_00;
}

getintproperty(var_00, var_01) {
  var_02 = var_01;
  var_02 = getdvarint(var_00, var_01);
  return var_02;
}

leaderdialogonplayer(var_00, var_01, var_02, var_03) {
  if(!isDefined(game["dialog"][var_00])) {
    return;
  }
  var_04 = self.pers["team"];

  if(isDefined(var_04) && (var_04 == "axis" || var_04 == "allies")) {
    var_05 = game["voice"][var_04] + game["dialog"][var_00];
    self _meth_8252(var_05, var_00, 2, var_01, var_02, var_03);
  }
}

_setactionslot(var_00, var_01, var_02) {
  self.saved_actionslotdata[var_00].type = var_01;
  self.saved_actionslotdata[var_00].item = var_02;
  self setactionslot(var_00, var_01, var_02);
}

getkillstreakweapon(var_00) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var_00, level.global_tables["killstreakTable"].weapon_col);
}

_objective_delete(var_00) {
  objective_delete(var_00);

  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_00;
  } else
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_00;
}

touchingbadtrigger(var_00) {
  var_01 = getEntArray("trigger_hurt", "classname");

  foreach(var_03 in var_01) {
    if(self istouching(var_03) && (level.mapname != "mp_mine" || var_3.dmg > 0))
      return 1;
  }

  var_05 = getEntArray("radiation", "targetname");

  foreach(var_03 in var_05) {
    if(self istouching(var_03))
      return 1;
  }

  if(isDefined(var_00) && var_00 == "gryphon") {
    var_08 = getEntArray("gryphonDeath", "targetname");

    foreach(var_03 in var_08) {
      if(self istouching(var_03))
        return 1;
    }
  }

  return 0;
}

playsoundinspace(var_00, var_01, var_02) {
  if(isDefined(var_00)) {
    if(isarray(var_00))
      var_00 = scripts\engine\utility::random(var_00);

    var_03 = lookupsoundlength(var_00);
    playLoopSound(var_01, var_00);

    if(isDefined(var_02))
      wait(var_03 / 1000);

    return var_03;
  }
}

play_random_sound_in_space(var_00, var_01, var_02) {
  if(isDefined(var_00)) {
    if(!isarray(var_00)) {
      var_03 = [];
      var_3[0] = var_00;
      var_00 = var_3[0];
    }

    var_04 = scripts\engine\utility::random(var_00);
    var_05 = lookupsoundlength(var_04);
    playLoopSound(var_01, var_04);

    if(isDefined(var_02))
      wait(var_05);

    return var_05;
  }
}

play_looping_sound_on_ent(var_00) {
  if(soundexists(var_00))
    self playLoopSound(var_00);
}

stop_looping_sound_on_ent(var_00) {
  if(soundexists(var_00))
    self stoploopsound(var_00);
}

playdeathsound() {
  var_00 = randomintrange(1, 8);
  var_01 = "generic";

  if(self getstruct_delete())
    var_01 = "female";

  if(self.team == "axis") {
    var_02 = var_01 + "_death_russian_" + var_00;

    if(soundexists(var_02))
      self playSound(var_02);
  } else {
    var_02 = var_01 + "_death_american_" + var_00;

    if(soundexists(var_02))
      self playSound(var_02);
  }
}

isfmjdamage(var_00, var_01, var_02) {
  return isDefined(var_02) && var_02 _hasperk("specialty_bulletpenetration") && isDefined(var_01) && scripts\engine\utility::isbulletdamage(var_01);
}

ischangingweapon() {
  return isDefined(self.changingweapon);
}

getattachmenttype(var_00) {
  if(!isDefined(var_00))
    return "none";

  var_01 = tablelookup("mp\attachmentTable.csv", 4, var_00, 2);

  if(!isDefined(var_01) || isDefined(var_01) && var_01 == "") {
    var_02 = getdvar("g_gametype");

    if(var_02 == "zombie")
      var_01 = tablelookup("cp\zombies\zombie_attachmentTable.csv", 4, var_00, 2);
  }

  return var_01;
}

weaponhasattachment(var_00, var_01) {
  if(!isDefined(var_00) || var_00 == "none" || var_00 == "")
    return 0;

  var_02 = getweaponattachmentsbasenames(var_00);

  foreach(var_04 in var_02) {
    if(var_04 == var_01)
      return 1;
  }

  return 0;
}

getweaponattachmentsbasenames(var_00) {
  var_01 = getweaponattachments(var_00);

  foreach(var_04, var_03 in var_01)
  var_1[var_04] = attachmentmap_tobase(var_03);

  return var_01;
}

attachmentmap_tobase(var_00) {
  if(isDefined(level.attachmentmap_uniquetobase[var_00]))
    var_00 = level.attachmentmap_uniquetobase[var_00];

  return var_00;
}

bot_is_fireteam_mode() {
  var_00 = botautoconnectenabled() == 2;

  if(var_00) {
    if(!level.teambased || level.gametype != "war" && level.gametype != "dom")
      return 0;

    return 1;
  }

  return 0;
}

isjuggernaut() {
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

attachmentmap_tounique(var_00, var_01) {
  var_02 = getweaponrootname(var_01);

  if(var_02 != var_01) {
    var_03 = getweaponbasename(var_01);
    var_04 = strtok(var_03, "_");
    var_05 = "mp" + getsubstr(var_4[2], 2, var_4[2].size);
    var_06 = var_4[0];

    for(var_07 = 1; var_07 < var_4.size; var_7++) {
      if(var_07 == 2) {
        var_06 = var_06 + ("_" + var_05);
        continue;
      }

      var_06 = var_06 + ("_" + var_4[var_07]);
    }

    if(isDefined(level.attachmentmap_basetounique[var_03]) && isDefined(level.attachmentmap_uniquetobase[var_00]) && isDefined(level.attachmentmap_basetounique[var_03][level.attachmentmap_uniquetobase[var_00]])) {
      var_08 = level.attachmentmap_uniquetobase[var_00];
      return level.attachmentmap_basetounique[var_03][var_08];
    } else if(isDefined(level.attachmentmap_basetounique[var_06]) && isDefined(level.attachmentmap_uniquetobase[var_00]) && isDefined(level.attachmentmap_basetounique[var_06][level.attachmentmap_uniquetobase[var_00]])) {
      var_08 = level.attachmentmap_uniquetobase[var_00];
      return level.attachmentmap_basetounique[var_06][var_08];
    } else if(isDefined(level.attachmentmap_basetounique[var_03]) && isDefined(level.attachmentmap_basetounique[var_03][var_00]))
      return level.attachmentmap_basetounique[var_03][var_00];
    else if(isDefined(level.attachmentmap_basetounique[var_06]) && isDefined(level.attachmentmap_basetounique[var_06][var_00]))
      return level.attachmentmap_basetounique[var_06][var_00];
    else if(var_4.size > 3) {
      var_09 = var_4[0] + "_" + var_4[1] + "_" + var_4[2];

      if(isDefined(level.attachmentmap_basetounique[var_09]) && isDefined(level.attachmentmap_basetounique[var_09][var_00]))
        return level.attachmentmap_basetounique[var_09][var_00];
      else {
        var_10 = strtok(var_06, "_");
        var_11 = var_10[0] + "_" + var_10[1] + "_" + var_10[2];

        if(isDefined(level.attachmentmap_basetounique[var_11]) && isDefined(level.attachmentmap_basetounique[var_11][var_00]))
          return level.attachmentmap_basetounique[var_11][var_00];
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_02]) && isDefined(level.attachmentmap_basetounique[var_02][var_00]))
    return level.attachmentmap_basetounique[var_02][var_00];
  else {
    var_12 = weapongroupmap(var_02);

    if(isDefined(var_12) && isDefined(level.attachmentmap_basetounique[var_12]) && isDefined(level.attachmentmap_basetounique[var_12][var_00]))
      return level.attachmentmap_basetounique[var_12][var_00];
  }

  return var_00;
}

weapongroupmap(var_00) {
  if(isDefined(level.weaponmapdata[var_00]) && isDefined(level.weaponmapdata[var_00].group))
    return level.weaponmapdata[var_00].group;

  return undefined;
}

iskillstreakweapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(var_00 == "none")
    return 0;

  if(scripts\engine\utility::isdestructibleweapon(var_00))
    return 0;

  if(issubstr(var_00, "killstreak"))
    return 1;

  if(issubstr(var_00, "remote_tank_projectile"))
    return 1;

  if(issubstr(var_00, "minijackal_"))
    return 1;

  if(isDefined(level.killstreakweildweapons) && isDefined(level.killstreakweildweapons[var_00]))
    return 1;

  if(scripts\engine\utility::isairdropmarker(var_00))
    return 1;

  var_01 = weaponinventorytype(var_00);

  if(isDefined(var_01) && var_01 == "exclusive")
    return 1;

  return 0;
}

clearusingremote() {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!scripts\engine\utility::isoffhandweaponsallowed())
    scripts\engine\utility::allow_offhand_weapons(1);

  var_00 = self getcurrentweapon();

  if(var_00 == "none" || iskillstreakweapon(var_00)) {
    var_01 = scripts\engine\utility::getlastweapon();

    if(isreallyalive(self)) {
      if(!self hasweapon(var_01))
        var_01 = getfirstprimaryweapon();

      self switchtoweapon(var_01);
    }
  }

  freezecontrolswrapper(0);
  self notify("stopped_using_remote");
}

getfirstprimaryweapon() {
  var_00 = self getweaponslistprimaries();
  return var_0[0];
}

set_visionset_for_watching_players(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = get_players_watching(var_04, var_05);

  foreach(var_08 in var_06) {
    var_08 notify("changing_watching_visionset");

    if(isDefined(var_03) && var_03)
      var_08 visionsetmissilecamforplayer(var_00, var_01);
    else
      var_08 visionsetnakedforplayer(var_00, var_01);

    if(var_00 != "" && isDefined(var_02)) {
      var_08 thread reset_visionset_on_team_change(self, var_01 + var_02);
      var_08 thread reset_visionset_on_disconnect(self);

      if(var_08 isinkillcam())
        var_08 thread reset_visionset_on_spawn();
    }
  }
}

get_players_watching(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(!isDefined(var_01))
    var_01 = 0;

  var_02 = self getentitynumber();
  var_03 = [];

  foreach(var_05 in level.players) {
    if(var_05 == self) {
      continue;
    }
    var_06 = 0;

    if(!var_01) {
      if(var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_07 = var_05 getspectatingplayer();

        if(isDefined(var_07) && var_07 == self)
          var_06 = 1;
      }

      if(var_5.forcespectatorclient == var_02)
        var_06 = 1;
    }

    if(!var_00) {
      if(var_5.killcamentity == var_02)
        var_06 = 1;
    }

    if(var_06)
      var_3[var_3.size] = var_05;
  }

  return var_03;
}

reset_visionset_on_team_change(var_00, var_01) {
  self endon("changing_watching_visionset");
  var_02 = gettime();
  var_03 = self.team;

  while(gettime() - var_02 < var_01 * 1000) {
    if(self.team != var_03 || !scripts\engine\utility::array_contains(var_00 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

reset_visionset_on_disconnect(var_00) {
  self endon("changing_watching_visionset");
  var_00 waittill("disconnect");

  if(isDefined(level.vision_set_override))
    self visionsetnakedforplayer(level.vision_set_override, 0.0);
  else
    self visionsetnakedforplayer("", 0.0);
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");

  if(isDefined(level.vision_set_override))
    self visionsetnakedforplayer(level.vision_set_override, 0.0);
  else
    self visionsetnakedforplayer("", 0.0);
}

isinkillcam() {
  return self.spectatekillcam;
}

func_F6DB(var_00, var_01, var_02) {
  if(!isDefined(level.console) || !isDefined(level.func_13E0E) || !isDefined(level.func_DADC))
    func_F305();

  if(func_9BEE())
    setdvar(var_00, var_02);
  else
    setdvar(var_00, var_01);
}

func_9BEE() {
  if(level.func_13E0E || level.func_DADC || !level.console)
    return 1;
  else
    return 0;
}

createfontstring(var_00, var_01, var_02) {
  if(!isDefined(var_02) || !var_02)
    var_03 = newclienthudelem(self);
  else
    var_03 = newhudelem();

  var_3.elemtype = "font";
  var_3.font = var_00;
  var_3.fontscale = var_01;
  var_3.basefontscale = var_01;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_01);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_03 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_03;
}

setparent(var_00) {
  if(isDefined(self.parent) && self.parent == var_00) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = var_00;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("TOPLEFT");
}

removechild(var_00) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_00) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

addchild(var_00) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_00;
  removedestroyedchildren();
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  var_00 = [];

  foreach(var_03, var_02 in self.children) {
    if(!isDefined(var_02)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_02;
  }

  self.children = var_00;
}

setpoint(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = 0;

  var_05 = getparent();

  if(var_04)
    self moveovertime(var_04);

  if(!isDefined(var_02))
    var_02 = 0;

  self.xoffset = var_02;

  if(!isDefined(var_03))
    var_03 = 0;

  self.yoffset = var_03;
  self.point = var_00;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_00, "TOP"))
    self.aligny = "top";

  if(issubstr(var_00, "BOTTOM"))
    self.aligny = "bottom";

  if(issubstr(var_00, "LEFT"))
    self.alignx = "left";

  if(issubstr(var_00, "RIGHT"))
    self.alignx = "right";

  if(!isDefined(var_01))
    var_01 = var_00;

  self.relativepoint = var_01;
  var_06 = "center_adjustable";
  var_07 = "middle";

  if(issubstr(var_01, "TOP"))
    var_07 = "top_adjustable";

  if(issubstr(var_01, "BOTTOM"))
    var_07 = "bottom_adjustable";

  if(issubstr(var_01, "LEFT"))
    var_06 = "left_adjustable";

  if(issubstr(var_01, "RIGHT"))
    var_06 = "right_adjustable";

  if(var_05 == level.uiparent) {
    self.horzalign = var_06;
    self.vertalign = var_07;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_06, "_adjustable") == var_5.alignx) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_06 == "center" || var_5.alignx == "center") {
    var_08 = int(var_5.width / 2);

    if(var_06 == "left_adjustable" || var_5.alignx == "right")
      var_09 = -1;
    else
      var_09 = 1;
  } else {
    var_08 = var_5.width;

    if(var_06 == "left_adjustable")
      var_09 = -1;
    else
      var_09 = 1;
  }

  self.x = var_5.x + var_08 * var_09;

  if(strip_suffix(var_07, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_07 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_07 == "top_adjustable" || var_5.aligny == "bottom")
      var_11 = -1;
    else
      var_11 = 1;
  } else {
    var_10 = var_5.height;

    if(var_07 == "top_adjustable")
      var_11 = -1;
    else
      var_11 = 1;
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_00, var_01, var_02, var_03);
      break;
  }

  updatechildren();
}

getparent() {
  return self.parent;
}

setpointbar(var_00, var_01, var_02, var_03) {
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

updatebar(var_00, var_01) {
  if(self.elemtype == "bar")
    updatebarscale(var_00, var_01);
}

updatebarscale(var_00, var_01) {
  var_02 = int(self.width * var_00 + 0.5);

  if(!var_02)
    var_02 = 1;

  self.bar.frac = var_00;
  self.bar setshader(self.bar.shader, var_02, self.height);

  if(isDefined(var_01) && var_02 < self.width) {
    if(var_01 > 0)
      self.bar scaleovertime((1 - var_00) / var_01, self.width, self.height);
    else if(var_01 < 0)
      self.bar scaleovertime(var_00 / (-1 * var_01), 1, self.height);
  }

  self.bar.rateofchange = var_01;
  self.bar.lastupdatetime = gettime();
}

updatechildren() {
  for(var_00 = 0; var_00 < self.children.size; var_0++) {
    var_01 = self.children[var_00];
    var_01 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

createicon(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03))
    var_04 = newclienthudelem(self);
  else
    var_04 = newhudelem();

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_01;
  var_4.height = var_02;
  var_4.basewidth = var_4.width;
  var_4.baseheight = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_04 setparent(level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_00)) {
    var_04 setshader(var_00, var_01, var_02);
    var_4.shader = var_00;
  }

  return var_04;
}

destroyelem() {
  var_00 = [];

  for(var_01 = 0; var_01 < self.children.size; var_1++) {
    if(isDefined(self.children[var_01]))
      var_0[var_0.size] = self.children[var_01];
  }

  for(var_01 = 0; var_01 < var_0.size; var_1++)
    var_0[var_01] setparent(getparent());

  if(self.elemtype == "bar" || self.elemtype == "bar_shader")
    self.bar destroy();

  self destroy();
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5)
      self.alpha = 0.5;

    self.bar.hidden = 0;

    if(self.bar.alpha != 1)
      self.bar.alpha = 1;
  } else if(self.alpha != 1)
    self.alpha = 1;
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0)
    self.alpha = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0)
      self.bar.alpha = 0;
  }
}

createprimaryprogressbartext(var_00, var_01, var_02, var_03) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_00))
    var_00 = 0;

  if(!isDefined(var_01))
    var_01 = -25;

  if(self issplitscreenplayer())
    var_01 = var_01 + 20;

  var_04 = level.primaryprogressbarfontsize;
  var_05 = "default";

  if(isDefined(var_02))
    var_04 = var_02;

  if(isDefined(var_03))
    var_05 = var_03;

  var_06 = createfontstring(var_05, var_04);
  var_06 setpoint("CENTER", undefined, level.primaryprogressbartextx + var_00, level.primaryprogressbartexty + var_01);
  var_6.sort = -1;
  return var_06;
}

createprimaryprogressbar(var_00, var_01, var_02, var_03) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_00))
    var_00 = 0;

  if(!isDefined(var_01))
    var_01 = -25;

  if(self issplitscreenplayer())
    var_01 = var_01 + 20;

  if(!isDefined(var_02))
    var_02 = level.primaryprogressbarwidth;

  if(!isDefined(var_03))
    var_03 = level.primaryprogressbarheight;

  var_04 = createbar((1, 1, 1), var_02, var_03);
  var_04 setpoint("CENTER", undefined, level.primaryprogressbarx + var_00, level.primaryprogressbary + var_01);
  return var_04;
}

createbar(var_00, var_01, var_02, var_03) {
  var_04 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_00;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_04 setshader("progress_bar_fill", var_01, var_02);
  var_4.hidden = 0;

  if(isDefined(var_03))
    var_4.flashfrac = var_03;

  var_05 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_01;
  var_5.height = var_02;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_04;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_05 setparent(level.uiparent);
  var_05 setshader("progress_bar_bg", var_01 + 4, var_02 + 4);
  var_5.hidden = 0;
  return var_05;
}

isgameparticipant(var_00) {
  if(isaigameparticipant(var_00))
    return 1;

  if(isplayer(var_00))
    return 1;

  return 0;
}

isaigameparticipant(var_00) {
  if(isagent(var_00) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1)
    return 1;

  if(isbot(var_00))
    return 1;

  return 0;
}

setteamheadicon(var_00, var_01) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_02 = game["entity_headicon_" + var_00];
  self.entityheadiconteam = var_00;

  if(isDefined(var_01))
    self.entityheadiconoffset = var_01;
  else
    self.entityheadiconoffset = (0, 0, 0);

  self notify("kill_entity_headicon_thread");

  if(var_00 == "none") {
    if(isDefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_03 = newteamhudelem(var_00);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.z = self.origin[2] + self.entityheadiconoffset[2];
  var_3.alpha = 0.8;
  var_03 setshader(var_02, 10, 10);
  var_03 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_03;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(var_00, var_01) {
  if(level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(var_00)) {
    if(isDefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_02 = var_0.team;
  self.entityheadiconteam = var_02;

  if(isDefined(var_01))
    self.entityheadiconoffset = var_01;
  else
    self.entityheadiconoffset = (0, 0, 0);

  var_03 = game["entity_headicon_" + var_02];
  var_04 = newclienthudelem(var_00);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.z = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_04 setshader(var_03, 10, 10);
  var_04 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_04;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

keepiconpositioned() {
  self.entityheadicon gettweakabledvarvalue(self, self.entityheadiconoffset);
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

setheadicon(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(isgameparticipant(var_00) && !isplayer(var_00)) {
    return;
  }
  if(!isDefined(self.entityheadicons))
    self.entityheadicons = [];

  if(!isDefined(var_05))
    var_05 = 1;

  if(!isDefined(var_06))
    var_06 = 0.05;

  if(!isDefined(var_07))
    var_07 = 1;

  if(!isDefined(var_08))
    var_08 = 1;

  if(!isDefined(var_09))
    var_09 = 0;

  if(!isDefined(var_10))
    var_10 = 1;

  if(!isplayer(var_00) && var_00 == "none") {
    foreach(var_13, var_12 in self.entityheadicons) {
      if(isDefined(var_12))
        var_12 destroy();

      self.entityheadicons[var_13] = undefined;
    }
  } else {
    if(isplayer(var_00)) {
      if(isDefined(self.entityheadicons[var_0.guid])) {
        self.entityheadicons[var_0.guid] destroy();
        self.entityheadicons[var_0.guid] = undefined;
      }

      if(var_01 == "") {
        return;
      }
      if(isDefined(var_0.team)) {
        if(isDefined(self.entityheadicons[var_0.team])) {
          self.entityheadicons[var_0.team] destroy();
          self.entityheadicons[var_0.team] = undefined;
        }
      }

      var_12 = newclienthudelem(var_00);
      self.entityheadicons[var_0.guid] = var_12;
    } else {
      if(isDefined(self.entityheadicons[var_00])) {
        self.entityheadicons[var_00] destroy();
        self.entityheadicons[var_00] = undefined;
      }

      if(var_01 == "") {
        return;
      }
      foreach(var_13, var_15 in self.entityheadicons) {
        if(var_13 == "axis" || var_13 == "allies") {
          continue;
        }
        var_16 = getplayerforguid(var_13);

        if(var_16.team == var_00) {
          self.entityheadicons[var_13] destroy();
          self.entityheadicons[var_13] = undefined;
        }
      }

      var_12 = newteamhudelem(var_00);
      self.entityheadicons[var_00] = var_12;
    }

    if(!isDefined(var_03) || !isDefined(var_04)) {
      var_03 = 10;
      var_04 = 10;
    }

    var_12.archived = var_05;
    var_12.x = self.origin[0] + var_2[0];
    var_12.y = self.origin[1] + var_2[1];
    var_12.z = self.origin[2] + var_2[2];
    var_12.alpha = 0.85;
    var_12 setshader(var_01, var_03, var_04);
    var_12 setwaypoint(var_07, var_08, var_09, var_10);
    var_12 thread keeppositioned(self, var_02, var_06);
    thread destroyiconsondeath();

    if(isplayer(var_00))
      var_12 thread destroyonownerdisconnect(var_00);

    if(isplayer(self))
      var_12 thread destroyonownerdisconnect(self);
  }
}

showheadicon(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      var_2.alpha = 0.85;
  }
}

hideheadicon(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      var_2.alpha = 0;
  }
}

getplayerforguid(var_00) {
  foreach(var_02 in level.players) {
    if(var_2.guid == var_00)
      return var_02;
  }

  return undefined;
}

keeppositioned(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_03 = isDefined(var_0.classname) && !isownercarepakage(var_00);

  if(var_03)
    self gettweakabledvarvalue(var_00, var_01);

  for(;;) {
    if(!isDefined(var_00)) {
      return;
    }
    if(!var_03) {
      var_04 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.z = var_4[2] + var_1[2];
    }

    if(var_02 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_02);
      self.alpha = 0;
    }

    wait(var_02);
  }
}

isownercarepakage(var_00) {
  return isDefined(var_0.targetname) && var_0.targetname == "care_package";
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  if(!isDefined(self.entityheadicons)) {
    return;
  }
  foreach(var_02, var_01 in self.entityheadicons) {
    if(!isDefined(var_01)) {
      continue;
    }
    var_01 destroy();
  }
}

destroyonownerdisconnect(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self destroy();
}

_suicide() {
  if(!isusingremote() && !isDefined(self.fauxdeath))
    self suicide();
}

player_lua_progressbar(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = lua_progress_bar_think(var_00, var_01, var_02, var_03, var_04, var_05);
  return var_06;
}

lua_progress_bar_think(var_00, var_01, var_02, var_03, var_04, var_05) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = var_01;
  var_00 thread create_lua_progress_bar(self, var_03);
  var_0.hasprogressbar = 1;
  var_06 = lua_progress_bar_think_loop(var_00, self, var_02, var_04, var_05);

  if(isalive(var_00))
    var_0.hasprogressbar = 0;

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return var_06;
}

create_lua_progress_bar(var_00, var_01) {
  self endon("disconnect");
  self setclientomnvar("ui_securing", var_01);
  var_02 = -1;

  while(isreallyalive(self) && isDefined(var_00) && var_0.inuse && !level.gameended) {
    if(var_02 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime)
        var_0.curprogress = var_0.usetime;
    }

    var_02 = var_0.userate;
    self setclientomnvar("ui_securing_progress", var_0.curprogress / var_0.usetime);
    wait 0.05;
  }

  wait 0.5;
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_securing", 0);
}

lua_progress_bar_think_loop(var_00, var_01, var_02, var_03, var_04) {
  while(!level.gameended && isDefined(self) && isreallyalive(var_00) && (var_00 usebuttonpressed() || isDefined(var_03) || var_00 attackbuttonpressed() && isDefined(var_04)) && should_continue_progress_bar_think(var_00)) {
    wait 0.05;

    if(isDefined(var_01) && isDefined(var_02)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_02)
        return 0;
    }

    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      var_00 setclientomnvar("ui_securing_progress", 1);
      return isreallyalive(var_00);
    }
  }

  return 0;
}

should_continue_progress_bar_think(var_00) {
  if(isDefined(level.should_continue_progress_bar_think))
    return [[level.should_continue_progress_bar_think]](var_00);
  else if(scripts\engine\utility::is_true(var_0.in_afterlife_arcade))
    return 1;
  else
    return !scripts\cp\cp_laststand::player_in_laststand(var_00);
}

isplayingsolo() {
  if(getmaxclients() == 1)
    return 1;

  return 0;
}

removefromparticipantsarray() {
  var_00 = 0;

  for(var_01 = 0; var_01 < level.participants.size; var_1++) {
    if(level.participants[var_01] == self) {
      for(var_00 = 1; var_01 < level.participants.size - 1; var_1++)
        level.participants[var_01] = level.participants[var_01 + 1];

      level.participants[var_01] = undefined;
      break;
    }
  }
}

removefromcharactersarray() {
  var_00 = 0;

  for(var_01 = 0; var_01 < level.characters.size; var_1++) {
    if(level.characters[var_01] == self) {
      for(var_00 = 1; var_01 < level.characters.size - 1; var_1++)
        level.characters[var_01] = level.characters[var_01 + 1];

      level.characters[var_01] = undefined;
      break;
    }
  }
}

removefromspawnedgrouparray() {
  if(isDefined(self.group_name)) {
    if(isDefined(level.spawned_group) && isDefined(level.spawned_group[self.group_name]))
      level.spawned_group[self.group_name] = scripts\engine\utility::array_remove(level.spawned_group[self.group_name], self);
  }
}

createtimer(var_00, var_01) {
  var_02 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.basefontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_02;
}

_detachall() {
  self detachall();
}

is_valid_perk(var_00) {
  var_01 = getarraykeys(level.alien_perks["perk_0"]);

  if(scripts\engine\utility::array_contains(var_01, var_00))
    return 1;

  var_02 = getarraykeys(level.alien_perks["perk_1"]);

  if(scripts\engine\utility::array_contains(var_02, var_00))
    return 1;

  var_03 = getarraykeys(level.alien_perks["perk_2"]);
  return scripts\engine\utility::array_contains(var_03, var_00);
}

is_consumable_active(var_00) {
  if(isDefined(self.consumables) && isDefined(self.consumables[var_00]) && isDefined(self.consumables[var_00].on) && self.consumables[var_00].on == 1)
    return 1;
  else
    return 0;
}

notify_used_consumable(var_00) {
  self notify(self.consumables[var_00].usednotify);
}

notify_timeup_consumable(var_00) {
  self notify(level.consumables[var_00].timeupnotify);
}

drawline(var_00, var_01, var_02, var_03) {
  var_04 = int(var_02 * 20);

  for(var_05 = 0; var_05 < var_04; var_5++)
    wait 0.05;
}

is_upgrade_enabled(var_00) {
  if(!is_using_extinction_tokens())
    return 0;

  if(self getrankedplayerdata("cp", "upgrades_enabled_flags", var_00))
    return 1;
  else
    return 0;
}

allow_player_teleport(var_00, var_01) {
  if(var_00) {
    if(!isDefined(self.teleportdisableflags) && isDefined(var_01)) {
      foreach(var_03 in self.teleportdisableflags) {
        if(var_03 == var_01)
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, var_01);
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

    if(isDefined(var_01))
      self.teleportdisableflags[self.teleportdisableflags.size] = var_01;

    self.disabledteleportation++;
    self.can_teleport = 0;
  }
}

ismeleeenabled() {
  return !isDefined(self.disabledmelee) || !self.disabledmelee;
}

isteleportenabled() {
  return !isDefined(self.disabledteleportation) || !self.disabledteleportation;
}

allow_player_interactions(var_00) {
  if(var_00) {
    self.disabledinteractions--;

    if(!self.disabledinteractions)
      self.interactions_disabled = undefined;
  } else {
    self.disabledinteractions++;
    self.interactions_disabled = 1;
  }
}

areinteractionsenabled() {
  return self.disabledinteractions < 1;
}

_linkto(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_02))
    var_02 = "tag_origin";

  if(!isDefined(var_03))
    var_03 = (0, 0, 0);

  if(!isDefined(var_04))
    var_04 = (0, 0, 0);

  if(!isDefined(self.playerlinkedcounter))
    self.playerlinkedcounter = 0;

  self.playerlinkedcounter++;

  if(self.playerlinkedcounter == 1)
    self linkto(var_01, var_02, var_03, var_04);
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

enable_infinite_ammo(var_00) {
  if(var_00) {
    self.infiniteammocounter++;
    self setclientomnvar("zm_ui_unlimited_ammo", 1);
  } else {
    if(self.infiniteammocounter > 0)
      self.infiniteammocounter--;

    if(!self.infiniteammocounter)
      self setclientomnvar("zm_ui_unlimited_ammo", 0);
  }
}

isinfiniteammoenabled() {
  return self.infiniteammocounter >= 1;
}

allow_player_ignore_me(var_00) {
  if(var_00) {
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
  self.disabledusability = 0;
  self enableusability();
}

is_using_extinction_tokens() {
  return 0;

  if(getdvarint("extinction_tokens_enabled") > 0)
    return 1;

  return 0;
}

coop_getweaponclass(var_00) {
  if(!isDefined(var_00) || isDefined(var_00) && var_00 == "none")
    return "none";

  var_01 = getbaseweaponname(var_00);
  var_02 = tablelookup(level.statstable, 4, var_01, 1);

  if(var_02 == "" && isDefined(level.game_mode_statstable)) {
    if(isDefined(var_00)) {
      var_01 = getbaseweaponname(var_00);
      var_02 = tablelookup(level.game_mode_statstable, 4, var_01, 2);
    }
  }

  if(isenvironmentweapon(var_00))
    var_02 = "weapon_mg";
  else if(var_00 == "none")
    var_02 = "other";
  else if(var_02 == "")
    var_02 = "other";

  return var_02;
}

is_holding_deployable() {
  return self.is_holding_deployable;
}

has_special_weapon() {
  return self.has_special_weapon;
}

filloffhandweapons(var_00, var_01) {
  var_02 = self getweaponslistall();
  var_03 = 0;
  var_04 = undefined;
  var_05 = 0;

  foreach(var_07 in var_02) {
    if(var_07 != var_00) {
      if(var_07 != "none" && var_07 != "alienthrowingknife_mp" && var_07 != "alientrophy_mp" && var_07 != "iw6_aliendlc21_mp")
        self giveuponsuppressiontime(var_07);

      continue;
    }

    if(isDefined(var_07) && var_07 != "none") {
      var_05 = self getammocount(var_07);
      self setweaponammostock(var_07, var_05 + var_01);
      var_03 = 1;
      break;
    }
  }

  if(var_03 == 0) {
    _giveweapon(var_00);
    self setweaponammostock(var_00, var_01);
  }
}

getequipmenttype(var_00) {
  switch (var_00) {
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
      var_01 = "lethal";
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
      var_01 = "tactical";
      break;
    default:
      var_01 = undefined;
      break;
  }

  return var_01;
}

giveperkoffhand(var_00) {
  if(var_00 == "none" || var_00 == "specialty_null")
    self give_player_xp("none");
  else {
    self.secondarygrenade = var_00;

    if(issubstr(var_00, "_mp")) {
      switch (var_00) {
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

      _giveweapon(var_00, 0);

      switch (var_00) {
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
          self setweaponammoclip(var_00, 1);
          break;
        default:
          self givestartammo(var_00);
          break;
      }

      _setperk(var_00);
      return;
    }

    _setperk(var_00);
  }
}

_launchgrenade(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = self launchgrenade(var_00, var_01, var_02, var_03, var_05);

  if(!isDefined(var_04))
    var_6.notthrown = 1;
  else
    var_6.notthrown = var_04;

  var_06 setotherent(self);
  return var_06;
}

blockperkfunction(var_00) {
  if(!isDefined(self.perksblocked[var_00]))
    self.perksblocked[var_00] = 1;
  else
    self.perksblocked[var_00]++;

  if(self.perksblocked[var_00] == 1 && _hasperk(var_00)) {
    foreach(var_06, var_02 in level.extraperkmap) {
      if(var_00 == var_06) {
        foreach(var_04 in var_02) {
          if(!isDefined(self.perksblocked[var_04]))
            self.perksblocked[var_04] = 1;
          else
            self.perksblocked[var_04]++;

          if(self.perksblocked[var_04] == 1) {}
        }

        break;
      }
    }
  }
}

unblockperkfunction(var_00) {
  self.perksblocked[var_00]--;

  if(self.perksblocked[var_00] == 0) {
    self.perksblocked[var_00] = undefined;

    if(_hasperk(var_00)) {
      foreach(var_06, var_02 in level.extraperkmap) {
        if(var_00 == var_06) {
          foreach(var_04 in var_02) {
            self.perksblocked[var_04]--;

            if(self.perksblocked[var_04] == 0)
              self.perksblocked[var_04] = undefined;
          }

          break;
        }
      }
    }
  }
}

getweaponclass(var_00) {
  var_01 = getbaseweaponname(var_00);
  var_02 = level.statstable;
  var_03 = tablelookup(var_02, 4, var_01, 1);

  if(var_03 == "") {
    var_04 = strip_suffix(var_00, "_zm");
    var_03 = tablelookup(var_02, 4, var_04, 1);
  }

  if(var_03 == "" && isDefined(level.game_mode_statstable)) {
    var_04 = strip_suffix(var_00, "_zm");
    var_03 = tablelookup(level.game_mode_statstable, 4, var_04, 1);
  }

  if(isenvironmentweapon(var_00))
    var_03 = "weapon_mg";
  else if(iskillstreakweapon(var_00))
    var_03 = "killstreak";
  else if(issuperweapon(var_00))
    var_03 = "super";
  else if(var_00 == "none")
    var_03 = "other";
  else if(var_03 == "")
    var_03 = "other";

  return var_03;
}

removedamagemodifier(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 1;

  if(var_01) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[var_00] = undefined;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[var_00] = undefined;
  }
}

adddamagemodifier(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 1;

  if(var_02) {
    if(!isDefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[var_00] = var_01;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[var_00] = var_01;
  }
}

getdamagemodifiertotal() {
  var_00 = 1.0;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_02 in self.additivedamagemodifiers)
    var_00 = var_00 + (var_02 - 1.0);
  }

  var_04 = 1.0;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_02 in self.multiplicativedamagemodifiers)
    var_04 = var_04 * var_02;
  }

  return var_00 * var_04;
}

isinventoryprimaryweapon(var_00) {
  switch (weaponinventorytype(var_00)) {
    case "altmode":
    case "primary":
      return 1;
    default:
      return 0;
  }
}

_enablecollisionnotifies(var_00) {
  if(!isDefined(self.enabledcollisionnotifies))
    self.enabledcollisionnotifies = 0;

  if(var_00) {
    if(self.enabledcollisionnotifies == 0)
      self enablecollisionnotifies(1);

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1)
      self enablecollisionnotifies(0);

    self.enabledcollisionnotifies--;
  }
}

has_tag(var_00, var_01) {
  if(!isDefined(var_00))
    return 0;

  var_02 = _getnumparts(var_00);

  for(var_03 = 0; var_03 < var_02; var_3++) {
    if(tolower(_getpartname(var_00, var_03)) == tolower(var_01))
      return 1;
  }

  return 0;
}

is_trap(var_00, var_01) {
  if(isDefined(var_01) && (var_01 == "iw7_beamtrap_zm" || var_01 == "iw7_escapevelocity_zm" || var_01 == "iw7_rockettrap_zm" || var_01 == "iw7_discotrap_zm" || var_01 == "iw7_chromosphere_zm" || var_01 == "iw7_buffertrap_zm" || var_01 == "iw7_electrictrap_zm" || var_01 == "iw7_fantrap_zm" || var_01 == "iw7_hydranttrap_zm" || var_01 == "iw7_moshtrap_zm"))
    return 1;

  if(!isDefined(var_00))
    return 0;

  if(isDefined(var_0.tesla_type))
    return 1;

  if(!isDefined(var_0.script_noteworthy) && !isDefined(var_0.targetname))
    return 0;

  if(isDefined(var_0.targetname) && (var_0.targetname == "fence_generator" || var_0.targetname == "puddle_generator"))
    return 1;

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "fire_trap")
    return 1;

  return 0;
}

riotshieldname() {
  var_00 = self getweaponslist("primary");

  if(!self.hasriotshield) {
    return;
  }
  foreach(var_02 in var_00) {
    if(weapontype(var_02) == "riotshield")
      return var_02;
  }
}

player_has_special_ammo(var_00, var_01) {
  return isDefined(var_0.special_ammo_type) && var_0.special_ammo_type == var_01;
}

has_stun_ammo(var_00) {
  if(isDefined(self.special_ammo_type))
    return player_has_special_ammo(self, "stun_ammo");

  if(!isDefined(var_00))
    var_01 = self getcurrentweapon();
  else
    var_01 = var_00;

  if(var_01 == "none")
    var_01 = self getweaponslistprimaries()[0];

  var_02 = getrawbaseweaponname(var_01);

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_02]) && self.special_ammocount[var_02] > 0)
    return 1;

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[var_02]) && self.special_ammocount_comb[var_02] > 0)
    return 1;

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

isriotshield(var_00) {
  if(var_00 == "none")
    return 0;

  return weapontype(var_00) == "riotshield";
}

isaltmodeweapon(var_00) {
  if(!isDefined(var_00) || var_00 == "none")
    return 0;

  return weaponinventorytype(var_00) == "altmode";
}

hasriotshield() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(isriotshield(var_03)) {
      var_00 = 1;
      break;
    }
  }

  return var_00;
}

is_empty_string(var_00) {
  return var_00 == "";
}

func_F225(var_00, var_01) {
  if(isDefined(var_01))
    self notify(var_00, var_01);
  else
    self notify(var_00);
}

notifyafterframeend(var_00, var_01) {
  self waittill(var_00);
  waittillframeend;
  self notify(var_01);
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

isheadshot(var_00, var_01, var_02, var_03) {
  if(isDefined(var_03)) {
    if(isDefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle")
        return 0;

      if(var_3.code_classname == "misc_turret")
        return 0;

      if(var_3.code_classname == "script_model")
        return 0;
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien")
        return 0;
    }
  }

  return (var_01 == "head" || var_01 == "helmet" || var_01 == "neck") && var_02 != "MOD_MELEE" && var_02 != "MOD_IMPACT" && var_02 != "MOD_SCARAB" && var_02 != "MOD_CRUSH" && !isenvironmentweapon(var_00);
}

getteamarray(var_00, var_01) {
  var_02 = [];

  if(!isDefined(var_01) || var_01) {
    foreach(var_04 in level.characters) {
      if(var_4.team == var_00)
        var_2[var_2.size] = var_04;
    }
  } else {
    foreach(var_04 in level.players) {
      if(var_4.team == var_00)
        var_2[var_2.size] = var_04;
    }
  }

  return var_02;
}

getotherteam(var_00) {
  if(level.multiteambased) {}

  if(var_00 == "allies")
    return "axis";
  else if(var_00 == "axis")
    return "allies";
  else
    return "none";
}

waittill_any_ents_return(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  self endon("death");
  var_14 = spawnStruct();
  var_00 childthread scripts\engine\utility::waittill_string(var_01, var_14);

  if(isDefined(var_02) && isDefined(var_03))
    var_02 childthread scripts\engine\utility::waittill_string(var_03, var_14);

  if(isDefined(var_04) && isDefined(var_05))
    var_04 childthread scripts\engine\utility::waittill_string(var_05, var_14);

  if(isDefined(var_06) && isDefined(var_07))
    var_06 childthread scripts\engine\utility::waittill_string(var_07, var_14);

  if(isDefined(var_08) && isDefined(var_09))
    var_08 childthread scripts\engine\utility::waittill_string(var_09, var_14);

  if(isDefined(var_10) && isDefined(var_11))
    var_10 childthread scripts\engine\utility::waittill_string(var_11, var_14);

  if(isDefined(var_12) && isDefined(var_13))
    var_12 childthread scripts\engine\utility::waittill_string(var_13, var_14);

  var_14 waittill("returned", var_15);
  var_14 notify("die");
  return var_15;
}

waittill_any_ents_or_timeout_return(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14) {
  self endon("death");
  var_15 = spawnStruct();
  var_01 childthread scripts\engine\utility::waittill_string(var_02, var_15);

  if(isDefined(var_03) && isDefined(var_04))
    var_03 childthread scripts\engine\utility::waittill_string(var_04, var_15);

  if(isDefined(var_05) && isDefined(var_06))
    var_05 childthread scripts\engine\utility::waittill_string(var_06, var_15);

  if(isDefined(var_07) && isDefined(var_08))
    var_07 childthread scripts\engine\utility::waittill_string(var_08, var_15);

  if(isDefined(var_09) && isDefined(var_10))
    var_09 childthread scripts\engine\utility::waittill_string(var_10, var_15);

  if(isDefined(var_11) && isDefined(var_12))
    var_11 childthread scripts\engine\utility::waittill_string(var_12, var_15);

  if(isDefined(var_13) && isDefined(var_14))
    var_13 childthread scripts\engine\utility::waittill_string(var_14, var_15);

  var_15 childthread scripts\engine\utility::_timeout(var_00);
  var_15 waittill("returned", var_16);
  var_15 notify("die");
  return var_16;
}

player_black_screen(var_00, var_01, var_02, var_03) {
  self endon("disconnect");
  self endon("intermission");
  self endon("death");
  self.player_black_screen = newclienthudelem(self);
  self.player_black_screen.x = 0;
  self.player_black_screen.y = 0;
  self.player_black_screen setshader("black", 640, 480);
  self.player_black_screen.alignx = "left";
  self.player_black_screen.aligny = "top";
  self.player_black_screen.sort = 1;
  self.player_black_screen.horzalign = "fullscreen";
  self.player_black_screen.vertalign = "fullscreen";
  self.player_black_screen.alpha = 0;
  self.player_black_screen.foreground = 1;

  if(!scripts\engine\utility::is_true(var_03))
    self.player_black_screen fadeovertime(var_00);

  self.player_black_screen.alpha = 1;

  if(!scripts\engine\utility::is_true(var_03))
    wait(var_00 + 0.05);

  wait(var_01);
  self.player_black_screen fadeovertime(var_02);
  self.player_black_screen.alpha = 0;
  wait(var_02 + 0.05);
  self.player_black_screen destroy();
}

riotshield_hasweapon() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(isriotshield(var_03)) {
      var_00 = 1;
      break;
    }
  }

  return var_00;
}

riotshield_attach(var_00, var_01) {
  var_02 = undefined;

  if(var_00) {
    self.riotshieldmodel = var_01;
    var_02 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var_01;
    var_02 = "tag_shield_back";
  }

  self attachshieldmodel(var_01, var_02);
  self.hasriotshield = riotshield_hasweapon();
}

launchshield(var_00, var_01) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    if(isDefined(self.riotshieldmodel))
      riotshield_detach(1);
    else if(isDefined(self.riotshieldmodelstowed))
      riotshield_detach(0);
  }
}

riotshield_detach(var_00) {
  var_01 = undefined;
  var_02 = undefined;

  if(var_00) {
    var_01 = self.riotshieldmodel;
    var_02 = "tag_weapon_right";
  } else {
    var_01 = self.riotshieldmodelstowed;
    var_02 = "tag_shield_back";
  }

  self detachshieldmodel(var_01, var_02);

  if(var_00)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(var_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;

  if(var_00) {
    var_03 = self.riotshieldmodel;
    var_01 = "tag_weapon_right";
    var_02 = "tag_shield_back";
  } else {
    var_03 = self.riotshieldmodelstowed;
    var_01 = "tag_shield_back";
    var_02 = "tag_weapon_right";
  }

  self moveshieldmodel(var_03, var_01, var_02);

  if(var_00) {
    self.riotshieldmodelstowed = var_03;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = var_03;
    self.riotshieldmodelstowed = undefined;
  }
}

riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

remove_crafting_item() {
  self setclientomnvar("zombie_souvenir_piece_index", 0);

  if(isDefined(level.crafting_remove_func))
    self[[level.crafting_remove_func]]();

  self.current_crafting_struct = undefined;
}

store_weapons_status(var_00, var_01) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, var_01);
  self.copy_weapon_level = [];
  var_02 = [];

  foreach(var_04 in self.copy_fullweaponlist) {
    if(!isstrstart(var_04, "alt_"))
      var_2[var_2.size] = var_04;
  }

  self.copy_fullweaponlist = var_02;

  foreach(var_04 in self.copy_fullweaponlist) {
    self.copy_weapon_ammo_clip[var_04] = self getweaponammoclip(var_04);
    self.copy_weapon_ammo_stock[var_04] = self getweaponammostock(var_04);

    if(issubstr(var_04, "akimbo"))
      self.copy_weapon_ammo_clip_left[var_04] = self getweaponammoclip(var_04, "left");

    if(isDefined(self.pap[getrawbaseweaponname(var_04)]))
      self.copy_weapon_level[var_04] = self.pap[getrawbaseweaponname(var_04)].lvl;
  }

  if(isDefined(var_00)) {
    var_08 = [];

    foreach(var_04 in self.copy_fullweaponlist) {
      var_10 = 0;

      foreach(var_12 in var_00) {
        if(var_04 == var_12) {
          var_10 = 1;
          break;
        } else if(getweaponbasename(var_04) == var_12) {
          var_10 = 1;
          break;
        }
      }

      if(var_10) {
        continue;
      }
      var_8[var_8.size] = var_04;
    }

    self.copy_fullweaponlist = var_08;

    foreach(var_12 in var_00) {
      if(self.copy_weapon_current == var_12) {
        self.copy_weapon_current = "none";
        break;
      }
    }
  }
}

get_current_weapon(var_00, var_01) {
  var_02 = var_00 getcurrentweapon();

  if(scripts\engine\utility::is_true(var_01) && is_melee_weapon(var_02))
    var_02 = var_00 getweaponslistall()[1];

  return var_02;
}

is_melee_weapon(var_00, var_01) {
  switch (var_00) {
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
      if(scripts\engine\utility::is_true(var_01))
        return 0;
      else
        return 1;
    default:
      return 0;
  }
}

is_primary_melee_weapon(var_00) {
  switch (var_00) {
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

restore_weapons_status(var_00) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  var_01 = self getweaponslistall();

  foreach(var_03 in var_01) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_03) && !in_inclusion_list(var_00, var_03))
      self giveuponsuppressiontime(var_03);
  }

  foreach(var_03 in self.copy_fullweaponlist) {
    if(!self hasweapon(var_03))
      self giveweapon(var_03, -1, 0, -1, 1);

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_03)
      self assignweaponoffhandprimary(var_03);

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_03)
      self assignweaponoffhandsecondary(var_03);

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_03)
      self assignweaponoffhandspecial(var_03);

    if(isDefined(self.copy_weapon_ammo_clip[var_03]))
      self setweaponammoclip(var_03, self.copy_weapon_ammo_clip[var_03]);

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[var_03]))
        self setweaponammoclip(var_03, self.copy_weapon_ammo_clip_left[var_03], "left");
    }

    if(isDefined(self.copy_weapon_ammo_stock[var_03]))
      self setweaponammostock(var_03, self.copy_weapon_ammo_stock[var_03]);

    if(isDefined(self.copy_weapon_level[var_03])) {
      var_06 = spawnStruct();
      var_6.lvl = self.copy_weapon_level[var_03];
      self.pap[getrawbaseweaponname(var_03)] = var_06;
    }
  }

  var_08 = self.copy_weapon_current;

  if(!isDefined(var_08) || var_08 == "none") {
    foreach(var_10 in self.copy_fullweaponlist) {
      if(scripts\cp\cp_weapon::isbulletweapon(var_10)) {
        var_08 = var_10;
        break;
      }
    }
  }

  if(scripts\engine\utility::isweaponswitchallowed())
    self switchtoweaponimmediate(var_08);

  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
  self.copy_weapon_ammo_clip_left = undefined;

  if(isDefined(level.arcade_last_stand_power_func))
    self[[level.arcade_last_stand_power_func]]();
}

restore_primary_weapons_only(var_00) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  var_01 = 0;

  foreach(var_03 in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(var_03)) {
      self.primary_weapons[var_01] = var_03;
      var_01 = var_01 + 1;
    }
  }

  var_05 = 0;

  foreach(var_03 in self.primary_weapons) {
    if(var_05 < 3) {
      if(isstrstart(var_03, "alt_")) {
        continue;
      }
      if(!self hasweapon(var_03))
        self giveweapon(var_03, -1, 0, -1, 1);

      self setweaponammoclip(var_03, self.copy_weapon_ammo_clip[var_03]);
      self setweaponammostock(var_03, self.copy_weapon_ammo_stock[var_03]);

      if(isDefined(self.copy_weapon_level[var_03])) {
        var_07 = spawnStruct();
        var_7.lvl = self.copy_weapon_level[var_03];
        self.pap[getrawbaseweaponname(var_03)] = var_07;
      }

      var_5++;
    }
  }

  var_09 = self.copy_weapon_current;

  if(!isDefined(var_09) || !self hasweapon(var_09) || var_09 == "none")
    var_09 = getweapontoswitchbackto();

  self switchtoweaponimmediate(var_09);
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

add_to_weapons_status(var_00, var_01, var_02, var_03) {
  foreach(var_05 in var_00) {
    self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_05;
    self.copy_weapon_ammo_clip[var_05] = var_1[var_05];
    self.copy_weapon_ammo_stock[var_05] = var_2[var_05];
  }

  self.copy_weapon_current = var_03;
}

in_inclusion_list(var_00, var_01) {
  if(!isDefined(var_00))
    return 0;

  return scripts\engine\utility::array_contains(var_00, var_01);
}

vec_multiply(var_00, var_01) {
  return (var_0[0] * var_01, var_0[1] * var_01, var_0[2] * var_01);
}

restore_super_weapon() {
  self giveweapon("super_default_zm");
  self assignweaponoffhandspecial("super_default_zm");
  self.specialoffhandgrenade = "super_default_zm";

  if(scripts\engine\utility::is_true(self.consumable_meter_full))
    self setweaponammoclip("super_default_zm", 1);
}

is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && (self.species == "humanoid" || self.species == "zombie");
}

is_zombies_mode() {
  return level.gametype == "zombie";
}

coop_mode_has(var_00) {
  if(!isDefined(level.coop_mode_feature))
    return 0;

  return isDefined(level.coop_mode_feature[var_00]);
}

coop_mode_enable(var_00) {
  if(!isDefined(level.coop_mode_feature))
    level.coop_mode_feature = [];

  foreach(var_02 in var_00)
  level.coop_mode_feature[var_02] = 1;
}

make_entity_sentient_cp(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 1;

  if(var_01)
    return self makeentitysentient(var_00, 1);
  else
    return self makeentitysentient(var_00);
}

get_attacker_as_player(var_00) {
  if(isDefined(var_00)) {
    if(isplayer(var_00))
      return var_00;

    if(isDefined(var_0.owner) && isplayer(var_0.owner))
      return var_0.owner;
  }

  return undefined;
}

removeexcludedattachments(var_00) {
  if(isDefined(level.excludedattachments)) {
    foreach(var_02 in level.excludedattachments) {
      foreach(var_04 in var_00) {
        if(attachmentmap_tobase(var_04) == var_02)
          var_00 = scripts\engine\utility::array_remove(var_00, var_04);
      }
    }
  }

  return var_00;
}

getrandomweaponattachments(var_00, var_01, var_02) {
  var_03 = [];

  if(weaponhaspassive(var_00, var_01, "passive_random_attachments")) {
    if(0) {
      var_04 = getavailableattachments(var_00, var_02, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_05 = int(max(0, 5 - var_2.size));

      if(var_05 > 0) {
        var_06 = randomintrange(1, var_05 + 1);
        var_03 = buildrandomattachmentarray(var_00, var_06, var_02);
      }
    }
  }

  return var_03;
}

weaponhaspassive(var_00, var_01, var_02) {
  var_03 = getweaponpassives(var_00, var_01);

  if(!isDefined(var_03) || var_3.size <= 0)
    return 0;

  foreach(var_05 in var_03) {
    if(var_02 == var_05)
      return 1;
  }

  return 0;
}

buildrandomattachmentarray(var_00, var_01, var_02) {
  var_03 = [];
  var_04 = scripts\cp\cp_weapon::getattachmenttypeslist(var_00, var_02);

  if(var_4.size > 0) {
    var_03 = [];
    var_05 = scripts\engine\utility::array_randomize_objects(var_04);

    foreach(var_10, var_07 in var_05) {
      if(var_01 <= 0) {
        break;
      }
      var_08 = 1;

      switch (var_10) {
        case "undermount":
        case "barrel":
          var_08 = 1;
          break;
        case "rail":
        case "pap":
        case "perk":
          var_08 = 0;
          break;
        default:
          var_08 = randomintrange(1, var_01 + 1);
          break;
      }

      if(var_08 > 0) {
        if(var_08 > var_7.size)
          var_08 = var_7.size;

        var_01 = var_01 - var_08;

        for(var_07 = scripts\engine\utility::array_randomize_objects(var_07); var_08 > 0; var_8--) {
          var_09 = var_7[var_7.size - var_08];

          if(!issubstr(var_09, "ark") && !issubstr(var_09, "arcane"))
            var_3[var_3.size] = var_09;
        }
      }
    }
  }

  return var_03;
}

getavailableattachments(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 1;

  var_03 = getweaponattachmentarrayfromstats(var_00);
  var_04 = [];

  foreach(var_06 in var_03) {
    var_07 = getattachmenttype(var_06);

    if(!var_02 && var_07 == "rail") {
      continue;
    }
    if(isDefined(var_01) && listhasattachment(var_01, var_06)) {
      continue;
    }
    var_4[var_4.size] = var_06;
  }

  return var_04;
}

listhasattachment(var_00, var_01) {
  foreach(var_03 in var_00) {
    if(var_03 == var_01)
      return 1;
  }

  return 0;
}

getweaponattachmentarrayfromstats(var_00) {
  var_00 = getweaponrootname(var_00);

  if(!isDefined(level.weaponattachments))
    level.weaponattachments = [];

  if(!isDefined(level.weaponattachments[var_00])) {
    var_01 = [];

    for(var_02 = 0; var_02 <= 19; var_2++) {
      var_03 = tablelookup("mp\statsTable.csv", 4, var_00, 10 + var_02);

      if(var_03 == "") {
        break;
      }
      var_1[var_1.size] = var_03;
    }

    level.weaponattachments[var_00] = var_01;
  }

  return level.weaponattachments[var_00];
}

getweaponpaintjobid(var_00) {
  return -1;
}

getweaponcamo(var_00) {
  var_01 = self getrankedplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_00, "camo");

  if(isDefined(var_01) && var_01 != "none")
    return var_01;
  else
    return "none";
}

getweaponcosmeticattachment(var_00) {
  var_01 = self getrankedplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_00, "cosmeticAttachment");

  if(isDefined(var_01) && var_01 != "none")
    return var_01;
  else
    return "none";
}

getweaponreticle(var_00) {
  var_01 = self getrankedplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_00, "reticle");

  if(isDefined(var_01) && var_01 != "none")
    return var_01;
  else
    return "none";
}

mpbuildweaponname(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = weaponattachdefaultmap(var_00);
  var_10 = buildweaponassetname(var_00, var_04);

  if(isDefined(var_04) && var_04 >= 0) {
    var_11 = getrandomweaponattachments(var_10, var_04, var_01);

    if(var_11.size > 0)
      var_01 = scripts\engine\utility::array_combine_unique(var_01, var_11);
  }

  var_12 = coop_getweaponclass(var_10);

  if(isDefined(var_09))
    var_01 = scripts\engine\utility::array_combine_unique(var_01, var_09);

  var_01 = weaponattachremoveextraattachments(var_01);
  var_01 = removeexcludedattachments(var_01);

  for(var_13 = 0; var_13 < var_1.size; var_13++)
    var_1[var_13] = attachmentmap_tounique(var_1[var_13], var_10);

  if(isDefined(var_09)) {
    for(var_13 = 0; var_13 < var_9.size; var_13++)
      var_9[var_13] = attachmentmap_tounique(var_9[var_13], var_10);
  }

  if(isDefined(var_09))
    var_01 = scripts\engine\utility::array_combine_unique(var_01, var_09);

  if(isDefined(var_04) && var_04 >= 0) {
    var_14 = getweaponvariantattachments(var_10, var_04);

    if(var_14.size > 0)
      var_01 = scripts\engine\utility::array_combine_unique(var_01, var_14);
  }

  var_01 = scripts\engine\utility::array_remove(var_01, "none");

  if(isDefined(var_08) && var_08 != "none")
    var_1[var_1.size] = var_08;

  if(var_1.size > 0)
    var_01 = filterattachments(var_01);

  var_15 = [];

  foreach(var_17 in var_01) {
    var_18 = attachmentmap_toextra(var_17);

    if(isDefined(var_18))
      var_15[var_15.size] = attachmentmap_tounique(var_18, var_10);
  }

  if(var_15.size > 0)
    var_01 = scripts\engine\utility::array_combine_unique(var_01, var_15);

  if(var_1.size > 0)
    var_01 = scripts\engine\utility::alphabetize(var_01);

  var_10 = reassign_weapon_name(var_10, var_01);

  foreach(var_21 in var_01)
  var_10 = var_10 + ("+" + var_21);

  if(issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_02, var_04);
    var_23 = 0;

    if(isholidayweapon(var_10, var_04) || issummerholidayweapon(var_10, var_04))
      var_23 = isholidayweaponusingdefaultscope(var_10, var_01);

    if(var_23)
      var_10 = var_10 + "+scope1";
    else
      var_10 = buildweaponnamereticle(var_10, var_03);

    var_10 = buildweaponnamevariantid(var_10, var_04);
  }

  return var_10;
}

reassign_weapon_name(var_00, var_01) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_00)]))
    return var_00;
  else {
    switch (var_00) {
      case "iw7_machete_mp":
        if(scripts\engine\utility::is_true(self.base_weapon))
          var_00 = "iw7_machete_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 1 || scripts\engine\utility::is_true(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_machete_mp";
          else
            var_00 = "iw7_machete_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 2) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_machete_mp_pap1";
          else
            var_00 = "iw7_machete_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 3)
          var_00 = "iw7_machete_mp_pap2";

        break;
      case "iw7_two_headed_axe_mp":
        if(scripts\engine\utility::is_true(self.base_weapon))
          var_00 = "iw7_two_headed_axe_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 1 || scripts\engine\utility::is_true(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_two_headed_axe_mp";
          else
            var_00 = "iw7_two_headed_axe_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 2) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_two_headed_axe_mp_pap1";
          else
            var_00 = "iw7_two_headed_axe_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 3)
          var_00 = "iw7_two_headed_axe_mp_pap2";

        break;
      case "iw7_spiked_bat_mp":
        if(scripts\engine\utility::is_true(self.base_weapon))
          var_00 = "iw7_spiked_bat_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 1 || scripts\engine\utility::is_true(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_spiked_bat_mp";
          else
            var_00 = "iw7_spiked_bat_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 2) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_spiked_bat_mp_pap1";
          else
            var_00 = "iw7_spiked_bat_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 3)
          var_00 = "iw7_spiked_bat_mp_pap2";

        break;
      case "iw7_golf_club_mp":
        if(scripts\engine\utility::is_true(self.base_weapon))
          var_00 = "iw7_golf_club_mp";
        else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 1 || scripts\engine\utility::is_true(self.ephemeral_downgrade)) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_golf_club_mp";
          else
            var_00 = "iw7_golf_club_mp_pap1";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 2) {
          if(scripts\engine\utility::is_true(self.bang_bangs))
            var_00 = "iw7_golf_club_mp_pap1";
          else
            var_00 = "iw7_golf_club_mp_pap2";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_00)]) && self.pap[getrawbaseweaponname(var_00)].lvl == 3)
          var_00 = "iw7_golf_club_mp_pap2";

        break;
      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(var_01, "axepap1"))
          var_00 = "iw7_axe_zm_pap1";
        else if(scripts\engine\utility::array_contains(var_01, "axepap2"))
          var_00 = "iw7_axe_zm_pap2";

        break;
      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(var_01, "katanapap1"))
          var_00 = "iw7_katana_zm_pap1";
        else if(scripts\engine\utility::array_contains(var_01, "katanapap2"))
          var_00 = "iw7_katana_zm_pap2";

        break;
      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(var_01, "nunchuckspap1"))
          var_00 = "iw7_nunchucks_zm_pap1";
        else if(scripts\engine\utility::array_contains(var_01, "nunchuckspap2"))
          var_00 = "iw7_nunchucks_zm_pap2";

        break;
      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(var_01, "freezepap1"))
          var_00 = "iw7_forgefreeze_zm_pap1";
        else if(scripts\engine\utility::array_contains(var_01, "freezepap2"))
          var_00 = "iw7_forgefreeze_zm_pap2";

        break;
      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(var_01, "shredderpap1"))
          var_00 = "iw7_shredder_zm_pap1";

        break;
      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(var_01, "dischordpap1"))
          var_00 = "iw7_dischord_zm_pap1";

        break;
      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(var_01, "fmpap1"))
          var_00 = "iw7_facemelter_zm_pap1";

        break;
      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(var_01, "hcpap1"))
          var_00 = "iw7_headcutter_zm_pap1";

        break;
    }
  }

  return var_00;
}

get_weapon_variant_id(var_00, var_01) {
  var_02 = getbaseweaponname(var_01);

  if(isenumvaluevalid("mp", "LoadoutWeapon", var_02) && weaponhasvariants(var_02))
    return var_00 getrankedplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_02, "variantID");
  else
    return -1;
}

weaponhasvariants(var_00) {
  if(!isDefined(var_00))
    return 0;

  switch (var_00) {
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

weaponattachremoveextraattachments(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(isDefined(level.attachmentextralist[var_03])) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

weaponattachdefaultmap(var_00) {
  if(isDefined(level.weaponmapdata[var_00]) && isDefined(level.weaponmapdata[var_00].attachdefaults))
    return level.weaponmapdata[var_00].attachdefaults;

  return undefined;
}

buildweaponassetname(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0) {
    switch (var_00) {
      case "iw7_two_headed_axe":
      case "iw7_spiked_bat":
      case "iw7_machete":
      case "iw7_golf_club":
        return var_00 + "_mp";
      case "iw7_golf_club_mp":
      case "iw7_spiked_bat_mp":
      case "iw7_two_headed_axe_mp":
      case "iw7_machete_mp":
        return var_00;
      case "iw7_ake":
        return var_00 + "_zml";
      case "iw7_crb":
        return var_00 + "_zml";
      case "iw7_sonic":
        return var_00 + "_zmr";
      case "iw7_ump45":
        return var_00 + "_zml";
      case "iw7_ripper":
        return var_00 + "_zmr";
      case "iw7_g18":
        return var_00 + "_zmr";
      case "iw7_spas":
        return var_00 + "_zmr";
      case "iw7_cheytac":
        return var_00 + "_zmr";
      case "iw7_katana_zm_pap2":
      case "iw7_katana_zm_pap1":
      case "iw7_nunchucks_zm_pap2":
      case "iw7_nunchucks_zm_pap1":
      case "iw7_katana_zm":
      case "iw7_nunchucks_zm":
        return var_00;
    }

    return var_00 + "_zm";
  } else {
    var_02 = getweaponassetfromrootweapon(var_00, var_01);
    return var_02;
  }
}

getweaponassetfromrootweapon(var_00, var_01) {
  var_02 = "mp\loot\weapon\" + var_00 + ".csv ";
  var_03 = tablelookup(var_02, 0, var_01, 20);
  return var_03;
}

getweaponvariantattachments(var_00, var_01) {
  var_02 = [];
  var_03 = getweaponpassives(var_00, var_01);

  if(isDefined(var_03)) {
    foreach(var_05 in var_03) {
      var_06 = getpassiveattachment(var_05);

      if(!isDefined(var_06)) {
        continue;
      }
      var_2[var_2.size] = var_06;
    }
  }

  return var_02;
}

getpassiveattachment(var_00) {
  var_01 = getpassivestruct(var_00);

  if(!isDefined(var_01) || !isDefined(var_1.attachmentroll))
    return undefined;

  return var_1.attachmentroll;
}

getweaponpassives(var_00, var_01) {
  return getpassivesforweapon(var_00, var_01);
}

getpassivesforweapon(var_00, var_01) {
  var_02 = getlootinfoforweapon(var_00, var_01);

  if(isDefined(var_02))
    return var_2.passives;

  return undefined;
}

getlootinfoforweapon(var_00, var_01) {
  var_02 = getweaponrootname(var_00);

  if(!isDefined(level.lootweaponcache))
    level.lootweaponcache = [];

  if(isDefined(level.lootweaponcache[var_02]) && isDefined(level.lootweaponcache[var_02][var_01])) {
    var_03 = level.lootweaponcache[var_02][var_01];
    return var_03;
  }

  var_03 = cachelootweaponweaponinfo(var_00, var_02, var_01);

  if(isDefined(var_03))
    return var_03;

  return undefined;
}

getweaponrootname(var_00) {
  var_01 = strtok(var_00, "_");

  if(weapon_is_dlc_melee(var_00)) {
    var_00 = var_1[0];

    for(var_02 = 1; var_02 < var_1.size - 1; var_2++)
      var_00 = var_00 + ("_" + var_1[var_02]);
  } else if(weapon_is_dlc2_melee(var_00))
    return var_00;
  else if(var_1[0] == "iw6" || var_1[0] == "iw7")
    var_00 = var_1[0] + "_" + var_1[1];
  else if(var_1[0] == "alt")
    var_00 = var_1[1] + "_" + var_1[2];

  return var_00;
}

weapon_is_dlc2_melee(var_00) {
  return issubstr(var_00, "katana") || issubstr(var_00, "nunchucks");
}

weapon_is_dlc_melee(var_00) {
  return issubstr(var_00, "two_headed") || issubstr(var_00, "spiked_bat") || issubstr(var_00, "machete") || issubstr(var_00, "golf_club");
}

cachelootweaponweaponinfo(var_00, var_01, var_02) {
  if(!isDefined(level.lootweaponcache[var_01]))
    level.lootweaponcache[var_01] = [];

  var_03 = getweaponloottable(var_00);
  var_04 = readweaponinfofromtable(var_03, var_02);
  level.lootweaponcache[var_01][var_02] = var_04;
  return var_04;
}

readweaponinfofromtable(var_00, var_01) {
  var_02 = tablelookuprownum(var_00, 0, var_01);
  var_03 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_00, var_02, 1);
  var_3.weaponasset = tablelookupbyrow(var_00, var_02, 20);
  var_3.passives = [];

  for(var_04 = 0; var_04 < 3; var_4++) {
    var_05 = tablelookupbyrow(var_00, var_02, 21 + var_04);

    if(isDefined(var_05) && var_05 != "")
      var_3.passives[var_3.passives.size] = var_05;
  }

  return var_03;
}

filterattachments(var_00) {
  var_01 = [];

  if(isDefined(var_00)) {
    foreach(var_03 in var_00) {
      var_04 = 1;

      foreach(var_06 in var_01) {
        if(var_03 == var_06) {
          var_04 = 0;
          break;
        }

        if(!attachmentscompatible(var_03, var_06)) {
          var_04 = 0;
          break;
        }
      }

      if(var_04)
        var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

attachmentscompatible(var_00, var_01) {
  var_00 = attachmentmap_tobase(var_00);
  var_01 = attachmentmap_tobase(var_01);
  var_02 = 1;

  if(var_00 == var_01)
    var_02 = 0;
  else if(isDefined(level.attachmentmap_conflicts)) {
    var_03 = scripts\engine\utility::alphabetize([var_00, var_01]);
    var_02 = !isDefined(level.attachmentmap_conflicts[var_3[0] + "_" + var_3[1]]);
  } else if(var_00 != "none" && var_01 != "none") {
    var_04 = tablelookuprownum("mp\attachmentcombos.csv", 0, var_01);

    if(tablelookup("mp\attachmentcombos.csv", 0, var_00, var_04) == "no")
      var_02 = 0;
  }

  return var_02;
}

attachmentmap_toextra(var_00) {
  var_01 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var_00]))
    var_01 = level.attachmentmap_uniquetoextra[var_00];

  return var_01;
}

getpassivestruct(var_00) {
  if(!isDefined(level.passivemap[var_00]))
    return undefined;

  var_01 = level.passivemap[var_00];
  return var_01;
}

map_check(var_00) {
  if(!isDefined(var_00))
    return 1;

  switch (var_00) {
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

buildweaponname(var_00, var_01, var_02, var_03, var_04) {
  if(isstrstart(var_00, "iw7_"))
    var_02 = 0;

  var_05 = [];

  foreach(var_07 in var_01)
  var_5[var_5.size] = attachmentmap_tounique(var_07, var_00);

  var_09 = getrawbaseweaponname(var_00);
  var_10 = var_00;
  var_11 = var_09 == "kbs" || var_09 == "cheytac" || var_09 == "m8" || var_09 == "ripper" || var_09 == "erad" || var_09 == "ar57";

  if(var_11) {
    var_12 = 0;

    foreach(var_07 in var_05) {
      if(getattachmenttype(var_07) == "rail") {
        var_12 = 1;
        break;
      }
    }

    if(!var_12)
      var_5[var_5.size] = var_09 + "scope";
  }

  if(var_5.size > 0) {
    var_15 = scripts\engine\utility::array_remove_duplicates(var_05);
    var_05 = scripts\engine\utility::alphabetize(var_15);
  }

  foreach(var_07 in var_05)
  var_10 = var_10 + ("+" + var_07);

  if(issubstr(var_10, "iw6") || issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_02);

    if(var_04 != "weapon_sniper" && isDefined(var_03))
      var_10 = buildweaponnamereticle(var_10, var_03);
  } else if(!scripts\cp\cp_weapon::isvalidzombieweapon(var_10 + "_zm"))
    var_10 = var_00 + "_zm";
  else {
    var_10 = buildweaponnamecamo(var_10, var_02);
    var_10 = buildweaponnamereticle(var_10, var_03);
    var_10 = var_10 + "_zm";
  }

  return var_10;
}

buildweaponnamevariantid(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return var_00;

  var_00 = var_00 + ("+loot" + var_01);
  return var_00;
}

isholidayweapon(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  if(var_01 == 6) {
    var_02 = getweaponrootname(var_00);
    return var_02 == "iw7_ripper" || var_02 == "iw7_lmg03" || var_02 == "iw7_ar57";
  }

  return 0;
}

issummerholidayweapon(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = getweaponrootname(var_00);

  if(var_01 == 8)
    return var_02 == "iw7_erad" || var_02 == "iw7_ake" || var_02 == "iw7_sdflmg";

  if(var_01 == 5)
    return var_02 == "iw7_mod2187" || var_02 == "iw7_longshot";

  return 0;
}

ismark2weapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  return var_00 >= 32;
}

isholidayweaponusingdefaultscope(var_00, var_01) {
  var_02 = attachmentmap_tounique("scope", getweaponbasename(var_00));
  return isDefined(var_02) && scripts\engine\utility::array_contains(var_01, var_02);
}

is_pap_camo(var_00) {
  if(isDefined(level.pap_1_camo) && var_00 == level.pap_1_camo)
    return 1;
  else if(isDefined(level.pap_2_camo) && var_00 == level.pap_2_camo)
    return 1;

  return 0;
}

buildweaponnamecamo(var_00, var_01, var_02) {
  var_03 = -1;
  var_04 = isDefined(var_01) && is_pap_camo(var_01);

  if(var_00 == "iw7_nunchucks_zm_pap1" || var_00 == "iw7_nunchucks_zm_pap2")
    return var_00 + "+camo" + 222;

  if(!var_04) {
    if(isholidayweapon(var_00, var_02)) {
      var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo89", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_00 + "+camo" + var_03;
    } else if(issummerholidayweapon(var_00, var_02)) {
      var_03 = int(tablelookup("mp\camoTable.csv", 1, "camo230", scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_00 + "+camo" + var_03;
    } else if((!isDefined(var_01) || var_01 == "none") && ismark2weapon(var_02)) {
      var_05 = getweaponqualitybyid(var_00, var_02);
      var_06 = undefined;

      switch (var_05) {
        case 1:
          var_06 = "camo99";
          break;
        case 2:
          var_06 = "camo101";
          break;
        case 3:
          var_06 = "camo102";
          break;
        case 4:
          var_06 = "camo103";
          break;
        default:
          break;
      }

      var_03 = int(tablelookup("mp\camoTable.csv", 1, var_06, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
      return var_00 + "+camo" + var_03;
    }
  }

  if(!isDefined(var_01))
    var_03 = 0;
  else
    var_03 = int(tablelookup("mp\camoTable.csv", 1, var_01, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));

  if(var_03 <= 0) {
    var_05 = getweaponqualitybyid(var_00, var_02);
    var_06 = undefined;

    switch (var_05) {
      case 1:
        var_06 = "camo24";
        break;
      case 2:
        var_06 = "camo19";
        break;
      case 3:
        var_06 = "camo18";
        break;
      default:
        break;
    }

    if(isDefined(var_06))
      var_03 = int(tablelookup("mp\camoTable.csv", 1, var_06, scripts\engine\utility::getcamotablecolumnindex("weapon_index")));
    else
      return var_00;
  }

  return var_00 + "+camo" + var_03;
}

getweaponqualitybyid(var_00, var_01) {
  if(!isDefined(var_01) || var_01 < 0)
    return 0;

  var_02 = getweaponloottable(var_00);
  var_03 = int(tablelookup(var_02, 0, var_01, 4));
  return var_03;
}

buildweaponnamereticle(var_00, var_01) {
  if(!isDefined(var_01))
    return var_00;

  var_02 = int(tablelookup("mp\reticleTable.csv", 1, var_01, 5));

  if(!isDefined(var_02) || var_02 == 0)
    return var_00;

  var_00 = var_00 + ("+scope" + var_02);
  return var_00;
}

has_zombie_perk(var_00) {
  if(!isDefined(self.zombies_perks))
    return 0;

  return scripts\engine\utility::is_true(self.zombies_perks[var_00]);
}

drawsphere(var_00, var_01, var_02, var_03) {
  var_04 = int(var_02 * 20);

  for(var_05 = 0; var_05 < var_04; var_5++)
    wait 0.05;
}

set_alien_emissive(var_00, var_01) {
  var_02 = self.maxemissive - self.defaultemissive;
  var_03 = var_01 * var_02 + self.defaultemissive;
  self getrandomhovernodesaroundtargetpos(var_00, var_03);
}

get_adjusted_armor(var_00, var_01) {
  if(var_00 + level.deployablebox_vest_rank[var_01] > level.deployablebox_vest_max)
    return level.deployablebox_vest_max;

  return var_00 + level.deployablebox_vest_rank[var_01];
}

alien_mode_has(var_00) {
  var_00 = tolower(var_00);

  if(!isDefined(level.alien_mode_feature))
    return 0;

  if(!isDefined(level.alien_mode_feature[var_00]))
    return 0;

  return level.alien_mode_feature[var_00];
}

enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
}

array_remove_index(var_00, var_01, var_02) {
  var_03 = [];

  foreach(var_07, var_05 in var_00) {
    if(var_07 == var_01) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_02))
      var_06 = var_07;
    else
      var_06 = var_3.size;

    var_3[var_06] = var_05;
  }

  return var_03;
}

is_normal_upright(var_00) {
  var_01 = (0, 0, 1);
  var_02 = 0.85;
  return vectordot(var_00, var_01) > var_02;
}

get_synch_direction_list(var_00) {
  if(!isDefined(self.synch_attack_setup))
    return [];

  if(!isDefined(self.synch_attack_setup.synch_directions))
    return [];

  if(!self.synch_attack_setup.type_specific)
    return self.synch_attack_setup.synch_directions;

  var_01 = scripts\cp\cp_agent_utils::get_agent_type(var_00);

  if(!isDefined(self.synch_attack_setup.synch_directions[var_01]))
    var_02 = "Synch attack on " + self.synch_attack_setup.identifier + " doesn't handle type: " + var_01;

  return self.synch_attack_setup.synch_directions[var_01];
}

getrandomindex(var_00) {
  var_01 = 0;

  foreach(var_03 in var_00)
  var_01 = var_01 + var_03;

  var_05 = randomintrange(0, var_01);
  var_01 = 0;

  foreach(var_07, var_03 in var_00) {
    var_01 = var_01 + var_03;

    if(var_05 <= var_01)
      return var_07;
  }

  return 0;
}

get_closest_living_player() {
  var_00 = 1073741824;
  var_01 = undefined;

  foreach(var_03 in level.players) {
    var_04 = distancesquared(self.origin, var_3.origin);

    if(isreallyalive(var_03) && var_04 < var_00) {
      var_01 = var_03;
      var_00 = var_04;
    }
  }

  return var_01;
}

get_array_of_valid_players(var_00, var_01) {
  var_02 = [];

  foreach(var_04 in level.players) {
    if(var_04 is_valid_player())
      var_2[var_2.size] = var_04;
  }

  if(!isDefined(var_00) || !var_00)
    return var_02;

  return scripts\engine\utility::get_array_of_closest(var_01, var_02);
}

is_valid_player(var_00) {
  if(!isplayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isDefined(var_00) && scripts\cp\cp_laststand::player_in_laststand(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "spectator")
    return 0;

  return 1;
}

any_player_nearby(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(distancesquared(var_3.origin, var_00) < var_01)
      return 1;
  }

  return 0;
}

timeoutvofunction_pain(var_00, var_01) {
  wait(var_01);
  level notify(var_00 + "_timed_out");
}

player_pain_vo(var_00) {
  self endon("disconnect");
  level endon("pain_vo_timed_out");
  level thread timeoutvofunction_pain("pain_vo", 0.5);
  var_01 = 5500;
  var_02 = gettime();

  if(!isDefined(self.next_pain_vo_time))
    self.next_pain_vo_time = var_02 + randomintrange(var_01, var_01 + 2000);
  else if(var_02 < self.next_pain_vo_time) {
    return;
  }
  while(scripts\cp\cp_music_and_dialog::vo_is_playing())
    wait 0.1;

  if(isDefined(self.vo_prefix)) {
    if(soundexists(self.vo_prefix + "plr_pain"))
      self playlocalsound(self.vo_prefix + "plr_pain");
    else if(soundexists(self.vo_prefix + "pain"))
      self playlocalsound(self.vo_prefix + "pain");
  }

  var_03 = "injured_pain_vocal";

  if(isDefined(var_00)) {
    if(isDefined(var_0.agent_type)) {
      switch (var_0.agent_type) {
        case "crab_mini":
          var_03 = "injured_pain_crabgoon";
          break;
        case "crab_brute":
          var_03 = "injured_pain_radactivecrab";
          break;
        case "crab_boss":
          var_03 = "injured_pain_radboss";
          break;
        case "skater":
          var_03 = "injured_pain_skater";
          break;
        case "ratking":
          var_03 = scripts\engine\utility::random(["injured_pain_ratking1", "injured_pain_ratking2", "injured_pain_ratking3"]);
          break;
        default:
          var_03 = "injured_pain_vocal";
          break;
      }
    }
  }

  scripts\cp\cp_vo::try_to_play_vo(var_03, "zmb_comment_vo");
  self.next_pain_vo_time = var_02 + randomintrange(var_01, var_01 + 1500);
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
  var_00 = get_pain_breathing_sfx_alias(self);

  if(isDefined(var_00)) {
    if(soundexists(var_00)) {
      while(!above_pain_breathing_sfx_threshold(self) && !level.gameended) {
        if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
          self playlocalsound(var_00);

        wait 1.5;
      }
    }

    set_is_playing_pain_breathing_sfx(self, 0);
  }
}

is_playing_pain_breathing_sfx(var_00) {
  return scripts\engine\utility::is_true(var_0.is_playing_pain_breathing_sfx);
}

above_pain_breathing_sfx_threshold(var_00) {
  var_01 = 0.3;
  return var_0.health / var_0.maxhealth > var_01;
}

set_is_playing_pain_breathing_sfx(var_00, var_01) {
  var_0.is_playing_pain_breathing_sfx = var_01;
}

get_pain_breathing_sfx_alias(var_00) {
  if(!level.gameended) {
    if(var_0.vo_prefix == "p1_")
      return "p1_plr_pain";
    else if(var_0.vo_prefix == "p2_")
      return "p2_plr_pain";
    else if(var_0.vo_prefix == "p3_")
      return "p3_plr_pain";
    else if(var_0.vo_prefix == "p4_")
      return "p4_plr_pain";
    else if(var_0.vo_prefix == "p5_")
      return "p5_plr_pain";
    else
      return "p3_plr_pain";
  }
}

pointvscone(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = var_00 - var_01;
  var_09 = vectordot(var_08, var_02);
  var_10 = vectordot(var_08, var_03);

  if(var_09 > var_04)
    return 0;

  if(var_09 < var_05)
    return 0;

  if(isDefined(var_07)) {
    if(abs(var_10) > var_07)
      return 0;
  }

  if(scripts\engine\utility::anglebetweenvectors(var_02, var_08) > var_06)
    return 0;

  return 1;
}

playvoforpillage(var_00) {
  var_01 = var_0.vo_prefix + "good_loot";

  if(scripts\cp\cp_vo::alias_2d_version_exists(var_00, var_01))
    var_00 playlocalsound(scripts\cp\cp_vo::get_alias_2d_version(var_00, var_01));
  else if(soundexists(var_01))
    var_00 playlocalsound(var_01);
}

deployable_box_onuse_message(var_00) {
  var_01 = "";

  if(isDefined(var_00) && isDefined(var_0.boxtype) && isDefined(level.boxsettings[var_0.boxtype].eventstring))
    var_01 = level.boxsettings[var_0.boxtype].eventstring;

  thread setlowermessage("deployable_use", var_01, 3);
}

is_goon(var_00) {
  switch (var_00) {
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;
    default:
      return 0;
  }
}

mark_dangerous_nodes(var_00, var_01, var_02) {
  _markdangerousnodes(var_00, var_01, 1);
  wait(var_02);
  _markdangerousnodes(var_00, var_01, 0);
}

healthregeninit(var_00) {
  level.healthregendisabled = var_00;
}

alien_health_per_player_init() {
  level.alien_health_per_player_scalar = [];
  level.alien_health_per_player_scalar[1] = 0.9;
  level.alien_health_per_player_scalar[2] = 1.0;
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
    scripts\engine\utility::waittill_any("damage", "health_perk_upgrade");

    if(!canregenhealth()) {
      continue;
    }
    var_00 = scripts\cp\cp_laststand::gethealthcap();
    var_01 = self.health / var_00;

    if(var_01 >= 1) {
      self.health = var_00;
      continue;
    }

    thread healthregen(gettime(), var_01);
    thread breathingmanager(gettime(), var_01);
  }
}

healthregen(var_00, var_01) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self.selfdamaging) && self.selfdamaging)
    wait 0.2;

  if(ishealthregendisabled()) {
    return;
  }
  var_02 = spawnStruct();
  getregendata(var_02);
  scripts\engine\utility::waittill_any_timeout(var_2.activatetime, "force_regeneration");

  for(;;) {
    var_03 = scripts\cp\cp_laststand::gethealthcap();
    var_02 = spawnStruct();
    getregendata(var_02);

    if(!scripts\cp\perks\perkfunctions::has_fragile_relic_and_is_sprinting()) {
      var_01 = self.health / self.maxhealth;

      if(self.health < int(var_03)) {
        if(var_01 + var_2.regenamount > int(1))
          self.health = int(var_03);
        else
          self.health = int(self.maxhealth * (var_01 + var_2.regenamount));
      } else
        break;
    }

    scripts\engine\utility::waittill_any_timeout(var_2.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");
  scripts\cp\cp_globallogic::player_init_invulnerability();
  resetattackerlist();
}

breathingmanager(var_00, var_01) {
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
  self.breathingstoptime = var_00 + 6000 * self.regenspeed;
  wait(6 * self.regenspeed);

  if(!level.gameended) {
    if(self.vo_prefix == "p1_") {
      if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
        self playlocalsound("p1_breathing_better");
    } else if(self.vo_prefix == "p2_") {
      if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
        self playlocalsound("p2_breathing_better");
    } else if(self.vo_prefix == "p3_") {
      if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
        self playlocalsound("p3_breathing_better");
    } else if(self.vo_prefix == "p4_") {
      if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
        self playlocalsound("p4_breathing_better");
    } else if(self.vo_prefix == "p5_") {
      if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
        self playlocalsound("p5_breathing_better");
    } else if(!scripts\engine\utility::is_true(self.vo_system_playing_vo))
      self playlocalsound("p3_breathing_better");
  }
}

getregendata(var_00) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\prestige::prestige_getslowhealthregenscalar();

  if(self.prestigehealthregennerfscalar == 1.0) {
    if(is_consumable_active("faster_health_regen_upgrade") || isDefined(level.purify_active)) {
      var_0.activatetime = 0.45;
      var_0.waittimebetweenregen = 0.045;
      var_0.regenamount = 0.1;
    } else if(self.health <= 45) {
      var_0.activatetime = 5;
      var_0.waittimebetweenregen = 0.05;
      var_0.regenamount = 0.1;
    } else {
      var_0.activatetime = 2.4;
      var_0.waittimebetweenregen = 0.1;
      var_0.regenamount = 0.1;
    }
  } else {
    var_0.activatetime = 2.4 * self.prestigehealthregennerfscalar;
    var_0.waittimebetweenregen = 0.1 * self.prestigehealthregennerfscalar;
    var_0.regenamount = 0.1;
  }
}

resetattackerlist(var_00) {
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
  if(scripts\cp\cp_laststand::player_in_laststand(self))
    return 0;

  return 1;
}

playerpainbreathingsound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  wait 2;

  for(;;) {
    wait 0.2;

    if(shouldplaypainbreathingsound()) {
      if(self.vo_prefix == "p1_") {
        if(soundexists("Fem_breathing_hurt"))
          self playlocalsound("Fem_breathing_hurt");
      } else
        self playlocalsound("breathing_hurt");

      wait 0.784;
      wait(0.1 + randomfloat(0.8));
    }
  }
}

shouldplaypainbreathingsound() {
  if(ishealthregendisabled() || isusingremote() || isDefined(self.breathingstoptime) && gettime() < self.breathingstoptime || self.health > self.maxhealth * 0.55 || level.gameended)
    return 0;
  else
    return 1;
}

ishealthregendisabled() {
  return isDefined(level.healthregendisabled) && level.healthregendisabled || isDefined(self.healthregendisabled) && self.healthregendisabled;
}

playerarmor() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("game_ended");

  if(!isDefined(self.bodyarmorhp))
    self.bodyarmorhp = 0;

  self setrankedplayerdata("cp", "alienSession", "armor", 0);
  var_00 = 0;

  for(;;) {
    scripts\engine\utility::waittill_any("player_damaged", "enable_armor");

    if(!isDefined(self.bodyarmorhp)) {
      if(var_00 > 0) {
        self setrankedplayerdata("cp", "alienSession", "armor", 0);
        var_00 = 0;
      }

      continue;
    }

    if(var_00 != self.bodyarmorhp) {
      var_01 = int(self.bodyarmorhp);
      self setrankedplayerdata("cp", "alienSession", "armor", var_01);
      var_00 = self.bodyarmorhp;
    }
  }
}

allow_secondary_offhand_weapons(var_00) {
  if(var_00) {
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

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    level notify("physSnd", self, var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);

    if(isDefined(var_00) && isDefined(var_0.phys_sound_func))
      level thread[[var_0.phys_sound_func]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  }
}

register_physics_collision_func(var_00, var_01) {
  var_0.phys_sound_func = var_01;
}

addtotraplist() {
  if(!scripts\engine\utility::array_contains(level.placed_crafted_traps, self))
    level.placed_crafted_traps = scripts\engine\utility::add_to_array(level.placed_crafted_traps, self);

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

removefromtraplist() {
  if(scripts\engine\utility::array_contains(level.placed_crafted_traps, self))
    level.placed_crafted_traps = scripts\engine\utility::array_remove(level.placed_crafted_traps, self);

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

ent_is_near_equipment(var_00) {
  var_01 = 16384;

  if(level.turrets.size) {
    var_02 = sortbydistance(level.turrets, var_0.origin);

    if(distance2dsquared(var_2[0].origin, var_0.origin) < var_01)
      return 1;
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(var_04 in level.placed_crafted_traps) {
      if(!isDefined(var_04)) {
        continue;
      }
      if(distance2dsquared(var_4.origin, var_0.origin) < var_01)
        return 1;
    }
  }

  if(isDefined(level.near_equipment_func))
    return [[level.near_equipment_func]](var_00);

  return 0;
}

set_crafted_inventory_item(var_00, var_01, var_02) {
  if(isDefined(var_2.current_crafted_inventory))
    var_2.current_crafted_inventory = undefined;

  var_2.current_crafted_inventory = spawnStruct();
  var_2.current_crafted_inventory.item = var_00;
  var_2.current_crafted_inventory.restore_func = var_01;
}

remove_crafted_item_from_inventory(var_00) {
  var_00 setclientomnvar("zom_crafted_weapon", 0);
  var_0.current_crafted_inventory = undefined;
}

is_escape_gametype() {
  return level.gametype == "escape";
}

item_handleownerdisconnect(var_00) {
  self endon("death");
  level endon("game_ended");
  self notify(var_00);
  self endon(var_00);
  self.owner waittill("disconnect");

  foreach(var_02 in level.players) {
    if(var_02 is_valid_player(1)) {
      self.owner = var_02;

      if(self.classname != "script_model")
        self setsentryowner(self.owner);

      break;
    }
  }

  thread item_handleownerdisconnect(var_00);
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

item_timeout(var_00, var_01, var_02) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.lifespan))
    self.lifespan = var_01;

  if(isDefined(var_00))
    self.lifespan = var_00;

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

  if(isDefined(var_02))
    self notify(var_02);
  else
    self notify("death");
}

item_oncarrierdeath(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("disconnect");
  var_01 = var_00 scripts\engine\utility::waittill_any_return("death", "last_stand");
  var_00 notify("force_cancel_placement");
}

item_oncarrierdisconnect(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("last_stand");
  var_00 waittill("disconnect");

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

item_ongameended(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("last_stand");
  level waittill("game_ended");
  self delete();
}

should_be_affected_by_trap(var_00, var_01, var_02) {
  if(!isDefined(var_00))
    return 0;

  if(!isalive(var_00))
    return 0;

  if(!isagent(var_00))
    return 0;

  if(!isDefined(var_0.agent_type))
    return 0;

  if(!isDefined(var_0.isactive) || !var_0.isactive)
    return 0;

  if(!isDefined(var_01) && isDefined(var_0.entered_playspace) && !var_0.entered_playspace)
    return 0;

  if(scripts\engine\utility::is_true(var_0.marked_for_death))
    return 0;

  if(!isDefined(var_0.team))
    return 0;

  if(var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_ghost" || var_0.agent_type == "zombie_grey")
    return 0;

  if(!scripts\engine\utility::is_true(var_02) && scripts\engine\utility::is_true(var_0.is_suicide_bomber))
    return 0;

  if(scripts\engine\utility::is_true(var_0.is_coaster_zombie))
    return 0;

  return 1;
}

set_quest_icon(var_00) {
  increment_num_of_quest_piece_completed();
  set_quest_icon_internal(var_00);
}

set_quest_icon_internal(var_00) {
  _setomnvarbit("zombie_quest_piece", var_00, 1);
  setclientmatchdata("questPieces", "quest_piece_" + var_00, 1);
}

set_completed_quest_mark(var_00) {
  _setomnvarbit("zm_completed_quest_marks", var_00, 1);
}

increment_num_of_quest_piece_completed() {
  if(!isDefined(level.num_of_quest_pieces_completed))
    level.num_of_quest_pieces_completed = 0;

  level.num_of_quest_pieces_completed++;

  if(level.script == "cp_zmb") {
    if(level.num_of_quest_pieces_completed == level.cp_zmb_number_of_quest_pieces) {
      foreach(var_01 in level.players)
      var_01 scripts\cp\zombies\achievement::update_achievement("STICKER_COLLECTOR", 24);
    }
  }
}

playplayerandnpcsounds(var_00, var_01, var_02) {
  var_00 playlocalsound(var_01);
  var_00 playsoundtoteam(var_02, "allies", var_00);
  var_00 playsoundtoteam(var_02, "axis", var_00);
}

roundup(var_00) {
  if(var_00 - int(var_00) >= 0.5)
    return int(var_00 + 1);
  else
    return int(var_00);
}

damage_over_time(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!should_apply_dot(var_00)) {
    return;
  }
  var_00 endon("death");

  if(!isDefined(var_03))
    var_03 = 600;

  if(!isDefined(var_02))
    var_02 = 5;

  if(!isDefined(var_04))
    var_04 = "MOD_UNKNOWN";

  if(!isDefined(var_05))
    var_05 = "iw7_dot_zm";

  if(isDefined(var_07)) {
    var_00 setscriptablestateflag(var_00, var_07, 1);

    if(isDefined(level.scriptablestatefunc))
      var_00 thread[[level.scriptablestatefunc]](var_00);
  }

  var_09 = 0;
  var_10 = 6;
  var_11 = var_02 / var_10;
  var_12 = var_03 / var_10;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    wait(var_11);

    if(isalive(var_00)) {
      var_0.flame_damage_time = gettime() + 500;

      if(var_0.health - var_12 <= 0) {
        if(isDefined(var_08))
          level notify(var_08);
      }

      if(isDefined(var_01)) {
        var_00 getrandomarmkillstreak(var_12, var_0.origin, var_01, var_01, var_04, var_05);
        continue;
      }

      var_00 getrandomarmkillstreak(var_12, var_0.origin, undefined, undefined, var_04, var_05);
    }
  }

  if(isDefined(var_07))
    var_00 setscriptablestateflag(var_00, var_07);

  if(scripts\engine\utility::is_true(var_0.marked_for_death))
    var_0.marked_for_death = undefined;

  if(scripts\engine\utility::is_true(var_0.flame_damage_time))
    var_0.flame_damage_time = undefined;
}

setscriptablestateflag(var_00, var_01, var_02) {
  switch (var_01) {
    case "combinedArcane":
    case "combinedarcane":
      if(scripts\engine\utility::is_true(var_02))
        var_0.is_afflicted = 1;
      else
        var_0.is_afflicted = undefined;

      break;
    case "burning":
      if(scripts\engine\utility::is_true(var_02))
        var_0.is_burning = var_02;
      else
        var_0.is_burning = undefined;

      break;
    case "electrified":
      if(scripts\engine\utility::is_true(var_02)) {
        var_0.is_electrified = var_02;
        var_0.allowpain = 1;
        var_0.stun_hit_time = gettime() + 3000;
      } else {
        var_0.is_electrified = undefined;
        var_0.allowpain = 0;
      }

      break;
    case "shocked":
      if(scripts\engine\utility::is_true(var_02))
        var_0.stunned = var_02;
      else
        var_0.stunned = undefined;

      break;
    case "chemBurn":
    case "chemburn":
      if(scripts\engine\utility::is_true(var_02))
        var_0.is_chem_burning = 1;
      else
        var_0.is_chem_burning = undefined;

      break;
    default:
      break;
  }
}

should_apply_dot(var_00) {
  if(isDefined(var_0.agent_type) && (var_0.agent_type == "c6" || var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost"))
    return 0;

  return 1;
}

update_trap_placement_internal(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_05 = var_2.carriedtrapoffset;
  var_06 = var_2.carriedtrapangles;
  var_07 = var_2.placementradius;
  var_08 = var_2.placementheighttolerance;
  var_09 = var_2.modelplacement;
  var_10 = var_2.modelplacementfailed;
  var_11 = var_2.placecancelablestring;
  var_12 = var_2.placestring;
  var_13 = var_2.cannotplacestring;
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_14 = -1;

  for(;;) {
    var_15 = self canplayerplacesentry(1, var_07);
    var_0.origin = var_15["origin"];
    var_0.angles = var_15["angles"];
    var_1.origin = var_0.origin + var_05;
    var_1.angles = var_0.angles + var_06;

    if(isDefined(self.onslide))
      var_0.canbeplaced = 0;
    else
      var_0.canbeplaced = self isonground() && var_15["result"] && abs(var_0.origin[2] - self.origin[2]) < var_08;

    if(ent_is_near_equipment(var_00))
      var_0.canbeplaced = 0;

    if(isDefined(var_03) && isDefined(level.discotrap_active) && isDefined(level.dance_floor_volume)) {
      if(var_00 istouching(level.dance_floor_volume))
        var_0.canbeplaced = 0;
    }

    if(isDefined(var_15["entity"]))
      var_0.moving_platform = var_15["entity"];
    else
      var_0.moving_platform = undefined;

    if(var_0.canbeplaced != var_14) {
      if(var_0.canbeplaced) {
        if(!isDefined(var_04))
          var_01 setModel(var_09);

        if(isDefined(var_0.firstplacement))
          self forceusehinton(var_11);
        else
          self forceusehinton(var_12);
      } else {
        if(!isDefined(var_04))
          var_01 setModel(var_10);

        self forceusehinton(var_13);
      }
    }

    var_14 = var_0.canbeplaced;
    wait 0.05;
  }
}

usegrenadegesture(var_00, var_01) {
  if(var_00 cangiveandfireoffhand(var_00 getvalidtakeweapon()) && !var_00 isgestureplaying()) {
    var_00 setweaponammostock(var_01, 1);
    var_00 giveandfireoffhand(var_01);
  }
}

is_codxp() {
  return getdvar("scr_codxp", "") != "";
}

too_close_to_other_interactions(var_00) {
  var_01 = sortbydistance(level.current_interaction_structs, var_00);

  if(distancesquared(var_1[0].origin, var_00) < 9216)
    return 1;

  return 0;
}

getweapontoswitchbackto() {
  if(isDefined(self.last_weapon))
    var_00 = self.last_weapon;
  else
    var_00 = self getcurrentweapon();

  var_01 = 0;
  var_02 = level.additional_laststand_weapon_exclusion;

  if(var_00 == "none")
    var_01 = 1;
  else if(scripts\engine\utility::array_contains(var_02, var_00))
    var_01 = 1;
  else if(scripts\engine\utility::array_contains(var_02, getweaponbasename(var_00)))
    var_01 = 1;
  else if(is_melee_weapon(var_00, 1) || isDefined(level.primary_melee_weapons) && scripts\engine\utility::array_contains(level.primary_melee_weapons, var_00))
    var_01 = 1;

  if(var_01) {
    var_03 = self getweaponslistall();

    for(var_04 = 0; var_04 < var_3.size; var_4++) {
      if(var_3[var_04] == "none")
        continue;
      else if(scripts\engine\utility::array_contains(var_02, var_3[var_04]))
        continue;
      else if(scripts\engine\utility::array_contains(var_02, getweaponbasename(var_3[var_04])))
        continue;
      else if(is_melee_weapon(var_3[var_04], 1) || isDefined(level.primary_melee_weapons) && scripts\engine\utility::array_contains(level.primary_melee_weapons, var_3[var_04]))
        continue;
      else if(!scripts\cp\cp_weapon::isprimaryweapon(var_3[var_04]))
        continue;
      else {
        var_01 = 0;
        var_00 = var_3[var_04];
        break;
      }
    }
  }

  if(var_01) {
    var_00 = "iw7_fists_zm";

    if(!self hasweapon(var_00))
      _giveweapon(var_00, undefined, undefined, 1);
  }

  return var_00;
}

getvalidtakeweapon(var_00) {
  var_01 = self getcurrentweapon();
  var_02 = 0;
  var_03 = level.additional_laststand_weapon_exclusion;

  if(isDefined(var_00))
    var_03 = scripts\engine\utility::array_combine(var_00, var_03);

  if(var_01 == "none")
    var_02 = 1;
  else if(scripts\engine\utility::array_contains(var_03, var_01))
    var_02 = 1;
  else if(scripts\engine\utility::array_contains(var_03, getweaponbasename(var_01)))
    var_02 = 1;
  else if(is_melee_weapon(var_01, 1))
    var_02 = 1;

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_02) {
    var_01 = self.last_valid_weapon;

    if(var_01 == "none")
      var_02 = 1;
    else if(scripts\engine\utility::array_contains(var_03, var_01))
      var_02 = 1;
    else if(scripts\engine\utility::array_contains(var_03, getweaponbasename(var_01)))
      var_02 = 1;
    else if(is_melee_weapon(var_01, 1))
      var_02 = 1;
    else
      var_02 = 0;
  }

  if(var_02) {
    var_04 = self getweaponslistall();

    for(var_05 = 0; var_05 < var_4.size; var_5++) {
      if(var_4[var_05] == "none")
        continue;
      else if(scripts\engine\utility::array_contains(var_03, var_4[var_05]))
        continue;
      else if(scripts\engine\utility::array_contains(var_03, getweaponbasename(var_4[var_05])))
        continue;
      else if(is_melee_weapon(var_4[var_05], 1))
        continue;
      else {
        var_02 = 0;
        var_01 = var_4[var_05];
        break;
      }
    }
  }

  return var_01;
}

getcurrentcamoname(var_00) {
  var_01 = getweaponcamoname(var_00);

  if(!isDefined(var_01))
    return undefined;

  switch (var_01) {
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
      return var_01;
  }

  return undefined;
}

add_to_notify_queue(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(self.notify_queue))
    self.notify_queue = [];

  if(!isDefined(self.notify_queue[var_00]))
    self.notify_queue[var_00] = 0;
  else
    self.notify_queue[var_00]++;

  if(self.notify_queue[var_00] > 0)
    wait(0.05 * self.notify_queue[var_00]);

  self notify(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  waittillframeend;

  if(isDefined(self.notify_queue[var_00])) {
    self.notify_queue[var_00]--;

    if(self.notify_queue[var_00] < 1)
      self.notify_queue[var_00] = undefined;
  }
}

take_fists_weapon(var_00) {
  foreach(var_02 in var_00 getweaponslistall()) {
    if(issubstr(var_02, "iw7_fists"))
      var_00 giveuponsuppressiontime(var_02);
  }
}

playlocalsound_safe(var_00) {
  if(soundexists(var_00))
    self playlocalsound(var_00);
}

stoplocalsound_safe(var_00) {
  if(soundexists(var_00))
    self stopolcalsound(var_00);
}

playsoundatpos_safe(var_00, var_01) {
  if(soundexists(var_01))
    playLoopSound(var_00, var_01);
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

firegesturegrenade(var_00, var_01) {
  var_02 = var_00 getcurrentweapon();

  if(cangiveandfireoffhand(var_02)) {
    var_00 setweaponammostock(var_01, 1);
    var_00 giveandfireoffhand(var_01);
  }
}

cangiveandfireoffhand(var_00) {
  if(!isDefined(var_00))
    return 1;

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(var_00)]))
      return 0;
    else
      return 1;
  } else
    return 1;
}

play_interaction_gesture(var_00) {
  if(!isDefined(var_00))
    var_00 = "iw7_powerlever_zm";

  if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp")
    thread firegesturegrenade(self, var_00);
}

deactivatebrushmodel(var_00, var_01) {
  var_00 notsolid();

  if(scripts\engine\utility::is_true(var_01))
    var_00 hide();
}

rankingenabled() {
  if(!isplayer(self))
    return 0;

  return level.onlinegame && !self.usingonlinedataoffline;
}

bufferednotify(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  thread bufferednotify_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
}

bufferednotify_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  self endon("disconnect");
  level endon("game_ended");
  var_10 = "bufferedNotify_" + var_00;
  self notify(var_10);
  self endon(var_10);

  if(!isDefined(self.bufferednotifications))
    self.bufferednotifications = [];

  if(!isDefined(self.bufferednotifications[var_00]))
    self.bufferednotifications[var_00] = [];

  var_11 = spawnStruct();
  var_11.func_C8E5 = var_01;
  var_11.func_C8E6 = var_02;
  var_11.func_C8E7 = var_03;
  var_11.func_C8E8 = var_04;
  var_11.func_C8E9 = var_05;
  var_11.func_C8EA = var_06;
  var_11.func_C8EB = var_07;
  var_11.func_C8EC = var_08;
  var_11.param9 = var_09;
  self.bufferednotifications[var_00][self.bufferednotifications[var_00].size] = var_11;
  waittillframeend;

  while(self.bufferednotifications[var_00].size > 0) {
    var_11 = self.bufferednotifications[var_00][0];
    self notify(var_00, var_11.func_C8E5, var_11.func_C8E6, var_11.func_C8E7, var_11.func_C8E8, var_11.func_C8E9, var_11.func_C8EA, var_11.func_C8EB, var_11.func_C8EC, var_11.param9);
    self.bufferednotifications[var_00] = array_remove_index(self.bufferednotifications[var_00], 0);
    wait 0.05;
  }
}

debugprintline(var_00) {}
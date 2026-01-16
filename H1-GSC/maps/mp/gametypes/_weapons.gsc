/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_weapons.gsc
******************************************/

init() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");

  switch (maps\mp\_utility::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level.scavenger_altmode = 0;
      break;
    case 2:
      level.scavenger_secondary = 0;
      break;
    case 3:
      level.scavenger_altmode = 0;
      level.scavenger_secondary = 0;
      break;
  }

  var_0 = getdvar("g_gametype");
  var_1 = maps\mp\_utility::getattachmentlistbasenames();
  var_1 = common_scripts\utility::alphabetize(var_1);
  var_2 = tablegetrowcount("mp\statstable.csv");
  var_3 = tablegetcolumncount("mp\statstable.csv");
  level.weaponlist = [];
  level.weaponattachments = [];

  for (var_4 = 0; var_4 <= var_2; var_4++) {
    if(!issubstr(tablelookupbyrow("mp\statstable.csv", var_4, 2), "weapon_")) {
      continue;
    }
    if(tablelookupbyrow("mp\statstable.csv", var_4, 51) != "") {
      continue;
    }
    if(tablelookupbyrow("mp\statstable.csv", var_4, var_3 - 1) == "Never") {
      continue;
    }
    var_5 = tablelookupbyrow("mp\statstable.csv", var_4, 4);

    if(var_5 == "" || var_5 == "none") {
      continue;
    }
    if(issubstr(var_5, "iw5") || issubstr(var_5, "iw6")) {
      var_6 = maps\mp\_utility::getweaponnametokens(var_5);
      var_5 = var_6[0] + "_" + var_6[1] + "_mp";
      level.weaponlist[level.weaponlist.size] = var_5;
      continue;
    } else
      level.weaponlist[level.weaponlist.size] = var_5 + "_mp";

    var_7 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_5);
    var_8 = [];

    foreach(var_10 in var_1) {
      if(!isdefined(var_7[var_10])) {
        continue;
      }
      level.weaponlist[level.weaponlist.size] = var_5 + "_" + var_10 + "_mp";
      var_8[var_8.size] = var_10;
    }

    var_12 = [];

    for (var_13 = 0; var_13 < var_8.size - 1; var_13++) {
      var_14 = tablelookuprownum("mp\attachmentCombos.csv", 0, var_8[var_13]);

      for (var_15 = var_13 + 1; var_15 < var_8.size; var_15++) {
        if(tablelookup("mp\attachmentCombos.csv", 0, var_8[var_15], var_14) == "no") {
          continue;
        }
        var_12[var_12.size] = var_8[var_13] + "_" + var_8[var_15];
      }
    }

    foreach(var_17 in var_12)
    level.weaponlist[level.weaponlist.size] = var_5 + "_" + var_17 + "_mp";
  }

  if(!isdefined(level.iszombiegame) || !level.iszombiegame) {
    foreach(var_20 in level.weaponlist)
    precacheitem(var_20);
  }

  thread maps\mp\_flashgrenades::main();
  thread maps\mp\_entityheadicons::init();

  if(!isdefined(level.weapondropfunction))
    level.weapondropfunction = ::dropweaponfordeath;

  var_23 = 70;
  level.claymoredetectiondot = cos(var_23);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;

  if(!isdefined(level.iszombiegame) || !level.iszombiegame) {
    level.minedetectiongraceperiod = 0.3;
    level.minedetectionradius = 100;
    level.minedetectionheight = 20;
    level.minedamageradius = 256;
    level.minedamagemin = 70;
    level.minedamagemax = 210;
    level.minedamagehalfheight = 46;
    level.mineselfdestructtime = 120;
  }

  level.delayminetime = 3.0;
  level.stingerfxid = loadfx("fx\explosions\aerial_explosion_large");
  level.meleeweaponbloodflick = loadfx("vfx\blood\blood_flick_melee_weapon");
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.missile_array = [];
  level.inventory_array = [];
  level.mines = [];
  level.trophies = [];
  precachemodel("weapon_claymore_bombsquad_mw1");
  precachemodel("weapon_c4_bombsquad_mw1");
  precachelaser("mp_attachment_lasersight");
  precachelaser("mp_attachment_lasersight_short");
  level.c4fxid = loadfx("vfx\lights\light_c4_blink");
  level.claymorefxid = loadfx("vfx\props\claymore_laser");
  level thread onplayerconnect();
  level.c4explodethisframe = 0;
  common_scripts\utility::array_thread(getentarray("misc_turret", "classname"), ::turret_monitoruse);
}

bombsquadwaiter() {
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "h1_c4_mp") {
      if(!isdefined(level.bombsquadmodelc4))
        level.bombsquadmodelc4 = "weapon_c4_bombsquad_mw1";

      var_0 thread createbombsquadmodel(level.bombsquadmodelc4, "tag_origin", self);
      continue;
    }

    if(var_2 == "h1_claymore_mp") {
      if(!isdefined(level.bombsquadmodelclaymore))
        level.bombsquadmodelclaymore = "weapon_claymore_bombsquad_mw1";

      var_0 thread createbombsquadmodel(level.bombsquadmodelclaymore, "tag_origin", self);
    }
  }
}

createbombsquadmodel(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 hide();
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  var_3 thread bombsquadvisibilityupdater(var_2);
  var_3 setmodel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 setcontents(0);
  self waittill("death");

  if(isdefined(self.trigger))
    self.trigger delete();

  var_3 delete();
}

bombsquadvisibilityupdater(var_0) {
  self endon("death");

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = var_0.team;
  checkbombsquadvisibility(var_0, var_1);

  for (;;) {
    level common_scripts\utility::waittill_any("joined_team", "player_spawned", "changed_kit", "update_bombsquad");
    self hide();
    checkbombsquadvisibility(var_0, var_1);
  }
}

checkbombsquadvisibility(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(level.teambased) {
      if(!isdefined(var_3.team) || var_3.team == "spectator") {
        continue;
      }
      if(var_3.team != var_1 && var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
        self showtoplayer(var_3);

      continue;
    }

    if(isdefined(var_0) && var_3 == var_0) {
      continue;
    }
    if(!var_3 maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
      continue;
    }
    self showtoplayer(var_3);
  }
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    var_0.issiliding = 0;
    maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0, 0);
    var_0 thread onplayerspawned();
    var_0 thread bombsquadwaiter();
    var_0 thread watchmissileusage();
    var_0 thread watchmeleeweapon();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    common_scripts\utility::waittill_any("spawned_player", "faux_spawn");
    self.currentweaponatspawn = self getcurrentweapon();
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;
    self.meleeweaponbloodytime = undefined;
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 0);

    if(!isdefined(self.trackingweaponname)) {
      self.trackingweaponname = "";
      self.trackingweaponname = "none";
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweaponhipfirekills = 0;
      self.trackingweapondeaths = 0;
      self.trackingweaponusetime = 0;
    }

    thread watchslide();
    thread watchweaponusage();
    thread watchgrenadeusage();
    thread watchstingerusage();
    thread watchweaponreload();
    thread watchmineusage();
    thread watchweaponinspection();

    if(!isdefined(level.iszombiegame) || !level.iszombiegame) {

    }

    thread stancerecoiladjuster();
    thread maps\mp\_opticsthermal::opticsthermal_think();
    thread maps\mp\_lasersight::lasersight_think();
    thread watchgrenadegraceperiod();

    if(!maps\mp\_utility::invirtuallobby())
      thread watchsentryusage();

    thread watchweaponchange();

    if(isdefined(level.onplayerspawnedweaponsfunc))
      self thread[[level.onplayerspawnedweaponsfunc]]();

    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponfrom = [];
    thread updatesavedlastweapon();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
    thread track_damage_info();

    if(!isdefined(self.spawninfo))
      self.spawninfo = spawnstruct();

    self.spawninfo.spawntime = gettime();
    self.spawninfo.damagedealttoofast = 0;
    self.spawninfo.damagereceivedtoofast = 0;
    self.spawninfo.badspawn = 0;
    var_0 = self.spawninfo.spawntime;

    if(!isdefined(self.num_lives))
      self.num_lives = 0;

    self.num_lives++;

    if(isagent(self)) {
      return;
    }
    var_1 = 0.1;
    var_2 = var_1;
    var_3 = "_matchdata.gsc";
    var_4 = -1;
    var_5 = -1;
    var_6 = -1;

    if(isdefined(self.spawninfo)) {
      if(isdefined(self.spawninfo.spawnpoint)) {
        if(isdefined(self.spawninfo.spawnpoint.israndom))
          var_4 = self.spawninfo.spawnpoint.israndom;

        if(isdefined(self.spawninfo.spawnpoint.numberofpossiblespawnchoices))
          var_5 = self.spawninfo.spawnpoint.numberofpossiblespawnchoices;

        if(isdefined(self.spawninfo.spawnpoint.lastupdatetime))
          var_6 = self.spawninfo.spawnpoint.lastupdatetime;
      }
    }

    reconspatialevent(self.spawnpos, "script_mp_playerspawn: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, version %f, script_file %s, randomSpawn %b, number_of_choices %d, last_update_time %d", self.name, self.lifeid, self.num_lives, self.wasti, self.team, var_0, var_2, var_3, var_4, var_5, var_6);
  }
}

recordtogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(var_2 == self.primaryweapon || var_2 == self.secondaryweapon) {
      var_3 = getweaponattachments(var_2);

      foreach(var_5 in var_3) {
        if(var_5 == "variablereddot") {
          self.pers["toggleScopeStates"][var_2] = self gethybridsightenabled(var_2);
          break;
        }
      }
    }
  }
}

watchstingerusage() {
  maps\mp\_stinger::stingerusageloop();
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread watchstartweaponchange();
  self.lastdroppableweapon = self.currentweaponatspawn;
  self.hitsthismag = [];
  var_0 = self getcurrentweapon();

  if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isdefined(self.hitsthismag[var_0]))
    self.hitsthismag[var_0] = weaponclipsize(var_0);

  self.bothbarrels = undefined;

  if(issubstr(var_0, "ranger"))
    thread watchrangerusage(var_0);

  var_1 = 1;

  for (;;) {
    if(!var_1)
      self waittill("weapon_change");

    var_1 = 0;
    var_0 = self getcurrentweapon();

    if(var_0 == "none") {
      continue;
    }
    var_2 = getweaponattachments(var_0);
    self.has_opticsthermal = 0;
    self.has_target_enhancer = 0;
    self.has_stock = 0;
    self.has_laser = 0;

    if(isdefined(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "opticstargetenhancer") {
          self.has_target_enhancer = 1;
          continue;
        }

        if(var_4 == "stock") {
          self.has_stock = 1;
          continue;
        }

        if(var_4 == "lasersight") {
          self.has_laser = 1;
          continue;
        }

        if(issubstr(var_4, "opticsthermal"))
          self.has_opticsthermal = 1;
      }
    }

    if(maps\mp\_utility::isbombsiteweapon(var_0)) {
      continue;
    }
    var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    self.bothbarrels = undefined;

    if(issubstr(var_0, "ranger"))
      thread watchrangerusage(var_0);

    if(var_6[0] == "alt") {
      var_7 = getsubstr(var_0, 4);
      var_0 = var_7;
      var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    }

    if(var_0 != "none" && var_6[0] != "iw5" && var_6[0] != "iw6" && var_6[0] != "h1") {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isdefined(self.hitsthismag[var_0 + "_mp"]))
        self.hitsthismag[var_0 + "_mp"] = weaponclipsize(var_0 + "_mp");
    } else if(var_0 != "none" && (var_6[0] == "iw5" || var_6[0] == "iw6" || var_6[0] == "h1")) {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isdefined(self.hitsthismag[var_0]))
        self.hitsthismag[var_0] = weaponclipsize(var_0);
    }

    if(maydropweapon(var_0))
      self.lastdroppableweapon = var_0;

    self.changingweapon = undefined;
  }
}

watchstartweaponchange() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self.changingweapon = undefined;

  for (;;) {
    self waittill("weapon_switch_started", var_0);
    self.changingweapon = var_0;

    if(var_0 == "none" && isdefined(self.iscapturingcrate) && self.iscapturingcrate) {
      while (self.iscapturingcrate)
        wait 0.05;

      self.changingweapon = undefined;
    }
  }
}

watchweaponreload() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();
    self.bothbarrels = undefined;

    if(!issubstr(var_0, "ranger")) {
      continue;
    }
    thread watchrangerusage(var_0);
  }
}

watchrangerusage(var_0) {
  var_1 = self getweaponammoclip(var_0, "right");
  var_2 = self getweaponammoclip(var_0, "left");
  self endon("reload");
  self endon("weapon_change");
  self endon("faux_spawn");

  for (;;) {
    self waittill("weapon_fired", var_3);

    if(var_3 != var_0) {
      continue;
    }
    self.bothbarrels = undefined;

    if(issubstr(var_0, "akimbo")) {
      var_4 = self getweaponammoclip(var_0, "left");
      var_5 = self getweaponammoclip(var_0, "right");

      if(var_2 != var_4 && var_1 != var_5)
        self.bothbarrels = 1;

      if(!var_4 || !var_5) {
        return;
      }
      var_2 = var_4;
      var_1 = var_5;
      continue;
    }

    if(var_1 == 2 && !self getweaponammoclip(var_0, "right")) {
      self.bothbarrels = 1;
      return;
    }
  }
}

maydropweapon(var_0) {
  if(var_0 == "none")
    return 0;

  if(issubstr(var_0, "uav"))
    return 0;

  if(issubstr(var_0, "killstreak"))
    return 0;

  if(maps\mp\_utility::getweaponclass(var_0) == "weapon_projectile")
    return 0;

  var_1 = weaponinventorytype(var_0);

  if(var_1 != "primary")
    return 0;

  if(issubstr(var_0, "combatknife") || issubstr(var_0, "underwater"))
    return 0;

  return 1;
}

dropweaponfordeath(var_0, var_1) {
  if(!maps\mp\_utility::isusingremote())
    waittillframeend;

  if(isdefined(level.blockweapondrops)) {
    return;
  }
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.droppeddeathweapon)) {
    return;
  }
  if(level.ingraceperiod) {
    return;
  }
  var_2 = self.lastdroppableweapon;

  if(!isdefined(var_2)) {
    return;
  }
  if(var_2 == "none") {
    return;
  }
  if(!self hasweapon(var_2)) {
    return;
  }
  if(maps\mp\_utility::isjuggernaut()) {
    return;
  }
  if(isdefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_2)) {
    return;
  }
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);

  if(var_3[0] == "alt") {
    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_4 > 0 && var_4 < 2) {
        var_2 = var_2 + var_3[var_4];
        continue;
      }

      if(var_4 > 0) {
        var_2 = var_2 + ("_" + var_3[var_4]);
        continue;
      }

      var_2 = "";
    }
  }

  if(var_2 != "riotshield_mp") {
    if(!self anyammoforweaponmodes(var_2)) {
      return;
    }
    var_5 = self getweaponammoclip(var_2, "right");
    var_6 = self getweaponammoclip(var_2, "left");

    if(!var_5 && !var_6) {
      return;
    }
    var_7 = self getweaponammostock(var_2);
    var_8 = weaponmaxammo(var_2);

    if(var_7 > var_8)
      var_7 = var_8;

    var_9 = self dropitem(var_2);

    if(!isdefined(var_9)) {
      return;
    }
    if(maps\mp\_utility::ismeleemod(var_1))
      var_9.origin = (var_9.origin[0], var_9.origin[1], var_9.origin[2] - 5);

    var_9 itemweaponsetammo(var_5, var_7, var_6);
  } else {
    var_9 = self dropitem(var_2);

    if(!isdefined(var_9)) {
      return;
    }
    var_9 itemweaponsetammo(1, 1, 0);
  }

  var_9 itemweaponsetammo(0, 0, 0, 1);
  self.droppeddeathweapon = 1;
  var_9.owner = self;
  var_9.ownersattacker = var_0;
  var_9.targetname = "dropped_weapon";
  var_9 thread watchpickup();
  var_9 thread deletepickupafterawhile();
}

detachifattached(var_0, var_1) {
  var_2 = self getattachsize();

  for (var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self getattachmodelname(var_3);

    if(var_4 != var_0) {
      continue;
    }
    var_5 = self getattachtagname(var_3);
    self detach(var_0, var_5);

    if(var_5 != var_1) {
      var_2 = self getattachsize();

      for (var_3 = 0; var_3 < var_2; var_3++) {
        var_5 = self getattachtagname(var_3);

        if(var_5 != var_1) {
          continue;
        }
        var_0 = self getattachmodelname(var_3);
        self detach(var_0, var_5);
        break;
      }
    }

    return 1;
  }

  return 0;
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isdefined(self)) {
    return;
  }
  self delete();
}

getitemweaponname() {
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

watchpickup() {
  self endon("death");
  var_0 = getitemweaponname();
  var_1 = self.owner;

  for (;;) {
    self waittill("trigger", var_2, var_3);

    if(isdefined(var_0) && var_0 == var_2.primaryweapon) {
      return;
    }
    if(isdefined(var_0) && var_0 == var_2.secondaryweapon) {
      return;
    }
    var_2.pickedupweaponfrom[var_0] = undefined;
    var_2.tookweaponfrom[var_0] = undefined;

    if(isdefined(var_2.pers["weaponPickupsCount"]))
      var_2.pers["weaponPickupsCount"]++;

    if(isdefined(var_1) && var_1 != var_2) {
      var_2.pickedupweaponfrom[var_0] = var_1;

      if(isdefined(self.ownersattacker) && self.ownersattacker == var_2)
        var_2.tookweaponfrom[var_0] = var_1;
    }

    if(isdefined(var_3)) {
      break;
    }
  }

  var_3.owner = var_2;
  var_3.targetname = "dropped_weapon";
  var_4 = var_3 getitemweaponname();

  if(isdefined(var_2.primaryweapon) && var_2.primaryweapon == var_4)
    var_2.primaryweapon = var_0;

  if(isdefined(var_2.secondaryweapon) && var_2.secondaryweapon == var_4)
    var_2.secondaryweapon = var_0;

  if(isdefined(var_2.pickedupweaponfrom[var_4])) {
    var_3.owner = var_2.pickedupweaponfrom[var_4];
    var_2.pickedupweaponfrom[var_4] = undefined;
  }

  if(isdefined(var_2.tookweaponfrom[var_4])) {
    var_3.ownersattacker = var_2;
    var_2.tookweaponfrom[var_4] = undefined;
  }

  var_3 thread watchpickup();
}

itemremoveammofromaltmodes() {
  var_0 = getitemweaponname();
  var_1 = weaponaltweaponname(var_0);

  for (var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self itemweaponsetammo(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

handlescavengerbagpickup(var_0) {
  self endon("death");
  level endon("game_ended");
  self waittill("scavenger", var_1);
  var_1 notify("scavenger_pickup");
  var_2 = var_1 getweaponslistoffhands();

  foreach(var_4 in var_2) {
    if(maps\mp\gametypes\_class::isvalidoffhand(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_tacticalresupply")) {
      var_1 batteryfullrecharge(var_4);
      continue;
    }

    if(maps\mp\gametypes\_class::isvalidequipment(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_lethalresupply")) {
      var_5 = var_1 getweaponammoclip(var_4);
      var_1 setweaponammoclip(var_4, var_5 + 1);
    }
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_scavenger")) {
    var_7 = var_1 getweaponslistprimaries();

    foreach(var_9 in var_7) {
      if(maps\mp\_utility::iscacprimaryweapon(var_9) || level.scavenger_secondary && maps\mp\_utility::iscacsecondaryweapon(var_9)) {
        var_10 = var_1 getweaponammostock(var_9);
        var_11 = 0;
        var_12 = maps\mp\_utility::getweaponclass(var_9);

        if(isbeamweapon(var_9) || var_12 == "weapon_riot" || issubstr(var_9, "riotshield")) {

        } else if(var_12 == "weapon_projectile") {
          if(var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
            var_11 = weaponclipsize(var_9);
        } else if(issubstr(var_9, "alt") && issubstr(var_9, "gl")) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
            var_11 = weaponclipsize(var_9);
        } else if(isbulletweapon(var_9)) {
          if(var_1 maps\mp\_utility::_hasperk("specialty_bulletresupply")) {
            var_13 = weaponmaxammo(var_9);
            var_11 = int(var_13 * var_1.ammopickup_scalar);
          }
        }

        if(var_11 > 0)
          var_1 setweaponammostock(var_9, var_10 + var_11);
      }
    }
  }

  var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scavenger");
}

dropscavengerfordeath(var_0) {
  waittillframeend;

  if(level.ingraceperiod) {
    return;
  }
  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(var_0 == self) {
    return;
  }
  if(level.iszombiegame) {
    return;
  }
  if(!isdefined(self.agentbody))
    var_1 = self dropscavengerbag("scavenger_bag_mp");
  else
    var_1 = self.agentbody dropscavengerbag("scavenger_bag_mp");

  var_1 thread handlescavengerbagpickup(self);

  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_add_scavenger_bag"]))
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_1);
}

getweaponbasedgrenadecount(var_0) {
  return 2;
}

getweaponbasedsmokegrenadecount(var_0) {
  return 1;
}

getfraggrenadecount() {
  var_0 = "h1_fraggrenade_mp";
  var_1 = self getammocount(var_0);
  return var_1;
}

getsmokegrenadecount() {
  var_0 = "h1_smokegrenade_mp";
  var_1 = self getammocount(var_0);
  return var_1;
}

setweaponstat(var_0, var_1, var_2) {
  maps\mp\gametypes\_gamelogic::setweaponstat(var_0, var_1, var_2);
}

watchweaponusage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for (;;) {
    self waittill("weapon_fired", var_1);
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
    self.lastshotfiredtime = gettime();

    if(isai(self)) {
      continue;
    }
    if(!maps\mp\_utility::iscacprimaryweapon(var_1) && !maps\mp\_utility::iscacsecondaryweapon(var_1) && !maps\mp\_utility::iscacmeleeweapon(var_1)) {
      continue;
    }
    if(isdefined(self.hitsthismag[var_1]))
      thread updatemagshots(var_1);

    var_2 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
    var_3 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
    var_4 = clamp(float(var_3) / float(var_2), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("totalShots", var_2);
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_4));
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_2 - var_3));

    if(isdefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
      self.hits = 0;
      return;
    }

    var_5 = 1;
    setweaponstat(var_1, var_5, "shots");
    setweaponstat(var_1, self.hits, "hits");
    self.hits = 0;
  }
}

updatemagshots(var_0) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("updateMagShots_" + var_0);
  self.hitsthismag[var_0]--;
  wait 0.05;
  self.hitsthismag[var_0] = weaponclipsize(var_0);
}

checkhitsthismag(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("updateMagShots_" + var_0);
  waittillframeend;

  if(isdefined(self.hitsthismag[var_0]) && self.hitsthismag[var_0] == 0) {
    var_1 = maps\mp\_utility::getweaponclass(var_0);
    maps\mp\gametypes\_missions::genericchallenge(var_1);
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }
}

checkhit(var_0, var_1) {
  self endon("disconnect");

  if(maps\mp\_utility::isstrstart(var_0, "alt_")) {
    var_2 = maps\mp\_utility::getweaponnametokens(var_0);

    foreach(var_4 in var_2) {
      if(var_4 == "shotgun") {
        var_5 = getsubstr(var_0, 0, 4);

        if(!isprimaryweapon(var_5) && !issidearm(var_5))
          self.hits = 1;

        continue;
      }

      if(var_4 == "hybrid") {
        var_6 = getsubstr(var_0, 4);
        var_0 = var_6;
      }
    }
  }

  var_8 = ismeleeinventoryweapon(var_0);

  if(!isprimaryweapon(var_0) && !issidearm(var_0) && !var_8) {
    return;
  }
  if(self meleebuttonpressed() && !var_8) {
    return;
  }
  switch (weaponclass(var_0)) {
    case "sniper":
    case "pistol":
    case "mg":
    case "smg":
    case "rifle":
      self.hits++;
      break;
    case "spread":
      self.hits = 1;
      break;
    default:
      break;
  }

  if(issubstr(var_0, "riotshield")) {
    thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname("riotshield", self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend;

  if(isdefined(self.hitsthismag[var_0]))
    thread checkhitsthismag(var_0);

  if(!isdefined(self.lasthittime[var_0]))
    self.lasthittime[var_0] = 0;

  if(self.lasthittime[var_0] == gettime()) {
    return;
  }
  self.lasthittime[var_0] = gettime();
  var_9 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
  var_10 = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

  if(var_10 <= var_9) {
    maps\mp\gametypes\_persistence::statsetbuffered("hits", var_10);
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_9 - var_10));
    var_11 = clamp(float(var_10) / float(var_9), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_11));
  }
}

attackercandamageitem(var_0, var_1) {
  return friendlyfirecheck(var_1, var_0);
}

friendlyfirecheck(var_0, var_1, var_2) {
  if(!isdefined(var_0))
    return 1;

  if(!level.teambased)
    return 1;

  var_3 = var_1.team;
  var_4 = level.friendlyfire;

  if(isdefined(var_2))
    var_4 = var_2;

  if(var_4 != 0)
    return 1;

  if(var_1 == var_0)
    return 1;

  if(!isdefined(var_3))
    return 1;

  if(var_3 != var_0.team)
    return 1;

  return 0;
}

watchgrenadeusage() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.throwinggrenade = undefined;
  self.gotpullbacknotify = 0;

  if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
    if(isdefined(self.dont_delete_grenades_on_next_spawn))
      self.dont_delete_grenades_on_next_spawn = undefined;
    else
      delete_all_grenades();
  } else {
    if(!isdefined(self.manuallydetonatedarray))
      self.manuallydetonatedarray = [];

    if(!isdefined(self.claymorearray))
      self.claymorearray = [];

    if(!isdefined(self.bouncingbettyarray))
      self.bouncingbettyarray = [];
  }

  thread watchmanuallydetonatedusage();
  thread watchmanualdetonationbyemptythrow();
  thread watchmanualdetonationbydoubletap();
  thread watchc4usage();
  thread watchclaymores();
  thread deletec4andclaymoresondisconnect();
  thread watchforthrowbacks();

  for (;;) {
    self waittill("grenade_pullback", var_0);
    setweaponstat(var_0, 1, "shots");
    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
    thread watchoffhandcancel();

    if(var_0 == "h1_claymore_mp") {
      continue;
    }
    self.throwinggrenade = var_0;
    self.gotpullbacknotify = 1;

    if(var_0 == "h1_c4_mp")
      beginc4tracking();
    else
      begingrenadetracking();

    self.throwinggrenade = undefined;
  }
}

begingrenadetracking() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  self endon("offhand_end");
  self endon("weapon_change");
  var_0 = gettime();
  self waittill("grenade_fire", var_1, var_2);

  if(isdefined(var_1)) {
    var_3 = maps\mp\_utility::strip_suffix(var_2, "_lefthand");

    if(gettime() - var_0 > 1000 && var_3 == "h1_fraggrenade_mp")
      var_1.iscooked = 1;

    self.changingweapon = undefined;
    var_1.owner = self;
    var_1.weaponname = var_2;

    switch (var_3) {
      case "h1_fraggrenade_mp":
        var_1 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
        var_1.originalowner = self;
        break;
    }
  }
}

watchoffhandcancel() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isdefined(self.changingweapon) && self.changingweapon != self getcurrentweapon())
    self.changingweapon = undefined;
}

watchsmokeexplode() {
  level endon("smokeTimesUp");
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  var_2 = 128;
  var_3 = 8;
  level thread waitsmoketime(var_3, var_2, var_1);

  for (;;) {
    if(!isdefined(var_0)) {
      break;
    }

    foreach(var_5 in level.players) {
      if(!isdefined(var_5)) {
        continue;
      }
      if(level.teambased && var_5.team == var_0.team) {
        continue;
      }
      if(distancesquared(var_5.origin, var_1) < var_2 * var_2) {
        var_5.inplayersmokescreen = var_0;
        continue;
      }

      var_5.inplayersmokescreen = undefined;
    }

    wait 0.05;
  }
}

waitsmoketime(var_0, var_1, var_2) {
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  level notify("smokeTimesUp");
  waittillframeend;

  foreach(var_4 in level.players) {
    if(isdefined(var_4))
      var_4.inplayersmokescreen = undefined;
  }
}

watchmissileusage() {
  self endon("disconnect");

  for (;;) {
    self waittill("missile_fire", var_0, var_1);
    var_2 = [var_0];

    if(issubstr(var_1, "_gl")) {
      var_0.owner = self;
      var_0.primaryweapon = self getcurrentprimaryweapon();
      var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
    }

    if(isdefined(var_0)) {
      var_0.weaponname = var_1;

      if(isprimaryorsecondaryprojectileweapon(var_1))
        var_0.firedads = self playerads();
    }

    switch (var_1) {
      case "iw5_lsr_mp":
      case "stinger_mp":
        var_0.lockedstingertarget = self.stingertarget;
        level notify("stinger_fired", self, var_2);
        thread maps\mp\_utility::setaltsceneobj(var_0, "tag_origin", 65);
        break;
      default:
        break;
    }

    switch (var_1) {
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
      case "rpg_mp":
        var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
      default:
        break;
    }
  }
}

watchhitbymissile() {
  self endon("disconnect");

  for (;;) {
    self waittill("hit_by_missile", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!isdefined(var_0) || !isdefined(var_1)) {
      continue;
    }
    if(level.teambased && self.team == var_0.team) {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    if(var_2 != "rpg_mp") {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    if(randomintrange(0, 100) < 99) {
      self cancelrocketcorpse(var_1, var_3, var_4, var_5, var_6, var_7);
      continue;
    }

    var_8 = getdvarfloat("rocket_corpse_max_air_time", 0.5);
    var_9 = getdvarfloat("rocket_corpse_view_offset_up", 100);
    var_10 = getdvarfloat("rocket_corpse_view_offset_forward", 35);
    self.isrocketcorpse = 1;
    self setcontents(0);
    var_11 = self setrocketcorpse(1);
    var_12 = var_11 / 1000.0;
    self.killcament = spawn("script_model", var_1.origin);
    self.killcament.angles = var_1.angles;
    self.killcament linkto(var_1);
    self.killcament setscriptmoverkillcam("rocket_corpse");
    self.killcament setcontents(0);
    self dodamage(1000, self.origin, var_0, var_1);
    self.body = self cloneplayer(var_11);
    self.body.origin = var_1.origin;
    self.body.angles = var_1.angles;
    self.body setcorpsefalling(0);
    self.body enablelinkto();
    self.body linkto(var_1);
    self.body setcontents(0);

    if(!isdefined(self.switching_teams))
      thread maps\mp\gametypes\_deathicons::adddeathicon(self.body, self, self.team, 5.0, 0);

    self playerhide();
    var_13 = vectornormalize(anglestoup(var_1.angles));
    var_14 = vectornormalize(anglestoforward(var_1.angles));
    var_15 = var_14 * var_9 + var_13 * var_10;
    var_16 = var_1.origin + var_15;
    var_17 = spawn("script_model", var_16);
    var_17 setmodel("tag_origin");
    var_17.angles = vectortoangles(var_1.origin - var_17.origin);
    var_17 linkto(var_1);
    var_17 setcontents(0);
    self cameralinkto(var_17, "tag_origin");

    if(var_8 > var_12)
      var_8 = var_12;

    var_18 = var_1 common_scripts\utility::waittill_notify_or_timeout_return("death", var_8);

    if(isdefined(var_18) && var_18 == "timeout" && isdefined(var_1))
      var_1 detonate();

    self notify("final_rocket_corpse_death");
    self.body unlink();
    self.body setcorpsefalling(1);
    self.body startragdoll();
    var_17 linkto(self.body);
    self.isrocketcorpse = undefined;
    self waittill("death_delay_finished");
    self cameraunlink();
    self.killcament delete();
    var_17 delete();
  }
}

watchsentryusage() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    self waittill("sentry_placement_finished", var_0);
    thread maps\mp\_utility::setaltsceneobj(var_0, "tag_flash", 65);
  }
}

empexplodewaiter() {
  thread maps\mp\gametypes\_shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  var_1 = getempdamageents(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isdefined(var_3.owner) && !friendlyfirecheck(self.owner, var_3.owner)) {
      continue;
    }
    var_3 notify("emp_damage", self.owner, 8.0);
  }
}

ninebangexplodewaiter() {
  thread maps\mp\gametypes\_shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  level thread doninebang(var_0, self.owner);
  var_1 = getempdamageents(var_0, 512, 0);

  foreach(var_3 in var_1) {
    if(isdefined(var_3.owner) && !friendlyfirecheck(self.owner, var_3.owner)) {
      continue;
    }
    var_3 notify("emp_damage", self.owner, 8.0);
  }
}

flashbangplayer(var_0, var_1, var_2) {
  var_3 = 640000;
  var_4 = 40000;
  var_5 = 60;
  var_6 = 40;
  var_7 = 11;

  if(!maps\mp\_utility::isreallyalive(var_0) || var_0.sessionstate != "playing") {
    return;
  }
  var_8 = distancesquared(var_1, var_0.origin);

  if(var_8 > var_3) {
    return;
  }
  if(var_8 <= var_4)
    var_9 = 1.0;
  else
    var_9 = 1.0 - (var_8 - var_4) / (var_3 - var_4);

  var_10 = var_0 sightconetrace(var_1);

  if(var_10 < 0.5) {
    return;
  }
  var_11 = anglestoforward(var_0 getplayerangles());
  var_12 = var_0.origin;

  switch (var_0 getstance()) {
    case "stand":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_5);
      break;
    case "crouch":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_6);
      break;
    case "prone":
      var_12 = (var_12[0], var_12[1], var_12[2] + var_7);
      break;
  }

  var_13 = var_1 - var_12;
  var_13 = vectornormalize(var_13);
  var_14 = 0.5 * (1.0 + vectordot(var_11, var_13));
  var_0 notify("flashbang", var_1, var_9, var_14, var_2);
}

doninebang(var_0, var_1) {
  level endon("game_ended");
  var_2 = 1;

  for (var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 > 0) {
      playsoundatpos(var_0, "null");

      foreach(var_5 in level.players)
      flashbangplayer(var_5, var_0, var_1);
    }

    var_7 = getempdamageents(var_0, 512, 0);

    foreach(var_9 in var_7) {
      if(isdefined(var_9.owner) && !friendlyfirecheck(self.owner, var_9.owner)) {
        continue;
      }
      var_9 notify("emp_damage", self.owner, 8.0);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

beginc4tracking() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::waittill_any("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

watchforthrowbacks() {
  self endon("faux_spawn");
  self endon("death");
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(self.gotpullbacknotify) {
      self.gotpullbacknotify = 0;
      continue;
    }

    if(!issubstr(var_1, "h1_frag")) {
      continue;
    }
    var_0.threwback = 1;
    var_0.originalowner = self;
    var_0 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
  }
}

manuallydetonated_removeundefined(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isdefined(var_3[0])) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

watchmanuallydetonatedusage() {
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = isweaponmanuallydetonatedbyemptythrow(var_1);
    var_3 = isweaponmanuallydetonatedbydoubletap(var_1);

    if(var_2 || var_3) {
      if(!self.manuallydetonatedarray.size)
        thread watchmanuallydetonatedfordoubletap();

      if(self.manuallydetonatedarray.size) {
        self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);

        if(self.manuallydetonatedarray.size >= level.maxperplayerexplosives)
          self.manuallydetonatedarray[0][0] detonate();
      }

      var_4 = self.manuallydetonatedarray.size;
      self.manuallydetonatedarray[var_4] = [];
      self.manuallydetonatedarray[var_4][0] = var_0;
      self.manuallydetonatedarray[var_4][1] = var_2;
      self.manuallydetonatedarray[var_4][2] = var_3;

      if(isdefined(var_0)) {
        var_0.owner = self;
        var_0 setotherent(self);
        var_0.team = self.team;
        var_0.weaponname = var_1;
        var_0.stunned = 0;
      }
    }
  }
}

watchc4usage() {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "c4" || var_1 == "h1_c4_mp") {
      level.mines[level.mines.size] = var_0;
      var_0 thread maps\mp\gametypes\_shellshock::c4_earthquake();
      var_0 thread c4damage(var_1);
      var_0 thread c4empdamage();
      var_0 thread c4empkillstreakwait();
      var_0 thread watchc4stuck();
    }
  }
}

watchc4stuck() {
  self endon("death");
  self waittill("missile_stuck");
  self.trigger = spawn("script_origin", self.origin);
  self.trigger.owner = self;
  makeexplosivetargetablebyai();
  thread playc4effects();
}

playc4effects() {
  var_0 = self gettagorigin("tag_fx");
  var_1 = self gettagangles("tag_fx");
  var_2 = spawnlinkedfx(level.c4fxid, self, "tag_fx");
  triggerfx(var_2);
  self waittill("death");
  var_2 delete();
}

c4empdamage() {
  self endon("death");

  for (;;) {
    self waittill("emp_damage", var_0, var_1);
    playfxontag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    self.disabled = undefined;
    self notify("enabled");
  }
}

c4empkillstreakwait() {
  self endon("death");

  for (;;) {
    level waittill("emp_update");
    self.disabled = undefined;
    self notify("enabled");
  }
}

setmineteamheadicon(var_0) {
  if(!maps\mp\_utility::invirtuallobby()) {
    self endon("death");
    wait 0.05;

    if(level.teambased)
      maps\mp\_entityheadicons::setteamheadicon(var_0, (0, 0, 20));
    else if(isdefined(self.owner))
      maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0, 0, 20));
  }
}

watchclaymores() {
  self endon("faux_spawn");
  self endon("spawned_player");
  self endon("disconnect");
  self.claymorearray = [];

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "claymore" || var_1 == "h1_claymore_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);

      if(self.claymorearray.size >= level.maxperplayerexplosives) {
        if(!maps\mp\_utility::invirtuallobby())
          deleteequipment(self.claymorearray[0]);
        else
          self.claymorearray[0] detonate();
      }

      self.claymorearray[self.claymorearray.size] = var_0;
      var_0.owner = self;
      var_0 setotherent(self);
      var_0.team = self.team;
      var_0.weaponname = var_1;
      var_0.trigger = spawn("script_origin", var_0.origin);
      var_0.trigger.owner = var_0;
      var_0.stunned = 0;
      var_0 makeexplosivetargetablebyai();
      level.mines[level.mines.size] = var_0;
      var_0 thread c4damage(var_1);
      var_0 thread handleclaymoreeffects();
      var_0 thread c4empdamage();
      var_0 thread c4empkillstreakwait();
      var_0 thread claymoredetonation();
      var_0 thread setmineteamheadicon(self.pers["team"]);
      self.changingweapon = undefined;
    }
  }
}

handleclaymoreeffects() {
  self endon("death");
  wait 0.15;
  thread playclaymoreeffects();
}

playclaymoreeffects() {
  var_0 = self gettagorigin("tag_fx");
  var_1 = self gettagangles("tag_fx");
  var_2 = spawnfx(level.claymorefxid, var_0, anglestoforward(var_1), anglestoup(var_1));
  triggerfx(var_2);
  self waittill("death");
  var_2 delete();
}

equipmentenableuse(var_0) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");
  self.trigger setcursorhint("HINT_NOICON");

  if(self.weaponname == "h1_c4_mp")
    self.trigger sethintstring(&"MP_PICKUP_C4");
  else if(self.weaponname == "h1_claymore_mp")
    self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
  else if(self.weaponname == "bouncingbetty_mp")
    self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");

  self.trigger maps\mp\_utility::setselfusable(var_0);
}

equipmentdisableuse(var_0) {
  self.trigger sethintstring("");
  self.trigger maps\mp\_utility::setselfunusuable();
}

equipmentwatchenabledisableuse(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = 1;

  for (;;) {
    if(var_0 getweaponammostock(self.weaponname) < weaponmaxammo(self.weaponname)) {
      if(!var_1) {
        equipmentenableuse(var_0);
        var_1 = 1;
      }
    } else if(var_1) {
      equipmentdisableuse(var_0);
      var_1 = 0;
    }

    wait 0.05;
  }
}

equipmentwatchuse(var_0, var_1) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self.trigger setcursorhint("HINT_NOICON");
  equipmentenableuse(var_0);

  if(isdefined(var_1) && var_1)
    thread updatetriggerposition();

  for (;;) {
    thread equipmentwatchenabledisableuse(var_0);
    self.trigger waittill("trigger", var_0);
    var_2 = var_0 getweaponammostock(self.weaponname);

    if(var_2 < weaponmaxammo(self.weaponname)) {
      var_0 playlocalsound("scavenger_pack_pickup");
      var_0 setweaponammostock(self.weaponname, var_2 + 1);
      self.trigger delete();
      self delete();
      self notify("death");
    }
  }
}

updatetriggerposition() {
  self endon("death");

  for (;;) {
    if(isdefined(self) && isdefined(self.trigger)) {
      self.trigger.origin = self.origin;

      if(isdefined(self.bombsquadmodel))
        self.bombsquadmodel.origin = self.origin;
    } else
      return;

    wait 0.05;
  }
}

claymoredetonation() {
  self endon("death");
  self endon("change_owner");
  var_0 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);
  thread deleteondeath(var_0);

  for (;;) {
    var_0 waittill("trigger", var_1);

    if(self.stunned) {
      wait 0.05;
      continue;
    }

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isdefined(self.owner)) {
        if(var_1 == self.owner) {
          continue;
        }
        if(isdefined(var_1.owner) && var_1.owner == self.owner)
          continue;
      }

      if(!friendlyfirecheck(self.owner, var_1, 0))
        continue;
    }

    if(lengthsquared(var_1 getentityvelocity()) < 10) {
      continue;
    }
    var_2 = abs(var_1.origin[2] - self.origin[2]);

    if(var_2 > 128) {
      continue;
    }
    if(!var_1 shouldaffectclaymore(self)) {
      continue;
    }
    if(var_1 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self playsound("claymore_activated");

  if(isplayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine")) {
    var_1 notify("triggered_claymore");
    wait(level.delayminetime);
  } else
    wait(level.claymoredetectiongraceperiod);

  if(isdefined(self.trigger))
    self.trigger delete();

  if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
    self.owner thread[[level.leaderdialogonplayer_func]]("claymore_destroyed", undefined, undefined, self.origin);

  self detonate();
}

shouldaffectclaymore(var_0) {
  if(isdefined(var_0.disabled))
    return 0;

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglestoforward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < level.claymoredetectionmindist)
    return 0;

  var_2 = vectornormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level.claymoredetectiondot;
}

deleteondeath(var_0) {
  self waittill("death");
  wait 0.05;

  if(isdefined(var_0)) {
    if(isdefined(var_0.trigger))
      var_0.trigger delete();

    var_0 delete();
  }
}

deleteequipment(var_0) {
  if(isdefined(var_0)) {
    if(isdefined(var_0.trigger))
      var_0.trigger delete();

    var_0 delete();
  }
}

watchmanuallydetonatedfordoubletap() {
  self endon("death");
  self endon("disconnect");
  self endon("all_detonated");
  level endon("game_ended");
  self endon("change_owner");
  var_0 = 0;

  for (;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;

      while (self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while (!self usebuttonpressed() && var_0 < 0.35) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.35) {
        continue;
      }
      if(!self.manuallydetonatedarray.size) {
        return;
      }
      self notify("detonate_double_tap");
    }

    wait 0.05;
  }
}

watchmanualdetonationbyemptythrow() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for (;;) {
    self waittill("detonate");
    manuallydetonateall(1);
  }
}

watchmanualdetonationbydoubletap() {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");

  for (;;) {
    self waittill("detonate_double_tap");
    var_0 = self getcurrentweapon();

    if(!isweaponmanuallydetonatedbydoubletap(var_0))
      manuallydetonateall(2);
  }
}

manuallydetonateall(var_0) {
  var_1 = 0;
  var_2 = [];

  for (var_3 = 0; var_3 < self.manuallydetonatedarray.size; var_3++) {
    if(!self.manuallydetonatedarray[var_3][var_0]) {
      var_1 = 1;
      continue;
    }

    var_4 = self.manuallydetonatedarray[var_3][0];

    if(isdefined(var_4)) {
      if(var_4.stunned) {
        var_1 = 1;
        return;
      }

      if(isdefined(var_4.weaponname) && !self getdetonateenabled(var_4.weaponname)) {
        var_1 = 1;
        continue;
      }

      if(isdefined(var_4.manuallydetonatefunc)) {
        self thread[[var_4.manuallydetonatefunc]](var_4);
        continue;
      }

      var_4 thread waitanddetonate(0, var_0);
    }
  }

  if(var_1)
    self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
  else {
    self.manuallydetonatedarray = var_2;
    self notify("all_detonated");
  }
}

waitanddetonate(var_0, var_1) {
  self endon("death");
  wait(var_0);
  waittillenabled();

  if(var_1 == 2)
    self detonatebydoubletap();
  else
    self detonate();

  level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

deletec4andclaymoresondisconnect() {
  self endon("faux_spawn");
  self endon("death");
  self waittill("disconnect");
  var_0 = self.manuallydetonatedarray;
  var_1 = self.claymorearray;
  wait 0.05;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isdefined(var_0[var_2][0]))
      var_0[var_2][0] delete();
  }

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isdefined(var_1[var_2]))
      var_1[var_2] delete();
  }
}

c4damage(var_0) {
  self endon("death");
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_1 = undefined;

  for (;;) {
    self waittill("damage", var_2, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isplayer(var_1) && !isagent(var_1)) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_1)) {
      continue;
    }
    if(isdefined(var_10)) {
      var_11 = maps\mp\_utility::strip_suffix(var_10, "_lefthand");

      switch (var_11) {
        case "h1_flashgrenade_mp":
        case "h1_concussiongrenade_mp":
        case "h1_smokegrenade_mp":
          continue;
      }
    }

    break;
  }

  if(level.c4explodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();

  if(isdefined(var_5) && (issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isdefined(var_9) && var_9 & level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isplayer(var_1))
    var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("c4");

  var_12 = 0;

  if(level.teambased) {
    if(isdefined(var_1) && isdefined(self.owner)) {
      var_13 = var_1.pers["team"];
      var_14 = self.owner.pers["team"];

      if(isdefined(var_13) && isdefined(var_14) && var_13 != var_14)
        var_12 = 1;
    }
  } else if(isdefined(self.owner) && isdefined(var_1) && var_1 != self.owner)
    var_12 = 1;

  if(var_12) {
    var_1 notify("destroyed_explosive");

    switch (var_0) {
      case "h1_claymore_mp":
      case "claymore":
        level thread maps\mp\gametypes\_rank::awardgameevent("destroyed_claymore", var_1, var_10, undefined, var_5);
        break;
      case "h1_c4_mp":
      case "c4":
        level thread maps\mp\gametypes\_rank::awardgameevent("destroyed_c4", var_1, var_10, undefined, var_5);
        break;
    }
  }

  if(isdefined(self.trigger))
    self.trigger delete();

  self detonate(var_1);
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

saydamaged(var_0, var_1) {
  for (var_2 = 0; var_2 < 60; var_2++)
    wait 0.05;
}

waittillenabled() {
  if(!isdefined(self.disabled)) {
    return;
  }
  self waittill("enabled");
}

makeexplosivetargetablebyai(var_0) {
  common_scripts\utility::make_entity_sentient_mp(self.owner.team);

  if(!isdefined(var_0) || !var_0)
    self makeentitynomeleetarget();

  if(issentient(self))
    self setthreatbiasgroup("DogsDontAttack");
}

setupbombsquad() {
  self.bombsquadids = [];

  if(self.detectexplosives && !self.bombsquadicons.size) {
    for (var_0 = 0; var_0 < 4; var_0++) {
      self.bombsquadicons[var_0] = newclienthudelem(self);
      self.bombsquadicons[var_0].x = 0;
      self.bombsquadicons[var_0].y = 0;
      self.bombsquadicons[var_0].z = 0;
      self.bombsquadicons[var_0].alpha = 0;
      self.bombsquadicons[var_0].archived = 1;
      self.bombsquadicons[var_0] setshader("waypoint_bombsquad", 14, 14);
      self.bombsquadicons[var_0] setwaypoint(0, 0);
      self.bombsquadicons[var_0].detectid = "";
    }
  } else if(!self.detectexplosives) {
    for (var_0 = 0; var_0 < self.bombsquadicons.size; var_0++)
      self.bombsquadicons[var_0] destroy();

    self.bombsquadicons = [];
  }
}

showheadicon(var_0) {
  var_1 = var_0.detectid;
  var_2 = -1;

  for (var_3 = 0; var_3 < 4; var_3++) {
    var_4 = self.bombsquadicons[var_3].detectid;

    if(var_4 == var_1) {
      return;
    }
    if(var_4 == "")
      var_2 = var_3;
  }

  if(var_2 < 0) {
    return;
  }
  self.bombsquadids[var_1] = 1;
  self.bombsquadicons[var_2].x = var_0.origin[0];
  self.bombsquadicons[var_2].y = var_0.origin[1];
  self.bombsquadicons[var_2].z = var_0.origin[2] + 24 + 128;
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 1;
  self.bombsquadicons[var_2].detectid = var_0.detectid;

  while (isalive(self) && isdefined(var_0) && self istouching(var_0))
    wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  self.bombsquadicons[var_2].detectid = "";
  self.bombsquadicons[var_2] fadeovertime(0.25);
  self.bombsquadicons[var_2].alpha = 0;
  self.bombsquadids[var_1] = undefined;
}

getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  var_5 = var_1 * var_1;
  var_6 = level.players;

  for (var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "playing") {
      continue;
    }
    var_8 = maps\mp\_utility::get_damageable_player_pos(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_6[var_7])))
      var_4[var_4.size] = maps\mp\_utility::get_damageable_player(var_6[var_7], var_8);
  }

  var_10 = getentarray("grenade", "classname");

  for (var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = maps\mp\_utility::get_damageable_grenade_pos(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_10[var_7])))
      var_4[var_4.size] = maps\mp\_utility::get_damageable_grenade(var_10[var_7], var_11);
  }

  var_12 = getentarray("destructible", "targetname");

  for (var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_12[var_7]))) {
      var_13 = spawnstruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 0;
      var_13.entity = var_12[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_14 = getentarray("destructable", "targetname");

  for (var_7 = 0; var_7 < var_14.size; var_7++) {
    var_11 = var_14[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_14[var_7]))) {
      var_13 = spawnstruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 1;
      var_13.entity = var_14[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_15 = getentarray("misc_turret", "classname");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "mp_remote_turret":
          var_4[var_4.size] = maps\mp\_utility::get_damageable_sentry(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getentarray("script_model", "classname");

  foreach(var_21 in var_19) {
    if(var_21.model != "projectile_bouncing_betty_grenade" && var_21.model != "ims_scorpion_body") {
      continue;
    }
    var_11 = var_21.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_21)))
      var_4[var_4.size] = maps\mp\_utility::get_damageable_mine(var_21, var_11);
  }

  return var_4;
}

getempdamageents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  var_5 = getentarray("grenade", "classname");

  foreach(var_7 in var_5) {
    var_8 = var_7.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_7)))
      var_4[var_4.size] = var_7;
  }

  var_11 = getentarray("misc_turret", "classname");

  foreach(var_13 in var_11) {
    var_8 = var_13.origin;
    var_9 = distance(var_0, var_8);

    if(var_9 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_13)))
      var_4[var_4.size] = var_13;
  }

  return var_4;
}

weapondamagetracepassed(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(lengthsquared(var_5) < var_2 * var_2)
    return 1;

  var_6 = vectornormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = bullettrace(var_4, var_1, 0, var_3);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(var_0, ".dmg");

    if(isdefined(var_3))
      thread debugprint(var_1, "." + var_3.classname);
    else
      thread debugprint(var_1, ".undefined");

    if(var_7["fraction"] == 1)
      thread debugline(var_4, var_1, (1, 1, 1));
    else {
      thread debugline(var_4, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.damageorigin = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self.isadestructable && (var_4 == "artillery_mp" || var_4 == "h1_claymore_mp")) {
      return;
    }
    self.entity notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
  }
}

debugline(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < 600; var_3++)
    wait 0.05;
}

debugcircle(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 16;

  var_4 = 360 / var_3;
  var_5 = [];

  for (var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_1;
    var_9 = sin(var_7) * var_1;
    var_10 = var_0[0] + var_8;
    var_11 = var_0[1] + var_9;
    var_12 = var_0[2];
    var_5[var_5.size] = (var_10, var_11, var_12);
  }

  for (var_6 = 0; var_6 < var_5.size; var_6++) {
    var_13 = var_5[var_6];

    if(var_6 + 1 >= var_5.size)
      var_14 = var_5[0];
    else
      var_14 = var_5[var_6 + 1];

    thread debugline(var_13, var_14, var_2);
  }
}

debugprint(var_0, var_1) {
  for (var_2 = 0; var_2 < 600; var_2++)
    wait 0.05;
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_5 = 700;
  var_6 = 25;
  var_7 = var_5 * var_5;
  var_8 = var_6 * var_6;
  var_9 = 60;
  var_10 = 40;
  var_11 = 11;

  if(issubstr(var_1, "_uts19_"))
    thread uts19shock(var_0);
  else {
    var_12 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    switch (var_12) {
      case "h1_concussiongrenade_mp":
        if(!isdefined(var_0)) {
          return;
        }
        if(maps\mp\_utility::is_true(self.concussionimmune)) {
          return;
        }
        var_13 = 1;

        if(isdefined(var_0.owner) && var_0.owner == var_4)
          var_13 = 0;

        var_14 = 512;
        var_15 = 1 - distance(self.origin, var_0.origin) / var_14;

        if(var_15 < 0)
          var_15 = 0;

        var_16 = 2 + 4 * var_15;

        if(isdefined(self.stunscaler))
          var_16 = var_16 * self.stunscaler;

        wait 0.05;
        self notify("concussed", var_4);
        self shellshock("concussion_grenade_mp", var_16);
        self.concussionendtime = gettime() + var_16 * 1000;

        if(isdefined(var_4) && var_4 != self)
          self.concussionattacker = var_4;
        else
          self.concussionattacker = undefined;

        if(var_13 && var_4 != self)
          var_4 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("stun");

        break;
      case "weapon_cobra_mk19_mp":
        break;
      default:
        maps\mp\gametypes\_shellshock::shellshockondamage(var_2, var_3);
        break;
    }
  }
}

isconcussed() {
  return isdefined(self.concussionendtime) && gettime() < self.concussionendtime;
}

getlastconcussionattacker() {
  return self.concussionattacker;
}

uts19shock(var_0) {
  if(getdvarint("scr_game_uts19_shock", 0) == 0) {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  var_1 = 0.45;
  var_2 = 1.2;
  var_3 = 250;
  var_4 = 700;
  var_5 = (distance(self.origin, var_0.origin) - var_3) / (var_4 - var_3);
  var_6 = 1 - var_5;
  var_6 = clamp(var_6, 0, 1);
  var_7 = var_1 + (var_2 - var_1) * var_6;

  if(isdefined(self.utsshockqueuedtime)) {
    if(self.utsshockqueuedtime >= var_7)
      return;
  }

  self.utsshockqueuedtime = var_7;
  self shellshock("uts19_mp", var_7);
  waittillframeend;

  if(isdefined(self))
    self.utsshockqueuedtime = undefined;
}

isprimaryweapon(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  switch (weaponclass(var_0)) {
    case "beam":
    case "sniper":
    case "rocketlauncher":
    case "pistol":
    case "mg":
    case "smg":
    case "rifle":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

isbulletweapon(var_0) {
  if(var_0 == "none")
    return 0;

  switch (maps\mp\_utility::getweaponclass(var_0)) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    case "weapon_heavy":
      return issubstr(var_0, "exoxmg") || issubstr(var_0, "lsat") || issubstr(var_0, "asaw");
    default:
      return 0;
  }
}

isbeamweapon(var_0) {
  return issubstr(var_0, "em1") || issubstr(var_0, "epm3");
}

isaltmodeweapon(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "altmode";
}

isinventoryweapon(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "item";
}

isriotshield(var_0) {
  if(var_0 == "none")
    return 0;

  return weapontype(var_0) == "riotshield";
}

isoffhandweapon(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "offhand";
}

issidearm(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  return weaponclass(var_0) == "pistol";
}

ismeleeinventoryweapon(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "melee";
}

isgrenade(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = weaponinventorytype(var_0);

  if(var_1 != "grenade")
    return 0;

  if(var_2 != "offhand")
    return 0;

  return 1;
}

isvalidlastweapon(var_0) {
  if(var_0 == "none")
    return 0;

  var_1 = weaponinventorytype(var_0);
  return var_1 == "primary" || var_1 == "altmode";
}

updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.currentweaponatspawn;
  self.saved_lastweapon = var_0;
  setweaponusagevariables(var_0);
  thread recordweaponusageondeathorgameend();

  for (;;) {
    self waittill("weapon_change", var_1);
    updateweaponusagestats(var_1);

    if(isvalidmovespeedscaleweapon(var_1))
      updatemovespeedscale();

    self.saved_lastweapon = var_0;

    if(isvalidlastweapon(var_1))
      var_0 = var_1;
  }
}

updateweaponusagestats(var_0) {
  var_1 = int((gettime() - self.weaponusagestarttime) / 1000);
  thread setweaponstat(self.weaponusagename, var_1, "timeInUse");
  setweaponusagevariables(var_0);
}

recordweaponusageondeathorgameend() {
  self endon("disconnect");
  self endon("faux_spawn");
  common_scripts\utility::waittill_any_ents(self, "death", level, "game_ended");
  var_0 = int((gettime() - self.weaponusagestarttime) / 1000);
  thread setweaponstat(self.weaponusagename, var_0, "timeInUse");
  setweaponusagevariables(self.weaponusagename);
}

setweaponusagevariables(var_0) {
  self.weaponusagename = var_0;
  self.weaponusagestarttime = gettime();
}

empplayer(var_0) {
  self endon("disconnect");
  self endon("death");
  thread clearempondeath();
}

clearempondeath() {
  self endon("disconnect");
  self waittill("death");
}

getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }

    if(var_0 > 10)
      var_0 = 10;
  } else
    var_0 = 8;

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  if(isdefined(level.weaponweightfunc))
    return [
      [level.weaponweightfunc]
    ](var_2);

  var_1 = int(tablelookup("mp\statstable.csv", 4, var_2, 8));
  return var_1;
}

clampweaponweightvalue(var_0) {
  return clamp(var_0, 0.0, 10.0);
}

isvalidmovespeedscaleweapon(var_0) {
  if(isvalidlastweapon(var_0))
    return 1;

  var_1 = weaponclass(var_0);

  if(var_1 == "ball")
    return 1;

  return 0;
}

updatemovespeedscale() {}

stancerecoiladjuster() {
  if(!isplayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  for (;;) {
    common_scripts\utility::waittill_any("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    self.stance = self getstance();

    if(self.stance == "prone") {
      var_0 = self getcurrentprimaryweapon();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg")
        maps\mp\_utility::setrecoilscale(0, 40);
      else if(var_1 == "weapon_sniper")
        maps\mp\_utility::setrecoilscale(0, 60);
      else
        maps\mp\_utility::setrecoilscale();

      continue;
    }

    if(self.stance == "crouch") {
      var_0 = self getcurrentprimaryweapon();
      var_1 = maps\mp\_utility::getweaponclass(var_0);

      if(var_1 == "weapon_lmg")
        maps\mp\_utility::setrecoilscale(0, 10);
      else if(var_1 == "weapon_sniper")
        maps\mp\_utility::setrecoilscale(0, 30);
      else
        maps\mp\_utility::setrecoilscale();

      continue;
    }

    maps\mp\_utility::setrecoilscale();
  }
}

buildweapondata(var_0) {}

isstucktofriendly(var_0) {
  return level.teambased && isdefined(var_0.team) && var_0.team == self.team;
}

turret_monitoruse() {
  if(getdvarint("scr_game_deleteturrets", 0) || level.gametype == "gun" || maps\mp\_utility::ishodgepodgeph() || maps\mp\_utility::ishodgepodgemm()) {
    self delete();
    return;
  }

  for (;;) {
    self waittill("trigger", var_0);
    thread turret_playerthread(var_0);
  }
}

turret_playerthread(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("weapon_change", "none");
  self waittill("turret_deactivate");
  var_0 notify("weapon_change", var_0 getcurrentweapon());
}

spawnmine(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_3))
    var_3 = (0, randomfloat(360), 0);

  var_5 = "projectile_bouncing_betty_grenade";
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_3;
  var_6 setmodel(var_5);
  var_6.owner = var_1;
  var_6.stunned = 0;
  var_6 setotherent(var_1);
  var_6.weaponname = "bouncingbetty_mp";
  level.mines[level.mines.size] = var_6;
  var_6.killcamoffset = (0, 0, 4);
  var_6.killcament = spawn("script_model", var_6.origin + var_6.killcamoffset);
  var_6.killcament setscriptmoverkillcam("explosive");
  var_1.equipmentmines = common_scripts\utility::array_removeundefined(var_1.equipmentmines);

  if(var_1.equipmentmines.size >= level.maxperplayerexplosives)
    var_1.equipmentmines[0] delete();

  var_1.equipmentmines[var_1.equipmentmines.size] = var_6;
  var_6 thread createbombsquadmodel("projectile_bouncing_betty_grenade_bombsquad", "tag_origin", var_1);
  var_6 thread minebeacon();
  var_6 thread setmineteamheadicon(var_1.pers["team"]);
  var_6 thread minedamagemonitor();
  var_6 thread mineproximitytrigger();
  var_7 = self getlinkedparent();

  if(isdefined(var_7))
    var_6 linkto(var_7);

  var_6 makeexplosivetargetablebyai(!var_4);
  return var_6;
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for (;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isplayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(isdefined(var_9) && var_9 == "bouncingbetty_mp") {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isdefined(var_9)) {
      var_10 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");

      switch (var_10) {
        case "h1_smokegrenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isdefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isdefined(var_8) && var_8 & level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isplayer(var_0))
    var_0 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("bouncing_betty");

  if(level.teambased) {
    if(isdefined(var_0) && isdefined(self.owner)) {
      var_11 = var_0.pers["team"];
      var_12 = self.owner.pers["team"];

      if(isdefined(var_11) && isdefined(var_12) && var_11 != var_12)
        var_0 notify("destroyed_explosive");
    }
  } else if(isdefined(self.owner) && isdefined(var_0) && var_0 != self.owner)
    var_0 notify("destroyed_explosive");

  thread mineexplode(var_0);
}

mineproximitytrigger() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 2;
  var_0 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_0.owner = self;
  thread minedeletetrigger(var_0);
  var_1 = undefined;

  for (;;) {
    var_0 waittill("trigger", var_1);

    if(self.stunned) {
      continue;
    }
    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isdefined(self.owner)) {
        if(var_1 == self.owner) {
          continue;
        }
        if(isdefined(var_1.owner) && var_1.owner == self.owner)
          continue;
      }

      if(!friendlyfirecheck(self.owner, var_1, 0))
        continue;
    }

    if(lengthsquared(var_1 getentityvelocity()) < 10) {
      continue;
    }
    if(var_1 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playsound("mine_betty_click");

  if(isplayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_delaymine")) {
    var_1 notify("triggered_mine");
    wait(level.delayminetime);
  } else
    wait(level.minedetectiongraceperiod);

  thread minebounce();
}

minedeletetrigger(var_0) {
  common_scripts\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");
  var_0 delete();
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.mineselfdestructtime);
  wait(randomfloat(0.4));
  self notify("mine_selfdestruct");
  thread mineexplode();
}

minebounce() {
  self playsound("mine_betty_spin");
  playfx(level.mine_launch, self.origin);

  if(isdefined(self.trigger))
    self.trigger delete();

  var_0 = self.origin + (0, 0, 64);
  self moveto(var_0, 0.7, 0, 0.65);
  self.killcament moveto(var_0 + self.killcamoffset, 0.7, 0, 0.65);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread playspinnerfx();
  wait 0.65;
  thread mineexplode();
}

mineexplode(var_0) {
  if(!isdefined(self) || !isdefined(self.owner)) {
    return;
  }
  if(!isdefined(var_0))
    var_0 = self.owner;

  self playsound("null");
  var_1 = self gettagorigin("tag_fx");
  playfx(level.mine_explode, var_1);
  wait 0.05;

  if(!isdefined(self) || !isdefined(self.owner)) {
    return;
  }
  self hide();
  self radiusdamage(self.origin, level.minedamageradius, level.minedamagemax, level.minedamagemin, var_0, "MOD_EXPLOSIVE");

  if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
    self.owner thread[[level.leaderdialogonplayer_func]]("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;

  if(!isdefined(self) || !isdefined(self.owner)) {
    return;
  }
  if(isdefined(self.trigger))
    self.trigger delete();

  self.killcament delete();
  self delete();
}

minestunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;
  playfxontag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

minestunend() {
  self.stunned = 0;
  stopfxontag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

minechangeowner(var_0) {
  if(isdefined(self.weaponname)) {
    if(isdefined(self.entityheadicon))
      self.entityheadicon destroy();

    if(self.weaponname == "bouncingbetty_mp") {
      if(isdefined(self.trigger))
        self.trigger delete();

      if(isdefined(self.effect["friendly"]))
        self.effect["friendly"] delete();

      if(isdefined(self.effect["enemy"]))
        self.effect["enemy"] delete();

      for (var_1 = 0; var_1 < self.owner.equipmentmines.size; var_1++) {
        if(self.owner.equipmentmines[var_1] == self)
          self.owner.equipmentmines[var_1] = undefined;
      }

      self.owner.equipmentmines = common_scripts\utility::array_removeundefined(self.owner.equipmentmines);
      self notify("change_owner");
      self.owner = var_0;
      self.owner.equipmentmines[self.owner.equipmentmines.size] = self;
      self.team = var_0.team;
      self setotherent(var_0);
      self.trigger = spawn("script_origin", self.origin + (0, 0, 25));
      self.trigger.owner = self;
      equipmentdisableuse(var_0);
      thread minebeacon();
      thread setmineteamheadicon(var_0.team);
      var_0 thread minewatchownerdisconnect(self);
      var_0 thread minewatchownerchangeteams(self);
    } else if(self.weaponname == "h1_claymore_mp") {
      if(isdefined(self.trigger))
        self.trigger delete();

      for (var_1 = 0; var_1 < self.owner.claymorearray.size; var_1++) {
        if(self.owner.claymorearray[var_1] == self)
          self.owner.claymorearray[var_1] = undefined;
      }

      self.owner.claymorearray = common_scripts\utility::array_removeundefined(self.owner.claymorearray);
      self notify("change_owner");
      self.owner = var_0;
      self.owner.claymorearray[self.owner.claymorearray.size] = self;
      self.team = var_0.team;
      self setotherent(var_0);
      self.trigger = spawn("script_origin", self.origin);
      self.trigger.owner = self;
      equipmentdisableuse(var_0);
      thread setmineteamheadicon(var_0.team);
      var_0 thread minewatchownerdisconnect(self);
      var_0 thread minewatchownerchangeteams(self);
      thread claymoredetonation();
    } else if(self.weaponname == "h1_c4_mp") {
      var_2 = 0;
      var_3 = 0;

      for (var_1 = 0; var_1 < self.owner.manuallydetonatedarray.size; var_1++) {
        if(self.owner.manuallydetonatedarray[var_1][0] == self) {
          self.owner.manuallydetonatedarray[var_1][0] = undefined;
          var_2 = self.owner.manuallydetonatedarray[var_1][1];
          var_3 = self.owner.manuallydetonatedarray[var_1][2];
        }
      }

      self.owner.manuallydetonatedarray = manuallydetonated_removeundefined(self.owner.manuallydetonatedarray);
      self notify("change_owner");
      self.owner = var_0;
      var_4 = self.owner.manuallydetonatedarray.size;
      self.owner.manuallydetonatedarray[var_4] = [];
      self.owner.manuallydetonatedarray[var_4][0] = self;
      self.owner.manuallydetonatedarray[var_4][1] = var_2;
      self.owner.manuallydetonatedarray[var_4][2] = var_3;
      self.team = var_0.team;
      self setotherent(var_0);
      equipmentdisableuse(var_0);
      thread setmineteamheadicon(var_0.team);
    }
  }
}

playspinnerfx() {
  self endon("death");
  var_0 = gettime() + 1000;

  while (gettime() < var_0) {
    wait 0.05;
    playfxontag(level.mine_spin, self, "tag_fx_spin1");
    playfxontag(level.mine_spin, self, "tag_fx_spin3");
    wait 0.05;
    playfxontag(level.mine_spin, self, "tag_fx_spin2");
    playfxontag(level.mine_spin, self, "tag_fx_spin4");
  }
}

minedamagedebug(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6[0] = (1, 0, 0);
  var_6[1] = (0, 1, 0);

  if(var_1[2] < var_5)
    var_7 = 0;
  else
    var_7 = 1;

  var_8 = (var_0[0], var_0[1], var_5);
  var_9 = (var_1[0], var_1[1], var_5);
  thread debugcircle(var_8, level.minedamageradius, var_6[var_7], 32);
  var_10 = distancesquared(var_0, var_1);

  if(var_10 > var_2)
    var_7 = 0;
  else
    var_7 = 1;

  thread debugline(var_8, var_9, var_6[var_7]);
}

minedamageheightpassed(var_0, var_1) {
  if(isplayer(var_1) && isalive(var_1) && var_1.sessionstate == "playing")
    var_2 = var_1 maps\mp\_utility::getstancecenter();
  else if(var_1.classname == "misc_turret")
    var_2 = var_1.origin + (0, 0, 32);
  else
    var_2 = var_1.origin;

  var_3 = 0;
  var_4 = var_0.origin[2] + var_3 + level.minedamagehalfheight;
  var_5 = var_0.origin[2] + var_3 - level.minedamagehalfheight;

  if(var_2[2] > var_4 || var_2[2] < var_5)
    return 0;

  return 1;
}

watchslide() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  for (;;) {
    self.issiliding = 0;
    self waittill("sprint_slide_begin");
    self.issiliding = 1;
    self.lastslidetime = gettime();
    self waittill("sprint_slide_end");
  }
}

watchmineusage() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("faux_spawn");

  if(isdefined(self.equipmentmines)) {
    if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1) {
      if(isdefined(self.dont_delete_mines_on_next_spawn))
        self.dont_delete_mines_on_next_spawn = undefined;
      else
        delete_all_mines();
    }
  } else
    self.equipmentmines = [];

  if(!isdefined(self.killstreakmines))
    self.killstreakmines = [];

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "bouncingbetty" || var_1 == "bouncingbetty_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
      var_0 thread minethrown(self, 1);
    }
  }
}

minethrown(var_0, var_1) {
  self.owner = var_0;
  self waittill("missile_stuck");

  if(!isdefined(var_0)) {
    return;
  }
  var_2 = bullettrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_3 = var_2["position"];

  if(var_2["fraction"] == 1) {
    var_3 = getgroundposition(self.origin, 12, 0, 32);
    var_2["normal"] = var_2["normal"] * -1;
  }

  var_4 = vectornormalize(var_2["normal"]);
  var_5 = vectortoangles(var_4);
  var_5 = var_5 + (90, 0, 0);
  var_6 = spawnmine(var_3, var_0, undefined, var_5, var_1);
  var_6.trigger = spawn("script_origin", var_6.origin + (0, 0, 25));
  var_6.trigger.owner = var_6;
  var_6 thread equipmentwatchuse(var_0);
  var_0 thread minewatchownerdisconnect(var_6);
  var_0 thread minewatchownerchangeteams(var_6);
  self delete();
}

minewatchownerdisconnect(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  self waittill("disconnect");

  if(isdefined(var_0.trigger))
    var_0.trigger delete();

  var_0 delete();
}

minewatchownerchangeteams(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("change_owner");
  common_scripts\utility::waittill_either("joined_team", "joined_spectators");

  if(isdefined(var_0.trigger))
    var_0.trigger delete();

  var_0 delete();
}

minebeacon() {
  self endon("change_owner");
  self.effect["friendly"] = spawnfx(level.mine_beacon["friendly"], self gettagorigin("tag_fx"));
  self.effect["enemy"] = spawnfx(level.mine_beacon["enemy"], self gettagorigin("tag_fx"));
  thread minebeaconteamupdater();
  self waittill("death");
  self.effect["friendly"] delete();
  self.effect["enemy"] delete();
}

minebeaconteamupdater() {
  self endon("death");
  self endon("change_owner");
  var_0 = self.owner.team;
  wait 0.05;
  triggerfx(self.effect["friendly"]);
  triggerfx(self.effect["enemy"]);

  for (;;) {
    self.effect["friendly"] hide();
    self.effect["enemy"] hide();

    foreach(var_2 in level.players) {
      if(level.teambased) {
        if(var_2.team == var_0)
          self.effect["friendly"] showtoplayer(var_2);
        else
          self.effect["enemy"] showtoplayer(var_2);

        continue;
      }

      if(var_2 == self.owner) {
        self.effect["friendly"] showtoplayer(var_2);
        continue;
      }

      self.effect["enemy"] showtoplayer(var_2);
    }

    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

delete_all_grenades() {
  if(isdefined(self.manuallydetonatedarray)) {
    for (var_0 = 0; var_0 < self.manuallydetonatedarray.size; var_0++) {
      if(isdefined(self.manuallydetonatedarray[var_0][0])) {
        if(isdefined(self.manuallydetonatedarray[var_0][0].trigger))
          self.manuallydetonatedarray[var_0][0].trigger delete();

        self.manuallydetonatedarray[var_0][0] delete();
      }
    }
  }

  self.manuallydetonatedarray = [];

  if(isdefined(self.claymorearray)) {
    for (var_0 = 0; var_0 < self.claymorearray.size; var_0++) {
      if(isdefined(self.claymorearray[var_0])) {
        if(isdefined(self.claymorearray[var_0].trigger))
          self.claymorearray[var_0].trigger delete();

        self.claymorearray[var_0] delete();
      }
    }
  }

  self.claymorearray = [];

  if(isdefined(self.bouncingbettyarray)) {
    for (var_0 = 0; var_0 < self.bouncingbettyarray.size; var_0++) {
      if(isdefined(self.bouncingbettyarray[var_0])) {
        if(isdefined(self.bouncingbettyarray[var_0].trigger))
          self.bouncingbettyarray[var_0].trigger delete();

        self.bouncingbettyarray[var_0] delete();
      }
    }
  }

  self.bouncingbettyarray = [];
}

delete_all_mines() {
  if(isdefined(self.equipmentmines)) {
    self.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);

    foreach(var_1 in self.equipmentmines) {
      if(isdefined(var_1.trigger))
        var_1.trigger delete();

      var_1 delete();
    }
  }
}

transfer_grenade_ownership(var_0) {
  var_0 delete_all_grenades();
  var_0 delete_all_mines();

  if(isdefined(self.manuallydetonatedarray))
    var_0.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
  else
    var_0.manuallydetonatedarray = undefined;

  if(isdefined(self.claymorearray))
    var_0.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
  else
    var_0.claymorearray = undefined;

  if(isdefined(self.bouncingbettyarray))
    var_0.bouncingbettyarray = common_scripts\utility::array_removeundefined(self.bouncingbettyarray);
  else
    var_0.bouncingbettyarray = undefined;

  if(isdefined(self.equipmentmines))
    var_0.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);
  else
    var_0.equipmentmines = undefined;

  if(isdefined(self.killstreakmines))
    var_0.killstreakmines = common_scripts\utility::array_removeundefined(self.killstreakmines);
  else
    var_0.killstreakmines = undefined;

  if(isdefined(var_0.manuallydetonatedarray)) {
    foreach(var_2 in var_0.manuallydetonatedarray)
    var_2[0].owner = var_0;
  }

  if(isdefined(var_0.claymorearray)) {
    foreach(var_5 in var_0.claymorearray)
    var_5.owner = var_0;
  }

  if(isdefined(var_0.bouncingbettyarray)) {
    foreach(var_8 in var_0.bouncingbettyarray) {
      var_8.owner = var_0;
      var_8 thread equipmentwatchuse(var_0);
    }
  }

  if(isdefined(var_0.equipmentmines)) {
    foreach(var_11 in var_0.equipmentmines) {
      var_11.owner = var_0;
      var_11 thread equipmentwatchuse(var_0);
    }
  }

  if(isdefined(var_0.killstreakmines)) {
    foreach(var_14 in var_0.killstreakmines) {
      var_14.owner = var_0;
      var_14 thread equipmentwatchuse(var_0);
    }
  }

  self.manuallydetonatedarray = [];
  self.claymorearray = [];
  self.bouncingbettyarray = [];
  self.equipmentmines = [];
  self.killstreakmines = [];
  self.dont_delete_grenades_on_next_spawn = 1;
  self.dont_delete_mines_on_next_spawn = 1;
}

equipmentdeathvfx() {
  playfx(common_scripts\utility::getfx("equipment_sparks"), self.origin);
  self playsound("sentry_explode");
}

equipmentdeletevfx() {
  playfx(common_scripts\utility::getfx("equipment_explode_big"), self.origin);
  playfx(common_scripts\utility::getfx("equipment_smoke"), self.origin);
}

equipmentempstunvfx() {
  playfxontag(common_scripts\utility::getfx("emp_stun"), self, "tag_origin");
}

track_damage_info() {
  self.damage_info = [];
  thread reset_damage_info_when_healed();
}

reset_damage_info_when_healed() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    if(self.health >= 100 && isdefined(self.damage_info) && self.damage_info.size > 0)
      self.damage_info = [];

    wait 0.05;
  }
}

stickyhandlemovers(var_0, var_1) {
  var_2 = spawnstruct();

  if(isdefined(var_0))
    var_2.notifystring = var_0;

  if(isdefined(var_1))
    var_2.endonstring = var_1;

  var_2.deathoverridecallback = ::stickymovingplatformdetonate;
  thread maps\mp\_movers::handle_moving_platforms(var_2);
}

stickymovingplatformdetonate(var_0) {
  if(!isdefined(self)) {
    return;
  }
  self endon("death");

  if(isdefined(self)) {
    if(isdefined(var_0.notifystring)) {
      if(var_0.notifystring == "detonate")
        self detonate();
      else
        self notify(var_0.notifystring);
    } else
      self delete();
  }
}

getgrenadegraceperiodtimeleft() {
  var_0 = 0;

  if(isdefined(level.grenadegraceperiod))
    var_0 = level.grenadegraceperiod;

  var_1 = 0;

  if(isdefined(level.prematch_done_time))
    var_1 = (gettime() - level.prematch_done_time) / 1000;

  return var_0 - var_1;
}

ingrenadegraceperiod() {
  return getgrenadegraceperiodtimeleft() > 0;
}

isweaponallowedingrenadegraceperiod(var_0) {
  if(issubstr(var_0, "glmwr"))
    return 0;

  if(isendstr(var_0, "_gl"))
    return 0;

  switch (var_0) {
    case "h1_fraggrenade_mp":
      return 0;
    default:
      break;
  }

  var_1 = getweaponbasename(var_0);

  if(isdefined(var_1)) {
    switch (var_1) {
      case "h1_rpg_mp":
        return 0;
      default:
        break;
    }
  }

  return 1;
}

watchgrenadegraceperiod() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for (;;) {
    [var_1, var_2, var_3] = common_scripts\utility::waittill_any_return_parms("grenade_fire", "missile_fire");

    if(!isdefined(var_3) || var_3 == "") {
      continue;
    }
    if(ingrenadegraceperiod()) {
      if(!isweaponallowedingrenadegraceperiod(var_3)) {
        var_4 = int(getgrenadegraceperiodtimeleft() + 0.5);

        if(!var_4)
          var_4 = 1;

        if(isplayer(self))
          self iprintlnbold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N", var_4);
      }

      continue;
    }

    break;
  }
}

isprimaryorsecondaryprojectileweapon(var_0) {
  var_1 = maps\mp\_utility::getweaponclass(var_0);
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  if(var_1 == "weapon_projectile")
    return 1;

  return 0;
}

saveweapon(var_0, var_1, var_2) {
  var_3 = self.saveweapons.size;

  if(var_3 == 0)
    self.firstsaveweapon = var_1;

  self.saveweapons[var_3]["type"] = var_0;
  self.saveweapons[var_3]["use"] = var_2;
}

getsavedweapon(var_0) {
  var_1 = self.saveweapons.size;
  var_2 = -1;

  for (var_3 = 0; var_3 < var_1; var_3++) {
    if(self.saveweapons[var_3]["type"] == var_0) {
      var_2 = var_3;
      break;
    }
  }

  if(var_2 >= 0)
    return self.saveweapons[var_2]["use"];
  else
    return "none";
}

restoreweapon(var_0) {
  var_1 = [];
  var_2 = self.saveweapons.size;
  var_3 = -1;
  var_4 = 0;

  for (var_5 = 0; var_5 < var_2; var_5++) {
    if(var_3 < 0 && self.saveweapons[var_5]["type"] == var_0) {
      var_3 = var_5;
      continue;
    }

    var_1[var_4] = self.saveweapons[var_5];
    var_4++;
  }

  if(var_3 >= 0) {
    var_6 = "none";

    if(var_1.size == 0) {
      var_6 = self.firstsaveweapon;
      self.saveweapons = var_1;
      self.firstsaveweapon = "none";
    } else {
      self.saveweapons = var_1;
      var_6 = getsavedweapon("underwater");

      if(var_6 == "none")
        var_6 = self.saveweapons[0]["use"];
    }

    var_7 = self getcurrentweapon();

    if(var_7 != var_6)
      self switchtoweaponimmediate(var_6);
  }
}

watchweaponinspection() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(isai(self) || isbot(self)) {
    return;
  }
  self notifyonplayercommand("weapon_inspection", "+actionslot 2");

  for (;;) {
    self waittill("weapon_inspection");

    if(maps\mp\_utility::invirtuallobby() && !maps\mp\_utility::is_true(level.in_firingrange)) {
      continue;
    }
    var_0 = self getcurrentprimaryweapon();
    var_1 = maps\mp\_utility::getweaponclass(var_0);
    var_2 = var_1 == "weapon_pistol";
    var_3 = maps\mp\gametypes\_class::isperkequipment(var_0);
    var_4 = getweaponbasename(var_0);

    if(isdefined(var_4))
      var_5 = var_4 == "h1_augsmg_mp";
    else
      var_5 = 0;

    if(var_2 || var_3 || var_5) {
      var_6 = self getammocount(var_0);

      if(var_6 == 0)
        continue;
    }

    self startweaponinspection();
    waitframe();

    while (self isinspectingweapon())
      waitframe();
  }
}

watchmeleeweapon() {
  self endon("disconnect");

  for (;;) {
    self waittill("melee_fired", var_0);

    if(!isdefined(var_0)) {
      continue;
    }
    if(isdefined(self.meleeweaponbloodytime) && maps\mp\_utility::ismeleeweapon(var_0)) {
      var_1 = gettime() - self.meleeweaponbloodytime <= 100;
      var_2 = gettime() - self.meleeweaponbloodytime > 4000;

      if(!var_1 && !var_2)
        thread playcleanmeleefx();
    }

    maps\mp\gametypes\_gamelogic::sethasdonecombat(self, 1);
    self.lastshotfiredtime = gettime();

    if(isai(self)) {
      continue;
    }
    if(!maps\mp\_utility::iscacmeleeweapon(var_0)) {
      continue;
    }
    var_3 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
    var_4 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
    var_5 = clamp(float(var_4) / float(var_3), 0.0, 1.0) * 10000.0;
    maps\mp\gametypes\_persistence::statsetbuffered("totalShots", var_3);
    maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_5));
    maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_3 - var_4));

    if(isdefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
      self.hits = 0;
      continue;
    }

    var_6 = 1;
    setweaponstat(var_0, var_6, "shots");
    setweaponstat(var_0, self.hits, "hits");
    self.hits = 0;
  }
}

playcleanmeleefx() {
  self endon("death");
  self endon("disconnect");
  wait 0.05;
  var_0 = self getvieworigin();
  var_1 = self getplayerangles();
  var_2 = anglestoforward(var_1);
  var_3 = bullettrace(var_0, var_0 + var_2 * 200, 0);

  if(var_3["fraction"] < 1)
    playfx(level.meleeweaponbloodflick, var_3["position"] - var_2 * 5, -1 * var_2);
}
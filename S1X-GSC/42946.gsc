/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42946.gsc
**************************************/

init() {
  level.juggsettings = [];
  level.juggsettings["juggernaut_exosuit"] = spawnStruct();
  level.juggsettings["juggernaut_exosuit"].splashusedname = "used_juggernaut";
  level.juggsettings["juggernaut_exosuit"].splashattachmentname = "callout_destroyed_heavyexoattachment";
  level.juggsettings["juggernaut_exosuit"].splashweakenedname = "callout_weakened_heavyexoattachment";
  level._effect["green_light_mp"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
  level._effect["juggernaut_sparks"] = loadfx("vfx/explosion/bouncing_betty_explosion");
  level._effect["jugg_droppod_open"] = loadfx("vfx/explosion/goliath_pod_opening");
  level._effect["jugg_droppod_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_goliath");
  level._effect["exo_ping_inactive"] = loadfx("vfx/unique/exo_ping_inactive");
  level._effect["exo_ping_active"] = loadfx("vfx/unique/exo_ping_active");
  level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
  level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
  level._effect["lethal_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_lethal_flash_wv");
  level._effect["swarm_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_tactical_wv_run");
  level.killstreakwieldweapons["juggernaut_sentry_mg_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_juggernautrockets_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_exoxmgjugg_mp_akimbo"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_juggtitan45_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_exominigun_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_mechpunch_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["playermech_rocket_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["killstreak_goliathsd_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["orbital_carepackage_droppod_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["heavy_exo_trophy_mp"] = "juggernaut_exosuit";
  level.killstreakfuncs["heavy_exosuit"] = ::tryuseheavyexosuit;
  game["dialog"]["assist_mp_goliath"] = "ks_goliath_joinreq";
  game["dialog"]["copilot_mp_goliath"] = "copilot_mp_goliath";
  game["dialog"]["sntryoff_mp_exoai"] = "sntryoff_mp_exoai";
  game["dialog"]["mancoff_mp_exoai"] = "mancoff_mp_exoai";
  game["dialog"]["longoff_mp_exoai"] = "longoff_mp_exoai";
  game["dialog"]["rcnoff_mp_exoai"] = "rcnoff_mp_exoai";
  game["dialog"]["rcktoff_mp_exoai"] = "rcktoff_mp_exoai";
  game["dialog"]["trphyoff_mp_exoai"] = "trphyoff_mp_exoai";
  game["dialog"]["weakdmg_mp_exoai"] = "weakdmg_mp_exoai";
  level thread onplayerconnect();
}

tryuseheavyexosuit(var_0, var_1) {
  if(isDefined(level.ishorde) && level.ishorde) {
    if(isDefined(self.hordegoliathpodinfield) || isDefined(self.hordegoliathcontroller) || isDefined(self.hordeclassgoliathcontroller)) {
      self iprintlnbold(&"KILLSTREAKS_HEAVY_EXO_IN_USE");
      return 0;
    }
  }

  var_2 = playerlaunchdroppod(var_1);
  return var_2;
}

resetweapon() {
  var_0 = maps\mp\_utility::getkillstreakweapon("heavy_exosuit");
  self switchtoweapon(common_scripts\utility::getlastweapon());
  maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_0);
}

cansetupstance() {
  if(self getstance() == "prone" || self getstance() == "crouch") {
    self setstance("stand");
  }

  maps\mp\_utility::freezecontrolswrapper(1);
  var_0 = gettime() + 1500;

  while(gettime() < var_0 && self getstance() != "stand") {
    waitframe();
  }

  maps\mp\_utility::freezecontrolswrapper(0);
  return self getstance() == "stand";
}

givejuggernaut(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  if(maps\mp\perks\_perkfunctions::haslightarmor()) {
    maps\mp\perks\_perkfunctions::unsetlightarmor();
  }

  if(maps\mp\_utility::_hasperk("specialty_explosivebullets")) {
    maps\mp\_utility::_unsetperk("specialty_explosivebullets");
  }

  self.maxhealth = 125;

  if(isDefined(level.ishorde) && level.ishorde) {
    self.maxhealth = 300 + 25 * self.hordearmor;
  }

  self.health = self.maxhealth;
  self.attackerlist = [];

  switch (var_0) {
    case "juggernaut_exosuit":
    default:
      var_2 = 1;
      var_3 = "juggernaut_exosuit";

      if(!isDefined(var_1) || common_scripts\utility::array_contains(var_1, "heavy_exosuit_maniac")) {
        var_2 = 1.15;
        var_3 = "juggernaut_exosuit_maniac";
      }

      self.juggmovespeedscaler = var_2;
      removeweapons();
      var_4 = isDefined(self.perks["specialty_hardline"]);
      maps\mp\gametypes\_class::giveandapplyloadout(self.pers["team"], var_3, 0, 0);
      maps\mp\gametypes\_playerlogic::streamclassweapons(0, 0, var_3);
      self.isjuggernaut = 1;
      self.movespeedscaler = var_2;
      maps\mp\_utility::giveperk("specialty_radarjuggernaut", 0);

      if(var_4) {
        maps\mp\_utility::giveperk("specialty_hardline", 0);
      }

      thread playersetupjuggernautexo(var_1, var_0);
      self.saved_lastweapon = self getweaponslistprimaries()[0];
      break;
  }

  maps\mp\gametypes\_weapons::updatemovespeedscale();
  self disableweaponpickup();

  if(!isDefined(var_1) || common_scripts\utility::array_contains(var_1, "heavy_exosuit_maniac")) {
    self playSound("goliath_suit_up_mp");
  } else {
    self playSound("goliath_suit_up_mp");
  }

  thread maps\mp\_utility::teamplayercardsplash(level.juggsettings[var_0].splashusedname, self);
  thread juggremover();
  level notify("juggernaut_equipped", self);
  maps\mp\_matchdata::logkillstreakevent("juggernaut", self.origin);
}

juggernautsounds() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    wait 3.0;
    self playSound("juggernaut_breathing_sound");
  }
}

radarmover(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  self endon("jugdar_removed");

  for(;;) {
    var_0 moveto(self.origin, 0.05);
    wait 0.05;
  }
}

juggremover() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  thread juggremoveongameended();
  common_scripts\utility::waittill_any("death", "joined_team", "joined_spectators", "lost_juggernaut");
  self enableweaponpickup();
  self.isjuggernaut = 0;
  common_scripts\utility::resetusability();
  self allowjump(1);
  self allowcrouch(1);
  self allowladder(1);
  self allowmantle(1);
  self setdemigod(0);

  if(isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay destroy();
  }

  self unsetperk("specialty_radarjuggernaut", 1);

  if(isDefined(self.personalradar)) {
    self notify("jugdar_removed");
    level maps\mp\gametypes\_portable_radar::deleteportableradar(self.personalradar);
    self.personalradar = undefined;
  }

  self notify("jugg_removed");
}

juggremoveongameended() {
  self endon("disconnect");
  self endon("jugg_removed");
  level waittill("game_ended");

  if(isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay destroy();
  }
}

removeweapons() {
  self.primarytorestore = common_scripts\utility::getlastweapon();

  foreach(var_1 in self.weaponlist) {
    var_2 = maps\mp\_utility::getweaponnametokens(var_1);

    if(var_2[0] == "alt") {
      self.restoreweaponclipammo[var_1] = self getweaponammoclip(var_1);
      self.restoreweaponstockammo[var_1] = self getweaponammostock(var_1);
      continue;
    }

    self.restoreweaponclipammo[var_1] = self getweaponammoclip(var_1);
    self.restoreweaponstockammo[var_1] = self getweaponammostock(var_1);
  }

  self.weaponstorestore = [];

  foreach(var_1 in self.weaponlist) {
    var_2 = maps\mp\_utility::getweaponnametokens(var_1);

    if(var_2[0] == "alt") {
      continue;
    }
    if(maps\mp\_utility::iskillstreakweapon(var_1)) {
      continue;
    }
    self.weaponstorestore[self.weaponstorestore.size] = var_1;
    self takeweapon(var_1);
  }
}

playersetupjuggernautexo(var_0, var_1) {
  var_2 = spawnStruct();
  self.heavyexodata = var_2;
  var_2.streakplayer = self;
  var_2.hascoopsentry = 1;
  var_2.modules = var_0;
  var_2.juggtype = var_1;

  if(isDefined(var_0)) {
    var_2.hasradar = common_scripts\utility::array_contains(var_0, "heavy_exosuit_radar");
    var_2.hasmaniac = common_scripts\utility::array_contains(var_0, "heavy_exosuit_maniac");
    var_2.haslongpunch = common_scripts\utility::array_contains(var_0, "heavy_exosuit_punch");
    var_2.hastrophy = common_scripts\utility::array_contains(var_0, "heavy_exosuit_trophy");
    var_2.hasrockets = common_scripts\utility::array_contains(var_0, "heavy_exosuit_rockets");
    var_2.hasextraammo = common_scripts\utility::array_contains(var_0, "heavy_exosuit_ammo");
  } else {
    var_2.hasradar = 1;
    var_2.hasmaniac = 1;
    var_2.haslongpunch = 0;
    var_2.hastrophy = 1;
    var_2.hasrockets = 1;
    var_2.hasextraammo = 1;
  }

  var_3 = 0;

  if(var_2.hasrockets) {
    var_3 = var_3 + 1;
  }

  if(var_2.haslongpunch) {
    var_3 = var_3 + 2;
  }

  if(var_2.hasradar) {
    var_3 = var_3 + 4;
  }

  if(var_2.hastrophy) {
    var_3 = var_3 + 8;
  }

  if(var_2.hasmaniac) {
    var_3 = var_3 + 16;
  }

  if(var_2.hascoopsentry) {
    var_3 = var_3 + 32;
  }

  self setclientomnvar("ui_exo_suit_modules_on", var_3);
  maps\mp\_utility::playerallowpowerslide(0, "heavyexo");

  if(!var_2.hasmaniac) {
    maps\mp\_utility::playerallowdodge(0, "heavyexo");
    maps\mp\_utility::playerallowboostjump(0, "heavyexo");
    maps\mp\_utility::playerallowhighjump(0, "heavyexo");
    maps\mp\_utility::playerallowhighjumpdrop(0, "heavyexo");
  }

  common_scripts\utility::_disableusability();
  self allowjump(0);
  self allowcrouch(0);
  self allowladder(0);
  self allowmantle(0);
  self.inliveplayerkillstreak = 1;
  self.mechhealth = 125;

  if(isDefined(level.ishorde) && level.ishorde) {
    self.mechhealth = self.maxhealth;
  }

  self setdemigod(1);
  self setclientomnvar("ui_exo_suit_health", 1);
  playersetjuggexomodel(var_2);
  thread playershowjuggernauthud(var_2);
  thread playercleanupondeath(var_2);
  thread playercleanuponother();
  thread playerrocketsandswarmwatcher();
  thread playermech_invalid_weapon_watcher();
  thread playerhandlebootupsequence();
  thread play_goliath_death_fx();
  thread playermech_watch_emp_grenade();

  if(isDefined(level.ishorde) && level.ishorde) {
    thread playermechtimeout();
  }

  if(var_2.hascoopsentry) {}

  if(var_2.hasradar) {
    level thread setupradar(self, var_2);
  }

  if(var_2.hasmaniac) {
    level thread setupmaniac(self);
    set_mech_chaingun_state("offline");
  } else {
    thread playerhandlebarrel();
    set_mech_chaingun_state("ready");
  }

  if(var_2.haslongpunch) {
    level thread setuplongpunch(self, var_2);
    set_mech_rocket_state("ready");
    thread playermech_monitor_rocket_recharge();
  } else {
    set_mech_rocket_state("offline");

    if(!var_2.hasmaniac) {
      self disableoffhandweapons();
    }
  }

  if(var_2.hastrophy) {
    level thread setuptrophy(self, var_2);
  }

  if(var_2.hasrockets) {
    level thread setuprocketswarm(self, var_2);
    set_mech_swarm_state("ready");
    thread playermech_monitor_swarm_recharge();
  } else {
    self disableoffhandsecondaryweapons();
    set_mech_swarm_state("offline");
  }

  level thread delaysetweapon(self);

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("horde_cancel_goliath");
  }

  wait 5;

  if(isDefined(self)) {
    thread self_destruct_goliath();
  }
}

playerhandlebootupsequence() {
  self.goliathbootupsequence = 1;
  wait 4.16;
  self.goliathbootupsequence = undefined;
}

juggernautmodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!var_0 maps\mp\_utility::isjuggernaut()) {
    return var_2;
  }

  var_9 = var_2;

  if(isDefined(var_3) && var_3 == "MOD_FALLING") {
    var_9 = 0;
  }

  if(isDefined(var_4) && var_4 == "boost_slam_mp") {
    var_9 = 20;
  }

  if(isDefined(var_1) && isDefined(var_0) && var_1 == var_0 && isDefined(var_4) && (var_4 == "iw5_juggernautrockets_mp" || var_4 == "playermech_rocket_mp")) {
    var_9 = 0;
  }

  if(isDefined(var_0.goliathbootupsequence) && var_0.goliathbootupsequence) {
    if(isDefined(level.ishorde) && level.ishorde && var_3 == "MOD_TRIGGER_HURT" && var_0 maps\mp\_utility::touchingbadtrigger()) {
      var_9 = 10000;
    } else {
      var_9 = 0;
    }
  }

  if(isDefined(var_1) && !maps\mp\gametypes\_weapons::friendlyfirecheck(var_0, var_1)) {
    var_9 = 0;
  }

  if(var_9 > 0) {
    if(maps\mp\_utility::attackerishittingteam(var_0, var_1)) {
      if(isDefined(level.juggernautmod)) {
        var_9 = var_9 * level.juggernautmod;
      } else {
        var_9 = var_9 * 0.08;
      }
    }

    if(isDefined(var_7) && var_7 == "head") {
      var_9 = var_9 * 4.0;
    }

    if(isDefined(var_4) && var_4 == "killstreak_goliathsd_mp" && isDefined(var_1) && isDefined(var_0) && var_1 == var_0) {
      var_9 = var_0.mechhealth + 1;
    }

    if(isDefined(var_4) && var_4 == "nuke_mp" && isDefined(var_1) && isDefined(var_0) && var_1 != var_0) {
      var_9 = var_0.mechhealth + 1;
    }

    var_0.mechhealth = var_0.mechhealth - var_9;

    if(isDefined(level.ishorde) && level.ishorde) {
      var_0 setclientomnvar("ui_exo_suit_health", var_0.mechhealth / var_0.maxhealth);
    } else {
      var_0 setclientomnvar("ui_exo_suit_health", var_0.mechhealth / 125);
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      if(isDefined(var_7) && var_7 == "head") {
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("headshot");
      } else {
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitjuggernaut");
      }

      if(var_0 maps\mp\gametypes\_damage::isnewattacker(var_1)) {
        var_0.attackerlist[var_0.attackerlist.size] = var_1;
      }
    }

    if(var_0.mechhealth < 0) {
      if(isDefined(level.ishorde) && level.ishorde) {
        maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(common_scripts\utility::getfx("goliath_self_destruct"), self.origin, anglestoup(self.angles));
        self thread[[level.hordehandlejuggdeath]]();
      } else {
        var_0 thread playerkillheavyexo(var_5, var_1, var_3, var_4, var_8);
      }
    }
  }

  return int(var_9);
}

playerkillheavyexo(var_0, var_1, var_2, var_3, var_4) {
  self notify("killHeavyExo");
  self allowjump(1);
  self allowcrouch(1);
  self allowladder(1);
  self allowmantle(1);
  self setdemigod(0);
  self.isjuggernaut = 0;
  var_5 = 1001;

  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_6 = 0;

  if(isDefined(var_3) && isDefined(var_1) && isDefined(var_2) && isDefined(var_4)) {
    var_6 = self dodamage(var_5, var_0, var_1, var_4, var_2, var_3);
  } else if(isDefined(var_3) && isDefined(var_1) && isDefined(var_2)) {
    var_6 = self dodamage(var_5, var_0, var_1, undefined, var_2, var_3);
  } else if(isDefined(var_1) && isDefined(var_2)) {
    var_6 = self dodamage(var_5, var_0, var_1, undefined, var_2);
  } else if(isDefined(var_1)) {
    var_6 = self dodamage(var_5, var_0, var_1, undefined);
  } else {
    var_6 = self dodamage(var_5, var_0);
  }
}

delaysetweapon(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  var_1 = maps\mp\_utility::getkillstreakweapon("heavy_exosuit");
  var_0 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_1);
  var_0 giveweapon("iw5_exominigun_mp");
  var_0 switchtoweapon("iw5_exominigun_mp");
  var_0 notify("waitTakeKillstreakWeapon");
  waitframe();
  var_0 setplayermech(1);
  var_0 disableweaponswitch();
}

playercleanupondeath(var_0) {
  self endon("disconnect");
  self waittill("death", var_1, var_2, var_3);

  if(isDefined(var_1) && isPlayer(var_1) && var_1 != self && var_1.team != self.team) {
    var_1 maps\mp\_utility::incplayerstat("goliath_destroyed", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("goliath_destroyed", var_1, var_3, self, var_2);
  }

  if(!isDefined(level.ishorde)) {
    maps\mp\_events::checkvandalismmedal(var_1);
  }

  self.inliveplayerkillstreak = undefined;
  self.mechhealth = undefined;
  playerreset(var_0);
}

playercleanuponother() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  level common_scripts\utility::waittill_any("game_ended");
  playerresetomnvars();
}

playerreset(var_0) {
  self notify("lost_juggernaut");
  self notify("exit_mech");
  playerresetomnvars();
  maps\mp\_utility::playerallowdodge(1, "heavyexo");
  maps\mp\_utility::playerallowpowerslide(1, "heavyexo");
  maps\mp\_utility::playerallowboostjump(1, "heavyexo");
  maps\mp\_utility::playerallowhighjump(1, "heavyexo");
  self enableoffhandsecondaryweapons();
  self enableoffhandweapons();
  self enableweaponswitch();
  self setplayermech(0);
  self.restoreweaponclipammo = undefined;
  self.restoreweaponstockammo = undefined;
  self.juggernautweak = undefined;
  self.heavyexodata = undefined;

  if(isDefined(self.juggernautattachments)) {
    self.juggernautattachments = undefined;
  }

  if(isDefined(var_0)) {
    foreach(var_2 in var_0.hud) {
      if(isDefined(var_2)) {
        var_2.textoffline = undefined;
        var_2.type = undefined;
        var_2 destroy();
      }
    }
  }
}

playerresetomnvars() {
  self setclientomnvar("ui_exo_suit_enabled", 0);
  self setclientomnvar("ui_exo_suit_modules_on", 0);
  self setclientomnvar("ui_exo_suit_health", 0);
  self setclientomnvar("ui_exo_suit_recon_cd", 0);
  self setclientomnvar("ui_exo_suit_punch_cd", 0);
  self setclientomnvar("ui_exo_suit_rockets_cd", 0);
  self setclientomnvar("ui_playermech_swarmrecharge", 0);
  self setclientomnvar("ui_playermech_rocketrecharge", 0);
}

playersetjuggexomodel(var_0) {
  self detachall();
  self setModel("npc_exo_armor_mp_base");
  self attach("head_hero_cormack_sentinel_halo");
  self setviewmodel("vm_view_arms_mech_mp");

  if(isDefined(var_0) && !var_0.hasmaniac || isDefined(level.ishorde)) {
    self attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
  }

  if(isai(self)) {
    self.hideondeath = 1;
  }

  self notify("goliath_equipped");
}

playerhandlebarrel() {
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  thread playercleanupbarrel();
  self notifyonplayercommand("goliathAttack", "+attack");
  self notifyonplayercommand("goliathAttackDone", "-attack");
  self.barrellinker = spawn("script_model", self gettagorigin("tag_barrel"));
  self.barrellinker setModel("generic_prop_raven");
  self.barrellinker linktosynchronizedparent(self, "tag_barrel", (12.7, 0, -2.9), (90, 0, 0));
  self.barrel = spawn("script_model", self.barrellinker gettagorigin("j_prop_1"));
  self.barrel setModel("npc_exo_armor_minigun_barrel");
  self.barrel linktosynchronizedparent(self.barrellinker, "j_prop_1", (0, 0, 0), (-90, 0, 0));

  if(isDefined(level.ishorde) && level.ishorde && isPlayer(self)) {
    self.barrel hudoutlineenable(5, 1);
  }

  self.barrellinker scriptmodelplayanimdeltamotion("mp_generic_prop_spin_02");
  self.barrellinker scriptmodelpauseanim(1);

  for(;;) {
    self waittill("goliathAttack");
    self.barrellinker scriptmodelpauseanim(0);
    self waittill("goliathAttackDone");
    self.barrellinker scriptmodelpauseanim(1);
  }
}

playercleanupbarrel() {
  if(isDefined(level.ishorde) && level.ishorde) {
    common_scripts\utility::waittill_any("death", "disconnect", "becameSpectator");
  } else {
    common_scripts\utility::waittill_any("death", "disconnect");
  }

  if(isDefined(level.ishorde) && level.ishorde) {
    self.barrel hudoutlinedisable();
  }

  self.barrel delete();
  self.barrellinker delete();
}

playerrocketsandswarmwatcher() {
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0 == "playermech_rocket_mp") {
      self notify("mech_rocket_pullback");
      self waittill("grenade_fire", var_1);
      self notify("mech_rocket_fire", var_1);
    } else if(var_0 == "playermech_rocket_swarm_mp" || var_0 == "playermech_rocket_swarm_maniac_mp") {
      self notify("mech_swarm_pullback");
      self waittill("grenade_fire", var_1);
      self notify("mech_swarm_fire", var_1.origin);
      var_1 delete();
    }

    waitframe();
  }
}

setupcoopturret(var_0, var_1) {
  var_2 = var_1 gettagorigin("tag_turret");
  var_3 = spawnattachment("juggernaut_sentry_mg_mp", "npc_heavy_exo_armor_turret_base", var_2, 200, var_1, &"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST");
  var_3 setmode("sentry_offline");
  var_3 setsentryowner(var_1);
  var_3 setleftarc(180);
  var_3 setrightarc(180);
  var_3 settoparc(55);
  var_3 setbottomarc(30);
  var_3 setdefaultdroppitch(0.0);
  var_3 setturretmodechangewait(1);
  var_3 makeunusable();
  var_3 maketurretsolid();
  var_3.rocketturret = 0;
  var_3.energyturret = 0;
  var_3.turrettype = "mg_turret";
  var_3.issentry = 0;
  var_3.stunned = 0;
  var_3.nexttracer = 5;
  var_3.heatlevel = 0;
  var_3.baseowner = var_1;

  if(level.teambased) {
    var_3 setturretteam(var_1.team);
  }

  var_3 common_scripts\utility::make_entity_sentient_mp(var_1.team);
  var_3 maps\mp\killstreaks\_autosentry::addtoturretlist(var_3 getentitynumber());
  var_3 thread maps\mp\killstreaks\_remoteturret::turret_watchdisabled();
  var_3 linkto(var_1, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_3.effect = spawnattachmenteffect(var_2, var_1);
  var_3.effect linkto(var_3, "tag_player", (29, -7, -6), (0, 0, 0));
  var_3.effect hide();
  var_0.coopturret = var_3;
  thread stopturret(var_0, var_3, var_1);
  thread handlecoopshooting(var_0, var_3, var_1);
  thread handleturretonplayerdone(var_0, var_3, var_1);
  return var_3;
}

stopturret(var_0, var_1, var_2) {
  var_1 waittill("death");

  if(isDefined(var_1)) {
    var_1.issentry = 0;
    var_2 notify("turretDead");
    removecoopturretbuddy(var_0);
    stopfxonattachment(var_1, common_scripts\utility::getfx("green_light_mp"), 1);
    var_1 playSound("sentry_explode");
    var_1 thread maps\mp\killstreaks\_remoteturret::sentry_stopattackingtargets();
    var_1 maps\mp\killstreaks\_autosentry::removefromturretlist(var_1 getentitynumber());
    var_1 setmode("sentry_offline");
    var_1.damagecallback = undefined;
    var_1 setCanDamage(0);
    var_1 setdamagecallbackon(0);
    var_1 freeentitysentient();
    var_1 setdefaultdroppitch(35);
    var_1 setsentryowner(undefined);
    level thread doturretdeatheffects(var_1);
  }
}

handlecoopshooting(var_0, var_1, var_2) {
  var_1 endon("death");
  var_3 = weaponfiretime("juggernaut_sentry_mg_mp");

  for(;;) {
    if(!isDefined(var_1.remotecontrolled) || !var_1.remotecontrolled) {
      waitframe();
      continue;
    }

    if(var_1.owner attackButtonPressed() && !var_1 isturretoverheated()) {
      var_1 turretshootblank(var_1.baseowner);
      wait(var_3);
      continue;
    }

    waitframe();
  }
}

turretshoot() {
  self shootturret();
  turretshootblank(self.baseowner);
}

turretshootblank(var_0) {
  var_1 = self gettagorigin("tag_flash");
  var_2 = anglesToForward(self gettagangles("tag_flash"));
  var_3 = var_1 + var_2 * 1000;
  var_4 = 0;
  self.nexttracer--;

  if(self.nexttracer <= 0) {
    var_4 = 1;
    self.nexttracer = 5;
  }

  shootblank(var_1, var_3, "juggernaut_sentry_mg_mp", var_4, var_0);
}

doturretdeatheffects(var_0) {
  var_0 playSound("sentry_explode");
  playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), var_0, "tag_aim");
  wait 1.5;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 playSound("sentry_explode_smoke");

  for(var_1 = 0; var_1 < 10; var_1++) {
    playFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), var_0, "tag_aim");
    wait 0.4;

    if(!isDefined(var_0)) {
      return;
    }
  }
}

handleturretonplayerdone(var_0, var_1, var_2) {
  thread attachmentdeath(var_0, var_1, var_2);
  waittillattachmentdone(var_2);
  stopfxonattachment(var_1, common_scripts\utility::getfx("green_light_mp"));
  var_1 maps\mp\killstreaks\_autosentry::removefromturretlist(var_1 getentitynumber());
  var_1.issentry = 0;
  var_2 notify("turretDead");
  removecoopturretbuddy(var_0);
  var_1 delete();
}

setupradar(var_0, var_1) {
  var_2 = var_0 gettagorigin("tag_recon_back");
  var_3 = spawnattachment("radar", "npc_heavy_exo_armor_recon_back_base", var_2, undefined, var_0);
  var_3 linkto(var_0, "tag_recon_back", (0, 0, 0), (0, 0, 0));
  var_0 thread playerhandleradarping(var_1, var_3);
  waittillattachmentdone(var_0);
  waitframe();
  var_3 delete();
}

playerhandleradarping(var_0, var_1) {
  var_1 endon("death");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  if(!isbot(self)) {
    self notifyonplayercommand("juggernautPing", "weapnext");
  }

  playFXOnTag(common_scripts\utility::getfx("exo_ping_inactive"), self, "J_SpineUpper");

  for(;;) {
    self waittill("juggernautPing");
    activate_exo_ping();
    self setclientomnvar("ui_exo_suit_recon_cd", 1);
    wait 10;
    deactivate_exo_ping();
    waitattachmentcooldown(5, "ui_exo_suit_recon_cd");
  }
}

activate_exo_ping() {
  thread stop_exo_ping();
  self setperk("specialty_exo_ping", 1, 0);
  self playlocalsound("mp_exo_cloak_activate");
  self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self, -1);
  killfxontag(common_scripts\utility::getfx("exo_ping_inactive"), self, "J_SpineUpper");
  playFXOnTag(common_scripts\utility::getfx("exo_ping_active"), self, "J_SpineUpper");
}

deactivate_exo_ping() {
  self unsetperk("specialty_exo_ping", 1);
  self playlocalsound("mp_exo_cloak_deactivate");

  if(isDefined(self.highlight_effect)) {
    maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
  }

  killfxontag(common_scripts\utility::getfx("exo_ping_active"), self, "J_SpineUpper");
  playFXOnTag(common_scripts\utility::getfx("exo_ping_inactive"), self, "J_SpineUpper");
}

stop_exo_ping() {
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    common_scripts\utility::waittill_any("death", "faux_spawn", "joined_team", "becameSpectator");
  } else {
    common_scripts\utility::waittill_any("death", "faux_spawn", "joined_team");
  }

  self unsetperk("specialty_exo_ping", 1);

  if(isDefined(self.highlight_effect)) {
    maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
  }

  killfxontag(common_scripts\utility::getfx("exo_ping_active"), self, "J_SpineUpper");
}

setupmaniac(var_0) {
  var_1 = var_0 gettagorigin("tag_maniac_l");
  var_2 = spawnattachment("speedAttachment", "npc_heavy_exo_armor_maniac_l_base", var_1, undefined, var_0);
  var_2 linkto(var_0, "tag_maniac_l", (0, 0, 0), (0, 0, 0));
  var_1 = var_0 gettagorigin("tag_maniac_r");
  var_3 = spawnattachment("speedAttachment", "npc_heavy_exo_armor_maniac_r_base", var_1, undefined, var_0);
  var_3 linkto(var_0, "tag_maniac_r", (0, 0, 0), (0, 0, 0));
  var_4 = var_0 gettagorigin("tag_jetpack");
  var_5 = spawnattachment("speedAttachment", "npc_heavy_exo_armor_jetpack_base", var_4, undefined, var_0);
  var_5 linkto(var_0, "tag_jetpack", (0, 0, 0), (0, 0, 0));
  waittillattachmentdone(var_0);
  attachmentexplode(var_2, var_0, "maniac", var_3);
  attachmentexplode(var_5, var_0, "maniac");
  waitframe();
  var_2 delete();
  var_3 delete();
  var_5 delete();
}

setuplongpunch(var_0, var_1) {
  var_0 setlethalweapon("playermech_rocket_mp");
  var_0 giveweapon("playermech_rocket_mp");
  var_2 = "tag_origin";
  var_0 thread playerwatchnoobtubeuse(var_1);
  waittillattachmentdone(var_0);
}

playerwatchnoobtubeuse(var_0) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    self waittill("mech_rocket_fire", var_1);
    playFXOnTag(common_scripts\utility::getfx("lethal_rocket_wv"), self, "TAG_WEAPON_RIGHT");
    thread reloadrocket(self, var_0);
  }
}

reloadrocket(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  waitattachmentcooldown(10, "ui_exo_suit_punch_cd");
}

playrocketreloadsound(var_0) {
  self playlocalsound("orbitalsupport_reload_40mm");
}

waitattachmentcooldown(var_0, var_1) {
  var_2 = 0;

  for(;;) {
    wait 0.05;
    var_2 = var_2 + 0.05;
    var_3 = 1 - var_2 / var_0;
    var_3 = clamp(var_3, 0, 1);
    self setclientomnvar(var_1, var_3);

    if(var_3 <= 0) {
      break;
    }
  }
}

setuptrophy(var_0, var_1) {
  var_2 = var_0 gettagorigin("j_spine4");
  var_3 = spawnattachment("trophy", "npc_heavy_exo_armor_trophy_l_base", var_2, undefined, var_0);
  var_3.stunned = 0;
  var_3.ammo = 1;
  var_3 linkto(var_0, "tag_trophy_l", (0, 0, 0), (0, 0, 0));
  var_3.weaponname = "heavy_exo_trophy_mp";
  var_3 thread maps\mp\gametypes\_equipment::trophyactive(var_0, undefined, 1, var_3.weaponname);
  var_3 thread maps\mp\gametypes\_equipment::trophyaddlaser(12, (90, 90, 270));
  var_3 thread maps\mp\gametypes\_equipment::trophysetmindot(-0.087, (90, 90, 270));
  level.trophies[level.trophies.size] = var_3;
  var_4 = spawnattachment("trophy", "npc_heavy_exo_armor_trophy_r_base", var_2, undefined, var_0);
  var_4.stunned = 0;
  var_4.ammo = 1;
  var_4 linkto(var_0, "tag_trophy_r", (0, 0, 0), (0, 0, 0));
  var_4.weaponname = "heavy_exo_trophy_mp";
  var_4 thread maps\mp\gametypes\_equipment::trophyactive(var_0, undefined, 1, var_4.weaponname);
  var_4 thread maps\mp\gametypes\_equipment::trophyaddlaser(6, (260, 90, 270));
  var_4 thread maps\mp\gametypes\_equipment::trophysetmindot(-0.087, (260, 90, 270));
  level.trophies[level.trophies.size] = var_4;
  var_3.othertrophy = var_4;
  var_4.othertrophy = var_3;
  waittillattachmentdone(var_0);
  var_3 notify("trophyDisabled");
  var_4 notify("trophyDisabled");
  waitframe();

  if(isDefined(var_3.laserent)) {
    var_3.laserent delete();
  }

  if(isDefined(var_4.laserent)) {
    var_4.laserent delete();
  }

  var_3 delete();
  var_4 delete();
}

trophystunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;
  self.othertrophy.stunned = 1;
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::getfx("mine_stunned"), var_0, "tag_origin");
  thread trophymovestunent(var_0);
  common_scripts\utility::waittill_notify_or_timeout("death", 3);
  self notify("stunEnd");
  stopFXOnTag(common_scripts\utility::getfx("mine_stunned"), var_0, "tag_origin");
  waitframe();
  var_0 delete();

  if(isDefined(self)) {
    self.stunned = 0;
    self.othertrophy.stunned = 0;
  }
}

trophymovestunent(var_0) {
  self endon("death");
  self endon("stunEnd");

  for(;;) {
    var_0.origin = self.origin;
    waitframe();
  }
}

setuprocketswarm(var_0, var_1) {
  var_2 = "playermech_rocket_swarm_mp";

  if(var_1.hasmaniac) {
    var_2 = "playermech_rocket_swarm_maniac_mp";
  }

  var_0 settacticalweapon(var_2);
  var_0 giveweapon(var_2);
  var_3 = "tag_origin";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawnattachment("rocketAttachment", "npc_heavy_exo_armor_missile_pack_base", var_4, undefined, var_0);
  var_5.lockedtarget = 0;
  var_5.reloading = 0;
  var_5.rockets = [];
  var_5.icons = [];
  var_5 linkto(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_5 hide();
  var_0.rocketattachment = var_5;
  thread scanforrocketenemies(var_5, var_0);
  var_0 thread playerwatchrocketuse(var_5, var_1);
  waittillattachmentdone(var_0, var_5);
  waitframe();
  var_5 delete();
  var_0.rocketattachment = undefined;
}

scanforrocketenemies(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_1 endon("becameSpectator");
  }

  for(;;) {
    waitframe();

    if(var_0.reloading || var_0.rockets.size > 0 || var_0.lockedtarget) {
      continue;
    }
    var_2 = getbestenemy(var_1, 4);

    if(isDefined(var_2)) {
      if(!isDefined(var_0.enemytarget) || var_0.enemytarget != var_2) {
        thread markplayerasrockettarget(var_0, var_1, var_2);
      }

      continue;
    }

    if(isDefined(var_0.enemytarget)) {
      var_0 notify("unmark");
      var_0.enemytarget = undefined;
    }
  }
}

playerisrocketswarmreloading() {
  return isDefined(self.rocketattachment) && isDefined(self.rocketattachment.reloading) && self.rocketattachment.reloading;
}

playerisrocketswarmtargetlocked() {
  return isDefined(self.rocketattachment) && isDefined(self.rocketattachment.enemytarget);
}

getbestenemy(var_0, var_1) {
  var_2 = 0.843391;
  var_3 = anglesToForward(var_0 getangles());
  var_4 = var_0 getEye();
  var_5 = undefined;
  var_6 = [];

  foreach(var_8 in level.participants) {
    if(var_8.team == var_0.team) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_8)) {
      continue;
    }
    var_9 = var_8 getEye();
    var_10 = vectornormalize(var_9 - var_4);
    var_11 = vectordot(var_3, var_10);

    if(var_11 > var_2) {
      var_6[var_6.size] = var_8;
      var_8.dot = var_11;
      var_8.checked = 0;
    }
  }

  if(var_6.size == 0) {
    return;
  }
  for(var_13 = 0; var_13 < var_1 && var_13 < var_6.size; var_13++) {
    var_14 = gethighestdot(var_6);
    var_14.checked = 1;
    var_15 = var_4;
    var_16 = var_14 getEye();
    var_17 = sighttracepassed(var_15, var_16, 1, var_0, var_14);

    if(var_17) {
      var_5 = var_14;
      break;
    }
  }

  foreach(var_8 in level.participants) {
    var_8.dot = undefined;
    var_8.checked = undefined;
  }

  return var_5;
}

gethighestdot(var_0) {
  if(var_0.size == 0) {
    return;
  }
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!var_4.checked && var_4.dot > var_2) {
      var_1 = var_4;
      var_2 = var_4.dot;
    }
  }

  return var_1;
}

playerwatchrocketuse(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    self waittill("mech_swarm_fire", var_2);

    if(var_0.reloading || var_0.lockedtarget) {
      waitframe();
      continue;
    }

    thread handlelockedtarget(var_0, var_1);
    thread reloadrocketswarm(var_0, self, var_1);
    thread firerocketswarm(var_0, self, var_2);
  }
}

handlelockedtarget(var_0, var_1) {
  var_0 endon("death");
  var_0.lockedtarget = 1;
  var_0 notify("lockedTarget");
  waittillrocketsexploded(var_0);

  if(isDefined(var_0)) {
    var_0.lockedtarget = 0;
    var_0.enemytarget = undefined;
  }
}

firerocketswarm(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1 getangles());
  var_4 = anglestoright(var_1 getangles());
  var_5 = [(0, 0, 50), (0, 0, 20), (10, 0, 0), (0, 10, 0)];
  playFXOnTag(common_scripts\utility::getfx("swarm_rocket_wv"), var_1, "TAG_ROCKET4");

  for(var_6 = 0; var_6 < 4; var_6++) {
    var_7 = var_2 + var_3 * 20 + var_4 * -30;
    var_8 = var_3 + random_vector(0.2);
    var_9 = magicbullet("iw5_juggernautrockets_mp", var_7, var_7 + var_8, var_1);
    var_0.rockets = common_scripts\utility::array_add(var_0.rockets, var_9);
    var_9 thread rockettargetent(var_0, var_0.enemytarget, var_5[var_6]);
    var_9 thread rocketdestroyaftertime(7);
  }
}

rockettargetent(var_0, var_1, var_2) {
  var_0 endon("death");

  if(isDefined(var_1)) {
    self missile_settargetent(var_1, var_2);
  }

  self waittill("death");
  var_0.rockets = common_scripts\utility::array_remove(var_0.rockets, self);
}

rocketdestroyaftertime(var_0) {
  self endon("death");
  wait(var_0);
  self delete();
}

reloadrocketswarm(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.reloading = 1;
  waitattachmentcooldown(10, "ui_exo_suit_rockets_cd");
  var_0.reloading = 0;
}

playrocketswarmreloadsound(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = 3;
  self playlocalsound("warbird_missile_reload_bed");
  wait 0.5;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    self playlocalsound("warbird_missile_reload");
    wait(var_2 / var_3);
  }
}

markplayerasrockettarget(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  var_0 notify("mark");
  var_0 endon("mark");
  var_0 endon("unmark");
  var_3 = (0, 0, 60);
  var_4 = var_2 getentitynumber();
  var_0.enemytarget = var_2;

  if(isDefined(level.ishorde) && level.ishorde) {
    var_2 hudoutlineenableforclient(var_1, 1, 0);
    var_1.markedformech[var_1.markedformech.size] = var_2;
  } else {
    var_2 hudoutlineenableforclient(var_1, 4, 0);
  }

  thread cleanuprockettargeticon(var_0, var_2, var_1);
  var_0 waittill("lockedTarget");
  var_2 hudoutlineenableforclient(var_1, 0, 0);
  waittillrocketsexploded(var_0);

  if(isDefined(level.ishorde) && level.ishorde) {
    if(level.currentaliveenemycount < 3) {
      if(level.objdefend && distancesquared(var_1.origin, level.currentdefendloc.origin) > 640000) {
        var_2 hudoutlineenableforclient(var_1, level.enemyoutlinecolor, 0);
      }

      var_1.markedformech = common_scripts\utility::array_remove(var_1.markedformech, var_2);
    } else {
      var_2 hudoutlinedisableforclient(var_1);
      var_1.markedformech = common_scripts\utility::array_remove(var_1.markedformech, var_2);
    }
  } else {
    var_2 hudoutlinedisableforclient(var_1);
  }
}

cleanuprockettargeticon(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  waittillunmarkplayerasrockettarget(var_0);

  if(isDefined(level.ishorde) && level.ishorde && isDefined(var_2)) {
    if(level.currentaliveenemycount < 3) {
      if(level.objdefend && distancesquared(var_2.origin, level.currentdefendloc.origin) > 640000) {
        var_1 hudoutlineenableforclient(var_2, level.enemyoutlinecolor, 0);
      }

      var_2.markedformech = common_scripts\utility::array_remove(var_2.markedformech, var_1);
    } else {
      var_1 hudoutlinedisableforclient(var_2);
      var_2.markedformech = common_scripts\utility::array_remove(var_2.markedformech, var_1);
    }
  } else if(isDefined(var_2)) {
    var_1 hudoutlinedisableforclient(var_2);
  }
}

waittillunmarkplayerasrockettarget(var_0) {
  var_0.enemytarget endon("death");
  var_0 common_scripts\utility::waittill_any("death", "mark", "unmark");
}

waittillrocketsexploded(var_0) {
  wait 0.1;

  while(isDefined(var_0) && var_0.rockets.size > 0) {
    waitframe();
  }
}

waittillattachmentdone(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 endon("death");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  if(isDefined(var_2)) {
    var_2 endon("death");
  }

  var_0 waittill("forever");
}

delayplayFX(var_0, var_1) {
  var_0 endon("death");
  waitframe();
  waitframe();
  playFXOnTag(var_1, var_0, "tag_origin");
}

stopfxonattachment(var_0, var_1, var_2) {
  if(isDefined(var_0.effect)) {
    stopFXOnTag(var_1, var_0.effect, "tag_origin");

    if(isDefined(var_2) && var_2) {
      playFX(common_scripts\utility::getfx("juggernaut_sparks"), var_0.effect.origin);
    }

    var_0.effect delete();
  }
}

attachmentdeath(var_0, var_1, var_2, var_3) {
  var_2 endon("death");
  var_2 endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_2 endon("becameSpectator");
  }

  if(isDefined(var_3)) {
    var_3 endon("death");
  }

  var_1 waittill("death", var_4, var_5, var_6);

  if(isDefined(var_4) && isPlayer(var_4)) {
    var_7 = level.juggsettings[var_0.juggtype].splashattachmentname;

    if(issubstr(var_1.attachmenttype, "weakSpot")) {
      var_7 = level.juggsettings[var_0.juggtype].splashweakenedname;
    }

    maps\mp\_utility::teamplayercardsplash(var_7, var_4);
  }
}

attachmentexplode(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    if(isalive(var_1)) {
      var_1 thread playerplayattachmentdialog(var_0.attachmenttype);
    }

    if(isDefined(var_0)) {
      playFX(common_scripts\utility::getfx("juggernaut_sparks"), var_0.origin);
    }

    if(isDefined(var_3)) {
      playFX(common_scripts\utility::getfx("juggernaut_sparks"), var_3.origin);
    }

    var_1 playSound("sentry_explode");
  }
}

hidefromplayer(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self showtoplayer(var_2);
    }
  }
}

hidefromplayers(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    if(!common_scripts\utility::array_contains(var_0, var_2)) {
      self showtoplayer(var_2);
    }
  }
}

spawnattachment(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(issubstr(var_0, "sentry")) {
    var_6 = spawnturret("misc_turret", var_2, var_0);
  } else {
    var_6 = spawn("script_model", var_2);
  }

  var_6 setModel(var_1);
  var_6.attachmenttype = var_0;

  if(isDefined(var_3)) {
    var_6.health = var_3;
    var_6.maxhealth = var_6.health;
    var_6.damagecallback = ::handleattachmentdamage;

    if(isDefined(var_5)) {
      var_6 thread handleattachmentdeath(var_0, var_4, var_5);
    }

    var_6 setdamagecallbackon(1);
  }

  var_6 hidefromplayer(var_4);
  var_6.owner = var_4;

  if(level.teambased) {
    var_6.team = var_4.team;
  }

  return var_6;
}

spawnattachmenteffect(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin");
  var_3 hidefromplayer(var_1);
  thread delayplayFX(var_3, common_scripts\utility::getfx("green_light_mp"));
  return var_3;
}

handleattachmentdeath(var_0, var_1, var_2) {
  if(var_0 == "weakSpotHead") {
    return;
  }
  level endon("game_ended");
  self waittill("death", var_3, var_4, var_5);

  if(!isDefined(var_3) || !isPlayer(var_3) || isDefined(var_1) && var_3 == var_1) {
    return;
  }
  level thread maps\mp\gametypes\_rank::awardgameevent("heavy_exo_attachment", var_3, undefined, undefined, undefined, var_2);
}

handleattachmentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self.lasttimedamaged)) {
    self.lasttimedamaged = 0;
  }

  var_12 = var_2;

  if(isDefined(var_1) && !maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner, var_1) || var_1 == self.owner || self.lasttimedamaged == gettime()) {
    var_12 = 0;
  } else {
    if(isDefined(var_5) && var_5 == "boost_slam_mp" && var_2 > 10) {
      var_12 = 10;
    }

    if(maps\mp\_utility::ismeleemod(var_4)) {
      var_12 = var_12 + self.maxhealth;
    }

    if(isDefined(var_3) && var_3 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    self.wasdamaged = 1;
    self.damagefade = 0.0;

    if(isPlayer(var_1)) {
      if(var_1 maps\mp\_utility::_hasperk("specialty_armorpiercing")) {
        var_12 = var_12 * level.armorpiercingmod;
      }

      var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("juggernautAttachment");
      var_1 notify("hitHeavyExoAttachment");
      self.lastattacker = var_1;
    }

    if(isDefined(var_5)) {
      var_13 = maps\mp\_utility::strip_suffix(var_5, "_lefthand");

      switch (var_13) {
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
        case "stinger_mp":
        case "remotemissile_projectile_mp":
          self.largeprojectiledamage = 1;
          var_12 = self.maxhealth + 1;
          break;
        case "stealth_bomb_mp":
        case "artillery_mp":
          self.largeprojectiledamage = 0;
          var_12 = var_12 + var_2 * 4;
          break;
        case "emp_grenade_killstreak_mp":
        case "emp_grenade_var_mp":
        case "emp_grenade_mp":
        case "bomb_site_mp":
          self.largeprojectiledamage = 0;
          var_12 = self.maxhealth + 1;
          break;
      }

      maps\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_5, self);
    }
  }

  self.lasttimedamaged = gettime();
  self finishentitydamage(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

random_vector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

handlecoopjoining(var_0, var_1) {
  for(;;) {
    var_2 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(var_1.team, &"MP_JOIN_HEAVY_EXO", "heavy_exosuit_coop_offensive", "assist_mp_goliath", "copilot_mp_goliath", var_1);
    level thread watchforjoin(var_2, var_1, var_0);
    var_3 = waittillpromptcomplete(var_1, "buddyJoinedStreak");
    maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_2);

    if(!isDefined(var_3)) {
      return;
    }
    var_3 = waittillpromptcomplete(var_1, "buddyLeftCoopTurret");

    if(!isDefined(var_3)) {
      return;
    }
  }
}

waittillpromptcomplete(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("turretDead");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  return var_0 common_scripts\utility::waittill_any_return_no_endon_death(var_1, var_2, var_3);
}

waittillturretstuncomplete(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("turretDead");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_1 endon("becameSpectator");
  }

  for(;;) {
    waitframe();

    if(var_0.coopturret.stunned || var_0.coopturret.directhacked) {
      continue;
    }
    return 1;
  }
}

watchforjoin(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("death");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_1 endon("becameSpectator");
  }

  var_3 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(var_0);
  var_1 notify("buddyJoinedStreak");
  var_3 thread playerremotecoopturret(var_2);
}

playerremotecoopturret(var_0) {
  self endon("disconnect");
  var_0.coopturret endon("death");
  var_0.streakplayer endon("death");
  var_0.streakplayer endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
    var_0.streakplayer endon("becameSpectator");
  }

  var_0.coopturret setsentryowner(undefined);
  var_0.coopturret setsentryowner(self);
  var_0.coopturret.owner = self;
  var_0.coopturret.effect hidefromplayers([self, var_0.streakplayer]);
  self.using_remote_turret = 1;
  var_0.coopturret maps\mp\killstreaks\_remoteturret::startusingremoteturret(180, 180, 55, 30, 1);
  thread removecoopturretbuddyondisconnect(var_0);
  var_0.coopturret maps\mp\killstreaks\_remoteturret::waittillremoteturretleavereturn();
  removecoopturretbuddy(var_0);
}

removecoopturretbuddyondisconnect(var_0) {
  var_0.coopturret endon("removeCoopTurretBuddy");
  self waittill("disconnect");
  thread removecoopturretbuddy(var_0);
}

removecoopturretbuddy(var_0) {
  if(!isDefined(var_0.coopturret.remotecontrolled)) {
    return;
  }
  var_0.coopturret notify("removeCoopTurretBuddy");
  var_0.coopturret.remotecontrolled = undefined;
  var_1 = var_0.coopturret.owner;

  if(isDefined(var_1)) {
    var_1.using_remote_turret = undefined;
    var_0.coopturret maps\mp\killstreaks\_remoteturret::stopusingremoteturret(0);
  } else if(isalive(var_0.coopturret)) {}

  var_1 enableweaponswitch();

  if(isDefined(var_0.streakplayer) && maps\mp\_utility::isreallyalive(var_0.streakplayer)) {
    if(isDefined(var_0.coopturret.effect)) {
      var_0.coopturret.effect hide();
    }

    var_0.coopturret setsentryowner(undefined);
    var_0.coopturret setsentryowner(var_0.streakplayer);
    var_0.coopturret.owner = var_0.streakplayer;
    var_0.streakplayer notify("buddyLeftCoopTurret");
  }
}

playershowjuggernauthud(var_0) {
  var_0.hud = [];
  thread playerwatchemp(var_0);
  createjuggernautoverlay(var_0);
}

createjuggernautoverlay(var_0) {
  self setclientomnvar("ui_exo_suit_enabled", 1);
  thread playermech_state_manager();
}

playerwatchemp(var_0) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    common_scripts\utility::waittill_any("emp_grenaded", "applyEMPkillstreak", "directHackStarted");

    foreach(var_2 in var_0.hud) {
      var_2.alpha = 0;
    }

    for(;;) {
      common_scripts\utility::waittill_any("empGrenadeTimedOut", "removeEMPkillstreak", "directHackTimedOut");
      waitframe();

      if(playershouldshowhud()) {
        break;
      }
    }

    foreach(var_2 in var_0.hud) {
      if(var_2.type != "rocketReload") {
        var_2 fadeovertime(0.5);
        var_2.alpha = 1;
      }
    }
  }
}

playershouldshowhud() {
  return !isDefined(self.empgrenaded) || !self.empgrenaded || (!isDefined(self.empon) || !self.empon);
}

playerplayattachmentdialog(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "juggernaut_sentry_mp_mp":
      var_1 = "sntryoff_mp_exoai";
      break;
    case "speedAttachment":
      var_1 = "mancoff_mp_exoai";
      break;
    case "punchAttachment":
      var_1 = "longoff_mp_exoai";
      break;
    case "radar":
      var_1 = "rcnoff_mp_exoai";
      break;
    case "rocketAttachment":
      var_1 = "rcktoff_mp_exoai";
      break;
    case "trophy":
      var_1 = "trphyoff_mp_exoai";
      break;
    default:
      var_1 = "weakdmg_mp_exoai";
      break;
  }

  maps\mp\_utility::leaderdialogonplayer(var_1);
}

playerlaunchdroppod(var_0) {
  var_1 = maps\mp\killstreaks\_orbital_util::playergetoutsidenode();

  if(!isDefined(var_1)) {
    thread maps\mp\killstreaks\_orbital_util::playerplayinvalidpositioneffect(common_scripts\utility::getfx("ocp_ground_marker_bad"));
    self setclientomnvar("ui_invalid_goliath", 1);
    return 0;
  }

  thread firedroppod(var_1, var_0);
  return 1;
}

droppodmovenearbyallies(var_0) {
  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self.unresolved_collision_nodes = getnodesinradius(self.origin, 300, 80, 200);

  foreach(var_2 in level.characters) {
    if(!isalive(var_2)) {
      continue;
    }
    if(isalliedsentient(var_2, var_0)) {
      if(distancesquared(self.origin, var_2.origin) < 6000) {
        maps\mp\_movers::unresolved_collision_nearest_node(var_2, 1);
      }
    }
  }
}

givebackgoliathstreak(var_0) {
  var_1 = maps\mp\killstreaks\_killstreaks::getstreakcost("heavy_exosuit");
  var_2 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("heavy_exosuit", 0);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("heavy_exosuit", var_1, undefined, var_0, var_2);
  thread maps\mp\killstreaks\_killstreaks::givekillstreak("heavy_exosuit", 0, 0, self, var_0);
}

firedroppod(var_0, var_1) {
  var_2 = maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(var_0);
  var_3 = var_0.origin;
  var_4 = magicbullet("orbital_carepackage_droppod_mp", var_2, var_3, self, 0, 1);
  var_4.team = self.team;
  var_4.killcament = spawn("script_model", (0, 0, 0));
  var_4.killcament linktosynchronizedparent(var_4, "tag_origin", (0, 0, 200), (0, 10, 10));
  var_4.killcament.targetname = "killCamEnt_goliath_droppod";
  var_4.killcament setscriptmoverkillcam("missile");
  var_4 thread maps\mp\_load::deletedestructiblekillcament();
  var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(var_5, "invisible", (0, 0, 0));
  objective_position(var_5, var_3);
  objective_state(var_5, "active");
  var_6 = "compass_waypoint_farp";
  objective_icon(var_5, var_6);
  var_7 = spawn("script_model", var_3 + (0, 0, 5));
  var_7.angles = (-90, 0, 0);
  var_7 setModel("tag_origin");
  var_7 hide();
  var_7 showtoplayer(self);
  playFXOnTag(common_scripts\utility::getfx("jugg_droppod_marker"), var_7, "tag_origin");
  maps\mp\killstreaks\_orbital_util::adddropmarker(var_7);
  var_8 = 0;

  if(isDefined(level.ishorde) && level.ishorde) {
    if(self.killstreakindexweapon == 1) {
      self notify("used_horde_goliath");
      var_8 = 1;
      self.hordeclassgoliathpodinfield = 1;
    }

    self.hordegoliathpodinfield = 1;
  }

  var_4 waittill("death");

  if(distancesquared(var_4.origin, var_3) > 22500) {
    var_7 delete();
    maps\mp\_utility::_objective_delete(var_5);

    if(!isDefined(level.ishorde) || !level.ishorde) {
      givebackgoliathstreak(var_1);
    } else {
      self[[level.hordegivebackgoliath]](var_8);
      self.hordeclassgoliathpodinfield = undefined;
      self.hordegoliathpodinfield = undefined;
    }

    return;
  }

  var_3 = getgroundposition(var_4.origin + (0, 0, 8), 20);
  thread destroy_nearby_turrets(var_3);
  var_7 hide();
  earthquake(0.4, 1, var_3, 800);
  playrumbleonposition("artillery_rumble", var_3);
  stopFXOnTag(common_scripts\utility::getfx("jugg_droppod_marker"), var_7, "tag_origin");
  var_9 = spawn("script_model", var_3);
  var_9.angles = (0, 0, 0);
  var_9 createcollision(var_3);
  var_9.targetname = "care_package";
  var_9.droppingtoground = 0;
  var_9.curobjid = var_5;
  var_10 = spawn("script_model", var_3);
  var_10.angles = (90, 0, 0);
  var_10.targetname = "goliath_pod_model";
  var_10 setModel("vehicle_drop_pod");
  var_10 thread handle_goliath_drop_pod_removal(var_9);

  if(isDefined(self)) {
    var_9.owner = self;
  }

  var_9.cratetype = "juggernaut";
  var_9.droptype = "juggernaut";
  var_9 thread control_goliath_usability();
  var_9 sethintstring(&"KILLSTREAKS_HEAVY_EXO_PICKUP");
  var_9 thread maps\mp\killstreaks\_airdrop::crateothercapturethink();
  var_9 thread maps\mp\killstreaks\_airdrop::crateownercapturethink();
  var_9 thread usegoliathupdater();
  var_11 = spawnStruct();
  var_11.useent = var_9;
  var_11.playdeathfx = 1;
  var_11.deathoverridecallback = ::movingplatformdeathfunc;
  var_11.touchingplatformvalid = ::movingplatformtouchvalid;
  var_9 thread maps\mp\_movers::handle_moving_platforms(var_11);
  var_9 thread handle_goliath_drop_pod_timeout(var_8);
  var_9 droppodmovenearbyallies(self);

  if(isDefined(level.ishorde) && level.ishorde) {
    var_9 disconnectpaths();
  }

  if(isDefined(level.ishorde) && level.ishorde) {
    if(level.zombiesstarted || level.teamemped["allies"]) {
      var_9 deletegoliathpod();
    } else {
      var_9 thread delete_goliath_drop_pod_for_event(self);
    }
  }

  var_12 = var_9 playerwaittillgoliathactivated();

  if(isDefined(level.ishorde) && level.ishorde && isDefined(self)) {
    if(isDefined(var_12) && var_12 != self) {
      if(var_8) {
        var_12.hordeclassgoliathowner = self;
        self.hordeclassgoliathcontroller = var_12;
      } else {
        var_12.hordegoliathowner = self;
        self.hordegoliathcontroller = var_12;
      }

      var_12[[level.laststandsaveloadoutinfo]](1, 1, 1);
    } else {
      self[[level.laststandsaveloadoutinfo]](1, 1, 1);
    }

    self.hordeclassgoliathpodinfield = undefined;
    self.hordegoliathpodinfield = undefined;
  }

  if(isDefined(var_12) && isalive(var_12)) {
    maps\mp\gametypes\_gamelogic::sethasdonecombat(var_12, 1);
    self notify("entering_juggernaut");
    var_12.enteringgoliath = 1;
    var_12 takeallweapons();
    var_12 giveweapon("iw5_combatknifegoliath_mp", 0, 0, 0, 1);
    var_12 switchtoweapon("iw5_combatknifegoliath_mp");
    var_12 unlink();
    var_12 maps\mp\_utility::freezecontrolswrapper(1);
    var_13 = var_3 - var_12.origin;
    var_14 = vectortoangles(var_13);
    var_15 = (0, var_14[1], 0);
    var_16 = rotatevector(var_13, (45, 0, 0));
    var_17 = spawn("script_model", var_3);
    var_17.angles = var_15;
    var_17 setModel("npc_exo_armor_ingress");
    var_17 scriptmodelplayanimdeltamotion("mp_goliath_spawn");
    var_12 maps\mp\_snd_common_mp::snd_message("goliath_pod_burst");

    if(isDefined(var_9)) {
      var_9 deletegoliathpod(0);
    }

    playFX(level._effect["jugg_droppod_open"], var_3, var_16);
    wait 0.1;
    var_12 is_entering_goliath(var_17, var_3);

    if(isDefined(var_12) && isalive(var_12) && !(isDefined(level.ishorde) && level.ishorde && isDefined(var_12.isspectator) && var_12.isspectator)) {
      var_12 setorigin(var_3, 1);
      var_12 setangles(var_17.angles);
      var_12 enableweapons();
      var_12 givejuggernaut("juggernaut_exosuit", var_1);
      var_17 delete();
      var_12 playgoliathtoidleleanim();

      if(isDefined(level.ishorde) && level.ishorde) {
        var_12.enteringgoliath = undefined;
      }

      wait 1;
      var_12.enteringgoliath = undefined;
      var_12 maps\mp\_utility::freezecontrolswrapper(0);

      if(isDefined(level.ishorde) && level.ishorde) {
        var_12 hudoutlineenable(5, 1);
      }
    } else {
      var_17 delete();
    }
  }

  var_7 delete();
}

destroy_nearby_turrets(var_0) {
  var_1 = 4096;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.turret) && distancesquared(var_3.turret.origin, var_0) <= var_1) {
      var_3.turret notify("death");
    }
  }
}

is_goliath_drop_pod(var_0) {
  return isDefined(var_0.cratetype) && var_0.cratetype == "juggernaut" && isDefined(var_0.droptype) && var_0.droptype == "juggernaut";
}

movingplatformdeathfunc(var_0) {
  if(isDefined(self) && isDefined(self.curobjid)) {
    maps\mp\_utility::_objective_delete(self.curobjid);
  }

  if(isDefined(var_0.emptymech)) {
    var_0.emptymech delete();
  }

  if(isDefined(var_0.useent)) {
    var_0.useent delete();
  }
}

movingplatformtouchvalid(var_0) {
  return goliathandcarepackagevalid(var_0) && goliathandgoliathvalid(var_0) && goliathandplatformvalid(var_0);
}

goliathandcarepackagevalid(var_0) {
  return !isDefined(self.cratetype) || !isDefined(var_0.targetname) || self.cratetype != "juggernaut" || var_0.targetname != "care_package";
}

goliathandgoliathvalid(var_0) {
  return !isDefined(self.cratetype) || !isDefined(var_0.cratetype) || self.cratetype != "juggernaut" || var_0.cratetype != "juggernaut";
}

goliathandplatformvalid(var_0) {
  return !isDefined(self.cratetype) || !isDefined(var_0.carepackagetouchvalid) || self.cratetype != "juggernaut" || !var_0.carepackagetouchvalid;
}

control_goliath_usability() {
  self endon("captured");
  self endon("death");
  level endon("game_ended");
  self makeusable();

  foreach(var_1 in level.players) {
    self disableplayeruse(var_1);
  }

  for(;;) {
    foreach(var_1 in level.players) {
      var_4 = 0;

      if(var_1 isonground() && !var_1 isonladder() && !var_1 isjumping() && !var_1 ismantling() && maps\mp\_utility::isreallyalive(var_1) && var_1 getstance() == "stand") {
        if(distancesquared(self.origin, var_1.origin) < 6000) {
          if(var_1 worldpointinreticle_rect(self.origin + (0, 0, 50), 65, 400, 600)) {
            var_4 = 1;
          }
        }
      }

      if(var_4 == 1) {
        self enableplayeruse(var_1);
        continue;
      }

      self disableplayeruse(var_1);
    }

    wait 0.2;
  }
}

is_entering_goliath(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_1 = var_1 - var_2 * 37;
  self setorigin(var_1, 0);
  self setangles(var_0.angles);
  wait 0.05;
  var_0 scriptmodelplayanimdeltamotion("mp_goliath_enter");
  self playgoliathentryanim();
  wait 2.3;
}

createcollision(var_0) {
  var_1 = getent("goliath_collision", "targetname");

  if(isDefined(var_1)) {
    self clonebrushmodeltoscriptmodel(var_1);
  }
}

playerwaittillgoliathactivated() {
  self endon("death");
  self waittill("captured", var_0);
  var_0 setstance("stand");
  var_0 setdemigod(1);

  if(isDefined(self.owner) && var_0 != self.owner) {
    if(!level.teambased || var_0.team != self.owner.team) {
      var_0 thread maps\mp\_events::hijackerevent(self.owner);
    } else if(!isDefined(level.ishorde)) {
      self.owner thread maps\mp\_events::sharedevent();
    }
  }

  return var_0;
}

usegoliathupdater() {
  self endon("death");
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(var_1 maps\mp\_utility::isjuggernaut()) {
      self disableplayeruse(var_1);
      thread usepostjuggernautupdater(var_1);
    }
  }

  for(;;) {
    level waittill("juggernaut_equipped", var_1);
    self disableplayeruse(var_1);
    thread usepostjuggernautupdater(var_1);
  }
}

usepostjuggernautupdater(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  var_0 waittill("death");
  self enableplayeruse(var_0);
}

adjustlink(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  thread drawspine(var_2, var_0);
  setDvar("scr_adjust_angles", "" + var_4);
  setDvar("scr_adjust_origin", "" + var_3);
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);

  for(;;) {
    waitframe();
    var_7 = getdvarvector("scr_adjust_angles");
    var_8 = getdvarvector("scr_adjust_origin");

    if(var_7 == var_5 && var_8 == var_6) {
      continue;
    }
    var_5 = var_7;
    var_6 = var_8;
    var_0 unlink();
    var_0 linkto(var_2, var_1, var_6, var_5);
  }
}

drawspine(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 endon("death");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 endon("becameSpectator");
  }

  for(;;) {
    var_2 = var_1.origin;
    var_3 = var_1.angles;
    debug_axis(var_2, var_3);
    waitframe();
  }
}

debug_axis(var_0, var_1) {
  var_2 = 20;
  var_3 = anglesToForward(var_1) * var_2;
  var_4 = anglestoright(var_1) * var_2;
  var_5 = anglestoup(var_1) * var_2;
}

playermech_ui_state_reset() {
  if(!isDefined(self.mechuistate)) {
    self.mechuistate = spawnStruct();
    self.mechuistate.chaingun = spawnStruct();
    self.mechuistate.swarm = spawnStruct();
    self.mechuistate.rocket = spawnStruct();
    self.mechuistate.threat_list = spawnStruct();
    self.mechuistate.state = "none";
    self.mechuistate.chaingun.state = "none";
    self.mechuistate.chaingun.last_state = "none";
    self.mechuistate.swarm.state = "none";
    self.mechuistate.swarm.last_state = "none";
    self.mechuistate.rocket.state = "none";
    self.mechuistate.rocket.last_state = "none";
  }

  set_mech_state();
  self.mechuistate.threat_list.threats = [];
  self.mechuistate.threat_list.compass_offsets = [];
  self.mechuistate.chaingun.heatlevel = 0;
  self.mechuistate.chaingun.overheated = 0;
  self.mechuistate.swarm.threat_scan = 0;
  self.mechuistate.swarm.recharge = 100;
  self.mechuistate.rocket.fire = 0;
  self.mechuistate.rocket.recharge = 100;
}

playermech_state_manager() {
  self endon("disconnect");
  self endon("exit_mech");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  playermech_ui_state_reset();
  set_mech_state();
  set_mech_chaingun_state();
  set_mech_rocket_state();
  set_mech_swarm_state();
  waitframe();

  for(;;) {
    state_chaingun_pump();
    state_rocket_pump();
    state_swarm_pump();
    playermech_ui_update_lui(self.mechuistate);
    wait 0.05;
  }
}

set_mech_state(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(self.mechuistate)) {
    return;
  }
  if(self.mechuistate.state == var_0) {
    return;
  }
  self.mechuistate.state = var_0;
}

get_mech_state() {
  if(!isDefined(self.mechuistate)) {
    return;
  }
  return self.mechuistate.state;
}

get_is_in_mech() {
  var_0 = self getattachmodelname(0);

  if(isDefined(var_0) && var_0 == "head_hero_cormack_sentinel_halo") {
    return 1;
  }

  return 0;
}

get_front_sorted_threat_list(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(vectordot(var_4.origin - self.origin, var_1) < 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_2 = sortbydistance(var_2, self.origin);
  return var_2;
}

playermech_ui_weapon_feedback(var_0, var_1) {
  self endon("disconnect");
  self endon("exit_mech");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  self setclientomnvar(var_1, 0);

  for(;;) {
    while(!self call[[var_0]]()) {
      wait 0.05;
    }

    self setclientomnvar(var_1, 1);

    while(self call[[var_0]]()) {
      wait 0.05;
    }

    self setclientomnvar(var_1, 0);
    wait 0.05;
  }
}

playermech_ui_update_lui(var_0) {
  var_1 = playerisrocketswarmtargetlocked();
  var_2 = 0;

  if(var_1) {
    var_2 = 1;
  }

  if(self.heavyexodata.hasrockets) {
    self setclientomnvar("ui_playermech_swarmrecharge", var_0.swarm.recharge);
  }

  if(self.heavyexodata.haslongpunch) {
    self setclientomnvar("ui_playermech_rocketrecharge", var_0.rocket.recharge);
  }
}

playermech_invalid_gun_callback() {
  if(self.mechuistate.chaingun.overheated) {
    return 1;
  }

  return 0;
}

playermech_invalid_rocket_callback() {
  if(self.mechuistate.rocket.recharge < 100) {
    return 1;
  }

  return 0;
}

playermech_invalid_swarm_callback() {
  if(self.mechuistate.swarm.recharge < 100) {
    return 1;
  }

  return 0;
}

playermech_invalid_weapon_instance(var_0, var_1) {
  self endon("disconnect");
  self endon("exit_mech");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  var_2 = 0;

  for(;;) {
    wait 0.05;

    if(self call[[var_0]]()) {
      if(!var_2) {
        if([[var_1]]()) {
          var_2 = 1;
          self playlocalsound("wpn_mech_offline");
          wait 1.5;
        }
      }

      continue;
    }

    var_2 = 0;
  }
}

playermech_invalid_weapon_watcher() {
  thread playermech_invalid_weapon_instance(::attackbuttonpressed, ::playermech_invalid_gun_callback);
  thread playermech_invalid_weapon_instance(::fragbuttonpressed, ::playermech_invalid_rocket_callback);
  thread playermech_invalid_weapon_instance(::secondaryoffhandbuttonpressed, ::playermech_invalid_swarm_callback);
}

state_main_pump() {
  switch (get_mech_state()) {
    case "dmg2":
    case "dmg2_transition":
    case "dmg1":
    case "dmg1_transition":
    case "base":
    case "base_transition":
    case "base_swarmonly":
    case "base_noweap":
    case "base_swarmonly_exit":
    case "base_swarmonly_nolegs":
    case "base_noweap_bootup":
      break;
    case "none":
      playermech_ui_state_reset();
      break;
    default:
  }
}

state_chaingun_pump() {
  var_0 = get_mech_chaingun_state();
  var_1 = self getcurrentweapon();
  self.mechuistate.chaingun.heatlevel = self getweaponheatlevel(var_1);
  self.mechuistate.chaingun.overheated = self isweaponoverheated(var_1);

  if(var_0 == "ready") {
    if(self.mechuistate.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(self attackButtonPressed()) {
      set_mech_chaingun_state("firing");
    }
  } else if(var_0 == "firing") {
    if(self.mechuistate.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(!self attackButtonPressed()) {
      set_mech_chaingun_state("ready");
    }
  } else if(var_0 == "overheat" && !self.mechuistate.chaingun.overheated) {
    set_mech_chaingun_state("ready");
  }
}

state_rocket_pump() {
  var_0 = get_mech_rocket_state();

  if(var_0 != "offline" && playermech_invalid_rocket_callback()) {
    set_mech_rocket_state("reload");
  } else if(var_0 == "reload" && !playermech_invalid_rocket_callback()) {
    set_mech_rocket_state("ready");
  }
}

state_swarm_pump() {
  var_0 = get_mech_swarm_state();

  if(!playerisrocketswarmtargetlocked() && !playerisrocketswarmreloading()) {
    set_mech_swarm_state("target");
  } else if(var_0 == "target" && playermech_invalid_swarm_callback()) {
    set_mech_swarm_state("reload");
  } else if(var_0 == "reload" && !playermech_invalid_swarm_callback()) {
    set_mech_swarm_state("ready");
  }
}

set_mech_chaingun_state(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(self.mechuistate.chaingun.state)) {
    self.mechuistate.chaingun.state = "none";
  }

  if(self.mechuistate.chaingun.state == var_0) {
    return;
  }
  self.mechuistate.chaingun.state = var_0;
  self notify("chaingun_state_" + var_0);
}

get_mech_chaingun_state() {
  if(!isDefined(self.mechuistate)) {
    return;
  }
  return self.mechuistate.chaingun.state;
}

same_mech_chaingun_last_state() {
  if(isDefined(self.mechuistate.chaingun.last_state) && self.mechuistate.chaingun.state == self.mechuistate.chaingun.last_state) {
    return 1;
  }

  self.mechuistate.chaingun.last_state = self.mechuistate.chaingun.state;
  return 0;
}

set_mech_rocket_state(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(self.mechuistate.rocket.state)) {
    self.mechuistate.rocket.state = "none";
  }

  if(self.mechuistate.rocket.state == var_0) {
    return;
  }
  self.mechuistate.rocket.state = var_0;
}

get_mech_rocket_state() {
  if(!isDefined(self.mechuistate)) {
    return;
  }
  return self.mechuistate.rocket.state;
}

same_mech_rocket_last_state() {
  if(isDefined(self.mechuistate.rocket.last_state) && self.mechuistate.rocket.state == self.mechuistate.rocket.last_state) {
    return 1;
  }

  self.mechuistate.rocket.last_state = self.mechuistate.rocket.state;
  return 0;
}

set_mech_swarm_state(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(self.mechuistate.swarm.state)) {
    self.mechuistate.swarm.state = "none";
  }

  if(self.mechuistate.swarm.state == var_0) {
    return;
  }
  self.mechuistate.swarm.state = var_0;
}

get_mech_swarm_state() {
  if(!isDefined(self.mechuistate)) {
    return;
  }
  return self.mechuistate.swarm.state;
}

same_mech_swarm_last_state() {
  if(isDefined(self.mechuistate.swarm.last_state) && self.mechuistate.swarm.state == self.mechuistate.swarm.last_state) {
    return 1;
  }

  self.mechuistate.swarm.last_state = self.mechuistate.swarm.state;
  return 0;
}

playermech_monitor_update_recharge(var_0, var_1) {
  var_0.recharge = 0;
  var_2 = 100.0 / (var_1 / 0.05);

  while(var_0.recharge < 100) {
    var_0.recharge = var_0.recharge + var_2;
    wait 0.05;
  }

  var_0.recharge = 100;

  while(isDefined(self.underwatermotiontype)) {
    wait 0.05;
  }
}

playermech_monitor_rocket_recharge() {
  self endon("disconnect");
  self endon("exit_mech");
  self notify("stop_rocket_recharge");
  self endon("stop_rocket_recharge");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    self waittill("mech_rocket_fire");
    self disableoffhandweapons();
    playermech_monitor_update_recharge(self.mechuistate.rocket, 10);
    self enableoffhandweapons();
    wait 0.05;
  }
}

playermech_monitor_swarm_recharge() {
  self endon("disconnect");
  self endon("exit_mech");
  self notify("stop_swarm_recharge");
  self endon("stop_swarm_recharge");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    self waittill("mech_swarm_fire");
    self disableoffhandsecondaryweapons();
    playermech_monitor_update_recharge(self.mechuistate.swarm, 10);
    self enableoffhandsecondaryweapons();
    wait 0.05;
  }
}

play_goliath_death_fx() {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  common_scripts\utility::waittill_any("death", "joined_team", "faux_spawn");

  if(isai(self)) {
    maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
    playFX(common_scripts\utility::getfx("goliath_self_destruct"), self.origin, anglestoup(self.angles));

    if(isagent(self) && isDefined(self.hideondeath) && self.hideondeath == 1) {
      var_0 = self getcorpseentity();

      if(isDefined(var_0)) {
        var_0 hide();
      }
    }
  } else if(!isDefined(self.juggernautsuicide) && !isDefined(level.ishorde)) {
    playFXOnTag(common_scripts\utility::getfx("goliath_death_fire"), self.body, "J_NECK");
    maps\mp\_snd_common_mp::snd_message("goliath_death_explosion");
  }

  self.juggernautsuicide = undefined;
}

self_destruct_goliath() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("horde_cancel_goliath");
  }

  var_0 = 0;

  while(maps\mp\_utility::isjuggernaut()) {
    if(self useButtonPressed()) {
      var_0 = var_0 + 0.05;

      if(var_0 > 1.0) {
        maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(common_scripts\utility::getfx("goliath_self_destruct"), self.origin, anglestoup(self.angles));
        wait 0.05;
        self.hideondeath = 1;
        self.juggernautsuicide = 1;
        radiusdamage(self.origin + (0, 0, 50), 400, 200, 20, self, "MOD_EXPLOSIVE", "killstreak_goliathsd_mp");

        if(isDefined(level.ishorde) && level.ishorde) {
          self thread[[level.hordehandlejuggdeath]]();
        }
      }
    } else {
      var_0 = 0;
    }

    wait 0.05;
  }
}

playermechtimeout() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lost_juggernaut");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("horde_cancel_goliath");
  }

  for(;;) {
    wait 1;
    self.mechhealth = self.mechhealth - int(self.maxhealth / 100);

    if(self.mechhealth < 0) {
      maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
      playFX(common_scripts\utility::getfx("goliath_self_destruct"), self.origin, anglestoup(self.angles));
      self thread[[level.hordehandlejuggdeath]]();
    }

    self setclientomnvar("ui_exo_suit_health", self.mechhealth / self.maxhealth);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.hideondeath = 0;
  }
}

deletegoliathpod(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(self.curobjid)) {
    maps\mp\_utility::_objective_delete(self.curobjid);
  }

  if(isDefined(self.droptype)) {
    if(var_0) {
      playFX(common_scripts\utility::getfx("ocp_death"), self.origin);
    }

    if(var_1) {
      playsoundatpos(self.origin, "orbital_pkg_self_destruct");
    }
  }

  self delete();
}

handle_goliath_drop_pod_timeout(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 120;

  if(isDefined(level.ishorde) && level.ishorde && var_0) {
    self.owner.hordeclassgoliathpodinfield = undefined;
    self.owner.hordegoliathpodinfield = undefined;
    self.owner notify("startJuggCooldown");
  }

  deletegoliathpod();
}

delete_goliath_drop_pod_for_event(var_0) {
  level endon("game_ended");
  self endon("death");
  common_scripts\utility::waittill_any_ents(level, "zombies_start", level, "EMP_JamTeamallies", var_0, "disconnect");
  deletegoliathpod();
}

handle_goliath_drop_pod_removal(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 waittill("death");
  self delete();
}

playermech_watch_emp_grenade() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  for(;;) {
    self waittill("emp_grenaded", var_0);

    if(isDefined(var_0) && isPlayer(var_0)) {
      var_0 thread ch_emp_goliath_think();
    }
  }
}

ch_emp_goliath_think() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isDefined(level.ishorde) && level.ishorde) {
    self endon("becameSpectator");
  }

  var_0 = 5.0;
  wait(var_0);

  if(maps\mp\_utility::isreallyalive(self)) {
    maps\mp\gametypes\_missions::processchallenge("ch_precision_closecall");
  }
}
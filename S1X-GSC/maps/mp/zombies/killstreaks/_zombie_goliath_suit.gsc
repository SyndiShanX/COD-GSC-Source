/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\killstreaks\_zombie_goliath_suit.gsc
****************************************************************/

init() {
  level._effect["green_light_mp"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
  level._effect["juggernaut_sparks"] = loadfx("vfx/explosion/bouncing_betty_explosion");
  level._effect["jugg_droppod_open"] = loadfx("vfx/explosion/goliath_pod_opening");
  level._effect["jugg_droppod_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_goliath");
  level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
  level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
  level._effect["lethal_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_lethal_flash_wv");
  level._effect["swarm_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_tactical_wv_run");
  level.goliathsuitweapons = ["iw5_exominigunzm_mp", "playermech_rocket_zm_mp", "playermech_rocket_swarm_zm_mp", "iw5_juggernautrocketszm_mp", "iw5_combatknifegoliath_mp"];
  level.killstreakwieldweapons["iw5_exominigunzm_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["playermech_rocket_zm_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["playermech_rocket_swarm_zm_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_juggernautrocketszm_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["iw5_combatknifegoliath_mp"] = "juggernaut_exosuit";
  level.killstreakwieldweapons["orbital_carepackage_droppod_zm_mp"] = "juggernaut_exosuit";
  level.killstreakfuncs["zm_goliath_suit"] = ::tryuseheavyexosuit;
  level.customjuggernautdamagefunc = ::juggernautmodifydamage;
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
  level thread roundlogic();
}

roundlogic() {
  var_0 = randomintrange(8, 10);

  for(;;) {
    level waittill("zombie_wave_started");

    if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops)) {
      continue;
    }
    while(level.wavecounter >= var_0) {
      var_1 = randomfloatrange(35, 45);
      var_2 = level common_scripts\utility::waittill_notify_or_timeout_return("zombie_wave_ended", var_1);

      if(!isDefined(var_2) || var_2 != "timeout") {
        continue;
      }
      if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops)) {
        continue;
      }
      var_2 = tryuseheavyexosuit();

      if(isDefined(var_2)) {
        var_0 = var_0 + randomintrange(5, 7);
      }
    }

    level waittill("zombie_wave_ended");
  }
}

getowner() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      return var_1;
    }
  }
}

tryuseheavyexosuit(var_0, var_1) {
  var_2 = self;

  if(!isDefined(self) || !isplayer(self)) {
    var_2 = getowner();

    if(!isDefined(var_2)) {
      return 0;
    }
  }

  var_3 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcratelandingspot(var_2, "goliath_suit");

  if(!isDefined(var_3)) {
    return 0;
  }

  level thread firedroppod(var_3, [], var_2);
  return 1;
}

givejuggernaut(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self.attackerlist = [];
  var_2 = 1;
  self.juggmovespeedscaler = var_2;
  var_3 = isDefined(self.perks["specialty_hardline"]);
  self.isjuggernaut = 1;
  self.movespeedscaler = var_2;
  maps\mp\_utility::giveperk("specialty_radarjuggernaut", 0);

  if(var_3) {
    maps\mp\_utility::giveperk("specialty_hardline", 0);
  }

  thread playersetupjuggernautexo(var_1, var_0);
  self.saved_lastweapon = self getweaponslistprimaries()[0];
  maps\mp\gametypes\_weapons::updatemovespeedscale();
  self playsoundonmovingent("goliath_suit_up_mp");
  level thread announcerglobalplaysuitvo("gol_start", 5, self);
  level notify("juggernaut_equipped", self);
  maps\mp\_matchdata::logkillstreakevent("juggernaut", self.origin);
}

cggoliathroverlay() {
  self endon("death");
  self endon("disconnect");
  self endon("death");
  self endon("ejectedFromJuggernaut");
  var_0 = 0.35;
  var_1 = newclienthudelem(self);
  thread cggoliathoverlaycleanup(var_1);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0.0;
  var_1 fadeovertime(var_0);
  var_1.alpha = 1.0;
  wait 2;
  var_1 fadeovertime(var_0);
  var_1.alpha = 0.0;
}

cggoliathoverlaycleanup(var_0) {
  var_0 endon("death");
  common_scripts\utility::waittill_any("spawned", "disconnect", "ejectedFromJuggernaut", "death");
  var_0 destroy();
}

removeweapons() {
  maps\mp\zombies\_zombies_laststand::savelaststandweapons("", 0);
  self.primarytorestore = common_scripts\utility::getlastweapon();
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    var_3 = maps\mp\_utility::getweaponnametokens(var_2);

    if(var_3[0] == "alt") {
      self.restoreweaponclipammo[var_2] = self getweaponammoclip(var_2);
      self.restoreweaponstockammo[var_2] = self getweaponammostock(var_2);
      continue;
    }

    self.restoreweaponclipammo[var_2] = self getweaponammoclip(var_2);
    self.restoreweaponstockammo[var_2] = self getweaponammostock(var_2);
  }

  self.weaponstorestore = [];

  foreach(var_2 in var_0) {
    var_3 = maps\mp\_utility::getweaponnametokens(var_2);

    if(var_3[0] == "alt") {
      continue;
    }
    if(maps\mp\_utility::iskillstreakweapon(var_2)) {
      continue;
    }
    self.weaponstorestore[self.weaponstorestore.size] = var_2;
    self takeweapon(var_2);
  }
}

restoreweapons() {
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    if(maps\mp\_utility::iskillstreakweapon(var_2) && !iskillstreakgoliathweapon(var_2)) {
      continue;
    }
    self takeweapon(var_2);
  }

  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.restoreweaponstockammo) || !isDefined(self.weaponstorestore)) {
    return;
  }
  self setlethalweapon("none");
  self settacticalweapon("none");
  var_4 = [];

  foreach(var_2 in self.weaponstorestore) {
    var_6 = maps\mp\_utility::getweaponnametokens(var_2);

    if(var_6[0] == "alt") {
      var_4[var_4.size] = var_2;
      continue;
    }

    if(maps\mp\zombies\_util::iszombielethal(var_2)) {
      self setlethalweapon(var_2);
    } else if(maps\mp\zombies\_util::iszombietactical(var_2)) {
      self settacticalweapon(var_2);
    }

    maps\mp\_utility::_giveweapon(var_2);

    if(isDefined(self.restoreweaponclipammo[var_2])) {
      self setweaponammoclip(var_2, self.restoreweaponclipammo[var_2]);
    }

    if(isDefined(self.restoreweaponstockammo[var_2])) {
      self setweaponammostock(var_2, self.restoreweaponstockammo[var_2]);
    }
  }

  foreach(var_9 in var_4) {
    if(isDefined(self.restoreweaponclipammo[var_9])) {
      self setweaponammoclip(var_9, self.restoreweaponclipammo[var_9]);
    }

    if(isDefined(self.restoreweaponstockammo[var_9])) {
      self setweaponammostock(var_9, self.restoreweaponstockammo[var_9]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.restoreweaponstockammo = undefined;
}

iskillstreakgoliathweapon(var_0) {
  return common_scripts\utility::array_contains(level.goliathsuitweapons, var_0);
}

playersetupjuggernautexo(var_0, var_1) {
  var_2 = spawnStruct();
  self.heavyexodata = var_2;
  var_2.streakplayer = self;
  var_2.hascoopsentry = 0;
  var_2.modules = var_0;
  var_2.juggtype = var_1;
  var_2.hasradar = 0;
  var_2.hasmaniac = 0;
  var_2.haslongpunch = 1;
  var_2.hastrophy = 0;
  var_2.hasrockets = 1;
  var_2.hasextraammo = 0;
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
  maps\mp\_utility::playerallowdodge(0, "heavyexo");
  maps\mp\_utility::playerallowboostjump(0, "heavyexo");
  maps\mp\_utility::playerallowhighjump(0, "heavyexo");
  maps\mp\_utility::playerallowhighjumpdrop(0, "heavyexo");
  self allowjump(0);
  self allowcrouch(0);
  self allowladder(0);
  self allowmantle(0);
  self.inliveplayerkillstreak = 1;
  self.mechhealth = 600;
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
  thread playermechtimeout();

  if(var_2.hascoopsentry) {
    var_4 = setupcoopturret(var_2, self);

    if(level.teambased) {
      level thread handlecoopjoining(var_2, self);
    }
  }

  if(!var_2.hasmaniac) {
    thread playerhandlebarrel();
    set_mech_chaingun_state("ready");
  }

  if(var_2.haslongpunch) {
    level thread setuplongpunch(self, var_2);
    set_mech_rocket_state("ready");
    thread playermech_monitor_rocket_recharge();
  }

  if(var_2.hasrockets) {
    level thread setuprocketswarm(self, var_2);
    set_mech_swarm_state("ready");
    thread playermech_monitor_swarm_recharge();
  }

  level thread setupeject(var_2, self);
  level thread delaysetweapon(self);
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

  if(isDefined(var_1) && isDefined(var_0) && var_1 == var_0 && isDefined(var_4) && (var_4 == "iw5_juggernautrocketszm_mp" || var_4 == "playermech_rocket_zm_mp")) {
    var_9 = 0;
  }

  if(isDefined(var_0.goliathbootupsequence) && var_0.goliathbootupsequence) {
    var_9 = 0;
  }

  if(isDefined(var_1) && !maps\mp\gametypes\_weapons::friendlyfirecheck(var_0, var_1)) {
    var_9 = 0;
  }

  if(isDefined(var_1) && isDefined(var_1.agent_type) && var_1.agent_type == "zombie_boss_oz_stage2" && var_3 == "MOD_IMPACT") {
    var_9 = var_9 * 2;
  }

  if(var_9 > 0) {
    if(maps\mp\_utility::attackerishittingteam(var_0, var_1)) {
      if(isDefined(level.juggernautmod)) {
        var_9 = var_9 * level.juggernautmod;
      } else {
        var_9 = var_9 * 0.08;
      }
    }

    var_10 = var_0.mechhealth / 600;
    var_0.mechhealth = var_0.mechhealth - var_9;
    var_11 = var_0.mechhealth / 600;
    var_0 setclientomnvar("ui_exo_suit_health", var_11);
    level thread dogoliathintegrityvo(var_10, var_11, self);

    if(isDefined(var_1) && isplayer(var_1)) {
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
      if(!isDefined(var_0.underwatermotiontype)) {
        var_0 thread playereject();
      } else {
        var_0 thread playerkillheavyexo(var_5, var_1, var_3, var_4, var_8);
      }
    }
  }

  return 0;
}

dogoliathintegrityvo(var_0, var_1, var_2) {
  if(var_0 > 0.75 && var_1 <= 0.75) {
    level thread announcerglobalplaysuitvo("gol_armor1", undefined, var_2);
  } else if(var_0 > 0.5 && var_1 <= 0.5) {
    level thread announcerglobalplaysuitvo("gol_armor2", undefined, var_2);
  } else if(var_0 > 0.25 && var_1 <= 0.25) {
    level thread announcerglobalplaysuitvo("gol_armor3", undefined, var_2);
  } else if(var_0 > 0.08 && var_1 <= 0.08) {
    level thread announcerglobalplaysuitvo("gol_armor4", undefined, var_2);
  }
}

playerkillheavyexo(var_0, var_1, var_2, var_3, var_4) {
  if(maps\mp\_utility::isjuggernaut()) {
    playerreset();
  }

  var_5 = "ui_zm_character_" + self.characterindex + "_alive";
  setomnvar(var_5, 0);
  maps\mp\_utility::_suicide();

  if(level.players.size < 2) {
    maps\mp\zombies\_zombies_laststand::zombieendgame(undefined, "MOD_SUICIDE");
  }

  level notify("player_left_goliath_suit");
}

delaysetweapon(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 giveweapon("iw5_exominigunzm_mp");
  var_0 switchtoweapon("iw5_exominigunzm_mp");
  waitframe();
  var_0 setplayermech(1);
  var_0 common_scripts\utility::_disableweaponswitch();

  if(var_0 hasweapon("iw5_combatknifegoliath_mp")) {
    var_0 takeweapon("iw5_combatknifegoliath_mp");
  }
}

playercleanupondeath(var_0) {
  self endon("disconnect");
  self endon("ejectedFromJuggernaut");
  self waittill("death", var_1, var_2, var_3);

  if(maps\mp\_utility::isjuggernaut()) {
    thread playerreset();
  }
}

playercleanuponother() {
  self endon("death");
  self endon("disconnect");
  self endon("ejectedFromJuggernaut");
  level common_scripts\utility::waittill_any("game_ended");
  playerresetomnvars();
}

playerreset() {
  self notify("lost_juggernaut");
  self notify("exit_mech");
  self.heavyexodata = undefined;
  self.isjuggernaut = 0;
  self unsetperk("specialty_radarjuggernaut", 1);
  self.movespeedscaler = 1;
  maps\mp\gametypes\_weapons::updatemovespeedscale();
  maps\mp\_utility::playerallowpowerslide(1, "heavyexo");
  maps\mp\_utility::playerallowdodge(1, "heavyexo");
  maps\mp\_utility::playerallowboostjump(1, "heavyexo");
  maps\mp\_utility::playerallowhighjump(1, "heavyexo");
  maps\mp\_utility::playerallowhighjumpdrop(1, "heavyexo");
  self allowjump(1);
  self allowcrouch(1);
  self allowladder(1);
  self allowmantle(1);
  self.inliveplayerkillstreak = undefined;
  self.mechhealth = undefined;
  self setdemigod(0);
  playerresetomnvars();
  self setplayermech(0);
  common_scripts\utility::_enableweaponswitch();
  self enableoffhandweapons();
  self enableoffhandsecondaryweapons();
  self.restoreweaponclipammo = undefined;
  self.restoreweaponstockammo = undefined;

  if(isDefined(self.juggernautattachments)) {
    self.juggernautattachments = undefined;
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
  self attach(self.characterhead);
  self setviewmodel("vm_view_arms_mech_mp");
  self attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
}

playerhandlebarrel() {
  self endon("death");
  self endon("disconnect");
  self endon("ejectedFromJuggernaut");
  thread playercleanupbarrel();
  self notifyonplayercommand("goliathAttack", "+attack");
  self notifyonplayercommand("goliathAttackDone", "-attack");
  self.barrellinker = spawn("script_model", self gettagorigin("tag_barrel"));
  self.barrellinker setModel("generic_prop_raven");
  self.barrellinker linktosynchronizedparent(self, "tag_barrel", (12.7, 0, -2.9), (90, 0, 0));
  self.barrel = spawn("script_model", self.barrellinker gettagorigin("j_prop_1"));
  self.barrel setModel("npc_exo_armor_minigun_barrel");
  self.barrel linktosynchronizedparent(self.barrellinker, "j_prop_1", (0, 0, 0), (-90, 0, 0));
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
  common_scripts\utility::waittill_any("death", "disconnect", "ejectedFromJuggernaut");

  if(isDefined(self)) {
    if(isDefined(self.barrel)) {
      self.barrel delete();
    }

    if(isDefined(self.barrellinker)) {
      self.barrellinker delete();
    }
  }
}

playerrocketsandswarmwatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("ejectedFromJuggernaut");

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0 == "playermech_rocket_zm_mp") {
      self notify("mech_rocket_pullback");
      self waittill("grenade_fire", var_1);
      self notify("mech_rocket_fire", var_1);
    } else if(var_0 == "playermech_rocket_swarm_zm_mp") {
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
  var_3 = spawnattachment("juggernaut_sentry_mg_zm_mp", "npc_heavy_exo_armor_turret_base", var_2, 200, var_1, &"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST");
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
  var_3 = weaponfiretime("juggernaut_sentry_mg_zm_mp");

  for(;;) {
    if(!isDefined(var_1.remotecontrolled) || !var_1.remotecontrolled) {
      waitframe();
      continue;
    }

    if(var_1.owner attackbuttonpressed() && !var_1 isturretoverheated()) {
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

  shootblank(var_1, var_3, "juggernaut_sentry_mg_zm_mp", var_4, var_0);
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

setuplongpunch(var_0, var_1) {
  var_0 setlethalweapon("playermech_rocket_zm_mp");
  var_0 giveweapon("playermech_rocket_zm_mp");
  var_2 = "tag_origin";
  var_0 thread playerwatchnoobtubeuse(var_1);
  waittillattachmentdone(var_0);
}

playerwatchnoobtubeuse(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("ejectedFromJuggernaut");

  for(;;) {
    self waittill("mech_rocket_fire", var_1);
    playFXOnTag(common_scripts\utility::getfx("lethal_rocket_wv"), self, "TAG_WEAPON_RIGHT");
    thread reloadrocket(self, var_0);
  }
}

reloadrocket(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  self endon("ejectedFromJuggernaut");
  waitattachmentcooldown(var_0 playergetrocketreloadtime(), "ui_exo_suit_punch_cd");
}

playergetrocketreloadtime() {
  if(maps\mp\_utility::gameflag("unlimited_ammo")) {
    return 0.1;
  } else if(maps\mp\_utility::_hasperk("specialty_fastreload")) {
    return 5;
  } else {
    return 10;
  }
}

waitattachmentcooldown(var_0, var_1) {
  self endon("disconnect");
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

setuprocketswarm(var_0, var_1) {
  var_2 = "playermech_rocket_swarm_zm_mp";
  var_0 settacticalweapon(var_2);
  var_0 giveweapon(var_2);
  var_3 = "tag_origin";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawnattachment("rocketAttachment", "npc_heavy_exo_armor_missile_pack_base", var_4, undefined, var_0);
  var_5.lockedtarget = 0;
  var_5.reloading = 0;
  var_5.enemytargets = [];
  var_5.rockets = [];
  var_5.icons = [];
  var_5 linkto(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_5 hide();
  var_0.rocketattachment = var_5;
  thread scanforrocketenemies(var_5, var_0);
  var_0 thread playerwatchrocketuse(var_5, var_1);
  waittillattachmentdone(var_0, var_5);
  waitframe();

  if(isDefined(var_5)) {
    var_5 delete();
  }

  var_0.rocketattachment = undefined;
}

scanforrocketenemies(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("ejectedFromJuggernaut");

  for(;;) {
    waitframe();

    if(var_0.reloading || var_0.rockets.size > 0 || var_0.lockedtarget) {
      continue;
    }
    var_0.enemytargets = getbestenemies(var_1, 5);
  }
}

playerisrocketswarmreloading() {
  return isDefined(self.rocketattachment) && isDefined(self.rocketattachment.reloading) && self.rocketattachment.reloading;
}

playerisrocketswarmtargetlocked() {
  return isDefined(self.rocketattachment) && isDefined(self.rocketattachment.enemytargets) && self.rocketattachment.enemytargets.size > 0;
}

getbestenemies(var_0, var_1) {
  var_2 = 0.843391;
  var_3 = anglesToForward(var_0 getangles());
  var_4 = var_0 getEye();
  var_5 = undefined;
  var_6 = [];
  var_7 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  if(isDefined(level.bossozstage1) && isDefined(level.bossozstage1.damagecallback)) {
    var_7[var_7.size] = level.bossozstage1;
  }

  foreach(var_9 in var_7) {
    if(issentient(var_9) && isalliedsentient(var_9, var_0)) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_9)) {
      continue;
    }
    if(issentient(var_9)) {
      var_10 = var_9 getEye();
    } else {
      var_10 = var_9.origin + (0, 0, 55);
    }

    var_11 = vectornormalize(var_10 - var_4);
    var_12 = vectordot(var_3, var_11);

    if(var_12 > var_2) {
      var_6[var_6.size] = var_9;
      var_9.dot = var_12;
      var_9.checked = 0;
    }
  }

  if(var_6.size == 0) {
    return [];
  }

  var_14 = [];

  for(var_15 = 0; var_15 < var_1 && var_15 < var_6.size; var_15++) {
    var_16 = gethighestdot(var_6);

    if(!isDefined(var_16)) {
      return;
    }
    var_16.checked = 1;
    var_17 = var_4;

    if(issentient(var_16)) {
      var_18 = var_16 getEye();
    } else {
      var_18 = var_16.origin + (0, 0, 55);
    }

    var_19 = sighttracepassed(var_17, var_18, 1, var_0, var_16);

    if(var_19) {
      var_14[var_14.size] = var_16;
    }
  }

  foreach(var_9 in var_7) {
    var_9.dot = undefined;
    var_9.checked = undefined;
  }

  return var_14;
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
    var_0.enemytargets = [];
  }
}

firerocketswarm(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1 getangles());
  var_4 = anglestoright(var_1 getangles());
  var_5 = [(0, 0, 50), (0, 0, 20), (10, 0, 0), (0, 10, 0)];
  playFXOnTag(common_scripts\utility::getfx("swarm_rocket_wv"), var_1, "TAG_ROCKET4");
  var_6 = 0;
  var_7 = undefined;

  for(var_8 = 0; var_8 < 4; var_8++) {
    var_9 = var_2 + var_3 * 20 + var_4 * -30;
    var_10 = var_3 + random_vector(0.2);
    var_11 = magicbullet("iw5_juggernautrocketszm_mp", var_9, var_9 + var_10, var_1);
    var_0.rockets = common_scripts\utility::array_add(var_0.rockets, var_11);

    if(var_6 < var_0.enemytargets.size) {
      var_7 = var_0.enemytargets[var_6];
      var_6++;
    }

    var_11 thread rockettargetent(var_0, var_7, var_5[var_8]);
    var_11 thread rocketdestroyaftertime(7);
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
  waitattachmentcooldown(var_1 playergetswarmreloadtime(), "ui_exo_suit_rockets_cd");
  var_0.reloading = 0;
}

playergetswarmreloadtime() {
  if(maps\mp\_utility::gameflag("unlimited_ammo")) {
    return 0.1;
  } else if(maps\mp\_utility::_hasperk("specialty_fastreload")) {
    return 5;
  } else {
    return 10;
  }
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
  var_0 endon("ejectedFromJuggernaut");

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
  var_2 endon("ejectedFromJuggernaut");

  if(isDefined(var_3)) {
    var_3 endon("death");
  }

  var_1 waittill("death", var_4, var_5, var_6);
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

  if(!isDefined(var_3) || !isplayer(var_3) || isDefined(var_1) && var_3 == var_1) {
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

    if(isplayer(var_1)) {
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
  var_0 endon("ejectedFromJuggernaut");
  var_0 endon("turretDead");
  return var_0 common_scripts\utility::waittill_any_return_no_endon_death(var_1, var_2, var_3);
}

waittillturretstuncomplete(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("turretDead");
  var_1 endon("ejectedFromJuggernaut");

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
  var_1 endon("ejectedFromJuggernaut");
  var_3 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(var_0);
  var_1 notify("buddyJoinedStreak");
  var_3 thread playerremotecoopturret(var_2);
}

playerremotecoopturret(var_0) {
  self endon("disconnect");
  var_0.coopturret endon("death");
  var_0.streakplayer endon("death");
  var_0.streakplayer endon("disconnect");
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
  self setclientomnvar("ui_exo_suit_enabled", 1);
  thread playermech_state_manager();
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

droppodmovenearbyallies(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self.unresolved_collision_nodes = getnodesinradius(self.origin, 300, 80, 200);

  foreach(var_2 in level.characters) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_2.team == var_0) {
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

firedroppod(var_0, var_1, var_2) {
  var_3 = var_2 maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(var_0);
  var_4 = var_0.origin;

  if(!isDefined(var_2)) {
    var_2 = getowner();
  }

  var_5 = var_2.team;
  var_6 = magicbullet("orbital_carepackage_droppod_zm_mp", var_3, var_4, var_2, 0, 1);
  var_6.team = var_5;
  var_7 = spawn("script_model", var_4 + (0, 0, 5));
  var_7.angles = (-90, 0, 0);
  var_7 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::getfx("jugg_droppod_marker"), var_7, "tag_origin");
  maps\mp\killstreaks\_orbital_util::adddropmarker(var_7, "goliath_suit");

  if(!maps\mp\zombies\_util::is_true(level.zmkillstreakgoliathprevo)) {
    var_8 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint(var_7.origin);
    var_8 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("gol_drop_pre");
    level.zmkillstreakgoliathprevo = 1;
  }

  var_6 waittill("death");

  if(distancesquared(var_6.origin, var_4) > 22500) {
    var_7 delete();
    return;
  }

  var_4 = getgroundposition(var_6.origin + (0, 0, 8), 20);

  if(!maps\mp\zombies\_util::is_true(level.zmkillstreakgoliathreactvo)) {
    var_8 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint(var_4);
    var_8 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("gol_react");
    level.zmkillstreakgoliathreactvo = 1;
  }

  thread destroy_nearby_turrets(var_4);
  var_7 hide();
  earthquake(0.4, 1, var_4, 800);
  playrumbleonposition("artillery_rumble", var_4);
  stopFXOnTag(common_scripts\utility::getfx("jugg_droppod_marker"), var_7, "tag_origin");
  var_9 = spawn("script_model", var_4);
  var_9.angles = (0, 0, 0);
  var_9 createcollision(var_4);
  var_9.targetname = "care_package";
  var_9.droppingtoground = 0;
  var_10 = spawn("script_model", var_4);
  var_10.angles = (90, 0, 0);
  var_10.targetname = "goliath_pod_model";
  var_10 setModel("vehicle_drop_pod");
  var_10 thread handle_goliath_drop_pod_removal(var_9);
  var_10 maps\mp\_entityheadicons::setheadicon(var_5, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon("zm_goliath_suit", []), (0, 0, 140), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  var_9.owner = undefined;
  var_9.cratetype = "juggernaut";
  var_9.droptype = "juggernaut";
  var_9 thread control_goliath_usability();
  var_9 sethintstring(&"KILLSTREAKS_HEAVY_EXO_PICKUP");
  var_9 thread cratecapturethink();
  var_9 thread usegoliathupdater();
  var_11 = spawnStruct();
  var_11.useent = var_9;
  var_11.playdeathfx = 1;
  var_11.deathoverridecallback = ::movingplatformdeathfunc;
  var_11.touchingplatformvalid = ::movingplatformtouchvalid;
  var_9 thread maps\mp\_movers::handle_moving_platforms(var_11);
  var_9 droppodmovenearbyallies(var_5);
  var_9 disconnectpaths();
  var_12 = var_9 playerwaittillgoliathactivated();

  if(isDefined(var_12) && isalive(var_12)) {
    maps\mp\gametypes\_gamelogic::sethasdonecombat(var_12, 1);
    var_12.enteringgoliath = 1;
    var_12 playerswitchtosuitupweapon();
    var_12 unlink();
    var_12 maps\mp\_utility::freezecontrolswrapper(1);
    var_13 = var_4 - var_12.origin;
    var_14 = vectortoangles(var_13);
    var_15 = (0, var_14[1], 0);
    var_16 = rotatevector(var_13, (45, 0, 0));
    var_17 = spawn("script_model", var_4);
    var_17.angles = var_15;

    if(level.nextgen) {
      var_17 setModel("npc_exo_armor_ingress");
      var_17 scriptmodelplayanimdeltamotion("mp_goliath_spawn");
    } else {
      var_17 setModel("npc_exo_armor_mp_base");
    }

    var_12 maps\mp\_snd_common_mp::snd_message("goliath_pod_burst");

    if(isDefined(var_9)) {
      var_9 deletegoliathpod(0);
    }

    playFX(level._effect["jugg_droppod_open"], var_4, var_16);
    wait 0.1;
    var_12 is_entering_goliath(var_17, var_4);

    if(isDefined(var_12) && isalive(var_12)) {
      var_12 setorigin(var_4, 1);
      var_12 setangles(var_17.angles);
      var_12 enableweapons();
      var_12 givejuggernaut("juggernaut_exosuit", var_1);
      var_17 delete();
      var_12 playgoliathtoidleleanim();
      wait 1;

      if(isDefined(var_12)) {
        var_12.enteringgoliath = undefined;
        var_12 maps\mp\_utility::freezecontrolswrapper(0);
      }
    } else {
      var_17 delete();
    }
  }

  var_7 delete();
}

playerswitchtosuitupweapon() {
  removeweapons();
  self giveweapon("iw5_combatknifegoliath_mp", 0, 0, 0, 1);
  self switchtoweapon("iw5_combatknifegoliath_mp");
}

cratecapturethink(var_0) {
  self endon("captured");
  var_1 = self;

  if(isDefined(self.otherstringent)) {
    var_1 = self.otherstringent;
  }

  while(isDefined(self)) {
    var_1 waittill("trigger", var_2);

    if(maps\mp\zombies\_util::arekillstreaksdisabled()) {
      continue;
    }
    if(var_2 maps\mp\_utility::isjuggernaut()) {
      continue;
    }
    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(var_2 isjumping() || isDefined(var_2.exo_hover_on) && var_2.exo_hover_on) {
      continue;
    }
    if(!var_2 isonground() && !maps\mp\killstreaks\_airdrop::waitplayerstuckoncarepackagereturn(var_2)) {
      continue;
    }
    if(!maps\mp\killstreaks\_airdrop::validateopenconditions(var_2)) {
      continue;
    }
    var_2.iscapturingcrate = 1;
    var_3 = maps\mp\killstreaks\_airdrop::createuseent();
    var_4 = var_3 useholdthink(var_2, undefined, var_0);

    if(isDefined(var_3)) {
      var_3 delete();
    }

    if(!var_4) {
      if(isDefined(var_2)) {
        var_2.iscapturingcrate = 0;
      }

      continue;
    }

    var_2.iscapturingcrate = 0;
    self notify("captured", var_2);
  }
}

useholdthink(var_0, var_1, var_2) {
  if(isplayer(var_0)) {
    var_0 playerlinkto(self);
  } else {
    var_0 linkto(self);
  }

  var_0 playerlinkedoffsetenable();

  if(!var_0 maps\mp\_utility::isjuggernaut()) {
    var_0 common_scripts\utility::_disableweapon();
  }

  thread useholdthinkplayerreset(var_0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(var_1)) {
    if(var_0 maps\mp\_utility::_hasperk("specialty_unwrapper") && isDefined(var_0.specialty_unwrapper_care_bonus)) {
      var_1 = var_1 * var_0.specialty_unwrapper_care_bonus;
    }

    if(isDefined(level.podcapturetimemodifier)) {
      var_1 = var_1 * level.podcapturetimemodifier;
    }

    self.usetime = var_1;
  } else if(var_0 maps\mp\_utility::_hasperk("specialty_unwrapper") && isDefined(var_0.specialty_unwrapper_care_bonus)) {
    self.usetime = 3000 * var_0.specialty_unwrapper_care_bonus;
  } else {
    self.usetime = 3000;
  }

  if(isplayer(var_0)) {
    var_0 thread personalusebar(self, var_2);
  }

  var_3 = useholdthinkloop(var_0);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  self.inuse = 0;
  self.curprogress = 0;
  return var_3;
}

useholdthinkplayerreset(var_0) {
  var_0 endon("death");
  common_scripts\utility::waittill_any("death", "captured", "useHoldThinkLoopDone");

  if(isalive(var_0)) {
    if(!var_0 maps\mp\_utility::isjuggernaut()) {
      var_0 common_scripts\utility::_enableweapon();
    }

    if(var_0 islinked()) {
      var_0 unlink();
    }
  }
}

personalusebar(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(var_1)) {
    iprintlnbold("Fixme @agersant " + var_1);
  }

  self setclientomnvar("ui_use_bar_text", 1);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      if(var_0.userate > 0) {
        var_3 = gettime();
        var_4 = var_0.curprogress / var_0.usetime;
        var_5 = var_3 + (1 - var_4) * (var_0.usetime / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_5));
      }

      var_2 = var_0.userate;
    }

    wait 0.05;
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

ishordelaststand(var_0) {
  return isDefined(level.ishorde) && level.ishorde && isDefined(var_0.laststand) && var_0.laststand;
}

useholdthinkloop(var_0) {
  var_0 endon("stop_useHoldThinkLoop");

  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && !maps\mp\zombies\_util::isplayerinlaststand(var_0) && var_0 usebuttonpressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    if(self.curprogress >= self.usetime) {
      return maps\mp\_utility::isreallyalive(var_0);
    }

    wait 0.05;
  }

  return 0;
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

  if(level.currentgen) {
    thread cggoliathroverlay();
  }

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
  var_0 endon("ejectedFromJuggernaut");
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
  setdvar("scr_adjust_angles", "" + var_4);
  setdvar("scr_adjust_origin", "" + var_3);
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
  self endon("ejectedFromJuggernaut");
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

playermech_ui_weapon_feedback(var_0, var_1) {
  self endon("disconnect");
  self endon("exit_mech");
  self endon("ejectedFromJuggernaut");
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
  self endon("ejectedFromJuggernaut");
  var_2 = 0;

  for(;;) {
    wait 0.05;

    if(self call[[var_0]]()) {
      if(!var_2) {
        if([
            [var_1]
          ]()) {
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

state_chaingun_pump() {
  var_0 = get_mech_chaingun_state();
  var_1 = self getcurrentweapon();
  self.mechuistate.chaingun.heatlevel = self getweaponheatlevel(var_1);
  self.mechuistate.chaingun.overheated = self isweaponoverheated(var_1);

  if(var_0 == "ready") {
    if(self.mechuistate.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(self attackbuttonpressed()) {
      set_mech_chaingun_state("firing");
    }
  } else if(var_0 == "firing") {
    if(self.mechuistate.chaingun.overheated) {
      set_mech_chaingun_state("overheat");
    } else if(!self attackbuttonpressed()) {
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
  self endon("ejectedFromJuggernaut");

  for(;;) {
    self waittill("mech_rocket_fire");
    self disableoffhandweapons();
    playermech_monitor_update_recharge(self.mechuistate.rocket, playergetrocketreloadtime());
    self enableoffhandweapons();
    wait 0.05;
  }
}

playermech_monitor_swarm_recharge() {
  self endon("disconnect");
  self endon("exit_mech");
  self notify("stop_swarm_recharge");
  self endon("stop_swarm_recharge");
  self endon("ejectedFromJuggernaut");

  for(;;) {
    self waittill("mech_swarm_fire");
    self disableoffhandsecondaryweapons();
    playermech_monitor_update_recharge(self.mechuistate.swarm, playergetswarmreloadtime());
    self enableoffhandsecondaryweapons();
    wait 0.05;
  }
}

play_goliath_death_fx() {
  level endon("game_ended");
  self endon("disconnect");
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
  }
}

playermechtimeout() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lost_juggernaut");
  self endon("ejectedFromJuggernaut");
  var_0 = int(2.0);

  while(maps\mp\zombies\_util::is_true(self.goliathbootupsequence)) {
    waitframe();
  }

  for(;;) {
    wait 1;
    var_1 = self.mechhealth / 600;
    self.mechhealth = self.mechhealth - var_0;
    var_2 = self.mechhealth / 600;
    self setclientomnvar("ui_exo_suit_health", var_2);
    level thread dogoliathintegrityvo(var_1, var_2, self);

    if(self.mechhealth < 0) {
      if(!isDefined(self.underwatermotiontype)) {
        thread playereject();
      } else {
        thread playerkillheavyexo(self.origin);
      }

      return;
    }
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

handle_goliath_drop_pod_removal(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 waittill("death");
  self delete();
}

setupeject(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1 endon("ejectedFromJuggernaut");

  if(!isbot(var_1)) {
    var_1 notifyonplayercommand("juggernautEject", "+goStand");
  }

  for(;;) {
    var_1 waittill("juggernautEject");
    waitframe();
    var_2 = 0;

    while(var_1 jumpbuttonpressed()) {
      var_2 = var_2 + 0.05;

      if(var_2 > 0.7) {
        if(!isDefined(var_1.underwatermotiontype)) {
          var_1 thread playereject();
        } else {
          var_1 thread playerkillheavyexo(var_1.origin);
        }

        return;
      }

      waitframe();
    }
  }
}

playereject(var_0) {
  self notify("ejectedFromJuggernaut");
  level thread juggernautsuitexplode(self);
  self detachall();
  self setModel(self.charactermodel);
  self setviewmodel(self.characterviewmodel);
  self attach(self.characterhead);
  restoreweapons();
  thread playersetpreviousweapon();

  if(maps\mp\_utility::isjuggernaut()) {
    playerreset();
  }

  level notify("player_left_goliath_suit");
}

playerhandlejump() {
  self endon("disconnect");
  self endon("death");
  self allowjump(0);
  wait 1;

  while(!self isonground()) {
    waitframe();
  }

  self allowjump(1);
}

playersetpreviousweapon() {
  self endon("disconnect");
  self endon("death");
  var_0 = self.primarytorestore;
  self.primarytorestore = undefined;

  while(self getcurrentweapon() != var_0) {
    self switchtoweapon(var_0);
    wait 0.1;
  }
}

juggernautsuitexplode(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_2 = var_1.origin;
  var_3 = var_1.angles;
  waittillframeend;

  if(isDefined(var_0)) {
    var_0 radiusdamage(var_2, 400, 200, 50, var_0, "MOD_EXPLOSIVE", "iw5_juggernautrocketszm_mp");
    var_0 maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
  }

  playFX(common_scripts\utility::getfx("goliath_self_destruct"), var_2, anglestoup(var_3));
}

announcerglobalplaysuitvo(var_0, var_1, var_2) {
  var_2 endon("death");
  var_2 endon("disconnect");
  var_2 endon("ejectedFromJuggernaut");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global", var_0, undefined, undefined, undefined, undefined, [var_2]);
}
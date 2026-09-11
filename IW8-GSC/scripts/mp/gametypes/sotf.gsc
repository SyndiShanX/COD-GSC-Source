/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sotf.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var0 = [];
  scripts\mp\gameobjects::main(var0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    level.matchrules_randomize = 0;
  }

  setplayerloadout();
  level.teambased = 1;
  level.overridecrateusetime = 500;
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onnormaldeath = &onnormaldeath;
  level.cratekill = &cratekill;
  level.pickupweaponhandler = &pickupweaponhandler;
  level.iconvisall = &iconvisall;
  level.objvisall = &objvisall;
  level.supportintel = 0;
  level.supportnuke = 0;
  level.vehicleoverride = "littlebird_neutral_mp";
  level.usedlocations = [];
  level.emptylocations = 1;
  level.firstcratedrop = 1;
  game["dialog"]["gametype"] = "hunted";

  if(getdvarint("OSMSLRTOP")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "sotf_hint";
  game["dialog"]["defense_obj"] = "sotf_hint";
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_sotf_crateamount", getmatchrulesdata("sotfData", "crateAmount"));
  setdynamicdvar("scr_sotf_crategunamount", getmatchrulesdata("sotfData", "crateGunAmount"));
  setdynamicdvar("scr_sotf_cratetimer", getmatchrulesdata("sotfData", "crateDropTimer"));
  setdynamicdvar("scr_sotf_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("sotf", 1);
  setdynamicdvar("scr_sotf_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("sotf", 1);
  setdynamicdvar("scr_sotf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("sotf", 0);
  setdynamicdvar("scr_sotf_promode", 0);
}

function onprecachegametype() {
  level._effect["signal_chest_drop"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["signal_chest_drop_mover"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  var2 = &"OBJECTIVES/WAR";
  var3 = &"OBJECTIVES/WAR_SCORE";
  var4 = &"OBJECTIVES/WAR_HINT";

  foreach(var6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var6, var2);

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var6, var2);
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var6, var3);
    }

    scripts\mp\utility\game::setobjectivehinttext(var6, var4);
  }

  initspawns();
  thread sotf();
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function setplayerloadout() {
  definechestweapons();
  var0 = getrandomweapon(level.pistolarray);
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0["name"]);
  var2 = tablelookup("mp/sotfWeapons.csv", 2, var1, 0);
  setomnvar("ui_sotf_pistol", int(var2));
  level.sotf_loadouts["axis"]["loadoutPrimary"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondary"] = var0["name"];
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutEquipment"] = "throwingknife_mp";
  level.sotf_loadouts["axis"]["loadoutOffhand"] = "flash_grenade_mp";
  level.sotf_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.sotf_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.sotf_loadouts["axis"]["loadoutPerks"] = ["specialty_longersprint", "specialty_extra_deadly"];
  level.sotf_loadouts["allies"] = level.sotf_loadouts["axis"];
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var2 = undefined;
  }

  return var2;
}

function onspawnplayer() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  self.pers["gamemodeLoadout"] = level.sotf_loadouts[self.pers["team"]];
  level notify("sotf_player_spawned", self);
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  thread waitloadoutdone();
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("giveLoadout");
  var0 = self getcurrentweapon();
  self setweaponammostock(var0, 0);
  self.oldprimarygun = var0;
  thread pickupweaponhandler();
}

function onplayerscore(var0, var1) {
  if(var0 == "kill") {
    var2 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var2;
  }

  return 0;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
  perkwatcher(var1);
}

function sotf() {
  thread startspawnchest();
}

function startspawnchest() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = getdvarint("scr_sotf_crateamount", 1);
  var1 = getdvarint("scr_sotf_cratetimer", 30);
  level waittill("sotf_player_spawned", var2);

  for(;;) {
    if(!isalive(var2)) {
      var2 = findnewowner(level.players);

      if(!isDefined(var2)) {
        continue;
      }

      continue;
    }

    while(isalive(var2)) {
      if(level.emptylocations) {
        for(var3 = 0; var3 < var0; var3++) {
          thread spawnchests(level);
        }

        thread showcratesplash(level);
        wait var1;
        continue;
      }

      waitframe();
    }
  }
}

function showcratesplash(var0) {
  foreach(var2 in level.players) {
    var2 thread scripts\mp\hud_message::showsplash(var0);
  }
}

function findnewowner(var0) {
  foreach(var2 in var0) {
    if(isalive(var2)) {
      return var2;
    }
  }

  level waittill("sotf_player_spawned", var4);
  return var4;
}

function spawnchests(var0) {
  var1 = scripts\engine\utility::getStructArray("sotf_chest_spawnpoint", "targetname");

  if(level.firstcratedrop) {
    var2 = getcenterpoint(var1);
    level.firstcratedrop = 0;
  } else {
    var2 = getrandompoint(var2);
  }

  if(isDefined(var2)) {
    playfxatpoint(var2);
    return;
  }
}

function playfxatpoint(var0) {
  var1 = var0 + (0, 0, 30);
  var2 = var0 + (0, 0, -1000);
  var3 = scripts\engine\trace::ray_trace(var1, var2, undefined, scripts\engine\trace::create_default_contents(1));
  var4 = var3["position"] + (0, 0, 1);
  var5 = var3["entity"];

  if(isDefined(var5)) {
    for(var6 = var5 getlinkedparent(); isDefined(var6); var6 = var5 getlinkedparent()) {
      var5 = var6;
    }
  }

  if(isDefined(var5)) {
    var7 = spawn("script_model", var4);
    var7 setModel("tag_origin");
    var7.angles = (90, randomintrange(-180, 179), 0);
    var7 linkTo(var5);
    thread playlinkedsmokeeffect(scripts\engine\utility::getfx("signal_chest_drop_mover"), var7);
    return;
  }

  playFX(scripts\engine\utility::getfx("signal_chest_drop"), var4);
}

function playlinkedsmokeeffect(var0, var1) {
  level endon("game_ended");
  wait 0.05;
  playFXOnTag(var0, var1, "tag_origin");
  wait 6;
  stopFXOnTag(var0, var1, "tag_origin");
  wait 0.05;
  var1 delete();
}

function getcenterpoint(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in var0) {
    var5 = distance2dsquared(level.mapcenter, var4.origin);

    if(!isDefined(var1) || var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  level.usedlocations[level.usedlocations.size] = var1.origin;
  return var1.origin;
}

function getrandompoint(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = 0;

    if(isDefined(level.usedlocations) && level.usedlocations.size > 0) {
      foreach(var5 in level.usedlocations) {
        if(var0[var2].origin == var5) {
          var3 = 1;
          break;
        }
      }

      if(var3) {
        continue;
      }

      var1 = var0[var2].origin;
      continue;
    }

    var1 = var0[var2].origin;
  }

  if(var1.size > 0) {
    var7 = randomint(var1.size);
    var8 = var1[var7];
    level.usedlocations[level.usedlocations.size] = var8;
    return var8;
  }

  level.emptylocations = 0;
  return undefined;
}

function definechestweapons() {
  var0 = [];
  var1 = [];

  for(var2 = 0; tablelookupbyrow("mp/sotfWeapons.csv", var2, 0) != ""; var2++) {
    var3 = tablelookupbyrow("mp/sotfWeapons.csv", var2, 2);
    var4 = tablelookupbyrow("mp/sotfWeapons.csv", var2, 1);
    var5 = isselectableweapon(var3);

    if(isDefined(var4) && var5 && var4 == "weapon_pistol") {
      var6 = 30;
      var0["name"] = var3;
      var0["weight"] = var6;
      continue;
    }

    if(isDefined(var4) && var5 && (var4 == "weapon_shotgun" || var4 == "weapon_smg" || var4 == "weapon_assault" || var4 == "weapon_tactical" || var4 == "weapon_sniper" || var4 == "weapon_dmr" || var4 == "weapon_lmg" || var4 == "weapon_projectile")) {
      var6 = 0;

      switch (var4) {
        case "weapon_shotgun":
          var6 = 35;
          break;
        case "weapon_assault":
        case "weapon_smg":
        case "weapon_tactical":
          var6 = 25;
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var6 = 15;
          break;
        case "weapon_lmg":
          var6 = 10;
          break;
        case "weapon_projectile":
          var6 = 30;
          break;
      }

      var1["name"] = var3 + "_mp";
      var1["group"] = var4;
      var1["weight"] = var6;
      continue;
    }
  }

  var1 = sortbyweight(var1);
  level.pistolarray = var0;
  level.weaponarray = var1;
}

function sotfcratethink(var0) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");

  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var1 = game["strings"][self.cratetype + "_hint"];
  } else {
    var1 = &"MP/GET_KILLSTREAK";
  }

  var2 = "icon_hunted";
  scripts\cp_mp\killstreaks\airdrop::cratesetupforuse(var1, var2);
  thread scripts\cp_mp\killstreaks\airdrop::crateallcapturethink();
  GscBinSkip4(0x35, 60);
}

function cratewatcher(var0) {
  wait var0;

  while(isDefined(self.inuse) && self.inuse) {
    waitframe();
  }

  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

function playerjoinwatcher() {
  for(;;) {
    level waittill("connected", var0);

    if(!isDefined(var0)) {
      continue;
    }

    if(isDefined(self.crateiconid)) {
      scripts\cp_mp\entityheadicons::ref_1315d(self.crateiconid, var0);
    }
  }
}

function cratekill(var0) {
  for(var1 = 0; var1 < level.usedlocations.size; var1++) {
    if(var0 != level.usedlocations[var1]) {
      continue;
    }

    level.usedlocations = scripts\engine\utility::array_remove(level.usedlocations, var0);
  }

  level.emptylocations = 1;
}

function isselectableweapon(var0) {
  var1 = tablelookup("mp/sotfWeapons.csv", 2, var0, 3);
  var2 = tablelookup("mp/sotfWeapons.csv", 2, var0, 4);

  if(var1 == "TRUE" && (var2 == "" || getdvarint(var2, 0) == 1)) {
    return true;
  }

  return false;
}

function getrandomweapon(var0) {
  var1 = setbucketval(var0);
  var2 = randomint(level.weaponmaxval["sum"]);
  var3 = undefined;

  for(var4 = 0; var4 < var1.size; var4++) {
    if(!var1[var4]["weight"]) {
      continue;
    }

    if(var1[var4]["weight"] > var2) {
      var3 = var1[var4];
      break;
    }
  }

  return var3;
}

function getrandomattachments(var0) {
  var1 = [];
  var2 = [];
  var3 = [];
  var4 = scripts\mp\utility\weapon::getweaponrootname(var0["name"]);
  var5 = scripts\mp\utility\weapon::register_wave_spawner(var4);

  if(var5.size > 0) {
    var6 = randomint(5);

    for(var7 = 0; var7 < var6; var7++) {
      var1 = getvalidattachments(var0, var2, var5);

      if(var1.size == 0) {
        break;
      }

      var8 = randomint(var1.size);
      var2 = var1[var8];
      var9 = scripts\mp\utility\weapon::attachmentmap_tounique(var1[var8], var4);
      var3 = var9;
    }

    var10 = scripts\mp\utility\weapon::getweapongroup(var0["name"]);

    if(var10 == "weapon_dmr" || var10 == "weapon_sniper" || var4 == "iw7_ripper") {
      var11 = 0;

      foreach(var13 in var2) {
        if(scripts\mp\utility\weapon::getattachmenttype(var13) == "rail") {
          var11 = 1;
          break;
        }
      }

      if(!var11 && var0["name"] != "iw7_m1_mp") {
        var15 = strtok(var4, "_")[1];
        var3 = var15 + "scope";
      }
    }

    if(var3.size > 0) {
      var3 = scripts\engine\utility::alphabetize(var3);

      foreach(var17 in var3) {
        var0 = var0["name"] + "_" + var17;
      }
    }
  }

  return var0["name"];
}

function getvalidattachments(var0, var1, var2) {
  var3 = [];
  var4 = scripts\mp\weapons::safechecknum(var0["name"]);

  foreach(var6 in var2) {
    if(var6 == "gl" || var6 == "shotgun") {
      continue;
    }

    var7 = attachmentcheck(var4, var6, var1);

    if(!var7) {
      continue;
    }

    var3 = var6;
  }

  return var3;
}

function attachmentcheck(var0, var1, var2) {
  for(var3 = 0; var3 < var2.size; var3++) {
    if(var1 == var2[var3] || !scripts\mp\utility\weapon::attachmentscompatible(var0, var1, var2[var3])) {
      return false;
    }
  }

  return true;
}

function checkscopes(var0) {
  foreach(var2 in var0) {
    if(var2 == "thermal" || var2 == "vzscope" || var2 == "acog" || var2 == "ironsight") {
      return true;
    }
  }

  return false;
}

function pickupweaponhandler() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    waitframe();
    var0 = self getweaponslistprimaries();

    if(var0.size > 1) {
      var1 = self.oldprimarygun;

      foreach(var3 in var0) {
        if(var3 == var1) {
          var4 = self getammocount(var3);
          var5 = self dropitem(var3);

          if(isDefined(var5) && var4 > 0) {
            var5.targetname = "dropped_weapon";
          }

          break;
        }
      }

      var0 = scripts\engine\utility::array_remove(var0, var1);
      self.oldprimarygun = var0[0];
    }
  }
}

function loginckillchain() {
  self.pers["killChains"]++;
  scripts\mp\persistence::statsetchild("round", "killChains", self.pers["killChains"]);
}

function perkwatcher() {
  if(level.allowperks) {
    switch (self.streakpoints) {
      case 2:
        scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
        thread scripts\mp\hud_message::showsplash("specialty_fastsprintrecovery_sotf", self.streakpoints);
        thread loginckillchain();
        break;
      case 3:
        scripts\mp\utility\perk::giveperk("specialty_lightweight");
        thread scripts\mp\hud_message::showsplash("specialty_lightweight_sotf", self.streakpoints);
        thread loginckillchain();
        break;
      case 4:
        scripts\mp\utility\perk::giveperk("specialty_stalker");
        thread scripts\mp\hud_message::showsplash("specialty_stalker_sotf", self.streakpoints);
        thread loginckillchain();
        break;
      case 5:
        scripts\mp\utility\perk::giveperk("specialty_regenfaster");
        thread scripts\mp\hud_message::showsplash("specialty_regenfaster_sotf", self.streakpoints);
        thread loginckillchain();
        break;
      case 6:
        scripts\mp\utility\perk::giveperk("specialty_deadeye");
        thread scripts\mp\hud_message::showsplash("specialty_deadeye_sotf", self.streakpoints);
        thread loginckillchain();
        break;
    }

    return;
  }
}

function iconvisall(var0, var1) {
  var2 = var0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, var1, 24, 1);
  self.crateheadicon = var1;
  self.crateiconid = var2;
}

function objvisall(var0) {
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var0);
}

function setbucketval(var0) {
  level.weaponmaxval["sum"] = 0;
  var1 = var0;

  for(var2 = 0; var2 < var1.size; var2++) {
    if(!var1[var2]["weight"]) {
      continue;
    }

    level.weaponmaxval["sum"] = level.weaponmaxval["sum"] + var1[var2]["weight"];
    var1["weight"] = level.weaponmaxval["sum"];
  }

  return var1;
}

function sortbyweight(var0) {
  var1 = [];
  var2 = [];

  for(var3 = 1; var3 < var0.size; var3++) {
    var4 = var0[var3]["weight"];
    var1 = var0[var3];

    for(var5 = var3 - 1; var5 >= 0 && is_weight_a_less_than_b(var0[var5]["weight"], var4); var5--) {
      var2 = var0[var5];
      var0 = var1;
      var0 = var2;
    }
  }

  return var0;
}

function is_weight_a_less_than_b(var0, var1) {
  return var0 < var1;
}
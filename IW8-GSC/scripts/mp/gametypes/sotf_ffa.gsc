/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sotf_ffa.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = [];
  scripts\mp\gameobjects::main(var_0);

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
  setteammode("ffa");
  level.teambased = 0;
  level.overridecrateusetime = 500;
  level.onplayerscore = &onplayerscore;
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
  level.assists_disabled = 1;
  game["dialog"]["gametype"] = "hunted";

  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "sotf_hint";
  game["dialog"]["defense_obj"] = "sotf_hint";
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_sotf_ffa_crateamount", getmatchrulesdata("sotfFFAData", "crateAmount"));
  setdynamicdvar("scr_sotf_ffa_crategunamount", getmatchrulesdata("sotfFFAData", "crateGunAmount"));
  setdynamicdvar("scr_sotf_ffa_cratetimer", getmatchrulesdata("sotfFFAData", "crateDropTimer"));
  setdynamicdvar("scr_sotf_ffa_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("sotf_ffa", 1);
  setdynamicdvar("scr_sotf_ffa_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("sotf_ffa", 1);
  setdynamicdvar("scr_sotf_ffa_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("sotf_ffa", 0);
  setdynamicdvar("scr_sotf_ffa_promode", 0);
}

function onprecachegametype() {
  level._effect["signal_chest_drop"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["signal_chest_drop_mover"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function onstartgametype() {
  setclientnamemode("auto_change");
  var_0 = &"OBJECTIVES/DM";
  var_1 = &"OBJECTIVES/DM_SCORE";
  var_2 = &"OBJECTIVES/DM_HINT";

  foreach(var_4 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_4, var_0);

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_4, var_0);
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_4, var_1);
    }

    scripts\mp\utility\game::setobjectivehinttext(var_4, var_2);
  }

  initspawns();
  thread sotf();
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function setplayerloadout() {
  definechestweapons();
  var_0 = getrandomweapon(level.pistolarray);
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0["name"]);
  var_2 = tablelookup("mp/sotfWeapons.csv", 2, var_1, 0);
  setomnvar("ui_sotf_pistol", int(var_2));
  level.sotf_loadouts["axis"]["loadoutPrimary"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondary"] = var_0["name"];
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
  var_0 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);

  if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getspawnpoint_random(var_0);
  } else {
    var_1 = undefined;
  }

  return var_1;
}

function onspawnplayer() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  self.pers["gamemodeLoadout"] = level.sotf_loadouts[self.pers["team"]];
  level notify("sotf_player_spawned", self);

  if(!isDefined(self.eventvalue)) {
    self.eventvalue = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\utility\stats::setextrascore0(self.eventvalue);
  }

  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  thread waitloadoutdone();
}

function waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("giveLoadout");
  var_0 = self getcurrentweapon();
  self setweaponammostock(var_0, 0);
  self.oldprimarygun = var_0;
  thread pickupweaponhandler();
}

function onplayerscore(var_0, var_1) {
  var_1.assists = var_1 scripts\mp\utility\stats::getpersstat("longestStreak");

  if(var_0 != "super_kill" && issubstr(var_0, "kill")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_2;
  }

  return 0;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  perkwatcher(var_1);
  var_6 = 0;

  foreach(var_8 in level.players) {
    if(isDefined(var_8.score) && var_8.score > var_6) {
      var_6 = var_8.score;
    }
  }
}

function sotf() {
  thread startspawnchest();
}

function startspawnchest() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getdvarint("scr_sotf_ffa_crateamount", 3);
  var_1 = getdvarint("scr_sotf_ffa_cratetimer", 30);
  level waittill("sotf_player_spawned", var_2);

  for(;;) {
    if(!isalive(var_2)) {
      var_2 = findnewowner(level.players);

      if(!isDefined(var_2)) {
        continue;
      }

      continue;
    }

    while(isalive(var_2)) {
      if(level.emptylocations) {
        for(var_3 = 0; var_3 < var_0; var_3++) {
          thread spawnchests(level);
        }

        thread showcratesplash(level);
        wait var_1;
        continue;
      }

      waitframe();
    }
  }
}

function showcratesplash(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::showsplash(var_0);
  }
}

function findnewowner(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      return var_2;
    }
  }

  level waittill("sotf_player_spawned", var_4);
  return var_4;
}

function spawnchests(var_0) {
  var_1 = scripts\engine\utility::getStructArray("sotf_chest_spawnpoint", "targetname");
  var_2 = getrandompoint(var_1);

  if(isDefined(var_2)) {
    playfxatpoint(var_2);
    return;
  }
}

function playfxatpoint(var_0) {
  var_1 = var_0 + (0, 0, 30);
  var_2 = var_0 + (0, 0, -1000);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, undefined, scripts\engine\trace::create_default_contents(1));
  var_4 = var_3["position"] + (0, 0, 1);
  var_5 = var_3["entity"];

  if(isDefined(var_5)) {
    for(var_6 = var_5 getlinkedparent(); isDefined(var_6); var_6 = var_5 getlinkedparent()) {
      var_5 = var_6;
    }
  }

  if(isDefined(var_5)) {
    var_7 = spawn("script_model", var_4);
    var_7 setModel("tag_origin");
    var_7.angles = (90, randomintrange(-180, 179), 0);
    var_7 linkTo(var_5);
    thread playlinkedsmokeeffect(scripts\engine\utility::getfx("signal_chest_drop_mover"), var_7);
    return;
  }

  playFX(scripts\engine\utility::getfx("signal_chest_drop"), var_4);
}

function playlinkedsmokeeffect(var_0, var_1) {
  level endon("game_ended");
  wait 0.05;
  playFXOnTag(var_0, var_1, "tag_origin");
  wait 6;
  stopFXOnTag(var_0, var_1, "tag_origin");
  wait 0.05;
  var_1 delete();
}

function getcenterpoint(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = distance2dsquared(level.mapcenter, var_4.origin);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  level.usedlocations[level.usedlocations.size] = var_1.origin;
  return var_1.origin;
}

function getrandompoint(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;

    if(isDefined(level.usedlocations) && level.usedlocations.size > 0) {
      foreach(var_5 in level.usedlocations) {
        if(var_0[var_2].origin == var_5) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        continue;
      }

      var_1 = var_0[var_2].origin;
      continue;
    }

    var_1 = var_0[var_2].origin;
  }

  if(var_1.size > 0) {
    var_7 = randomint(var_1.size);
    var_8 = var_1[var_7];
    level.usedlocations[level.usedlocations.size] = var_8;
    return var_8;
  }

  level.emptylocations = 0;
  return undefined;
}

function definechestweapons() {
  var_0 = [];
  var_1 = [];

  for(var_2 = 0; tablelookupbyrow("mp/sotfWeapons.csv", var_2, 0) != ""; var_2++) {
    var_3 = tablelookupbyrow("mp/sotfWeapons.csv", var_2, 2);
    var_4 = tablelookupbyrow("mp/sotfWeapons.csv", var_2, 1);
    var_5 = isselectableweapon(var_3);

    if(isDefined(var_4) && var_5 && var_4 == "weapon_pistol") {
      var_6 = 30;
      var_0["name"] = var_3;
      var_0["weight"] = var_6;
      continue;
    }

    if(isDefined(var_4) && var_5 && (var_4 == "weapon_shotgun" || var_4 == "weapon_smg" || var_4 == "weapon_assault" || var_4 == "weapon_tactical" || var_4 == "weapon_sniper" || var_4 == "weapon_dmr" || var_4 == "weapon_lmg" || var_4 == "weapon_projectile")) {
      var_6 = 0;

      switch (var_4) {
        case "weapon_shotgun":
          var_6 = 35;
          break;
        case "weapon_assault":
        case "weapon_smg":
        case "weapon_tactical":
          var_6 = 25;
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_6 = 15;
          break;
        case "weapon_lmg":
          var_6 = 10;
          break;
        case "weapon_projectile":
          var_6 = 30;
          break;
      }

      var_1["name"] = var_3 + "_mp";
      var_1["group"] = var_4;
      var_1["weight"] = var_6;
      continue;
    }
  }

  var_1 = sortbyweight(var_1);
  level.pistolarray = var_0;
  level.weaponarray = var_1;
}

function sotfcratethink(var_0) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");

  if(isDefined(game["strings"][self.cratetype + "_hint"])) {
    var_1 = game["strings"][self.cratetype + "_hint"];
  } else {
    var_1 = &"MP/GET_KILLSTREAK";
  }

  var_2 = "icon_hunted";
  scripts\cp_mp\killstreaks\airdrop::cratesetupforuse(var_1, var_2);
  thread scripts\cp_mp\killstreaks\airdrop::crateallcapturethink();
  GscBinSkip4(0x35, 60);
}

function cratewatcher(var_0) {
  wait var_0;

  while(isDefined(self.inuse) && self.inuse) {
    waitframe();
  }

  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

function playerjoinwatcher() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    if(isDefined(self.crateiconid)) {
      scripts\cp_mp\entityheadicons::ref_1315d(self.crateiconid, var_0);
    }
  }
}

function cratekill(var_0) {
  for(var_1 = 0; var_1 < level.usedlocations.size; var_1++) {
    if(var_0 != level.usedlocations[var_1]) {
      continue;
    }

    level.usedlocations = scripts\engine\utility::array_remove(level.usedlocations, var_0);
  }

  level.emptylocations = 1;
}

function isselectableweapon(var_0) {
  var_1 = tablelookup("mp/sotfWeapons.csv", 2, var_0, 3);
  var_2 = tablelookup("mp/sotfWeapons.csv", 2, var_0, 4);

  if(var_1 == "TRUE" && (var_2 == "" || getdvarint(var_2, 0) == 1)) {
    return true;
  }

  return false;
}

function getrandomweapon(var_0) {
  var_1 = setbucketval(var_0);
  var_2 = randomint(level.weaponmaxval["sum"]);
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!var_1[var_4]["weight"]) {
      continue;
    }

    if(var_1[var_4]["weight"] > var_2) {
      var_3 = var_1[var_4];
      break;
    }
  }

  return var_3;
}

function getrandomattachments(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0["name"]);
  var_5 = scripts\mp\utility\weapon::register_wave_spawner(var_4);

  if(var_5.size > 0) {
    var_6 = randomint(5);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_1 = getvalidattachments(var_0, var_2, var_5);

      if(var_1.size == 0) {
        break;
      }

      var_8 = randomint(var_1.size);
      var_2 = var_1[var_8];
      var_9 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1[var_8], var_4);
      var_3 = var_9;
    }

    var_10 = scripts\mp\utility\weapon::getweapongroup(var_0["name"]);

    if(var_10 == "weapon_dmr" || var_10 == "weapon_sniper" || var_4 == "iw6_dlcweap02") {
      var_11 = 0;

      foreach(var_13 in var_2) {
        if(scripts\mp\utility\weapon::getattachmenttype(var_13) == "rail") {
          var_11 = 1;
          break;
        }
      }

      if(!var_11) {
        var_15 = strtok(var_4, "_")[1];
        var_3 = var_15 + "scope";
      }
    }

    if(var_3.size > 0) {
      var_3 = scripts\engine\utility::alphabetize(var_3);

      foreach(var_17 in var_3) {
        var_0 = var_0["name"] + "_" + var_17;
      }
    }
  }

  return var_0["name"];
}

function getvalidattachments(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\mp\weapons::safechecknum(var_0["name"]);

  foreach(var_6 in var_2) {
    if(var_6 == "gl" || var_6 == "shotgun") {
      continue;
    }

    var_7 = attachmentcheck(var_4, var_6, var_1);

    if(!var_7) {
      continue;
    }

    var_3 = var_6;
  }

  return var_3;
}

function attachmentcheck(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_1 == var_2[var_3] || !scripts\mp\utility\weapon::attachmentscompatible(var_0, var_1, var_2[var_3])) {
      return false;
    }
  }

  return true;
}

function checkscopes(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 == "thermal" || var_2 == "vzscope" || var_2 == "acog" || var_2 == "ironsight") {
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
    var_0 = self getweaponslistprimaries();

    if(var_0.size > 1) {
      var_1 = self.oldprimarygun;

      foreach(var_3 in var_0) {
        if(var_3 == var_1) {
          var_4 = self getammocount(var_3);
          var_5 = self dropitem(var_3);

          if(isDefined(var_5) && var_4 > 0) {
            var_5.targetname = "dropped_weapon";
          }

          break;
        }
      }

      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      self.oldprimarygun = var_0[0];
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

function iconvisall(var_0, var_1) {
  var_2 = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, var_1, 24, 1);
  self.crateheadicon = var_1;
  self.crateiconid = var_2;
}

function objvisall(var_0) {
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
}

function setbucketval(var_0) {
  level.weaponmaxval["sum"] = 0;
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!var_1[var_2]["weight"]) {
      continue;
    }

    level.weaponmaxval["sum"] = level.weaponmaxval["sum"] + var_1[var_2]["weight"];
    var_1["weight"] = level.weaponmaxval["sum"];
  }

  return var_1;
}

function sortbyweight(var_0) {
  var_1 = [];
  var_2 = [];

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3]["weight"];
    var_1 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0 && is_weight_a_less_than_b(var_0[var_5]["weight"], var_4); var_5--) {
      var_2 = var_0[var_5];
      var_0 = var_1;
      var_0 = var_2;
    }
  }

  return var_0;
}

function is_weight_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}
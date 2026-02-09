/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\ranged_elite_soldier.gsc
****************************************************/

init() {
  init_common();
  level.agent_funcs["ranged_elite_soldier_goliath"] = level.agent_funcs["ranged_elite_soldier"];
  level.onspawnfinished["ranged_elite_soldier_goliath"] = ::onspawnfinishedgoliath;
  level.getloadout["ranged_elite_soldier_goliath"] = ::getgoliathloadout;
  var_0 = spawnStruct();
  var_0.agent_type = "ranged_elite_soldier_goliath";
  var_0.isbotagent = 1;
  var_0.health_scale = 4.0;
  var_0.damage_scale = 0.2;
  var_0.melee_damage_scale = 0.5;
  maps\mp\zombies\_util::agentclassregister(var_0, "ranged_elite_soldier_goliath");
  level.getspawntypefunc["ranged_elite_soldier"] = ::getsoldierroundspawntype;
  level.candroppickupsfunc["ranged_elite_soldier"] = ::soldierroundcandroppickups;
  level.roundstartfunc["ranged_elite_soldier"] = ::soldierroundstart;
  level.roundendfunc["ranged_elite_soldier"] = ::soldierroundend;
  level.randomspawnpointoverride["ranged_elite_soldier"] = ::soldiergetrandomspawnpoint;
  level.numenemiesthisroundfunc["ranged_elite_soldier"] = ::soldierroundnumenemies;
  level.roundspawndelayfunc["ranged_elite_soldier"] = ::soldierroundspawndelay;
  level.getrepulsortagfunc = ::soldiergetrepulsortag;
  level.soldierroundnum = 0;
  level._effect["npc_teleport_enemy"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
  level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
  level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
}

init_common() {
  if(isDefined(level.agent_funcs["ranged_elite_soldier"])) {
    return;
  }
  level.agent_funcs["ranged_elite_soldier"] = level.agent_funcs["zombie"];
  level.agent_funcs["ranged_elite_soldier"]["think"] = ::soldierthink;
  level.agent_funcs["ranged_elite_soldier"]["spawn"] = ::onsoldierspawned;
  level.agent_funcs["ranged_elite_soldier"]["on_damaged_finished"] = maps\mp\agents\_agents::agent_damage_finished;
  level.agent_funcs["ranged_elite_soldier"]["on_killed"] = ::onsoldierkilled;
  var_0 = spawnStruct();
  var_0.agent_type = "ranged_elite_soldier";
  var_0.isbotagent = 1;
  var_0.health_scale = 0.5;
  var_0.damage_scale = 0.015;
  var_0.melee_damage_scale = 0.32;
  var_0.model_bodies = ["atlas_biohazard_body_a"];
  var_0.model_heads = ["atlas_biohazard_head_a"];
  maps\mp\zombies\_util::agentclassregister(var_0, var_0.agent_type);

  if(!isDefined(level.ranged_elite_soldier_weapons)) {
    level.ranged_elite_soldier_weapons = [];
    level.ranged_elite_soldier_weapons["primary"] = [];
    level.ranged_elite_soldier_weapons["secondary"] = [];
    var_1 = [];

    if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {
      foreach(var_3 in level.magicboxweapons) {
        var_1[var_1.size] = var_3["baseNameNoMP"];
      }

      var_1[var_1.size] = "iw5_titan45zm";
      var_1[var_1.size] = "iw5_hmr9zm";
      var_1[var_1.size] = "iw5_m182sprzm";
      var_1[var_1.size] = "iw5_uts19zm";
    } else {
      foreach(var_3 in level.magicboxweapons) {
        var_1[var_1.size] = var_3["baseNameNoMP"];
      }

      var_1[var_1.size] = "iw5_titan45zm";
      var_1[var_1.size] = "iw5_arx160zm";
      var_1[var_1.size] = "iw5_mp11zm";
      var_1[var_1.size] = "iw5_hbra3zm";
      var_1[var_1.size] = "iw5_hmr9zm";
      var_1[var_1.size] = "iw5_maulzm";
      var_1[var_1.size] = "iw5_m182sprzm";
      var_1[var_1.size] = "iw5_uts19zm";
    }

    foreach(var_3 in var_1) {
      if(isvalidsoldierweapon(var_3)) {
        if(maps\mp\zombies\_util::isvalidprimaryzombies(var_3)) {
          level.ranged_elite_soldier_weapons["primary"][level.ranged_elite_soldier_weapons["primary"].size] = var_3;
          continue;
        }

        if(maps\mp\zombies\_util::isvalidsecondaryzombies(var_3)) {
          level.ranged_elite_soldier_weapons["secondary"][level.ranged_elite_soldier_weapons["secondary"].size] = var_3;
          continue;
        }

        if(!maps\mp\zombies\_util::isvalidequipmentzombies(var_3)) {}
      }
    }
  }
}

init_ally() {
  init_common();
  level._effect["npc_teleport_ally"] = loadfx("vfx/unique/dlc_teleport_soldier_good");
}

isvalidsoldierweapon(var_0) {
  switch (var_0) {
    case "iw5_exocrossbowzm":
    case "iw5_mahemzm":
    case "iw5_rw1zm":
    case "iw5_linegunzm":
    case "iw5_fusionzm":
    case "iw5_em1zm":
    case "iw5_rhinozm":
    case "iw5_gm6zm":
      return 0;
    default:
      return 1;
  }
}

getsoldierroundspawntype(var_0, var_1) {
  return "ranged_elite_soldier";
}

soldierroundcandroppickups(var_0) {
  return 0;
}

soldierroundstart() {
  level.soldierroundnum++;
  thread soldierroundupdatespawnpoints();
  iprintlnbold("Atlas Cleanup Crew Inbound!");
  level waittill("soldier_spawn_calculated");
}

soldierroundend() {
  maps\mp\gametypes\zombies::createpickup("ammo", level.lastenemydeathpos, "soldierRoundEnd");
  level notify("soldierRoundUpdateSpawnPoints");
}

soldierroundupdatespawnpoints() {
  level notify("soldierRoundUpdateSpawnPoints");
  level endon("soldierRoundUpdateSpawnPoints");
  level endon("game_ended");
  level.soldierspawn = undefined;
  level.validsoldiernodes = [];
  var_0 = getallnodes();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!maps\mp\zombies\_util::nodeisinspawncloset(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  wait 0.05;
  var_5 = 0.95;
  var_6 = 0.05;
  var_7 = 0.05;
  var_8 = 0.05;
  var_9 = var_5 - (var_6 + var_7 + var_8);

  for(;;) {
    var_10 = [];
    var_11 = [];

    foreach(var_13 in level.players) {
      if(isalive(var_13)) {
        var_14 = var_13 getnearestnode();

        if(isDefined(var_14)) {
          var_10[var_10.size] = var_14;
          var_11[var_11.size] = nodegetsplitgroup(var_14);
        }
      }
    }

    if(var_10.size == 0) {
      wait 0.1;
      continue;
    }

    var_16 = !isDefined(level.soldierspawn);

    if(!var_16) {
      var_17 = 0;

      foreach(var_19 in var_10) {
        if(nodesvisible(level.soldierspawn, var_19, 1)) {
          var_16 = 1;
          break;
        }

        var_17 = var_17 + distance(level.soldierspawn.origin, var_19.origin);
      }

      if(var_17 / var_10.size < 500) {
        var_16 = 1;
      }

      if(!var_16) {
        wait 0.1;
        continue;
      }
    }

    var_21 = [];

    foreach(var_3 in var_1) {
      if(!var_3 nodeisdisconnected()) {
        var_23 = nodegetsplitgroup(var_3);

        if(common_scripts\utility::array_contains(var_11, var_23)) {
          var_21[var_21.size] = var_3;
        }
      }
    }

    wait(var_6);
    var_25 = [];
    var_26 = 0;
    var_27 = int(var_21.size / (0.5 * var_9 / 0.05));

    foreach(var_3 in var_21) {
      var_29 = 1;

      foreach(var_19 in var_10) {
        if(nodesvisible(var_3, var_19, 1)) {
          var_29 = 0;
          break;
        }
      }

      if(var_29) {
        var_25[var_25.size] = var_3;
      }

      var_26++;

      if(var_26 % var_27 == 0) {
        wait 0.05;
      }
    }

    wait(var_7);
    var_26 = 0;
    var_33 = undefined;
    var_34 = -1;
    var_27 = int(var_25.size / (0.5 * var_9 / 0.05));

    foreach(var_3 in var_25) {
      var_36 = 0;

      foreach(var_19 in var_10) {
        var_36 = var_36 + distance(var_3.origin, var_19.origin);
      }

      if(var_36 > var_34) {
        var_34 = var_36;
        var_33 = var_3;
      }

      var_26++;

      if(var_26 % var_27 == 0) {
        wait 0.05;
      }
    }

    wait(var_8);

    if(isDefined(var_33)) {
      level.soldierspawn = var_33;
    } else {
      level.soldierspawn = common_scripts\utility::random(var_21);
    }

    level notify("soldier_spawn_calculated");
  }
}

comparenodedistances(var_0, var_1) {
  return level.nodedistances[var_0 getnodenumber()] <= level.nodedistances[var_1 getnodenumber()];
}

soldiergetrandomspawnpoint() {
  return level.soldierspawn;
}

soldierroundnumenemies(var_0) {
  var_1 = maps\mp\zombies\_util::getnumplayers();
  var_2 = 4 + level.soldierroundnum * 2;
  var_3 = var_1 * var_2;
  return var_3;
}

soldierroundspawndelay(var_0, var_1) {
  return 4.0;
}

soldierthink() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  childthread ammorefillprimary();
  childthread ammorefillsecondary();
  childthread maps\mp\zombies\_zombies::monitorbadzombieai();
  childthread maps\mp\zombies\_util::locateenemypositions();
}

getsoldierloadout() {
  var_0 = maps\mp\bots\_bots_loadout::bot_loadout_choose_from_attachmenttable;
  var_1 = [];
  var_1["loadoutWildcard1"] = "specialty_null";
  var_1["loadoutWildcard2"] = "specialty_null";
  var_1["loadoutWildcard3"] = "specialty_null";
  var_1["loadoutPrimary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["primary"]);
  var_1["loadoutPrimaryAttachment"] = self[[var_0]]("attachmenttable", var_1, "loadoutPrimaryAttachment", self.personality, self.difficulty);
  var_1["loadoutPrimaryAttachment2"] = self[[var_0]]("attachmenttable", var_1, "loadoutPrimaryAttachment2", self.personality, self.difficulty);
  var_1["loadoutPrimaryAttachment3"] = "none";
  var_1["loadoutPrimaryBuff"] = "specialty_null";
  var_1["loadoutPrimaryCamo"] = "none";
  var_1["loadoutPrimaryReticle"] = "none";
  var_1["loadoutSecondary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["secondary"]);
  var_1["loadoutSecondaryAttachment"] = self[[var_0]]("attachmenttable", var_1, "loadoutSecondaryAttachment", self.personality, self.difficulty);
  var_1["loadoutSecondaryAttachment2"] = self[[var_0]]("attachmenttable", var_1, "loadoutSecondaryAttachment2", self.personality, self.difficulty);
  var_1["loadoutSecondaryAttachment3"] = "none";
  var_1["loadoutSecondaryBuff"] = "specialty_null";
  var_1["loadoutSecondaryCamo"] = "none";
  var_1["loadoutSecondaryReticle"] = "none";
  var_1["loadoutEquipment"] = getsoldierloadoutequipment();
  var_1["loadoutEquipmentExtra"] = getsoldierloadoutequipmentextra();
  var_1["loadoutOffhand"] = getsoldierloadoutoffhand();
  var_1["loadoutPerk1"] = getsoldierloadoutperk(1, var_1);
  var_1["loadoutPerk2"] = "specialty_null";
  var_1["loadoutPerk3"] = getsoldierloadoutperk(3, var_1);
  var_1["loadoutPerk4"] = "specialty_null";
  var_1["loadoutPerk5"] = getsoldierloadoutperk(5, var_1);
  var_1["loadoutPerk6"] = "specialty_null";
  var_1["loadoutKillstreaks"][0] = "none";
  var_1["loadoutKillstreaks"][1] = "none";
  var_1["loadoutKillstreaks"][2] = "none";
  var_1["loadoutKillstreaks"][3] = "none";

  for(var_2 = 0; var_2 < 6; var_2++) {
    var_1["loadoutPerks"][var_2] = var_1["loadoutPerk" + (var_2 + 1)];
    var_1["loadoutPerk" + (var_2 + 1)] = undefined;
  }

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1["loadoutWildcards"][var_2] = var_1["loadoutWildcard" + (var_2 + 1)];
    var_1["loadoutWildcard" + (var_2 + 1)] = undefined;
  }

  return var_1;
}

getgoliathloadout() {
  var_0 = [];
  var_0["loadoutPrimary"] = "iw5_exominigun";
  var_0["loadoutPrimaryAttachment"] = "none";
  var_0["loadoutPrimaryAttachment2"] = "none";
  var_0["loadoutPrimaryAttachment3"] = "none";
  var_0["loadoutPrimaryBuff"] = "specialty_null";
  var_0["loadoutPrimaryCamo"] = "none";
  var_0["loadoutPrimaryReticle"] = "none";
  var_0["loadoutSecondary"] = "none";
  var_0["loadoutSecondaryAttachment"] = "none";
  var_0["loadoutSecondaryAttachment2"] = "none";
  var_0["loadoutSecondaryAttachment3"] = "none";
  var_0["loadoutSecondaryBuff"] = "specialty_null";
  var_0["loadoutSecondaryCamo"] = "none";
  var_0["loadoutSecondaryReticle"] = "none";
  var_0["loadoutEquipment"] = "none";
  var_0["loadoutOffhand"] = "none";
  var_0["loadoutKillstreaks"][0] = "none";
  var_0["loadoutKillstreaks"][1] = "none";
  var_0["loadoutKillstreaks"][2] = "none";
  var_0["loadoutKillstreaks"][3] = "none";
  var_0["loadoutPerks"] = ["specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null"];
  var_0["loadoutWildcards"] = ["specialty_null", "specialty_null", "specialty_null"];
  var_0["loadoutJuggernaut"] = 1;
  return var_0;
}

getsoldierloadoutoffhand() {
  if(issoldierally()) {
    return "specialty_null";
  }

  var_0 = ["exoshield_equipment_mp", "exoshield_equipment_mp", "exocloak_equipment_mp", "exocloak_equipment_mp", "exomute_equipment_mp", "exomute_equipment_mp"];

  if(level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10) {
    var_0[var_0.size] = "exorepulsor_equipment_mp";
  }

  return common_scripts\utility::random(var_0);
}

getsoldierloadoutequipment() {
  var_0 = ["frag_grenade_mp", "semtex_mp", "stun_grenade_mp", "emp_grenade_mp"];

  if(!issoldierally()) {
    var_0[var_0.size] = "smoke_grenade_mp";
  }

  return common_scripts\utility::random(var_0);
}

getsoldierloadoutequipmentextra() {
  return issoldierally() || level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10;
}

getsoldierloadoutperk(var_0, var_1) {
  var_2 = ["specialty_class_coldblooded"];

  for(var_3 = ""; var_3 == "" || common_scripts\utility::array_contains(var_2, var_3); var_3 = maps\mp\bots\_bots_loadout::bot_loadout_choose_from_set(["template_any"], "template_any", var_1, "loadoutPerk" + var_0)) {}

  return var_3;
}

issoldierally() {
  return self.agent_type == "zm_squadmate";
}

onsoldierspawned() {
  if(isDefined(level.agent_funcs[self.agent_type]["onAIConnect"])) {
    [[maps\mp\agents\_agent_utility::agentfunc("onAIConnect")]]();
  }

  setsoldierpersonalityanddifficulty();
  maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
  self.nopickups = 1;
  self.chosentemplates = [];
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";

  if(isDefined(level.getloadout) && isDefined(level.getloadout[self.agent_type])) {
    self.pers["gamemodeLoadout"] = self[[level.getloadout[self.agent_type]]]();
  } else {
    self.pers["gamemodeLoadout"] = getsoldierloadout();
  }

  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];

  if(isDefined(level.onspawnfinished) && isDefined(level.onspawnfinished[self.agent_type])) {
    self thread[[level.onspawnfinished[self.agent_type]]]();
  } else {
    thread onspawnfinished();
  }
}

onspawnfinished(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("applyLoadout");
  setsoldierbotsettings();
  self agentusescragentclipmask(1);
  self botsetflag("no_enemy_search", 1);
  self.pers["numberOfTimesCloakingUsed"] = 0;
  self.pers["numberOfTimesShieldUsed"] = 0;
  var_1 = self.overridebodymodel;
  var_2 = self.overrideheadmodel;

  if(!isDefined(var_1) || !isDefined(var_2)) {
    if(isDefined(level.agentclasses[self.agent_type].model_bodies)) {
      var_3 = randomint(level.agentclasses[self.agent_type].model_bodies.size);
      var_1 = level.agentclasses[self.agent_type].model_bodies[var_3];
      var_2 = level.agentclasses[self.agent_type].model_heads[var_3];
    }
  }

  if(isDefined(var_1)) {
    self setModel(var_1);

    if(isDefined(self.headmodel)) {
      self detach(self.headmodel, "");
    }

    self.headmodel = var_2;
    self attach(self.headmodel, "", 1);
  }

  self.ignorezombierecycling = 1;
}

playersetjuggexomodelzm(var_0) {
  self detachall();
  self setModel("npc_exo_armor_mp_base");
  self attach("head_hero_cormack_sentinel_halo");

  if(isDefined(var_0) && !var_0.hasmaniac || isDefined(level.ishorde)) {
    self attach("npc_exo_armor_minigun_handle", "TAG_HANDLE");
  }

  if(isai(self)) {
    self.hideondeath = 1;
  }

  self notify("goliath_equipped");
}

onspawnfinishedgoliath() {
  onspawnfinished();
  playersetjuggexomodelzm();
  self setplayermech(1);
  self botsetstance("stand");
  self allowjump(0);
  self allowladder(0);
  self allowmantle(0);
  self allowcrouch(0);
  self allowprone(0);
  maps\mp\_utility::playerallowhighjump(0, "class");
  maps\mp\_utility::playerallowdodge(0, "class");
  mechattachminigunbarrel();
  thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
  thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();
}

mechattachminigunbarrel() {
  self.barrellinker = spawn("script_model", self gettagorigin("tag_barrel"));
  self.barrellinker setModel("generic_prop_raven");
  self.barrellinker linktosynchronizedparent(self, "tag_barrel", (12.7, 0, -2.9), (90, 0, 0));
  self.barrel = spawn("script_model", self.barrellinker gettagorigin("j_prop_1"));
  self.barrel setModel("npc_exo_armor_minigun_barrel");
  self.barrel linktosynchronizedparent(self.barrellinker, "j_prop_1", (0, 0, 0), (-90, 0, 0));
}

setsoldierpersonalityanddifficulty() {
  maps\mp\bots\_bots_util::bot_set_personality("run_and_gun");

  if(isDefined(self.difficulty)) {
    maps\mp\bots\_bots_util::bot_set_difficulty(self.difficulty);
  } else if(issoldierally()) {
    maps\mp\bots\_bots_util::bot_set_difficulty("veteran");
  } else {
    maps\mp\bots\_bots_util::bot_set_difficulty("regular");
  }

  self.difficulty = self botgetdifficulty();
}

setsoldierbotsettings() {
  if(!issoldierally()) {
    self botsetdifficultysetting("quickPistolSwitch", 1);
    self botsetdifficultysetting("diveChance", 0.2);
    self botsetdifficultysetting("diveDelay", 300);
    self botsetdifficultysetting("slideChance", 0.6);
    self botsetdifficultysetting("cornerFireChance", 1.0);
    self botsetdifficultysetting("cornerJumpChance", 1.0);
    self botsetdifficultysetting("throwKnifeChance", 1.0);
    self botsetdifficultysetting("meleeDist", 100);
    self botsetdifficultysetting("meleeChargeDist", 160);
    self botsetdifficultysetting("grenadeCookPrecision", 100);
    self botsetdifficultysetting("grenadeDoubleTapChance", 1.0);
    self botsetdifficultysetting("strategyLevel", 3);
    self botsetdifficultysetting("intelligentSprintLevel", 2);
    self botsetdifficultysetting("holdBreathChance", 1.0);
    self botsetdifficultysetting("intelligentReload", 1.0);
    self botsetdifficultysetting("dodgeChance", 0.5);
    self botsetdifficultysetting("dodgeIntelligence", 0.8);
    self botsetdifficultysetting("boostSlamChance", 0.35);
    self botsetdifficultysetting("boostLookAroundChance", 1.0);
    self botsetdifficultysetting("diveDelay", 300);
    self botsetdifficultysetting("diveDelay", 300);
  }
}

ammorefillprimary() {
  if(self.primaryweapon == "none") {
    return;
  }
  for(;;) {
    self givemaxammo(self.primaryweapon);
    wait 12;
  }
}

ammorefillsecondary() {
  if(self.secondaryweapon == "none") {
    return;
  }
  for(;;) {
    self givemaxammo(self.secondaryweapon);
    wait 8;
  }
}

onsoldierkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.lastenemydeathpos = self.origin;

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 maps\mp\_utility::incplayerstat("kills", 1);
    var_1 maps\mp\_utility::incpersstat("kills", 1);
    var_1.kills = var_1 maps\mp\_utility::getpersstat("kills");
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "kills", var_1.kills);
  }

  if(isDefined(var_1)) {
    var_1 notify("killed_enemy");
  }

  if(isDefined(level.processenemykilledfunc)) {
    self thread[[level.processenemykilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  return maps\mp\agents\_agents::on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

soldiergetrepulsortag() {
  if(maps\mp\killstreaks\_aerial_utility::hastag(self.model, "TAG_JETPACK")) {
    return "TAG_JETPACK";
  } else {
    return "tag_shield_back";
  }
}
/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\escort_horde.gsc
****************************************************/

#using script_16ea1b94f0f381b3;
#using script_24fbedba9a7a1ef4;
#using script_315e06108d117c9a;
#using script_3ed005fe9b78b9da;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\gun;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\points;
#using scripts\mp\validation;
#namespace escort_horde;

function function_3885e1d74c6f11eb() {
  level.onmaprestart = &onmaprestart;
  level.var_8b5c3bda53460402 = &function_8d9dca133b662b60;
  level.onlyroundoverride = 1;
  level thread onstartgametypefinished();
  level.var_44815c2275fee420 = 1;
  level.disablepersonalnuke = 1;
  function_5e5f1db1c49f9fa("default1", &function_8121c27ec4fdb19d);
  function_5e5f1db1c49f9fa("default4", &function_7ede0aa8434bebd1);
  function_5e5f1db1c49f9fa("default3", &function_1824541ee1333b93);
  function_5e5f1db1c49f9fa("default2", &function_852acf50e7345bc8);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);
  level.modeupdateloadoutclass = &function_ca5d00ef2a435d1f;
  level.var_7e9532b5406cfa7d = &function_7e9532b5406cfa7d;
  level callback::add("player_death", &onplayerdeath);
  level callback::add("player_spawned", &onspawnplayer);
  level callback::add("player_connect", &onplayerconnect);
  level callback::add("on_zombie_ai_killed", &function_39a600444016629e);
  registersharedfunc("escort", "isZombie", &iszombie);
  registersharedfunc("escort", "isDogZombie", &isdogzombie);
  level.var_5622bf44905e2b1a = &function_89e10e876c0c0447;
  setDvar(@ "r_identifyoldmaterial", 0);
  setDvar(@ "hash_6db0c7f59c294cb4", 20);
  level thread spawn_zombies();

  setDvar(@ "hash_d01570d79c646246", 1);

  level._effect["vfx_jup_mut_jugg_transform_puff"] = loadfx("vfx/jup/gameplay/mutation/vfx_jup_mut_jugg_transform_puff.vfx");
  thread initpostmain();
}

function function_89e10e876c0c0447() {
  var_e217fd82c718af36 = getdvarint(@ "hash_c2b58986f486d692", 3);

  if(var_e217fd82c718af36 > 0) {
    level.agent_funcs["zombie"]["on_damaged"] = &namespace_daa149ca485fd50a::callbacksoldieragentdamaged;
    level.agent_funcs["zombie"]["gametype_on_killed"] = &scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
    level.agentskillstreakcount = var_e217fd82c718af36;
  }
}

function function_f9c27bb7f1c4fedc() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
}

function function_7e9532b5406cfa7d() {
  foreach(weapon in self getweaponslistprimaries()) {
    if(is_equal(weapon.basename, "jup_jp36_ar_anov94_mp")) {
      if(is_equal(weapon.isalternate, 1)) {
        self switchtoweapon(weapon);
        val::set("juggernaut_mutant", "weapon_switch", 0);
        self.var_967123630ad7ddc6 = 1;
        thread function_b3529ae567aafd97();
      }
    }
  }

  playFXOnTag(level._effect["vfx_jup_mut_jugg_transform_puff"], self, "tag_origin");
}

function function_b3529ae567aafd97() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(true) {
    wait 1;
    currentweapon = self getcurrentweapon();
    startingammo = weaponstartammo(currentweapon);
    clipammo = weaponclipsize(currentweapon);
    stockammo = startingammo - clipammo;
    self setweaponammoclip(currentweapon, 300);
  }
}

function onstartgametypefinished() {
  utility::flag_wait("onStartGameTypeFinished");
  level.streakglobals.streakbundles["fuel_airstrike"].kills = 6;
}

function initpostmain() {
  thread namespace_579c1620477fc1a::initpostmain();

  if(!threatbiasgroupexists("player_zombie")) {
    createthreatbiasgroup("player_zombie");
  }

  if(!threatbiasgroupexists("zombie")) {
    createthreatbiasgroup("zombie");
  }

  setignoremegroup("player_zombie", "zombie");
}

function function_8d9dca133b662b60(struct) {
  if(ismutationgamemodezombie()) {
    return struct;
  }

  return scripts\mp\validation::validateloadout(struct);
}

function function_f69b1a88bc3add30() {
  if(threatbiasgroupexists("player_zombie")) {
    self setthreatbiasgroup("player_zombie");
  }

  self hudoutlineenable("outlinefill_depth_white");
}

function function_587548933872d0b6(revived) {
  self hudoutlinedisable();
  self setthreatbiasgroup();
}

function onplayerconnect(params) {
  player = self;
  player thread scripts\mp\gametypes\gun::refillammo();
  player thread scripts\mp\gametypes\gun::refillsinglecountammo();
}

function onplayerdeath(params) {
  if(isDefined(self.var_ae387c36d115328f)) {
    self unlink();
    self.var_ae387c36d115328f delete();
  }

  if(istrue(iszombie())) {
    self clearsoundsubmix("jup_mp_mutation_breath", 1);
    self clearsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 1);
  }

  val::set("juggernaut_mutant", "weapon_switch", 1);
  self.var_967123630ad7ddc6 = 0;
  self setcamerathirdperson(0);
  self.operatorcustomization = undefined;
  self clearcustomization();
}

function onjoinedteam(player) {
  player function_4f64cc518d710ee1();
}

function function_4f64cc518d710ee1(halftime) {
  player = self;
  iszombie = player ismutationgamemodezombie();

  if(istrue(halftime)) {
    iszombie = !iszombie;
  }

  if(iszombie) {
    player setclientomnvar("ui_only_default_loadouts_player", 1);
    return;
  }

  player setclientomnvar("ui_only_default_loadouts_player", 0);
}

function onspawnplayer(params) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");

  if(isbot(self) && ismutationgamemodezombie()) {
    thread function_7042d138b3d8a4f4();
  }

  thread onspawnfinished();
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  thread function_3cd7aabb0e5dd22f();

  if(!istrue(iszombie())) {
    self clearsoundsubmix("jup_mp_mutation_breath", 1);
    self clearsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 1);
  }

  self setscriptablepartstate("mutant_cloak", "inactive");
}

function function_3cd7aabb0e5dd22f() {
  self notify("watchLoadoutChanged");
  self endon("watchLoadoutChanged");
  self endon("death_or_disconnect");
  function_4c09404e1f472457();

  while(true) {
    self waittill("giveLoadout");
    self notify("zombie_unset");
    waitframe();
    function_4c09404e1f472457();
  }
}

function onmaprestart() {
  foreach(player in level.players) {
    player function_57cad676a5cbb536();
    player function_e7762eb89190b46c();
    player function_4f64cc518d710ee1(1);
    player.class = undefined;
    player.pers["class"] = undefined;
    player.pers["classCache"] = undefined;
    player.preloadedclassstruct = undefined;
  }
}

function ononeleftevent(team) {}

function function_61c226745cc230bd(player) {
  if(!istrue(player.hasspawned)) {
    return false;
  }

  if(!ismutationgamemodezombie()) {
    return true;
  }

  return false;
}

function function_39a600444016629e(params) {
  playerattacker = params.eattacker;

  if(!isDefined(playerattacker) || !isPlayer(playerattacker)) {
    return;
  }

  if(ismutationgamemode()) {
    playerattacker thread scripts\mp\utility\points::doscoreevent(#"hash_30bae1a5dd41a4d1");
  }
}

function function_4c09404e1f472457() {
  if(!isDefined(self.defaultsuit)) {
    self.defaultsuit = self.suit;
  }

  if(!isDefined(self.defaultmodel)) {
    self.defaultmodel = self.model;
  }

  if(iszombie()) {
    if(!isDefined(self.class)) {
      thread function_8121c27ec4fdb19d();
      return;
    }

    if(!istrue(isdogzombie())) {
      self clearsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 1);
      self setsoundsubmix("jup_mp_mutation_breath", 0.1);
    } else if(istrue(isdogzombie())) {
      self clearsoundsubmix("jup_mp_mutation_breath", 1);
      self setsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 0.1);
    } else {
      self clearsoundsubmix("jup_mp_mutation_breath", 1);
      self clearsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 1);
    }

    if(!isDefined(level.var_e10b12c5cb975aa[self.class])) {
      var_4ab72a616f50b4c2 = [];
      var_4ab72a616f50b4c2[var_4ab72a616f50b4c2.size] = "default1";
      var_4ab72a616f50b4c2[var_4ab72a616f50b4c2.size] = "default3";
      var_4ab72a616f50b4c2[var_4ab72a616f50b4c2.size] = "default2";

      if(!isDefined(level.var_5f9486d264dece01)) {
        level.var_5f9486d264dece01 = 0;
      }

      if(!isDefined(self.var_72e77607f1ebe26e)) {
        self.var_6b81cdf774dac18d = var_4ab72a616f50b4c2[level.var_5f9486d264dece01];
        self.var_72e77607f1ebe26e = level.var_e10b12c5cb975aa[self.var_6b81cdf774dac18d];
        level.var_5f9486d264dece01++;
      }

      if(level.var_5f9486d264dece01 >= var_4ab72a616f50b4c2.size) {
        level.var_5f9486d264dece01 = 0;
      }

      self thread[[self.var_72e77607f1ebe26e]]();
      return;
    }

    if(istrue(self.isjuggernaut)) {
      return;
    }

    self thread[[level.var_e10b12c5cb975aa[self.class]]]();
    self setclientomnvar("ui_mutation_zombie_type", int(self.class_num));
    return;
  }

  if(istrue(self.isjuggernaut)) {
    return;
  }

  thread function_702b1da0c13a5636();
}

function function_5e5f1db1c49f9fa(class, func) {
  if(!isDefined(level.var_e10b12c5cb975aa)) {
    level.var_e10b12c5cb975aa = [];
  }

  level.var_e10b12c5cb975aa[class] = func;
}

function function_7042d138b3d8a4f4() {
  waitframe();

  while(isDefined(self)) {
    self takeallweapons();
    self giveweapon("iw9_me_fists_mp_zmb");
    self switchtoweapon("iw9_me_fists_mp_zmb");
    wait 10;
  }
}

function allowclasschoicefunc() {
  if(!isPlayer(self)) {
    return true;
  }

  if(isbot(self)) {
    return false;
  }

  iszombie = ismutationgamemodezombie();
  return !iszombie;
}

function spawn_zombies() {
  while(!scripts\mp\flags::gameflagexists("prematch_done")) {
    waitframe();
  }

  if(!getdvarint(@ "hash_edf44050ea46141c", 1)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_b054c7cee5a37e24 = getdvarint(@ "hash_a66c084bb8c1534b", 20);
  var_b55db3b8e7ae1878 = getdvarint(@ "hash_688285cc0b2cb55d", 325);

  while(true) {
    if(!isDefined(level.agentarray)) {
      waitframe();
      continue;
    }

    alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam(game["defenders"]);

    if(alive_enemies.size < var_b054c7cee5a37e24) {
      spawnpoint = function_ca3bbb75a4e56ba2();

      if(!isDefined(spawnpoint)) {
        spawnpoint = random(getspawnarray("mp_tdm_spawn")).origin;
      }

      zombie_type = "actor_jup_spawner_zombie_base_mutation_mode_mp";
      ai = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(zombie_type, spawnpoint, (0, randomint(360), 0), game["defenders"]);

      if(isDefined(ai)) {
        ai.goalradius = 16;
        ai.stealth_enabled = 0;
        ai.pathenemyfightdist = 0;
        ai.cornercheckenabled = 0;
        ai.friendlyteam = game["attackers"];
        ai.maxhealth = var_b55db3b8e7ae1878;
        ai.health = ai.maxhealth;
        ai thread scripts\asm\shared\mp\utility::animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
        ai utility::callsharedfunc("zombie_utils", "setMoveSpeed", "sprint", "horde_spawn", 1);
        ai setthreatbiasgroup("zombie");
      }
    }

    wait 3;
  }
}

function function_ca3bbb75a4e56ba2() {
  randx = level.mapcenter[0] + randomintrange(-1000, 1000);
  randy = level.mapcenter[1] + randomintrange(-1000, 1000);
  var_308da6b1fed33068 = level.mapcenter[2];
  var_afaaa0a18b3fcf40 = (randx, randy, var_308da6b1fed33068);
  var_60de69d206774bb8 = getclosestpointonnavmesh(var_afaaa0a18b3fcf40);
  return var_60de69d206774bb8;
}

function isdogzombie() {
  return ismutationgamemodezombie() && is_equal(self.class, "default4");
}

function iszombie() {
  team = self.pers["team"];

  if(!isDefined(team)) {
    team = self.sessionteam;
  }

  if(isDefined(self.bot_team)) {
    team = self.bot_team;
  }

  if(team == "none") {
    return undefined;
  }

  return is_equal(team, game["defenders"]);
}

function function_ca5d00ef2a435d1f(struct) {
  player = self;

  if(istrue(player.isjuggernaut)) {
    if(player ismutationgamemodezombie()) {
      struct.loadoutprimary = "jup_jp36_ar_anov94";
      struct.loadoutprimaryvariantid = 9;
      struct.loadoutprimaryattachments = [];
      struct.loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon_blueprint(struct.loadoutprimary, undefined, undefined, struct.loadoutprimaryvariantid, undefined, undefined, 0);
    }

    return;
  }

  if(!player ismutationgamemodezombie()) {
    struct.loadoutkillstreak1 = "fuel_airstrike";
    struct.loadoutkillstreak2 = "remote_turret";
    struct.loadoutkillstreak3 = "juggernaut";
    return;
  }

  struct.loadoutprimary = "iw9_me_fists_mp";
  struct.loadoutprimaryattachments = [];
  struct.loadoutprimaryvariantid = -1;
  struct.loadoutprimaryobject = makeweapon(struct.loadoutprimary);
  struct.loadoutsecondary = "none";
  struct.loadoutsecondaryattachments = [];
  struct.loadoutsecondaryobject = makeweapon("none");
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "juggernaut_mutant";
  struct.loadoutequipmentprimary = "none";
  struct.loadoutequipmentsecondary = "none";
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";
}

function function_a3942567e9f08fb2() {
  while(true) {
    if(getdvarint(@ "hash_a5fcedd02f31dfc0", 0)) {
      val = getdvarint(@ "hash_a5fcedd02f31dfc0", 0);
      setDvar(@ "hash_a5fcedd02f31dfc0", 0);

      if(val == 1) {}

      if(val == 2) {
        level.player thread function_7ede0aa8434bebd1();
      }

      if(val == 3) {
        level.player thread function_7ede0aa8434bebd1();
      }

      level.player kill();
    }

    wait 0.25;
  }
}

# /
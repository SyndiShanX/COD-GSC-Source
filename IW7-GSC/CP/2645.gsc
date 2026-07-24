/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2645.gsc
**************************************/

init() {
  scripts\engine\utility::struct_class_init();
  _id_F6BD();
  _id_F6BA();
  scripts\cp\utility::_id_F305();
  setupcallbacks();
  scripts\cp\utility::initgameflags();
  scripts\cp\utility::initlevelflags();
  _id_FAAB();
  _id_F6BB();
  _id_F6BF();
  _id_F6BC();
  _id_AE18();
  _id_10958();
  _id_97F7();
  setupexploders();
  _id_9817();
  _id_988B();
  scripts\common\fx::initfx();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\cp\cp_movers::init();
  scripts\cp\_id_0A53::main();
  scripts\cp\cp_merits::buildmeritinfo();
  scripts\cp\cp_gamelogic::init();
  scripts\cp\cp_laststand::init_laststand();

  if(_id_100BC())
    level thread _id_132A3();

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

_id_F6BD() {
  level._id_1307 = 1;
  level.splitscreen = issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") || getdvarint("force_ranking");
  level.script = tolower(getDvar("mapname"));
  level.gametype = tolower(getDvar("ui_gametype"));
  level.teamnamelist = ["axis", "allies"];
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  level.teambased = 1;
  level.objectivebased = 0;
  level.func = [];
  level.createfx_enabled = getDvar("createfx") != "";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.hardcoremode = 0;
  level._id_C22E = 0;
  level.reclaimedreservedobjectives = [];
}

_id_F6BA() {
  setDvar("ui_inhostmigration", 0);
  setDvar("camera_thirdPerson", getdvarint("scr_thirdPerson"));
  setDvar("sm_sunShadowScale", 1);
  setDvar("r_specularcolorscale", 2.5);
  setDvar("r_diffusecolorscale", 1);
  setDvar("r_lightGridEnableTweaks", 0);
  setDvar("r_lightGridIntensity", 1);
  setDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));
  setDvar("isMatchMakingGame", scripts\cp\utility::matchmakinggame());
  setDvar("ui_overtime", 0);
  setDvar("ui_allow_teamchange", 1);
  setDvar("g_deadChat", 1);
  setDvar("min_wait_for_players", 5);
  setDvar("ui_friendlyfire", 0);
  setDvar("cg_drawFriendlyHUDGrenades", 0);
  setDvar("cg_drawCrosshair", scripts\engine\utility::ter_op(level.hardcoremode == 1, 0, 1));
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 0);
}

setupcallbacks() {
  level.callbackstartgametype = ::_id_4631;
  level.callbackplayerconnect = ::_id_5043;
  level.callbackplayerdisconnect = ::_id_5045;
  level.callbackplayerdamage = ::_id_5044;
  level.callbackplayerkilled = ::_id_5046;
  level.callbackplayermigrated = ::_id_5049;
  level.callbackhostmigration = ::_id_503E;
  level.getspawnpoint = ::defaultgetspawnpoint;
  level.onspawnplayer = ::blank;
  level.onprecachegametype = ::blank;
  level.onstartgametype = ::blank;
  level._id_D3D5 = ::_id_5048;
  level.initagentscriptvariables = scripts\cp\cp_agent_utils::initagentscriptvariables;
  level.setagentteam = scripts\cp\cp_agent_utils::set_agent_team;
  level.agentvalidateattacker = scripts\cp\cp_agent_utils::validateattacker;
  level.agentfunc = scripts\cp\cp_agent_utils::agentfunc;
  level.getfreeagent = scripts\cp\cp_agent_utils::getfreeagent;
  level.addtocharactersarray = scripts\cp\cp_agent_utils::addtocharactersarray;
  level.callbackplayerlaststand = scripts\cp\cp_laststand::callback_defaultplayerlaststand;
  level.endgame = scripts\cp\cp_gamelogic::endgame;
  level._id_72BF = scripts\cp\cp_gamelogic::_id_72BF;
}

_id_AE18() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

_id_5044(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

_id_5046(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_FAAB() {
  var_0 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage"];

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "classname");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isDefined(var_3[var_4].script_prefab_exploder))
        var_3[var_4].script_exploder = var_3[var_4].script_prefab_exploder;

      if(isDefined(var_3[var_4].script_exploder))
        level thread exploder_load(var_3[var_4]);
    }
  }
}

_id_10958() {
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    scripts\engine\utility::waitframe();
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    scripts\engine\utility::waitframe();
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    scripts\engine\utility::waitframe();
  }
}

_id_5048() {
  if(scripts\engine\utility::is_true(self.keep_perks)) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough"))
      return 200;
    else
      return 100;
  } else
    return 100;
}

_id_F6BB() {
  game["thermal_vision"] = "thermal_mp";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["clientid"] = 0;
  game["roundsPlayed"] = 0;
  game["state"] = "playing";
  game["status"] = "normal";
  game["roundsWon"] = [];
}

_id_F6BF() {
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("", 0);
}

_id_F6BC() {
  setnojipscore(0);
  setnojiptime(0);
}

defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();

  if(var_1 == 4)
    var_1 = 1;

  return var_0[var_1];
}

_id_5038() {
  level.gameended = 1;
  setomnvar("allow_server_pause", 0);
  level notify("game_ended", "allies");
  scripts\engine\utility::waitframe();
  exitlevel(0);
}

_id_4631() {
  [[level.onprecachegametype]]();
  _id_E256();
  _id_E255();
  scripts\cp\perks\perkmachines::_id_98B1();
  scripts\cp\perks\prestige::initprestige();
  scripts\cp\cp_weaponrank::init();
  scripts\cp\cp_weaponpassives::init();
  thread scripts\cp\powers\coop_powers::init();
  scripts\cp\cp_merits::init();
  thread scripts\cp\contracts_coop::init();
  level thread _id_E896();
  level thread _id_8489();
  level thread _id_10D9F();
  game["gamestarted"] = 1;
}

_id_E256() {
  level.teamcount["allies"] = 0;
  level.teamcount["axis"] = 0;
  level.teamcount["spectator"] = 0;
  level.hasspawned["allies"] = 0;
  level.hasspawned["axis"] = 0;
  level.fauxvehiclecount = 0;
  level.gameended = 0;
  level._id_72B3 = 0;
  level.hostforcedend = 0;
  level._id_8487 = 10;
  level.ingraceperiod = level._id_8487;
  level.noragdollents = getEntArray("noragdoll", "targetname");
  level.friendlyfire = 0;
  level.starttime = gettime();
}

_id_E255() {
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.helis = [];
  level.turrets = [];
  level._id_935F = [];
  level.ugvs = [];
  level.balldrones = [];
}

_id_E896() {
  level notify("coop_pre_match");
  level endon("game_ended");
  level endon("coop_pre_match");
  scripts\cp\utility::gameflaginit("prematch_done", 0);
  setomnvar("ui_prematch_period", 1);

  if(isDefined(level.prematchfunc))
    [[level.prematchfunc]]();

  scripts\cp\utility::gameflagset("prematch_done");
  setomnvar("ui_prematch_period", 0);
}

_id_8489() {
  level notify("coop_grace_period");
  level endon("game_ended");
  level endon("coop_grace_period");

  while(getactiveclientcount() == 0)
    scripts\engine\utility::waitframe();

  while(level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level.ingraceperiod = 0;
}

_id_10D9F() {
  [[level.onstartgametype]]();
}

_id_100BC() {
  return !level.console && (getDvar("dedicated") == "dedicated LAN server" || getDvar("dedicated") == "dedicated internet server");
}

_id_132A3() {
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("xblive_privatematch"))
      exitlevel(0);

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

_id_5043() {
  self endon("disconnect");
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";
  var_0 = gettime();
  level notify("connected", self);
  game["clientid"]++;
  _id_98BC();
  _id_F7F0();
  initclientdvars();
  setupsavedactionslots();
  _id_98B9();
  _id_988E();
  scripts\cp\perks\prestige::initplayerprestige();
  scripts\cp\perks\perk_utility::_id_95C1();
  self.no_team_outlines = 0;
  self.no_outline = 0;

  if(scripts\cp\utility::coop_mode_has("outline"))
    thread scripts\cp\cp_outline::playeroutlinemonitor();

  thread scripts\cp\cp_vo::_id_97CC();
  thread scripts\cp\cp_merits::updatemerits();

  if(self ishost())
    level.player = self;

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  waittillframeend;
  _id_1810(self);

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    spawnintermission();
    return;
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"]))
    self thread[[level.bot_funcs["think"]]]();

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer))
    thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

  if(isDefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  if(!isai(self))
    _id_D3D9();

  spawnplayer();
}

_id_D3D9() {
  thread _id_102EC();
  thread _id_72C1();
}

_id_F7F0() {
  self.guid = scripts\cp\utility::getuniqueid();
  self.clientid = game["clientid"];
  self.usingonlinedataoffline = self isusingonlinedataoffline();
  self.connected = 1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.inlaststand = 0;
}

initclientdvars() {
  initclientdvarssplitscreenspecific();
  self setclientdvars("cg_drawSpectatorMessages", 1, "cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0, "ui_altscene", 0);

  if(level.teambased)
    self setclientdvar("cg_everyonehearseveryone", 0);
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovscale", "0.75");
    setDvar("r_materialBloomHQScriptMasterEnable", 0);
  } else
    self setclientdvars("cg_fovscale", "1");
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnStruct();
    self.saved_actionslotdata[var_0].type = "";
    self.saved_actionslotdata[var_0].item = undefined;
  }

  if(!level.console) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnStruct();
      self.saved_actionslotdata[var_0].type = "";
      self.saved_actionslotdata[var_0].item = undefined;
    }
  }
}

_id_98B9() {
  self.perks = [];
  self.perksperkname = [];
}

_id_102EC() {
  self endon("disconnect");

  for(;;) {
    self waittill("sprint_slide_begin");
    self _meth_8241(level._effect["slide_dust"], self getEye());
  }
}

_id_72C1() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "arcade_off")
      self notify("adjustedStance");

    if(var_0 == "end_game") {
      level thread[[level._id_72BF]]();
      self notify("disconnect");
    }
  }
}

spawnintermission(var_0) {
  _id_F726();
  var_1 = self.forcespawnangles;
  spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(level.console)
    self setclientdvar("cg_fov", "90");

  scripts\cp\utility::updatesessionstate("intermission");
}

_id_F726() {
  var_0 = _id_7ED8();
  _id_F717(var_0.origin, var_0.angles);
}

_id_F717(var_0, var_1) {
  self.forcespawnorigin = var_0;
  self.forcespawnangles = var_1;
}

_id_7ED8() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  return var_0[0];
}

spawnplayer(var_0) {
  thread _id_108F4(var_0);
}

_id_108F4(var_0) {
  self endon("disconnect");
  self endon("joined_spectators");
  level endon("game_ended");

  if(self.waitingtospawn) {
    return;
  }
  _id_136E9();
  _id_108F3(var_0);
}

_id_136E9() {
  self.waitingtospawn = 1;

  if(scripts\cp\utility::isusingremote())
    self waittill("stopped_using_remote");

  self.waitingtospawn = 0;
}

_id_108F3(var_0) {
  self notify("spawned");
  self notify("started_spawnPlayer");

  if(level.gameended)
    self spawn(getspawnorigin(self, 1), _id_8132(self));
  else
    self spawn(getspawnorigin(self), _id_8132(self));

  _id_E262();
  _id_E261();
  _id_E263();
  resetplayerdamagemodifiers();
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0);

  if(!var_0)
    _id_C07F();

  if(isai(self))
    _id_10828(var_0);

  [[level.onspawnplayer]]();

  if(!scripts\engine\utility::flag("introscreen_over"))
    scripts\cp\utility::freezecontrolswrapper(1);

  self[[level.custom_giveloadout]](var_0);

  if(getdvarint("camera_thirdPerson"))
    scripts\cp\utility::setthirdpersondof(1);

  if(_id_1001B())
    scripts\cp\utility::freezecontrolswrapper(1);

  waittillframeend;
  self notify("spawned_player");
  level notify("player_spawned", self);
}

_id_E262() {
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_hud_shake", 0);
}

_id_E261() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(level.console)
    self setclientdvar("cg_fov", "65");
}

resetplayerdamagemodifiers() {
  if(isDefined(self.additivedamagemodifiers)) {
    var_0 = getarraykeys(self.additivedamagemodifiers);

    foreach(var_2 in var_0)
    scripts\cp\utility::removedamagemodifier(var_2, 1);
  }

  if(isDefined(self.multiplicativedamagemodifiers)) {
    var_0 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(var_2 in var_0)
    scripts\cp\utility::removedamagemodifier(var_2, 0);
  }
}

_id_E263() {
  var_0 = _id_8144();
  self.team = var_0;
  self.sessionteam = var_0;
  self.pers["team"] = var_0;
  self.fauxdeath = undefined;
  self.movespeedscaler = 1;
  self.disabledweapon = 0;
  self.disabledoffhandweapons = 0;
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
}

_id_8144() {
  if(isDefined(level._id_D425))
    return [[level._id_D425]](self);

  return "allies";
}

_id_C07F() {
  _id_E25B();
  scripts\cp\utility::updatesessionstate("playing");
}

_id_E25B() {
  self.maxhealth = self[[level._id_D3D5]]();
  self.health = self.maxhealth;
  self.avoidkillstreakonspawntimer = 5.0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.objectivescaler = 1;
}

_id_10828(var_0) {
  scripts\cp\utility::freezecontrolswrapper(1);

  if(!var_0) {
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();
  }
}

getspawnorigin(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0.forcespawnorigin)) {
    var_2 = var_0.forcespawnorigin;
    var_2 = getclosestpointonnavmesh(var_2);

    if(isDefined(var_1))
      var_2 = var_0.forcespawnorigin;

    var_0.forcespawnorigin = undefined;
  } else {
    var_3 = var_0[[level.getspawnpoint]]();
    var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::is_true(level.disable_start_spawn_on_navmesh), scripts\engine\utility::drop_to_ground(var_3.origin, 0, -100), getclosestpointonnavmesh(var_3.origin));

    if(isDefined(var_1))
      var_2 = var_3;

    if(level.script == "cp_disco")
      var_2 = var_3.origin;
  }

  return var_2;
}

_id_8132(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.forcespawnangles)) {
    var_1 = var_0.forcespawnangles;
    var_0.forcespawnangles = undefined;
  } else {
    var_2 = var_0[[level.getspawnpoint]]();
    var_1 = scripts\engine\utility::ter_op(isDefined(var_2.angles), var_2.angles, (0, 0, 0));
  }

  return var_1;
}

_id_1001B() {
  if(game["state"] == "postgame")
    return 1;

  return 0;
}

enterspectator() {
  var_0 = _id_7ED8();
  self setspectatedefaults(var_0.origin, var_0.angles);
  _id_F717(var_0.origin, var_0.angles);
  _id_F858();
  scripts\cp\utility::updatesessionstate("spectator");
}

_id_F858() {
  if(isDefined(level._id_10979))
    [[level._id_10979]](self);
  else
    _id_504C(self);
}

_id_504C(var_0) {
  var_0 allowspectateteam("allies", 1);
  var_0 allowspectateteam("axis", 1);
  var_0 allowspectateteam("freelook", 0);
  var_0 allowspectateteam("none", 1);
}

_id_5045(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }
  scripts\cp\cp_analytics::on_player_disconnect(var_0);
  _id_E15A(self);

  if(_id_563B())
    level thread[[level._id_72BF]]();

  if(isDefined(level.onplayerdisconnected))
    level thread[[level.onplayerdisconnected]](self, var_0);
}

_id_563B() {
  if(level.splitscreen)
    return level.players.size <= 1;

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2))
      var_0 = scripts\cp\cp_laststand::gameshouldend(var_2);
  }

  return var_0;
}

_id_1810(var_0) {
  level.players[level.players.size] = var_0;
  level.participants[level.participants.size] = var_0;
  level.characters[level.characters.size] = var_0;
}

_id_E15A(var_0) {
  level.players = scripts\engine\utility::array_remove(level.players, var_0);
  level.participants = scripts\engine\utility::array_remove(level.participants, var_0);
  level.characters = scripts\engine\utility::array_remove(level.characters, var_0);
}

_id_5049() {
  if(self ishost())
    initclientdvarssplitscreenspecific();

  if(_id_9E39(self)) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(_id_9E39(var_2))
        var_0++;
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3)
      level notify("hostmigration_enoughplayers");
  }
}

_id_9E39(var_0) {
  return !isDefined(var_0.pers["isBot"]) || var_0.pers["isBot"] == 0;
}

_id_503E() {
  if(level.gameended) {
    return;
  }
  if(isDefined(level._id_C53D))
    level thread[[level._id_C53D]]();

  level.hostmigrationreturnedplayercount = 0;

  foreach(var_1 in level.characters)
  var_1.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");

  foreach(var_1 in level.characters) {
    if(isDefined(var_1))
      var_1 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

    if(isPlayer(var_1))
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);
  }

  setDvar("ui_game_state", game["state"]);
  level endon("host_migration_begin");
  scripts\cp\cp_hostmigration::hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("ui_inhostmigration", 0);

  if(isDefined(level.hostmigrationend))
    level thread[[level.hostmigrationend]]();

  level notify("host_migration_end");
}

_id_97F7() {
  var_0 = getEntArray("destructable", "targetname");

  if(getDvar("scr_destructables") == "0") {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] delete();
  } else {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] thread destructable_think();
  }
}

destructable_think() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self.script_accumulate))
    var_0 = self.script_accumulate;

  if(isDefined(self.script_threshold))
    var_1 = self.script_threshold;

  if(isDefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  var_2 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_3, var_4);

    if(var_3 >= var_1) {
      var_2 = var_2 + var_3;

      if(var_2 >= var_0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  var_0 = self;

  if(isDefined(var_0.fx))
    playFX(var_0.fx, var_0.origin + (0, 0, 6));

  var_0 delete();
}

setupexploders() {
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].script_prefab_exploder))
      var_0[var_2].script_exploder = var_0[var_2].script_prefab_exploder;

    if(isDefined(var_0[var_2].script_exploder)) {
      if(var_0[var_2].model == "fx" && (!isDefined(var_0[var_2].targetname) || var_0[var_2].targetname != "exploderchunk")) {
        var_0[var_2] hide();
        continue;
      }

      if(isDefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploder") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
        continue;
      }

      if(isDefined(var_0[var_2].targetname) && var_0[var_2].targetname == "exploderchunk") {
        var_0[var_2] hide();
        var_0[var_2] notsolid();
      }
    }
  }

  var_3 = [];
  var_4 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isDefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  var_4 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isDefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  var_4 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    if(isDefined(var_4[var_2].script_prefab_exploder))
      var_4[var_2].script_exploder = var_4[var_2].script_prefab_exploder;

    if(isDefined(var_4[var_2].script_exploder))
      var_3[var_3.size] = var_4[var_2];
  }

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  var_5 = [];
  var_5["exploderchunk visible"] = 1;
  var_5["exploderchunk"] = 1;
  var_5["exploder"] = 1;

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_6 = var_3[var_2];
    var_7 = scripts\engine\utility::createexploder(var_6.script_fxid);
    var_7.v = [];
    var_7.v["origin"] = var_6.origin;
    var_7.v["angles"] = var_6.angles;
    var_7.v["delay"] = var_6.script_delay;
    var_7.v["firefx"] = var_6.script_firefx;
    var_7.v["firefxdelay"] = var_6.script_firefxdelay;
    var_7.v["firefxsound"] = var_6.script_firefxsound;
    var_7.v["firefxtimeout"] = var_6._id_ED96;
    var_7.v["earthquake"] = var_6.script_earthquake;
    var_7.v["damage"] = var_6.script_damage;
    var_7.v["damage_radius"] = var_6.script_radius;
    var_7.v["soundalias"] = var_6.script_soundalias;
    var_7.v["repeat"] = var_6.script_repeat;
    var_7.v["delay_min"] = var_6.script_delay_min;
    var_7.v["delay_max"] = var_6.script_delay_max;
    var_7.v["target"] = var_6.target;
    var_7.v["ender"] = var_6.script_ender;
    var_7.v["type"] = "exploder";

    if(!isDefined(var_6.script_fxid))
      var_7.v["fxid"] = "No FX";
    else
      var_7.v["fxid"] = var_6.script_fxid;

    var_7.v["exploder"] = var_6.script_exploder;

    if(!isDefined(var_7.v["delay"]))
      var_7.v["delay"] = 0;

    if(isDefined(var_6.target)) {
      var_8 = getEnt(var_7.v["target"], "targetname").origin;
      var_7.v["angles"] = vectortoangles(var_8 - var_7.v["origin"]);
    }

    if(var_6.classname == "script_brushmodel" || isDefined(var_6.model)) {
      var_7.model = var_6;
      var_7.model.disconnect_paths = var_6.script_disconnectpaths;
    }

    if(isDefined(var_6.targetname) && isDefined(var_5[var_6.targetname]))
      var_7.v["exploder_type"] = var_6.targetname;
    else
      var_7.v["exploder_type"] = "normal";

    var_7 scripts\common\createfx::post_entity_creation_function();
  }
}

_id_9817() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level._id_912F["allies"] = spawnStruct();
  level._id_912F["axis"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level._id_115E4 = 32;
  level._id_115E1 = 14;
  level._id_115E3 = 192;
  level._id_115E2 = 8;
  level._id_115E0 = 1.65;
  level.lowertextyalign = "BOTTOM";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.2;
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay))
      wait(var_0.script_delay);
    else
      wait 4;

    level thread exploder_load(var_0);
    return;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

player_init_health_regen() {
  self.regenspeed = 1;
}

player_init_invulnerability() {
  self.haveinvulnerabilityavailable = 1;
}

player_init_damageshield() {
  self.damageshieldexpiretime = gettime();
}

blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_98BC() {
  self setplayerdata("cp", "alienSession", "team_shots", 0);
  self setplayerdata("cp", "alienSession", "team_kills", 0);
  self setplayerdata("cp", "alienSession", "team_hives", 0);
  self setplayerdata("cp", "alienSession", "downed", 0);
  self setplayerdata("cp", "alienSession", "hivesDestroyed", 0);
  self setplayerdata("cp", "alienSession", "prestigenerfs", 0);
  self setplayerdata("cp", "alienSession", "repairs", 0);
  self setplayerdata("cp", "alienSession", "drillPlants", 0);
  self setplayerdata("cp", "alienSession", "deployables", 0);
  self setplayerdata("cp", "alienSession", "challengesCompleted", 0);
  self setplayerdata("cp", "alienSession", "challengesAttempted", 0);
  self setplayerdata("cp", "alienSession", "trapKills", 0);
  self setplayerdata("cp", "alienSession", "currencyTotal", 0);
  self setplayerdata("cp", "alienSession", "currencySpent", 0);
  self setplayerdata("cp", "alienSession", "kills", 0);
  self setplayerdata("cp", "alienSession", "revives", 0);
  self setplayerdata("cp", "alienSession", "time", 0);
  self setplayerdata("cp", "alienSession", "score", 0);
  self setplayerdata("cp", "alienSession", "shots", 0);
  self setplayerdata("cp", "alienSession", "last_stand_count", 0);
  self setplayerdata("cp", "alienSession", "deaths", 0);
  self setplayerdata("cp", "alienSession", "headShots", 0);
  self setplayerdata("cp", "alienSession", "hits", 0);
  self setplayerdata("cp", "alienSession", "resources", 0);
  self setplayerdata("cp", "alienSession", "waveNum", 0);
}

_id_988E() {
  if(isDefined(level._id_D0FE))
    [[level._id_D0FE]]();
  else
    scripts\cp\cp_laststand::default_player_init_laststand();
}

_id_988B() {
  level._id_A6CB = scripts\engine\utility::getStructArray("respawn_edge", "targetname");
}

_id_7F56() {
  return scripts\engine\utility::getclosest(self.origin, level._id_A6CB);
}
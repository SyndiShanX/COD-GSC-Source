/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5bab271917698dc4.gsc
*************************************************/

#using script_5bab271917698dc4;
#using script_5bc60484d17fa95c;
#using script_64acb6ce534155b7;
#using script_930a1e7bd882c1d;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_rewards;
#using scripts\mp\gametypes\br_skydive_protection;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace namespace_6e6b980bec22af5b;

function br_kioskrevive(squadmate, sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729, var_36f3c4e4a602e257, var_df631fdd92a76bb1, var_b6acf0c07c4311e6) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("kioskRevivePlayer")) {
    squadmate thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("kioskRevivePlayer", sponsor);
    return;
  }

  if(isDefined(var_b6acf0c07c4311e6)) {
    context = var_b6acf0c07c4311e6;
  } else {
    context = "br_kioskRevive";
  }

  squadmate thread scripts\mp\gametypes\br_gulag::playergulagautowin(context, sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729, var_36f3c4e4a602e257, var_df631fdd92a76bb1, var_b6acf0c07c4311e6);
}

function function_d5ee3d3fad992d43(var_a7e165a26e5ba7e9, respawnstruct, var_6ff65a93bb36c6a) {
  player = self;

  if(istrue(level.brgametype.var_6f3c4d74a8c614ab)) {
    player notify("started_spawnPlayer");
  }

  if(isDefined(respawnstruct.preparerespawn)) {
    respawnready = self[[respawnstruct.preparerespawn]](respawnstruct.optparams);

    if(!istrue(respawnready)) {
      return;
    }
  }

  var_1476e0f78320a501 = 0;

  if(istrue(level.brgametype.var_a916b204f027af6b)) {
    var_1476e0f78320a501 = player playerwaitforprestreaming();
  }

  streamtimeout = scripts\mp\gametypes\br_public::getdefaultstreamhinttimeoutms() / 1000;

  if(isDefined(var_6ff65a93bb36c6a)) {
    spawnpoint = var_6ff65a93bb36c6a;
  } else {
    spawnpoint = playergetrespawnpoint(0, streamtimeout);

    if(isDefined(level.br_circle)) {
      circleindex = level.br_circle.circleindex;
      logstring("[br_spawnrespawn] Point chosen: matchTime=" + gettime() / 1000 + " circle=" + circleindex + " spawnType='" + spawnpoint.type + "' timeToSpawn=" + streamtimeout);
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("modifyRespawnPoint")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("modifyRespawnPoint", spawnpoint, streamtimeout);
  }

  if(isDefined(var_6ff65a93bb36c6a)) {
    streamorigin = spawnpoint.origin;
  } else {
    streamorigin = playerprestreamrespawnorigin(spawnpoint);
  }

  self.forcespawnorigin = streamorigin;

  if(isDefined(var_a7e165a26e5ba7e9)) {
    wait var_a7e165a26e5ba7e9;
  }

  if(var_1476e0f78320a501) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }

  player thread function_334a8fe67e88bbe7();
  player thread function_9ceb26b230856d29();
  player scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
  var_b59f471c2c064e56 = 1;
  wait var_b59f471c2c064e56;
  player scripts\mp\hud_message::clearsplashqueue();
  player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  player scripts\cp_mp\execution::_clearexecution();
  player scripts\mp\gametypes\br_pickups::initplayer();
  player.respawningfromtoken = undefined;

  if(isDefined(respawnstruct.var_46ff3a000308206a)) {
    player thread triggerrespawnoverlay(respawnstruct.var_46ff3a000308206a);
  }

  if(isDefined(player)) {
    br_respawn(spawnpoint, streamorigin, respawnstruct);
  }
}

function br_respawn(spawnpoint, streamorigin, respawnstruct) {
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();

  if(issharedfuncdefined("teamAssim", "isEnabled") && [[getsharedfunc("teamAssim", "isEnabled")]]() && issharedfuncdefined("teamAssim", "enablePlayer")) {
    [[getsharedfunc("teamAssim", "enablePlayer")]](self, "player_dead");
  }

  if(issharedfuncdefined("teamAssim", "isEnabled") && [[getsharedfunc("teamAssim", "isEnabled")]]() && issharedfuncdefined("teamAssim", "enablePlayer")) {
    [[getsharedfunc("teamAssim", "enablePlayer")]](self, "br_gulag");
  }

  respawndone = 0;

  if(isDefined(respawnstruct.prerespawn)) {
    respawndone = self[[respawnstruct.prerespawn]](respawnstruct.optparams);
  }

  foreach(crate in level.br_pickups.crates) {
    crate scripts\cp_mp\killstreaks\airdrop::function_c6f053f1952c1fec(self, 1);
  }

  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  scripts\mp\gametypes\br::givelaststandifneeded(self);

  if(isDefined(level.var_e82dd38d666141db)) {
    self[[level.var_e82dd38d666141db]](0);
  }

  if(istrue(respawndone)) {
    return;
  }

  if(!isDefined(spawnpoint)) {
    spawnpoint = playergetrespawnpoint();
  }

  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(streamorigin)) {
    startorigin = streamorigin;
  }

  function_961b4afc4c695b94();
  function_ab31cf673d70f72d(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  function_a593971d75d82113();
  function_379bb555405c16bb("br_spawnrespawn::br_respawn()");
  thread playercleanupentondisconnect(linker);
  waitframe();

  if(getDvar(@ "hash_87485eca39b418a6") == "1" && !isbot(self) && scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587() && !istrue(self.gulag)) {
    scripts\mp\playerlogic::enableoutline();
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(respawnstruct.respawncleanup)) {
    self[[respawnstruct.respawncleanup]](respawnstruct.optparams);
  }

  if(getdvarint(@ "scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  }

  while(getdvarint(@ "hash_e43719f8cb449c07", 0) != 0) {
    waitframe();
  }

  scripts\mp\gametypes\br_public::playerclearstreamhintorigin();

  if(isDefined(streamorigin)) {
    linker.origin = spawnorigin;
  }

  scripts\common\damage_effects::function_a2b4e6088394bade();
  self clearsoundsubmix("iw9_mp_killcam");
  wait 0.5;

  if(isDefined(respawnstruct.respawnsound)) {
    linker playsoundtoplayer(respawnstruct.respawnsound, self);
  }

  wait 1;

  if(!isDefined(self)) {
    return;
  }

  if(!self islinked()) {
    namespace_8bfdb6eb5a3df67a::function_ab31cf673d70f72d(spawnorigin, spawnangles);

    scripts\mp\utility\script::demoforcesre("<dev string:x1c>" + self.name + "<dev string:x27>");
  }

  self unlink();
  self clearclienttriggeraudiozone(1);

  if(scripts\mp\gametypes\br_public::isbrpracticemode()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("solo_cin_igc_music", 2);
  }

  function_6fb380927695ee76(1);
  function_d669022f6cd65402(1);
  falltime = 0;

  if(isDefined(level.parachutedeploydelay)) {
    falltime = level.parachutedeploydelay;
  }

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() && !istrue(self.isjuggernaut)) {
    thread scripts\cp_mp\parachute::startfreefall(falltime, 0, undefined, undefined, 1);
  } else if(istrue(self.isjuggernaut)) {
    self skydive_setbasejumpingstatus(0);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self setclientomnvar("ui_show_spectateHud", -1);
    self setclientomnvar("ui_cash_dropped", 0);
  }

  resetplayermovespeedscale();

  if(isDefined(respawnstruct.var_104e34b87a973660)) {
    thread namespace_8bfdb6eb5a3df67a::triggerrespawnoverlay(respawnstruct.var_104e34b87a973660);
  }

  if(istrue(respawnstruct.var_3bd8653773757c7)) {
    self setclientomnvar("ui_br_transition_type", 0);
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("armor") && !istrue(respawnstruct.optparams.var_ab53d8433a949828)) {
    var_968bd61837a9c038 = function_b3e550fc1ed00cb6();
    respawnreserveplates = getmatchrulesdata("commonOption", "respawnReservePlates");
    scripts\cp_mp\armor::givestartingarmor(var_968bd61837a9c038, undefined, respawnreserveplates);
  }

  namespace_1eb3c4e0e28fac71::onplayerrespawn();
  scripts\mp\gametypes\br_quest_util::onplayerrespawn();
  scripts\mp\gametypes\br_rewards::onplayerrespawn();
  scripts\mp\gametypes\br_supply_drops_common::function_f5d7f1682f6fc578();
  level callback::callback(#"hash_2bdabaeb3b833ac", {
    #player: self
  });

  if(isDefined(respawnstruct.onrespawn)) {
    self[[respawnstruct.onrespawn]](respawnstruct.optparams);
  }

  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread function_e68e4bb4f65f5fe4();
  }

  self notify("respawn_fade_from_black");
  thread scripts\mp\gametypes\br::function_467380e90c7db5a7();
  waitframe();
  linker delete();

  if(istrue(level.var_3ff7c73209fcf59d)) {
    scripts\mp\gametypes\br_skydive_protection::initprotection();
  }

  if(scripts\mp\gametypes\br_public::isbrpracticemode()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(!istrue(level.ignoregulagredeploysplash) && isDefined(respawnstruct.var_4a8a68afccfa6692)) {
    thread scripts\mp\hud_message::showsplash(respawnstruct.var_4a8a68afccfa6692, respawnstruct.var_24fbc5c0da36ef41, undefined, undefined, undefined, respawnstruct.var_748a99415228de0e);
  }

  if(isDefined(respawnstruct.var_dd58a7afdb07f8cd)) {
    scripts\mp\gametypes\br_public::brleaderdialogplayer(respawnstruct.var_dd58a7afdb07f8cd, self, undefined, undefined, 0, undefined, respawnstruct.var_a256bbf96994aad1);
  }

  if(isDefined(respawnstruct.postrespawn)) {
    self[[respawnstruct.postrespawn]](respawnstruct.optparams);
  }

  if(function_7ba31cb6b21c346f()) {
    if(isDefined(respawnstruct.optparams.sponsor) && respawnstruct.optparams.sponsor != self) {
      thread function_36edf91561322753(1);
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onPlayerRespawnDone")) {
    thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onPlayerRespawnDone", self);
  }
}

function function_b3e550fc1ed00cb6() {
  var_968bd61837a9c038 = getmatchrulesdata("commonOption", "respawnArmor");

  if(isDefined(self.overriderespawnarmor)) {
    var_968bd61837a9c038 = self.overriderespawnarmor;
    self.overriderespawnarmor = undefined;
  }

  if(istrue(level.var_75c3b6e138fd717c) && istrue(level.pe_heavyarmor.var_1d15bc0e6aa8b694)) {
    var_968bd61837a9c038 += 50;
  }

  return var_968bd61837a9c038;
}

function function_ade48af7c782e202(cleanupcallback, soundalias, var_3bd8653773757c7) {
  rs = spawnStruct();
  rs.respawncleanup = cleanupcallback;
  rs.respawnsound = soundalias;
  rs.var_3bd8653773757c7 = var_3bd8653773757c7;
  rs.optparams = spawnStruct();
  return rs;
}

function function_9fd565bcd654ed48(var_70611a166496b64f) {
  self.preparerespawn = var_70611a166496b64f;
}

function function_b4c313df5d7fb216(var_423dd9037c2efe0d, var_46ff3a000308206a) {
  self.prerespawn = var_423dd9037c2efe0d;
  self.var_46ff3a000308206a = var_46ff3a000308206a;
}

function function_8cb232cdf47da79c(var_f3255509dc99ae6b, var_104e34b87a973660) {
  self.onrespawn = var_f3255509dc99ae6b;
  self.var_104e34b87a973660 = var_104e34b87a973660;
}

function function_2556973693d6315(var_63eedd53df6143ea, var_4a8a68afccfa6692, var_24fbc5c0da36ef41, var_748a99415228de0e, var_dd58a7afdb07f8cd, var_a256bbf96994aad1) {
  self.postrespawn = ter_op(isDefined(level.brgametype.var_63eedd53df6143ea), level.brgametype.var_63eedd53df6143ea, var_63eedd53df6143ea);
  self.var_4a8a68afccfa6692 = ter_op(isDefined(level.brgametype.var_4a8a68afccfa6692), level.brgametype.var_4a8a68afccfa6692, var_4a8a68afccfa6692);
  self.var_24fbc5c0da36ef41 = ter_op(isDefined(level.brgametype.var_24fbc5c0da36ef41), level.brgametype.var_24fbc5c0da36ef41, var_24fbc5c0da36ef41);
  self.var_748a99415228de0e = ter_op(isDefined(level.brgametype.var_748a99415228de0e), level.brgametype.var_748a99415228de0e, var_748a99415228de0e);
  self.var_dd58a7afdb07f8cd = ter_op(isDefined(level.brgametype.var_dd58a7afdb07f8cd), level.brgametype.var_dd58a7afdb07f8cd, var_dd58a7afdb07f8cd);
  self.var_a256bbf96994aad1 = ter_op(isDefined(level.brgametype.var_a256bbf96994aad1), level.brgametype.var_a256bbf96994aad1, var_a256bbf96994aad1);
}

function playerhandlesponsor(sponsor, tokenused, var_74af5908127b6729, skipoverlay, var_36f3c4e4a602e257, context) {
  player = self;
  var_84e2123aaca9a965 = player;
  var_df2fbb13c226be75 = "token";

  if(isDefined(sponsor)) {
    viprevive = istrue(player.br_iseliminated) && !isalive(player) && istrue(player.wasingulag);
    assert(isPlayer(sponsor));

    if(istrue(var_36f3c4e4a602e257)) {
      assert(istrue(player.gulag) && !isalive(player));
    } else {
      assert(player scripts\mp\gametypes\br_public::iseligibleforteamrevive() || viprevive);
    }

    var_84e2123aaca9a965 = sponsor;
    var_df2fbb13c226be75 = "token_sponsored";
  }

  if(isDefined(sponsor) || istrue(var_74af5908127b6729)) {
    if(!array_contains(level.teamdata[player.team]["alivePlayers"], player)) {
      player scripts\mp\playerlogic::addtoalivecount(context);
    }

    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player, context);
  }

  scripts\mp\gametypes\br_analytics::branalytics_gulagstart(player, var_df2fbb13c226be75);
  scripts\mp\gametypes\br_analytics::branalytics_respawn(self, int(isDefined(sponsor)), context);

  if(istrue(var_84e2123aaca9a965.hasrespawntoken)) {
    var_84e2123aaca9a965 scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  return [var_84e2123aaca9a965, var_df2fbb13c226be75];
}

function playerwaitforprestreaming() {
  player = self;
  var_1476e0f78320a501 = istrue(player.prestreamingspectatetarget);

  if(var_1476e0f78320a501) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar("br_standby_for_respawn");

    while(istrue(player.prestreamingspectatetarget)) {
      waitframe();
    }
  }

  return var_1476e0f78320a501;
}

function playerprestreamrespawnorigin(spawnpoint, timeoutms) {
  droporigin = scripts\mp\gametypes\br_public::playerstreamhintdroptoground(spawnpoint.origin, spawnpoint.height);
  self setpredictedstreamloaddist(0);
  scripts\mp\gametypes\br_public::playerstreamhintlocation(droporigin, timeoutms);
  return droporigin;
}

function function_961b4afc4c695b94() {
  self setallstreamloaddist(0);
}

function function_ab31cf673d70f72d(origin, angles) {
  self cancelmantle();

  if(!isDefined(self.sessionstate) || self.sessionstate != "spectator") {
    scripts\mp\gametypes\br_gametypes::function_d72afaccedfc946e("onPlayerTeleport", self, self.origin, origin, "respawn");
    self setOrigin(origin, 1);
    self setplayerangles(angles);
  }
}

function function_b70d7f3bdddd33fd(testpos) {
  circleready = isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent);

  if(!circleready) {
    return 1;
  }

  if(scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() > 1) {
    return scripts\mp\gametypes\br_circle_util::function_27779e30fe4c0d62(testpos);
  }

  safeorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  saferadius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  dist = distance2d(testpos, safeorigin);
  return dist < saferadius;
}

function function_82ab584ac2a991b7(testpos) {
  circleready = isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent);

  if(!circleready) {
    return 1;
  }

  if(scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() > 1) {
    return scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(testpos);
  }

  dangerorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  dangerradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  dist = distance2d(testpos, dangerorigin);
  return dist < dangerradius;
}

function function_61b5424aa3fe974e(testpos, timeuntilspawn, checkbadcircles) {
  if(!scripts\mp\gametypes\br_c130::ispointinbounds(testpos, 1)) {
    return false;
  }

  if(istrue(checkbadcircles)) {
    if(scripts\mp\gametypes\br_circle::_ispointinbadarea(testpos)) {
      return false;
    }
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent) || !isDefined(level.br_circle.dangercircleent)) {
    return true;
  }

  if(scripts\mp\gametypes\br_circle_util::function_d8fbacc18e5d8498() && scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(testpos)) {
    return true;
  }

  var_d6f728b66bd3966 = scripts\mp\gametypes\br_circle::function_d6f728b66bd3966(level.br_circle.circleindex);

  if(!var_d6f728b66bd3966 && function_b70d7f3bdddd33fd(testpos)) {
    return true;
  }

  if(!function_82ab584ac2a991b7(testpos)) {
    return false;
  }

  if(isDefined(timeuntilspawn)) {
    var_653bf8aef0b21244 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(testpos);

    if(timeuntilspawn > var_653bf8aef0b21244) {
      return false;
    }
  }

  safeorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  saferadius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  dangerorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  dangerradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_a1f3366ddb6d1b0a = length(dangerorigin - safeorigin);
  var_eb45834677a22f12 = vectorNormalize(dangerorigin - safeorigin);
  interppct = level.respawncircleinterppct;
  var_3a7066356862f921 = safeorigin + var_eb45834677a22f12 * var_a1f3366ddb6d1b0a * interppct;
  var_d29771ba9e188f0d = saferadius + (dangerradius - saferadius) * interppct;
  dist = distance2d(testpos, var_3a7066356862f921);
  return dist < var_d29771ba9e188f0d;
}

function isplayervalidrespawntarget(player, timeuntilspawn) {
  if(player == self) {
    return false;
  }

  if(!isalive(player) || player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || istrue(player.br_iseliminated)) {
    return false;
  }

  if(!function_61b5424aa3fe974e(player.origin, timeuntilspawn)) {
    return false;
  }

  return true;
}

function playergetbestrespawnteammate(forcefallback, timeuntilspawn, skipself, skipbot) {
  ignoreplayer = undefined;

  if(istrue(level.onlinegame) && isDefined(self) && self getprivatepartysize()) {
    var_efd570582b503c0f = undefined;

    foreach(fireteammember in self getfireteammembers()) {
      if(istrue(skipbot) && isbot(fireteammember)) {
        continue;
      }

      if(!isplayervalidrespawntarget(fireteammember, timeuntilspawn)) {
        continue;
      }

      var_efd570582b503c0f = fireteammember;

      if(fireteammember isfireteamleader()) {
        break;
      }
    }

    if(isDefined(var_efd570582b503c0f) && istrue(forcefallback)) {
      ignoreplayer = var_efd570582b503c0f;
      var_efd570582b503c0f = undefined;

      foreach(fireteammember in self getfireteammembers()) {
        if(istrue(skipbot) && isbot(fireteammember)) {
          continue;
        }

        if(isDefined(ignoreplayer) && ignoreplayer == fireteammember) {
          continue;
        }

        if(!isplayervalidrespawntarget(fireteammember, timeuntilspawn)) {
          continue;
        }

        var_efd570582b503c0f = fireteammember;

        if(fireteammember isfireteamleader()) {
          break;
        }
      }
    }

    if(isDefined(var_efd570582b503c0f)) {
      return var_efd570582b503c0f;
    }
  }

  if(isDefined(self.lastdeathpos)) {
    var_cd8409952c0be5c8 = undefined;
    closestdist = undefined;
    players = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

    foreach(player in players) {
      if(istrue(skipbot) && isbot(player)) {
        continue;
      }

      if(isDefined(ignoreplayer) && ignoreplayer == player) {
        continue;
      }

      if(!isplayervalidrespawntarget(player, timeuntilspawn)) {
        continue;
      }

      if(player isparachuting() || player isskydiving()) {
        continue;
      }

      var_12810e24e83acb1d = distance2dsquared(self.lastdeathpos, player.origin);

      if(!isDefined(closestdist) || var_12810e24e83acb1d < closestdist) {
        var_cd8409952c0be5c8 = player;
        closestdist = var_12810e24e83acb1d;
      }
    }

    if(isDefined(var_cd8409952c0be5c8) && istrue(forcefallback) && !isDefined(ignoreplayer)) {
      ignoreplayer = var_cd8409952c0be5c8;
      var_cd8409952c0be5c8 = undefined;
      closestdist = undefined;

      foreach(player in players) {
        if(istrue(skipbot) && isbot(player)) {
          continue;
        }

        if(isDefined(ignoreplayer) && ignoreplayer == player) {
          continue;
        }

        if(!isplayervalidrespawntarget(player, timeuntilspawn)) {
          continue;
        }

        if(player isparachuting() || player isskydiving()) {
          continue;
        }

        var_12810e24e83acb1d = distance2dsquared(self.lastdeathpos, player.origin);

        if(!isDefined(closestdist) || var_12810e24e83acb1d < closestdist) {
          var_cd8409952c0be5c8 = player;
          closestdist = var_12810e24e83acb1d;
        }
      }
    }

    if(isDefined(var_cd8409952c0be5c8)) {
      return var_cd8409952c0be5c8;
    }
  }

  var_cd8409952c0be5c8 = undefined;
  var_517e15e5e8524c5a = array_randomize(level.teamdata[self.team]["alivePlayers"]);

  foreach(squadmember in var_517e15e5e8524c5a) {
    if(istrue(skipbot) && isbot(squadmember)) {
      continue;
    }

    if(isDefined(ignoreplayer) && ignoreplayer == squadmember) {
      continue;
    }

    if(!isplayervalidrespawntarget(squadmember, timeuntilspawn)) {
      continue;
    }

    var_cd8409952c0be5c8 = squadmember;

    if(istrue(squadmember scripts\mp\gametypes\br_public::isplayerbrsquadleader())) {
      break;
    }
  }

  if(isDefined(var_cd8409952c0be5c8)) {
    return var_cd8409952c0be5c8;
  } else if(!istrue(skipself)) {
    if(getsubgametype() == "plunder" || getsubgametype() == "risk") {
      teamcount = getteamdata(self.team, "teamCount");

      if(teamcount == 1 && !istrue(self.disconnecting) && !scripts\mp\outofbounds::ispointinoutofbounds(self.origin)) {
        return self;
      }
    }
  }

  return undefined;
}

function function_c3ad6aae08369e12() {
  teammates = level.teamdata[self.team]["players"];

  foreach(squadmember in teammates) {
    if(squadmember == self) {
      continue;
    }

    var_b3070bb45ec5b461 = squadmember.forcespawnorigin;

    if(!isDefined(var_b3070bb45ec5b461)) {
      var_b3070bb45ec5b461 = squadmember.var_f9792c4242dc4625;
    }

    if(!isDefined(var_b3070bb45ec5b461)) {
      continue;
    }

    return var_b3070bb45ec5b461;
  }

  return undefined;
}

function getsafeoriginaroundpoint(point, var_c4000fd1c78d0587, timeuntilspawn, checkbadcircles) {
  const_pi = 3.14159;
  safeorigins = scripts\mp\gametypes\br_circle_util::function_de2f1b656ee04ba9();

  foreach(safeorigin in safeorigins) {
    safetopoint = vectorNormalize(point - safeorigin);
    ang = vectortoangles(safetopoint);
    randomyaw = randomfloatrange(getdvarfloat(@ "hash_83a1498acddbc2fa", 0), getdvarfloat(@ "hash_83c5338ace040d50", 359));

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      dir = safetopoint;
    } else {
      dir = vectorNormalize(anglesToForward(ang + (0, ter_op(cointoss(), randomyaw, randomyaw * -1), 0)));
    }

    origin = point + dir * var_c4000fd1c78d0587;

    if(function_61b5424aa3fe974e(origin, timeuntilspawn, checkbadcircles)) {
      return origin;
    }

    dir *= -1;
    origin = point + dir * var_c4000fd1c78d0587;

    if(function_61b5424aa3fe974e(origin, timeuntilspawn, checkbadcircles)) {
      return origin;
    }

    dir = vectorNormalize(safeorigin - point);
    origin = point + dir * var_c4000fd1c78d0587;

    if(function_61b5424aa3fe974e(origin, timeuntilspawn, checkbadcircles)) {
      return origin;
    }

    arclength = var_c4000fd1c78d0587;
    radius = distance2d(point, safeorigin);
    angle = arclength / radius;

    if(angle > const_pi) {
      angle = const_pi;
    }

    angledeg = angle * 180 / const_pi;
    origin = rotatepointaroundvector((0, 0, 1), point - safeorigin, angledeg) + safeorigin;

    if(function_61b5424aa3fe974e(origin, timeuntilspawn, checkbadcircles)) {
      return origin;
    }

    origin = scripts\mp\gametypes\br_circle::getrandompointincircle(point, var_c4000fd1c78d0587);

    if(function_61b5424aa3fe974e(origin, timeuntilspawn, checkbadcircles)) {
      return origin;
    }
  }

  return undefined;
}

function playergetbestrespawnmissionorigin() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("missions")) {
    return undefined;
  }

  contract = namespace_1eb3c4e0e28fac71::function_22239d4cff05d0a1(self.team);

  if(isDefined(contract)) {
    switch (contract.type.ref) {
      case #"hash_96e641d7fe5b1cf1":
        if(isDefined(contract.targetplayer)) {
          return contract.targetplayer.origin;
        }

        break;
      case #"hash_1cc92bad632fbc15":
        if(isDefined(contract.domflag) && isDefined(contract.domflag.curorigin)) {
          return contract.domflag.curorigin;
        }

        break;
      case #"hash_5c57b61aa79410db":
        if(isDefined(contract.caches) && isDefined(contract.caches[contract.cachescollected])) {
          return contract.caches[contract.cachescollected].origin;
        }

        break;
      case #"hash_218ddcea32fa5fbc":
        if(isDefined(contract.var_9aa953016facacc)) {
          return contract.var_9aa953016facacc.origin;
        }

        break;
      case #"hash_1c8102acfec27e36":
      case #"hash_3684a21686064f80":
      case #"hash_69146251ab5ca13a":
        break;
      case #"hash_4f0e37558d043245":
      case #"hash_7b0c576c4a7e4890":
      case #"hash_7c1fe89be55d7789":
      case #"hash_96815ed47cc355cf":
      case #"hash_bf5597954aaed3d7":
      case #"hash_cc7c1c701864c7bf":
      case #"hash_d0eb8b9de6742b83":
      case #"hash_de61e484b9734ea1":
        break;
      default:
        assertmsg("<dev string:x5a>" + contract.type);
        break;
    }
  }

  return undefined;
}

function playergetbestdropbagorigin(timeuntilspawn) {
  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != self.team) {
      continue;
    }

    if(isDefined(crate.playerscaptured) && isDefined(crate.playerscaptured[self getentitynumber()])) {
      continue;
    }

    if(function_61b5424aa3fe974e(crate.origin, timeuntilspawn)) {
      return crate.origin;
    }
  }
}

function playergetrespawnpoint(forcefallback, timeuntilspawn, overrideheight) {
  spawnorigin = undefined;
  spawnangles = undefined;
  height = overrideheight;
  offsetheight = 1;
  spawntype = "";

  if(isDefined(self.setspawnpoint)) {
    spawnorigin = self.setspawnpoint.playerspawnpos;
    spawnangles = self.setspawnpoint.playerspawnangles;
    spawntype = "setSpawnPoint";
  }

  if(istrue(level.var_a1c4a8da2619c984)) {
    spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    spawnpoint = spawnStruct();
    spawnpoint.origin = random(spawns).origin;
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.height = 0;
    return spawnpoint;
  }

  if(level.var_6bed852a909e4f70 == 1 || level.var_6bed852a909e4f70 == 2) {
    spawnpoint = spawnStruct();
    spawnpoint.origin = level.prematchspawnorigins[0].origin;
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.height = 0;
    return spawnpoint;
  }

  var_f6ac3c609e85cb74 = getdvarfloat(@ "scr_br_respawnmaxlastdeathoffset", -1);

  if(!isDefined(spawnorigin) && var_f6ac3c609e85cb74 >= 0 && isDefined(self.lastdeathpos)) {
    startorigin = getsafeoriginaroundpoint(self.lastdeathpos, var_f6ac3c609e85cb74, timeuntilspawn);

    if(isDefined(startorigin)) {
      spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(startorigin);
      spawnangles = getanglesfacingorigin(spawnorigin, startorigin);
      spawntype = "lastDeath";
    }
  }

  var_f6ac3c609e85cb74 = getdvarfloat(@ "scr_br_respawnmaxteammateoffset", 1000);

  if(!isDefined(spawnorigin) && var_f6ac3c609e85cb74 >= 0) {
    var_b4e45dbe012f4a40 = playergetbestrespawnteammate(forcefallback, timeuntilspawn);

    if(isDefined(var_b4e45dbe012f4a40)) {
      blackscreentime = getdvarfloat(@ "hash_879a2fde5543837", 5) * 1000;
      var_6e6b11a5415dc87 = getdvarfloat(@ "hash_5845ae9020002373", 30) * 1000;
      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if((brgametype == "plunder" || brgametype == "risk" || brgametype == "kingslayer") && isDefined(level.teamdata[self.team]["lastParachuteTime"]) && level.teamdata[self.team]["lastParachuteTime"] + var_6e6b11a5415dc87 > gettime() + blackscreentime && distance2d(level.teamdata[self.team]["lastParachuteOrigin"], var_b4e45dbe012f4a40.origin) < getdvarfloat(@ "scr_br_respawnmaxteammateoffset", 1000) * 1.25) {
        spawnorigin = level.teamdata[self.team]["lastParachuteOrigin"];
        spawnangles = level.teamdata[self.team]["lastParachuteAngles"];
        spawntype = "abovePlayerCached";
      } else {
        checkbadcircles = getdvarint(@ "hash_899e9302a5910263", 1) == 1;
        spawnorigin = getsafeoriginaroundpoint(var_b4e45dbe012f4a40.origin, var_f6ac3c609e85cb74, timeuntilspawn, checkbadcircles);

        if(isDefined(spawnorigin)) {
          spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(spawnorigin);
          spawnangles = getanglesfacingorigin(spawnorigin, var_b4e45dbe012f4a40.origin);
          spawntype = "abovePlayer";
          level.teamdata[self.team]["lastParachuteOrigin"] = spawnorigin;
          level.teamdata[self.team]["lastParachuteAngles"] = spawnangles;
          level.teamdata[self.team]["lastParachuteTime"] = gettime();
        }
      }
    }

    if(!isDefined(spawnorigin) && !scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      teammateorigin = function_c3ad6aae08369e12();

      if(isDefined(teammateorigin)) {
        spawnorigin = getsafeoriginaroundpoint(teammateorigin, var_f6ac3c609e85cb74, timeuntilspawn);

        if(isDefined(spawnorigin)) {
          spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(spawnorigin);
          spawnangles = getanglesfacingorigin(spawnorigin, teammateorigin);
          spawntype = "respawningTeammate";
        }
      }
    }
  }

  var_f6ac3c609e85cb74 = getdvarfloat(@ "hash_721aa1f6148749eb", 3000);

  if(!isDefined(spawnorigin) && var_f6ac3c609e85cb74 >= 0) {
    missionorigin = playergetbestrespawnmissionorigin();

    if(isDefined(missionorigin)) {
      spawnorigin = getsafeoriginaroundpoint(missionorigin, var_f6ac3c609e85cb74, timeuntilspawn);
      spawnangles = getanglesfacingorigin(spawnorigin, missionorigin);
      spawntype = "missionOrigin";
    }
  }

  var_f6ac3c609e85cb74 = getdvarfloat(@ "hash_5243c598e26f304a", 3000);

  if(!isDefined(spawnorigin) && var_f6ac3c609e85cb74 >= 0) {
    crateorigin = playergetbestdropbagorigin(timeuntilspawn);

    if(isDefined(crateorigin)) {
      spawnorigin = getsafeoriginaroundpoint(crateorigin, var_f6ac3c609e85cb74, timeuntilspawn);
      spawnangles = getanglesfacingorigin(spawnorigin, crateorigin);
      spawntype = "dropBagOrigin";
    }
  }

  if(!isDefined(spawnorigin) && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("playerGetRespawnPoint")) {
    spawnorigin = scripts\mp\gametypes\br_gametypes::function_d72afdccedfc9b07("playerGetRespawnPoint", forcefallback, timeuntilspawn, overrideheight);
    spawntype = "brGameTypeFunc";
  }

  if(!isDefined(spawnorigin)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      multicirclemerge = scripts\mp\gametypes\br_circle_util::function_d8fbacc18e5d8498();

      if(getdvarint(@ "hash_89fd9a93b31a5cf2", 0) && !istrue(multicirclemerge)) {
        timeoffset = getdvarfloat(@ "hash_45c8ae384e9d6b92", 2);
        spawnorigin = scripts\mp\gametypes\br_circle::function_bf5f4d7a498988a8(self, timeuntilspawn, timeoffset);
        spawntype = "pointFromSquadmate";
      }

      if(!isDefined(spawnorigin)) {
        maxradiuspct = getdvarfloat(@ "hash_2fc319e6652da3d9", 0.9);

        if(getdvarint(@ "hash_f1d47ddb5b62548b", 1)) {
          spawnorigin = scripts\mp\gametypes\br_circle::function_fc52ae1478a8fc25(maxradiuspct, timeuntilspawn);
          spawntype = "perimeterPointFromSquadmate";
        }

        if(!isDefined(spawnorigin) && getdvarint(@ "hash_ef1ac888d0efeb04", 1)) {
          spawnorigin = scripts\mp\gametypes\br_circle::function_bf16029a7b6ff1fa(maxradiuspct, timeuntilspawn);
          spawntype = "perimeterPointFromLoadout";
        }

        if(isDefined(spawnorigin)) {
          spawnangles = getanglesfacingorigin(scripts\mp\gametypes\br_circle::getsafecircleorigin(), spawnorigin);
          facingangleoffset = 0;

          if(getdvarint(@ "hash_43845157c16d2358", 1)) {
            baseorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
            checkbadcircles = getdvarint(@ "hash_6094db79787dea90", 1) == 1;
            facingangleoffset = -90;
            var_87cef474127de542 = 10;

            if(cointoss()) {
              facingangleoffset = -1 * facingangleoffset;
              var_87cef474127de542 = -1 * var_87cef474127de542;
            }

            testorigin = rotatevector(spawnorigin - baseorigin, (0, var_87cef474127de542, 0)) + baseorigin;

            if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(testorigin, checkbadcircles, timeuntilspawn)) {
              spawnorigin = testorigin;
            } else {
              facingangleoffset = -1 * facingangleoffset;
              var_87cef474127de542 = -1 * var_87cef474127de542;
              testorigin = rotatevector(spawnorigin - baseorigin, (0, var_87cef474127de542, 0)) + baseorigin;

              if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(testorigin, checkbadcircles, timeuntilspawn)) {
                spawnorigin = testorigin;
              } else {
                facingangleoffset = 0;
              }
            }
          }

          yaw = angleclamp(spawnangles[1] + facingangleoffset);
          spawnangles = (0, yaw, 0);
        }
      }

      if(!isDefined(spawnorigin)) {
        origin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        radius = scripts\mp\gametypes\br_circle::getsafecircleradius();

        if(istrue(multicirclemerge)) {
          origin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
          radius = scripts\mp\gametypes\br_circle::getdangercircleradius();
        } else if(!scripts\mp\gametypes\br_circle_util::ispointindangercircle(origin)) {
          origin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        }

        minradiuspct = getdvarfloat(@ "hash_8eb0ced475a9baf1", 0.5);
        maxradiuspct = getdvarfloat(@ "hash_4e9825c71ceb94ff", 0.9);
        droptoground = getdvarint(@ "hash_951c7b13ffdd6905", 1);
        snaptonavmesh = getdvarint(@ "hash_7017ad29dbedc8b1", 1);
        checkbadcircles = getdvarint(@ "hash_7371a5983f296bd6", 1);
        spawnorigin = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(origin, radius, minradiuspct, maxradiuspct, droptoground, snaptonavmesh, checkbadcircles, timeuntilspawn);
        spawntype = "randomPointInBounds";
      }
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.autorespawnwaittime) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.autorespawnwaittime * 1000 > gettime()) {
        spawnorigin = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
        spawntype = "chosenOrigin";
      } else {
        potentialspawnloc = [];

        foreach(struct in level.prematchspawnorigins) {
          if(distance2dsquared(struct.origin, self.origin) > var_f6ac3c609e85cb74) {
            potentialspawnloc[potentialspawnloc.size] = struct;
          }
        }

        if(potentialspawnloc.size == 0) {
          potentialspawnloc = level.prematchspawnorigins;
        }

        potentialspawnloc = array_randomize(potentialspawnloc);
        spawnorigin = potentialspawnloc[0].origin;
        spawnorigin += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        spawntype = "randomPotential";
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = spawnorigin;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      spawnangles = (0, 0, 0);

      if(spawnorigin[2] > 10000) {
        offsetheight = 0;
        height = namespace_81156089ff1fe819::getinfilspawnoffset();
      }
    } else {
      spawnorigin = (0, 0, 0);
      spawnangles = (0, 0, 0);
      spawntype = "zero";
    }
  }

  if(!isDefined(spawnangles)) {
    circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_d097b5e68baa10d1 = vectortoyaw(circleorigin - spawnorigin);
    spawnangles = (0, var_d097b5e68baa10d1, 0);
  }

  if(offsetheight) {
    if(!isDefined(height)) {
      height = scripts\cp_mp\parachute::getc130height();
    }

    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onRespawnScaleHeightOffset")) {
      height *= scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onRespawnScaleHeightOffset");
    }

    if(isDefined(level.var_dc52a11d1ee2690e) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
      height = level.var_dc52a11d1ee2690e;
    }

    if(isDefined(level.respawnheightoverride)) {
      height = level.respawnheightoverride;
    }

    if(istrue(level.var_5b5a1fcd1024eda5) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
      height = function_d6bfa8a9e6d014db(height);
    }

    if(istrue(level.var_5b5a1fcd1024eda5) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
      height = function_d6bfa8a9e6d014db(height);
    }

    dropspawnoffset = (0, 0, height);
    spawnorigin = scripts\mp\gametypes\br::getoffsetspawnorigin(spawnorigin, dropspawnoffset);
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = spawnangles;
  spawnpoint.height = height;
  spawnpoint.type = spawntype;

  if(getdvarint(@ "hash_3055e0f04ccac0e4", 1)) {
    if(scripts\mp\outofbounds::ispointinoutofbounds(spawnpoint.origin)) {
      switch (spawntype) {
        case #"hash_881585932f5309f8":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using setSpawnPoint");
          break;
        case #"hash_92d9b519cc4ed831":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using lastDeath");
          break;
        case #"hash_5ebf5fe3ac8c1009":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayerCached");
          break;
        case #"hash_32dde0b86dfcf603":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayer");
          break;
        case #"hash_ce247261a67b199d":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using respawningTeammate");
          break;
        case #"hash_523f16a1bd5c632b":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using missionOrigin");
          break;
        case #"hash_2407d21162ec8264":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using dropBagOrigin");
          break;
        case #"hash_4866a4440a9d2f4d":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using brGameTypeFunc");
          break;
        case #"hash_9bb2da60407fd710":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using pointFromSquadmate");
          break;
        case #"hash_ee97f72782afbedd":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromSquadmate");
          break;
        case #"hash_fd00b142d0523bb2":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromLoadout");
          break;
        case #"hash_7b5c236dc48a8946":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPointInBounds");
          break;
        case #"hash_36f5ff8a130e852d":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using chosenOrigin");
          break;
        case #"hash_237a346d94c046e4":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPotential");
          break;
        case #"hash_6e4a8ac4007a65c3":
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using zero");
          break;
        default:
          scripts\mp\utility\script::demoforcesre("Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using " + spawntype);
          break;
      }
    }
  }

  return spawnpoint;
}

function getanglesfacingorigin(startorigin, facingorigin) {
  if(isDefined(startorigin) && isDefined(facingorigin)) {
    yawtopoint = vectortoyaw(facingorigin - startorigin);
    angles = (0, yawtopoint, 0);
    return angles;
  }
}

function playercleanupentondisconnect(ent) {
  ent endon("death");
  self waittill("disconnect");

  if(isDefined(ent)) {
    ent delete();
  }
}

function function_d669022f6cd65402(enable) {
  if(enable) {
    self enableoffhandweapons();
    self enableusability();
    return;
  }

  self disableoffhandweapons();
  self disableusability();
}

function triggerrespawnoverlay(overlaytype) {
  self endon("disconnect");
  gametyperesult = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("triggerRespawnOverlay");

  if(istrue(gametyperesult)) {
    return;
  }

  wait 0.5;

  if(function_cfe304859f30e747("gulagGetWinSplashName")) {
    splashname = function_3cceb052d780fef1("gulagGetWinSplashName");
  } else {
    splashname = "br_gulag_winner";
  }

  thread scripts\mp\hud_message::showsplash(splashname);
}

function resetplayermovespeedscale() {
  player = self;
  player.fastcrouchspeedmod = 0;
  player scripts\mp\weapons::updatemovespeedscale();
}

function fadeoutin(fadetime) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(fadetime)) {
    fadetime = 1;
  }

  playercinematicfadein();
  wait fadetime;
  function_e68e4bb4f65f5fe4();
}

function function_334a8fe67e88bbe7(fadespectators) {
  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    function_19e0946144544a19();
  } else {
    playercinematicfadein();
  }

  if(istrue(fadespectators)) {
    function_9e7bd567746e94a1();
  }
}

function function_9ceb26b230856d29() {
  self endon("disconnect");
  self endon("respawn_fade_from_black");
  level waittill("game_ended");
  self setclientomnvar("ui_br_bink_overlay_state", 0);
}

function function_e68e4bb4f65f5fe4() {
  thread playercinematicfadeout();
  function_8375db589e70a6ee();
}

function function_9e7bd567746e94a1() {
  spectators = scripts\mp\gametypes\br_spectate::getspectatorsofplayer(self);

  foreach(spectator in spectators) {
    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      spectator function_19e0946144544a19();
      continue;
    }

    spectator playercinematicfadein();
  }
}

function function_8375db589e70a6ee() {
  spectators = scripts\mp\gametypes\br_spectate::getspectatorsofplayer(self);

  foreach(spectator in spectators) {
    spectator thread playercinematicfadeout();
  }
}

function fadeoutinspectatorsofplayer(fadetime) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(fadetime)) {
    fadetime = 1;
  }

  function_9e7bd567746e94a1();
  wait fadetime;
  function_8375db589e70a6ee();
}

function playeriscinematiclayeron() {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return false;
  }

  var_a143cdb0e0e442c2 = self getclientomnvar("ui_br_bink_overlay_state");

  if(var_a143cdb0e0e442c2 != 0 && var_a143cdb0e0e442c2 != 6) {
    return true;
  }

  return false;
}

function playeriscinematicblacklayeron() {
  var_a143cdb0e0e442c2 = self getclientomnvar("ui_br_bink_overlay_state");
  return isDefined(var_a143cdb0e0e442c2) && var_a143cdb0e0e442c2 == 7;
}

function playercinematicfadein() {
  self setclientomnvar("ui_br_bink_overlay_state", 7);
}

function function_19e0946144544a19() {
  self setclientomnvar("ui_br_bink_overlay_state", 11);
}

function playercinematicfadeout() {
  self endon("disconnect");

  if(playeriscinematiclayeron()) {
    self setclientomnvar("ui_br_bink_overlay_state", 6);
    wait 1;
    self setclientomnvar("ui_br_bink_overlay_state", 0);
  }
}

function plunderplayerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  if(getdvarint(@ "hash_fe3afd6ead4aa523", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  teamcount = getteamdata(self.team, "teamCount");

  if(!istrue(self.squadwiped) || teamcount == 1) {
    var_80365e25f6e3befd = 1;
    wait var_80365e25f6e3befd;
  }

  if(istrue(self.hasrespawntoken) && isDefined(level.tokenrespawnwaittime)) {
    spawnwait = level.tokenrespawnwaittime;
  } else if(level.incrementalrespawnpunish > 0) {
    spawnwait = clamp(self.pers["deaths"] * level.incrementalrespawnpunish, 0, level.incrementalrespawnpunishmax);
  } else if(isDefined(level.autorespawnwaittime)) {
    spawnwait = level.autorespawnwaittime;
  } else {
    spawnwait = getdvarint(@ "hash_5639a8f49b94dacb", 20);
  }

  var_ac5cf023ca77db21 = getdvarfloat(@ "hash_de0dfc4549393ba2", 10);

  if(spawnwait < var_ac5cf023ca77db21) {
    spawnwait = var_ac5cf023ca77db21;
  }

  if(level.respawntimedisable != 0) {
    spawnwait = 0;
  }

  var_e343378b89e661fb = getdvarfloat(@ "hash_cc53a64fa6e4897b", 5);
  ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;

  if(istrue(self.squadwiped) || teamcount == 1) {
    spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
    streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
    thread fadetogearingup(0, teamcount > 1);
    wait var_e343378b89e661fb;
  } else if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + spawnwait * 1000));
    var_a294c35cbb452cbf = spawnwait - var_ac5cf023ca77db21;
    var_d2f5422694822652 = spawnwait - var_a294c35cbb452cbf;
    blackscreenwait = spawnwait - getdvarfloat(@ "hash_879a2fde5543837", 6);
    thread fadetogearingup(blackscreenwait);
    result = waittill_notify_or_timeout_return("squad_wipe_death", var_a294c35cbb452cbf);

    if(result == "squad_wipe_death") {
      spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
      streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
      thread fadetogearingup(0, 1);
      wait var_e343378b89e661fb;
    } else {
      thread updateprestreamrespawn();
      result = waittill_notify_or_timeout_return("squad_wipe_death", var_d2f5422694822652);

      if(result == "squad_wipe_death") {
        spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
        streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
        thread fadetogearingup(0, 1);
        wait var_e343378b89e661fb;
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
  streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);

  if(istrue(self.squadwiped)) {
    self.squadwiped = 0;

    if(teamcount > 1 && !scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
    }
  }

  if(isteamextracted(self.team)) {
    return;
  }

  if(istrue(self.hasrespawntoken)) {
    thread namespace_8bfdb6eb5a3df67a::triggerrespawnoverlay(4);
    self.tokenrespawned = 1;
    scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  if(isteamextracted(self.team)) {
    return;
  }

  if(getdvarint(@ "scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  }

  ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() && isDefined(level.player_respawn_struct)) {
    spawnpoint = getStruct(level.player_respawn_struct, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, spawnpoint, 1, streamorigin, 1);
  scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(self, "plunderPlayerRespawn");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_respawn");
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
}

function fadetogearingup(waittime, squadwiped) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0) {
    wait waittime;
  }

  var_b59f471c2c064e56 = 1;
  thread function_35b4f2460e697a2e();
  wait var_b59f471c2c064e56 - 0.25;

  if(istrue(squadwiped)) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 6);
  } else {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 2);
  }

  wait 0.25;

  if(getdvarint(@ "hash_f006294ef8b720a4", 1) == 1) {
    scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
    spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
    scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
    scripts\mp\gametypes\br::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    ent_flag_set("playerRespawn_intermission_spawned");
  }
}

function function_35b4f2460e697a2e() {
  level endon("game_ended");
  self endon("disconnect");
  namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  self waittill("spawned_player");
  namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
}

function updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  while(true) {
    if(ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
      currenttime = gettime();
      assert(isDefined(self.intermissionspawntime));
      assert(self.intermissionspawntime <= currenttime);

      if(currenttime - self.intermissionspawntime >= getdvarfloat(@ "hash_57fbcc1bae0f210a", 2) * 1000) {
        spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(1);
        streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
      streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1;
  }
}

function setteamasextracted(team) {
  level.teamdata[team]["extracted"] = 1;
}

function isteamextracted(team) {
  return istrue(level.teamdata[team]["extracted"]);
}

function function_d6bfa8a9e6d014db(height) {
  if(istrue(level.var_af67cf91fef6a11c)) {
    return height;
  }

  if(isDefined(level.var_b257658f289a3108)) {
    if(level.var_27506e83d743e391 < 0 || level.br_circle.circleindex < level.var_27506e83d743e391) {
      var_ac61029d6f979867 = level.var_b257658f289a3108 * level.br_circle.circleindex;
      height = function_d986479e0b55e637(height, var_ac61029d6f979867);
    } else {
      var_ac61029d6f979867 = level.var_b257658f289a3108 * level.var_27506e83d743e391;
      height = function_d986479e0b55e637(height, var_ac61029d6f979867);
    }
  }

  return height;
}

function function_d986479e0b55e637(height, var_ac61029d6f979867) {
  if(var_ac61029d6f979867 > 0) {
    var_b68f01b7ca095faf = height * var_ac61029d6f979867;
    height -= var_b68f01b7ca095faf;

    if(height <= level.var_5321a1377f9cc5aa) {
      height = level.var_5321a1377f9cc5aa;
    }
  }

  return height;
}

function function_600cc18a5b7b64b0() {
  tablename = getmatchrulesdata("brData", "respawnLoadoutTable");

  if(tablename == "") {
    return;
  }

  respawnloadouttable = getscriptbundle("respawnloadouttable:" + tablename);

  if(!isDefined(respawnloadouttable)) {
    scripts\mp\utility\script::demoforcesre("Respawn loadout table " + tablename + " does not exist");
    return;
  }

  foreach(respawnloadout in respawnloadouttable.loadoutlist) {
    function_69a7411c700538e3("classtable:" + respawnloadout.table, respawnloadout.circleindex, respawnloadout.var_c6616a0492de643c);
  }
}

function function_69a7411c700538e3(table, circleindex, var_c6616a0492de643c) {
  if(!isDefined(level.respawnloadout)) {
    level.respawnloadout = [];
  }

  newloadoutindex = circleindex;
  var_7d958726e11b327 = scripts\mp\class::function_df2933f96d726d71(table);
  level.respawnloadout[newloadoutindex] = [];

  for(classindex = 0; classindex < var_7d958726e11b327; classindex++) {
    level.respawnloadout[newloadoutindex][level.respawnloadout[newloadoutindex].size] = function_aa8a954d66bf39b4(classindex, table);
  }

  level.var_e1f92a4c781a3039 = [];

  foreach(circleindex, circleloadout in level.respawnloadout) {
    if(isDefined(level.respawnloadout[circleindex]) && level.respawnloadout[circleindex].size > 0) {
      level.var_e1f92a4c781a3039[circleindex] = spawnStruct();
      level.var_e1f92a4c781a3039[circleindex].index = randomintrange(0, level.respawnloadout[circleindex].size);
      level.var_e1f92a4c781a3039[circleindex].var_c6616a0492de643c = var_c6616a0492de643c;
    }
  }
}

function function_aa8a954d66bf39b4(classindex, table) {
  var_cfa6985254954fb3 = scripts\mp\class::function_c7a0b640c398497(table, classindex);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = var_cfa6985254954fb3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = var_cfa6985254954fb3.primaryweapon.attachment1;
  loadout["loadoutPrimaryAttachment2"] = var_cfa6985254954fb3.primaryweapon.attachment2;
  loadout["loadoutPrimaryAttachment3"] = var_cfa6985254954fb3.primaryweapon.attachment3;
  loadout["loadoutPrimaryAttachment4"] = var_cfa6985254954fb3.primaryweapon.attachment4;
  loadout["loadoutPrimaryAttachment5"] = var_cfa6985254954fb3.primaryweapon.attachment5;
  loadout["loadoutPrimaryCamo"] = var_cfa6985254954fb3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = var_cfa6985254954fb3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = var_cfa6985254954fb3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = var_cfa6985254954fb3.secondaryweapon.attachment1;
  loadout["loadoutSecondaryAttachment2"] = var_cfa6985254954fb3.secondaryweapon.attachment2;
  loadout["loadoutSecondaryAttachment3"] = var_cfa6985254954fb3.secondaryweapon.attachment3;
  loadout["loadoutSecondaryAttachment4"] = var_cfa6985254954fb3.secondaryweapon.attachment4;
  loadout["loadoutSecondaryAttachment5"] = var_cfa6985254954fb3.secondaryweapon.attachment5;
  loadout["loadoutSecondaryCamo"] = var_cfa6985254954fb3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = var_cfa6985254954fb3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = var_cfa6985254954fb3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = var_cfa6985254954fb3.equipment.secondary;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [var_cfa6985254954fb3.perks.perk1, var_cfa6985254954fb3.perks.perk2, var_cfa6985254954fb3.perks.perk3, var_cfa6985254954fb3.extraperks.perk1, var_cfa6985254954fb3.extraperks.perk2, var_cfa6985254954fb3.extraperks.perk3];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = classindex;
  return loadout;
}

function function_eee8abc18302f5ef() {
  loadout = level.br_standard_loadout;
  noextraammo = 0;

  if(isDefined(level.respawnloadout)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circleindex = level.br_circle.circleindex;
    }

    if(circleindex > 0 && scripts\mp\gametypes\br_circle::function_fc0f865ddcf551ad()) {
      circleindex -= 1;
    }

    for(index = 0; index <= circleindex; index++) {
      if(isDefined(level.var_e1f92a4c781a3039[index])) {
        loadout = level.respawnloadout[index][level.var_e1f92a4c781a3039[index].index];
        var_a07526bb98bbc752 = level.var_e1f92a4c781a3039[index].var_c6616a0492de643c;
      }
    }
  }

  return [loadout, noextraammo];
}
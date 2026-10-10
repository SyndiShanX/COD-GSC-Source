/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\common.gsc
***********************************************/

#using script_29ec5691a72b84d4;
#using script_2d9d24f7c63ac143;
#using script_3008e3767a2a503c;
#using script_3d3105ba2325c3d6;
#using script_3e09a5630d611fe;
#using script_53da3333b83b3527;
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airdrop_multiple;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\class;
#using scripts\mp\cranked;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\altered_strain;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\cache;
#using scripts\mp\gametypes\countdown;
#using scripts\mp\gametypes\headhunter;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\gametypes\team_gun;
#using scripts\mp\gametypes\trickrtreat;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\lightarmor;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnselection;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\stealth\player;
#namespace common;

function setupcommoncallbacks() {
  level.onnormaldeath = &oncommonnormaldeath;
  level.onsuicidedeath = &oncommonsuicidedeath;
  level.onteamchangedeath = &oncommonteamchangedeath;
  addspecialistdialog();

  if(isusingmatchrulesdata()) {
    level.var_6b6ab19619b97010 = &function_6b6ab19619b97010;
    [[level.var_6b6ab19619b97010]]();
  }

  function_9081e2d33d0b53f9();
  function_e9ad38af5a6bedcd();
  function_8d478840c4e44366();
  function_36532a1506f2c161();
  function_30dd74b21bfffe6();
  function_52343d5c1b190cf0();
  function_1513c3f71e935d73();
  level.spawnprotectionexception = undefined;
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onplayerjointeamcommon);
  registerdogtagsenableddvar(getgametype(), 0);
  level._effect["cranked_explode"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
}

function function_6b6ab19619b97010() {
  setdynamicdvar(@ "scr_game_aiagentsinmp", getmatchrulesdata("commonOption", "aiSpawnOnDeath"));
  setdynamicdvar(@ "scr_game_aispawnondeath", getmatchrulesdata("commonOption", "aiSpawnOnDeath"));
  setdynamicdvar(@ "scr_game_buymode", getmatchrulesdata("commonOption", "buyMode"));
  setdynamicdvar(@ "hash_4e33f79a5437aa5c", getmatchrulesdata("commonOption", "classForceLoadouts"));
  setdynamicdvar(@ "hash_a88f1329561bc6e1", getmatchrulesdata("commonOption", "carePackageDropTime"));
  setdynamicdvar(@ "hash_127490a7577f169f", getmatchrulesdata("commonOption", "tier1ModeEnabled"));
  setdynamicdvar(@ "hash_a2c2c2007177185e", getmatchrulesdata("commonOption", "hardcoreModeOn"));
  setdynamicdvar(@ "hash_58f6ddd5e5892406", getmatchrulesdata("commonOption", "allowCalloutMarkerPing"));
  setdynamicdvar(@ "hash_d20b1b97fdefa92a", getmatchrulesdata("commonOption", "allowCalloutMarkerPing"));

  if(getdvarint(@ "hash_969da081cdd3cead", 0)) {
    setdynamicdvar(@ "scr_game_aiagentsinmp", 1);
    setdynamicdvar(@ "scr_game_aispawnondeath", 0);
  }
}

function private function_1ad07a0f83834639(params) {
  scripts\cp_mp\armor::initarmor(0);
}

function commononstartgametype() {
  level.usepingsystem = getdvarint(@ "hash_58f6ddd5e5892406", 1);

  if(istrue(level.usepingsystem)) {
    scripts\mp\calloutmarkerping_mp::calloutmarkerping_init();
  }

  level callback::add("player_connect", &function_1ad07a0f83834639);
  level scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\cp_mp\armor::givestartingarmor);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&scripts\cp_mp\armor::function_13caa305c839a278);
}

function updatecommongametypedvars() {
  level.dogtagsenabled = dvarintvalue("dogtags", 0, 0, 1);

  if(level.dogtagsenabled) {
    scripts\mp\gametypes\obj_dogtag::init();
  }

  level.var_d11891ea093da336 = getdvarint(@ "hash_999284fe9956d101");

  if(level.var_d11891ea093da336) {
    namespace_b09d1ea3e62b8710::init();
  }

  level.var_642e0047d274650a = getdvarint(@ "scr_cache", 0);

  if(level.var_642e0047d274650a) {
    scripts\mp\gametypes\cache::init();
  }

  if(!istrue(level.var_ec2fb549b15ad827) && !privatematch()) {
    level.var_998f1f31d478a7d5 = getdvarint(@ "scr_countdown");

    if(level.var_998f1f31d478a7d5) {
      if(getgametype() == "ob" || getgametype() == "ob_rift_run") {
        namespace_bc22b8386eb4de80::init();
      } else {
        scripts\mp\gametypes\countdown::init();
      }
    }

    level.var_1feae7506bf96a9c = getdvarint(@ "hash_b3da5c3cd4713168");

    if(level.var_1feae7506bf96a9c) {
      if(getgametype() == "ob" || getgametype() == "ob_rift_run") {
        namespace_53bcac5ffbd6efd0::init();
      } else {
        scripts\mp\gametypes\altered_strain::init();
      }
    }

    if(function_966592fd716d49c7()) {
      if(getgametype() != "ob" && getgametype() != "ob_rift_run") {
        scripts\mp\gametypes\trickrtreat::init();
      } else {
        namespace_16ea2abb1525b83a::init();
      }
    }
  }

  level.headhunterenabled = getdvarint(@ "hash_6ce81dfbd7b97537");

  if(level.headhunterenabled) {
    scripts\mp\gametypes\headhunter::init();
  }

  level.mtxkillthresholdstage1 = dvarintvalue("mtxKillThresholdStage1", 10, 1, 20);
  level.mtxkillthresholdstage2 = dvarintvalue("mtxKillThresholdStage2", 20, 1, 20);
  assertex(level.mtxkillthresholdstage1 < level.mtxkillthresholdstage2, "<dev string:x1c>");
}

function oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  score = 0;

  if(isbot(self) && isDefined(self.isbotmedicrole)) {
    self.isbotmedicrole = undefined;
  }

  if(istrue(level.flashpointactive) && isDefined(attacker) && isDefined(attacker.team)) {
    scripts\mp\flashpoint::flashpoint_processnewevent(attacker, victim, gettime(), "kill_by_" + attacker.team);
  }

  if(isDefined(attacker.damagetrigger) && isDefined(attacker.damagetrigger.objweapon) && attacker.damagetrigger.objweapon.basename == "iw9_racecar_mp") {
    return 1;
  }

  var_e67514ba22eec9cb = islaststandenabled() && istrue(victim.playergoingintols);

  if(!var_e67514ba22eec9cb && isDefined(attacker.team) && attacker.team != self.team) {
    var_605b9986ce6166a1 = level.scoremod["death"] * -1;

    if(var_605b9986ce6166a1 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::giveteamscoreforobjective(victim.pers["team"], var_605b9986ce6166a1, 0);
      } else {
        attacker scripts\mp\gamescore::giveplayerscore(#"kill", var_605b9986ce6166a1);
      }
    }

    score = level.scoremod["kill"];

    if(istrue(iskillstreakweapon)) {
      score += level.scoremod["kskill"];
    }

    if(meansofdeath == "MOD_HEAD_SHOT") {
      score += level.scoremod["headshot"];
    }

    if(level.dogtagsenabled && gameflag("prematch_done")) {
      level thread scripts\mp\gametypes\obj_dogtag::spawndogtags(victim, attacker, "new_tag_spawned", meansofdeath);
    }

    if(level.var_642e0047d274650a && gameflag("prematch_done")) {
      level thread scripts\mp\gametypes\cache::function_9e0ae8b3ac9a190f(victim, attacker, "new_cache_spawned", meansofdeath);
    }
  }

  if(isDefined(attacker.team) && attacker.team != self.team || !istrue(level.teambased) && attacker != self) {
    if((istrue(level.var_998f1f31d478a7d5) || istrue(level.var_1feae7506bf96a9c) || function_966592fd716d49c7()) && gameflag("prematch_done")) {
      if(getgametype() != "ob" && getgametype() != "ob_rift_run") {
        level thread scripts\mp\gametypes\countdown::function_7502f58e600e74a2(victim, attacker, "new_loot_item_spawned", meansofdeath);
      }
    }
  }

  if(level.gametype != "havoc" && (function_f698bfd3efa33302() || function_e9f3a160bbefe208(attacker) || function_e9f3a160bbefe208(victim))) {
    if(matchmakinggame() && isDefined(attacker.cranked)) {
      if(!var_e67514ba22eec9cb && score != 0) {
        score += 1;
        attacker thread scripts\mp\rank::scoreeventpopup(hashcat(#"hash_2c8bcbb02ec7ff9b", score));
      }
    }

    attacker scripts\mp\cranked::oncranked(victim, attacker, lifeid);
  }

  if(function_c1cddd7ae3bc2698()) {
    ismeleeweapon = isriotshield(objweapon.basename);
    isknife = isknifeonly(objweapon.basename) || isakimbomeleeweapon(objweapon.basename) || isaxeweapon(objweapon.basename) || ismeleeoverrideweapon(objweapon);
    isexecution = isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION";

    if(isexecution || meansofdeath == "MOD_MELEE" && isknife) {
      score = 0;
      victimteamscore = getteamscore(victim.pers["team"]);

      if(victimteamscore > 0 && !(victimteamscore % level.var_ff35df662c18a63d == 0)) {
        victim scripts\mp\utility\stats::incpersstat("setbacks", 1);
        victim scripts\mp\persistence::statsetchild("round", "setbacks", victim.pers["setbacks"]);
        victim scripts\mp\utility\stats::setextrascore1(victim.pers["setbacks"]);
        level scripts\mp\gamescore::giveteamscoreforobjective(victim.pers["team"], -1, 0);
      }
    }
  }

  if(level.gametype == "war" && getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    headsize = victim getclientomnvar("ui_voxel_head_size");
    score *= headsize;
  }

  if(score != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    } else {
      attacker scripts\mp\gamescore::giveplayerscore(#"kill", score, victim);
    }
  }

  var_f4143542f608e034 = 1;

  if(isDefined(level.var_5df506226294aa65)) {
    level thread[[level.var_5df506226294aa65]](victim, attacker);
  }

  if(istrue(level.droparmorondeath)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    victim scripts\mp\gametypes\br_pickups::dropbrhealthpack(dropstruct);
  }

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19() && getdvarint(@ "hash_6ce02fdc43b4f5cf", 0) != 0) {
    victim spawnhealthpickup();
  }

  if(isPlayer(attacker) && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    killfeeddata = meansofdeath == "MOD_HEAD_SHOT";
    killfeeddata += level.scoremod["kill"] << 4;
    attacker function_417749e099f041f(killfeeddata, victim getentitynumber());
  }
}

function oncommonsuicidedeath(victim) {
  if(function_f698bfd3efa33302() || function_e9f3a160bbefe208(victim)) {
    victim scripts\mp\cranked::cleanupcrankedplayertimer();
  }

  if(isDefined(level.scoremod)) {
    var_605b9986ce6166a1 = level.scoremod["death"] * -1;

    if(var_605b9986ce6166a1 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::giveteamscoreforobjective(victim.pers["team"], var_605b9986ce6166a1, 0);
      }
    }
  }

  if(isDefined(level.modeonsuicidedeath)) {
    [[level.modeonsuicidedeath]](victim);
  }
}

function oncommonteamchangedeath(victim) {
  if(function_f698bfd3efa33302() || function_e9f3a160bbefe208(victim)) {
    victim scripts\mp\cranked::cleanupcrankedplayertimer();
  }

  if(isDefined(level.modeonteamchangedeath)) {
    [[level.modeonteamchangedeath]](victim);
  }
}

function dogtagcommonallyonusecb(player) {}

function dogtagcommonenemyonusecb(player) {}

function onspawnplayercommon(revivespawn) {
  if(istrue(game["inLiveLobby"])) {
    var_949548949727d77e = istrue(level.allowprematchdamage) && istrue(level.spawnprotectiontimer);
    thread managespawnprotection(var_949548949727d77e);
  } else if(istrue(level.spawnprotectiontimer) && !istrue(revivespawn)) {
    if(isDefined(level.spawnprotectionexception)) {
      if([[level.spawnprotectionexception]]()) {
        thread managespawnprotection(1);
      }
    } else {
      thread managespawnprotection(1);
    }
  }

  if(isteamreviveenabled()) {
    thread scripts\mp\teamrevive::updaterevivetriggerspawnposition();
  }

  if(istrue(level.disablesupersprint)) {
    self allowsupersprint(0);
  }

  if(istrue(level.disablemount)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  if(scripts\mp\utility\perk::function_d327b07e25d475e1()) {
    scripts\mp\hud_message::showsplash("equipped_perks_mp");
  }

  if(isDefined(level.modeonspawnplayer)) {
    [[level.modeonspawnplayer]](revivespawn);
  } else {
    thread updatematchstatushintonspawncommon();
  }

  if(getgametypenumlives() != 0) {
    updatealiveomnvars();
  }

  if(istrue(game["practiceRound"])) {
    if(istrue(level.snowballfight)) {
      thread snowballfighthint();
    } else {
      self sethudtutorialmessage("MP_INGAME_ONLY/PRACTICE_ROUND", 1);
    }
  } else if(!isagent(self)) {
    self clearhudtutorialmessage();
  }

  if(isDefined(level.elevatoronspawnplayer)) {
    self[[level.elevatoronspawnplayer]]();
  }
}

function nvghintnotify(var_e9def77708d779b7) {
  self endon("disconnect");
  self notify("nvg_spawn_tutorial");
  self endon("nvg_spawn_tutorial");
  firstspawn = 1;

  if(!isDefined(var_e9def77708d779b7)) {
    var_e9def77708d779b7 = 0;
  }

  while(true) {
    if(firstspawn) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    if(var_e9def77708d779b7 < 2) {
      if(self usinggamepad()) {
        msg = "hint_use_nvg";
      } else {
        msg = "hint_use_nvg_kb";
      }

      if(gameflag("infil_will_run") && !gameflag("prematch_done")) {
        level waittill("prematch_done");
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(msg);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      } else {
        if(!var_e9def77708d779b7) {
          wait 5;
        }

        scripts\mp\utility\lower_message::setlowermessageomnvar(msg);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      }

      var_e9def77708d779b7++;
      continue;
    }

    break;
  }
}

function function_72646e9a09d68970() {
  if(self iscodcaster()) {
    return;
  }

  achievementid = getdvarint(@ "hash_7b6a932574c43db8", 0);
  self function_86af48e06c94360a(achievementid);
}

function function_59a736fffddc7c05(achievementid, progressdata) {
  var_cf4e298f83ea9b6f = getdvarint(@ "hash_7b6a932574c43db8", 0);
  trialtimelimit = getdvarint(@ "hash_a82da6c4bfc1360a", 9000);

  if(achievementid == var_cf4e298f83ea9b6f) {
    var_4ca632f1f2a8af51 = scripts\cp_mp\playerachievements::function_691880160b33d133("progress");
    progress = 0;

    for(index = 0; index < progressdata.progress_values.size; index++) {
      progress_id = progressdata.progress_values[index].progress_id;

      if(var_4ca632f1f2a8af51 == progress_id) {
        progress = progressdata.progress_values[index].progress;
        break;
      }
    }

    println("<dev string:x5c>" + self.name + "<dev string:x99>" + achievementid + "<dev string:xa6>" + progress);

    if(progress >= trialtimelimit) {
      kick(self getentitynumber(), "EXE/PLAYERKICKED", 1);
    }
  }
}

function onplayerkilledcommon(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid, iskillstreakweapon) {
  if(getgametypenumlives() != 0) {
    updatealiveomnvars();
  }

  if(isDefined(level.onplayerkilled)) {
    [[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
  }

  if(isDefined(level.var_9abca503637351b3)) {
    [[level.var_9abca503637351b3]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
  }

  if(function_2009718b681222c2()) {
    if(isbot(self)) {
      self.classcallback = "gamemode";
    }
  }
}

function onplayerconnectcommon() {
  while(true) {
    level waittill("connected", player);

    if(isDefined(level.onplayerconnect)) {
      level thread[[level.onplayerconnect]](player);
    }

    if(istrue(level.droparmorondeath)) {
      player.var_d2dbb2fa012e6d9c = [];
    }

    if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
      player thread function_9baeafa29fcf15f9();
    }

    if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4() && !namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
      player thread nvghintnotify();
    }

    if(function_2009718b681222c2()) {
      level.denyclasschoice = 1;
      player scripts\mp\class::function_a16868d4dcd81a4b();
      player.pers["gamemodeLoadout"] = game["forceRandomLoadout"][game["forceRandomLoadoutIndex"]];
    }

    if(istrue(level.usepingsystem)) {
      player scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();
    }

    if(isDefined(player) && utility::function_a10967d736dc56e5()) {
      level thread function_70c67fa95f4222c1(player);
    }

    if(!player function_1cb874dfc01de80d()) {
      if(getdvarint(@ "hash_7b6a932574c43db8", 0) != 0) {
        println("<dev string:xb5>" + self.name);
        player function_72646e9a09d68970();
      }
    }
  }
}

function function_70c67fa95f4222c1(player) {
  player endon("disconnect");

  if(!isDefined(level.difficultytype)) {
    level scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  }

  player.gameskill = namespace_310bdaa3cf041c47::get_gameskill();
  player namespace_310bdaa3cf041c47::set_difficulty_from_locked_settings();
  player.owner = undefined;
  flag_wait("level_stealth_initialized");

  while(!isDefined(player.team)) {
    waitframe();
  }

  player scripts\stealth\player::main();
}

function onplayerdisconnectcommon(player) {
  if(getgametypenumlives() != 0) {
    player updatealiveomnvars();
  }

  if(isDefined(level.onplayerdisconnect)) {
    player thread[[level.onplayerdisconnect]](player);
  }
}

function onplayerjointeamcommon(player) {
  if(isDefined(level.onplayerjointeam)) {
    [[level.onplayerjointeam]](self);
  }

  if(istrue(level.dogtagsenabled)) {
    scripts\mp\gametypes\obj_dogtag::onplayerjoinedteam(player);
  }

  if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    player thread nvghintnotify(1);
  }
}

function managespawnprotection(usetimer) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_spawn_protection");
  thread applyspawnprotection();

  if(!istrue(level.allowprematchdamage)) {
    gameflagwait("prematch_done");
  }

  if(usetimer) {
    wait level.spawnprotectiontimer;
  }

  thread removespawnprotection();
}

function applyspawnprotection() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  self waittill("spawned_player");
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
}

function removespawnprotection() {
  self endon("disconnect");

  if(isDefined(self)) {
    self.spawnprotection = 0;
  }

  scripts\mp\lightarmor::lightarmor_unset(self);
  self notify("remove_spawn_protection");
}

function updatealiveomnvars() {
  if(isDefined(level.updatealiveomnvars)) {
    self[[level.updatealiveomnvars]]();
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    totalalivecount = 0;
    totalplayers = 0;

    foreach(entry in level.teamnamelist) {
      totalalivecount += getteamdata(entry, "aliveCount");
      totalplayers += getteamcount(entry);
    }

    setomnvar("ui_allies_alive", 0);
    setomnvar("ui_axis_alive", totalalivecount);
    setomnvar("ui_allies_team_size", 0);
    setomnvar("ui_axis_team_size", totalplayers);
    return;
  }

  setomnvar("ui_allies_alive", getteamdata("allies", "aliveCount"));
  setomnvar("ui_axis_alive", getteamdata("axis", "aliveCount"));
  setomnvar("ui_allies_team_size", getteamcount("allies"));
  setomnvar("ui_axis_team_size", getteamcount("axis"));
}

function updatematchstatushintonspawncommon() {
  level endon("game_ended");
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
}

function ffmessageonspawn() {
  wait 1;

  if(isDefined(self)) {
    scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
  }
}

function addspecialistdialog() {
  game["dialog"]["specialty_warhead"] = "perk_amped";
  game["dialog"]["specialty_tac_resist"] = "perk_amped";
  game["dialog"]["specialty_covert_ops"] = "perk_coldblooded";
  game["dialog"]["specialty_hustle"] = "perk_doubletime";
  game["dialog"]["specialty_eod"] = "perk_eod";
  game["dialog"]["specialty_guerrilla"] = "perk_ghost";
  game["dialog"]["specialty_surveillance"] = "perk_highalert";
  game["dialog"]["specialty_heavy_metal"] = "perk_killchain";
  game["dialog"]["specialty_munitions_2"] = "perk_overkill";
  game["dialog"]["specialty_strategist"] = "perk_pointman";
  game["dialog"]["specialty_quick_fix"] = "perk_quickfix";
  game["dialog"]["specialty_restock"] = "perk_restock";
  game["dialog"]["specialty_scavenger_plus"] = "perk_scavenger";
  game["dialog"]["specialty_extra_shrapnel"] = "perk_shrapnel";
  game["dialog"]["specialty_specialist_bonus"] = "perk_specialistbonus";
  game["dialog"]["specialty_tactical_recon"] = "perk_spotter";
  game["dialog"]["specialty_huntmaster"] = "perk_tracker";
  game["dialog"]["specialty_tune_up"] = "perk_tuneup";
}

function function_e9ad38af5a6bedcd() {
  if(getdvarint(@ "scr_game_buymode", 0) == 1) {
    function_88b47710bece931f();
  }
}

function function_88b47710bece931f() {
  function_fdc32b02a967aa99();
  setomnvar("ui_buy_mode", 1);
  level.var_9cdaadfddeda4d7a = 1;
  level.var_8ec1a1ca587a6487 = &function_8ec1a1ca587a6487;
  level.noinventory = 1;
  level.br_plunder_enabled = 1;
  level.var_1e17e3480b1d264d = 1;
  level.armoronweaponswitchlongpress = 1;
  setDvar(@ "hash_ed6e4ffa933af621", 1);
  setDvar(@ "scr_game_allow_loot", 1);

  setDvar(@ "scr_player_allowarmor", 1);

  setDvar(@ "loot_table_name", "mp/loot/br/default/loot_item_defs.csv");
  setDvar(@ "loot_table_zones", " mp/loot/core/risk/loot_table_zones.csv");
  setDvar(@ "bg_piggybackarmoronnvg", 1);
  scripts\mp\gametypes\br_armory_kiosk::function_b38f5ffe645943c3("core");

  if(level.var_1e17e3480b1d264d) {
    level.var_9c1e3c18b99409e9 = &function_9c1e3c18b99409e9;
  }

  level thread function_d05c9bf671a28d2d();
  level thread function_88822b4598ff1773();

  level thread function_697ba36fc0e3cde4();
}

function function_d05c9bf671a28d2d() {
  waitframe();
  level scripts\common\ui::lui_registercallback("buy_menu_open", &scripts\mp\gametypes\br_armory_kiosk::armorykioskused);
  level scripts\common\ui::lui_registercallback("buy_menu_close", &function_cd2db96ca42742e6);
  scripts\mp\gametypes\br_armory_kiosk::init();
  level.var_8e9daba162280a8e = 1;
  level.var_6beff7b631ab7e18 = &function_6beff7b631ab7e18;
}

function private function_cd2db96ca42742e6(value) {
  self notify("buy_menu_close");
}

function function_fdc32b02a967aa99() {
  var_4d43eb408252daa0 = [];
  var_4d43eb408252daa0[var_4d43eb408252daa0.size] = getEnt("cyber_empzone_axis", "targetname");
  var_4d43eb408252daa0[var_4d43eb408252daa0.size] = getEnt("cyber_empzone_allies", "targetname");
  var_58553518a66cebe9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in var_58553518a66cebe9) {
    var_4d43eb408252daa0[var_4d43eb408252daa0.size] = trig;
  }

  if(var_4d43eb408252daa0.size == 0) {
    primaryflags = getEntArray("flag_primary", "targetname");

    foreach(flag in primaryflags) {
      var_4d43eb408252daa0[var_4d43eb408252daa0.size] = flag;
      break;
    }
  }

  var_c9050c643d9fceac = [];

  foreach(temp in var_4d43eb408252daa0) {
    newtemp = spawnStruct();
    newtemp.origin = temp.origin;
    newtemp.angles = temp.angles;
    var_c9050c643d9fceac[var_c9050c643d9fceac.size] = newtemp;
  }

  level thread function_bdc6d23a3189ec1f(var_c9050c643d9fceac);
}

function function_bdc6d23a3189ec1f(var_baaf67a759d54315) {
  waitframe();
  level.buystations = [];
  radiantstations = getStructArray("buystation_loc", "targetname");

  foreach(loc in radiantstations) {
    radiantstations[radiantstations.size] = radiantstations;
  }

  if(radiantstations.size > 0) {
    var_baaf67a759d54315 = radiantstations;
  }

  tracecontents = scripts\engine\trace::create_default_contents(1);

  foreach(loc in var_baaf67a759d54315) {
    if(radiantstations.size == 0) {
      groundorigin = drop_to_ground(loc.origin + anglesToForward(loc.angles) * 50, 50, -200, undefined, tracecontents);
      spawnangles = loc.angles;
    } else {
      groundorigin = loc.origin;
      spawnangles = loc.angles;
    }

    buystation = spawnscriptable("br_plunder_box", groundorigin, spawnangles);
    buystation setscriptablepartstate("br_plunder_box", "visible");
    buystation.var_5cfa621ebf61d8aa = 0;
    level.buystations[level.buystations.size] = buystation;
  }
}

function function_88822b4598ff1773() {
  level.var_68a1353068460d1 = &scripts\mp\cranked::function_68a1353068460d1;
  waitframe();

  if(level.crankedbombtimer == 0) {
    level.crankedbombtimer = 30;
  }
}

function function_d19636a80151b35d(squadindex) {
  player = self;
  player.br_squadindex = squadindex;
  newextrainfo = player.game_extrainfo & 65528;
  newextrainfo |= squadindex;
  player.game_extrainfo = newextrainfo;
  player setclientomnvar("ui_client_squad_index", 1);
}

function function_6beff7b631ab7e18(instance, player) {
  if(isint(instance)) {
    instance = player;
    instance.var_5cfa621ebf61d8aa = 0;
    instance.objectivekey = "_a";
  }

  if(istrue(instance.var_5cfa621ebf61d8aa) || istrue(level.var_8e9daba162280a8e)) {
    player setclientomnvar("ui_buystation_override", scripts\cp_mp\utility\loot::function_54b046aa3ba2678a("core"));
  }
}

function function_8ec1a1ca587a6487(itemref) {
  switch (itemref) {
    case #"hash_25789111b74943b4":
    case #"hash_43f2312fe01322cf":
      self.pers["armor_buy_plates"]++;
      break;
    case #"hash_a7a7446a3194cb49":
      if(isreallyalive(self)) {
        if(isDefined(self.armorhealth) && self.armorhealth < self.maxarmorhealth) {
          scripts\cp_mp\armor::setarmorhealth(int(clamp(self.armorhealth + level.var_4b78859bacc88808, 0, self.maxarmorhealth)));
        }
      } else {
        self.pers["armor_buy_plates_instant"]++;
        thread scripts\cp_mp\armor::function_4f88731347251184();
      }
    default:
      break;
  }
}

function function_9baeafa29fcf15f9() {
  scripts\cp_mp\cash::function_6da8b65579348d0b();
  function_d19636a80151b35d(1);

  if(!isDefined(self.pers["armor_buy_plates"])) {
    self.pers["armor_buy_plates"] = 0;
    self.pers["armor_buy_plates_instant"] = 0;
  }
}

function function_697ba36fc0e3cde4() {
  setdevdvarifuninitialized(@ "hash_1ede0bb893291602", 0);

  while(true) {
    if(getdvarint(@ "hash_1ede0bb893291602", 0) > 0) {
      foreach(player in level.players) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(getdvarint(@ "hash_1ede0bb893291602", 0), undefined, 1);
      }
    }

    setdevdvar(@ "hash_1ede0bb893291602", 0);
    wait 1;
  }
}

function function_8d478840c4e44366() {
  level.var_726494df62567093 = ter_op(getdvarint(@ "hash_4e33f79a5437aa5c", 0) > 0, getdvarint(@ "hash_4e33f79a5437aa5c", 0), undefined);

  if(function_2009718b681222c2()) {
    level thread function_5e789e0461bc3a69();
  }
}

function function_2009718b681222c2() {
  return isDefined(level.var_726494df62567093) && level.var_726494df62567093 > 0;
}

function function_5e789e0461bc3a69() {
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  level.bots_gametype_handles_class_choice = 1;
  waitframe();
  thread function_943a60c848e07e13();
  function_9ef19af8915ebb2();
}

function function_943a60c848e07e13() {
  if(getdvarint(@ "hash_b665ceb14dabc0ed", -1) != -1) {
    function_be8c4476e2e599f();
    game["<dev string:xf3>"] = 0;
    return;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(game["roundsPlayed"] == 0) {
    if(istrue(game["practiceRound"])) {
      function_be8c4476e2e599f();
      game["forceRandomLoadoutIndex"] = 0;
    } else if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
      if(istrue(game["didSnowFight"])) {
        game["didSnowFight"] = undefined;
      }

      function_be8c4476e2e599f();
      game["forceRandomLoadoutIndex"] = 0;
    }

    return;
  }

  level.loadoutchangeround = level.var_726494df62567093;

  if(level.loadoutchangeround != 0) {
    if(game["roundsPlayed"] % level.loadoutchangeround == 0) {
      game["forceRandomLoadoutIndex"]++;
    }

    if(game["forceRandomLoadoutIndex"] == game["forceRandomLoadout"].size) {
      game["forceRandomLoadoutIndex"] = 0;
    }

    return;
  }

  game["forceRandomLoadoutIndex"] = 0;
}

function function_be8c4476e2e599f() {
  game["forceRandomLoadout"] = [];
  loadouts = [];
  classidx = 0;
  table = "classtable:classtable_force_loadouts";

  if(getdvarint(@ "hash_b665ceb14dabc0ed", -1) != -1) {
    classidx = getdvarint(@ "hash_b665ceb14dabc0ed", 0);
    loadouts[loadouts.size] = function_e2302479ca960e45(table, classidx);
    game["<dev string:x10e>"] = array_randomize(loadouts);
    return;
  }

  numloadouts = scripts\mp\class::function_df2933f96d726d71(table);

  while(classidx < numloadouts) {
    loadouts[loadouts.size] = function_e2302479ca960e45(table, classidx);
    classidx++;
  }

  overrideweapons = undefined;
  overridechance = undefined;
  var_7ea3494e3da2fba5 = getDvar(@ "hash_76bc70aac09a0054", "");
  var_8831b759b9f84be1 = getdvarfloat(@ "hash_680f5c2690e8d15f", 0);

  if(var_7ea3494e3da2fba5 != "" && var_8831b759b9f84be1 > 0) {
    weapontokens = strtok(var_7ea3494e3da2fba5, ",");

    foreach(variantkey in weapontokens) {
      var_94b8da0083dae53 = strtok(variantkey, "|");

      if(var_94b8da0083dae53.size == 2) {
        rootweapon = var_94b8da0083dae53[0];
        variantid = int(var_94b8da0083dae53[1]);
        validweapon = weaponisValid(rootweapon, variantid);
        assertex(validweapon, "<dev string:x124>" + variantkey);

        if(validweapon) {
          if(!isDefined(overrideweapons)) {
            overrideweapons = [];
            overridechance = var_8831b759b9f84be1;
          }

          struct = spawnStruct();
          struct.rootweapon = rootweapon;
          struct.variantid = variantid;
          overrideweapons[overrideweapons.size] = struct;
        }
      }
    }
  }

  loadouts = function_a8fc18df76d1aa2f(loadouts, 99, overrideweapons, overridechance);
  game["forceRandomLoadout"] = array_randomize(loadouts);
}

function function_e2302479ca960e45(table, classindex) {
  loadoutarray = [];
  loadoutarray["loadoutArchetype"] = "archetype_assault";
  loadoutarray["loadoutPrimaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, classindex, 0);
  loadoutarray["loadoutPrimary"] = scripts\mp\class::table_getweapon(table, classindex, 0);

  for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxprimaryattachments(); attachmentindex++) {
    attachstring = scripts\mp\class::getattachmentloadoutstring(attachmentindex, #"primary");
    loadoutarray[attachstring] = scripts\mp\class::table_getweaponattachment(table, classindex, 0, attachmentindex);
  }

  loadoutarray["loadoutPrimaryCamo"] = scripts\mp\class::table_getweaponcamo(table, classindex, 0);
  loadoutarray["loadoutPrimaryReticle"] = scripts\mp\class::table_getweaponreticle(table, classindex, 0);
  loadoutarray["loadoutPrimaryVariantID"] = 0;
  loadoutarray["loadoutSecondaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, classindex, 1);
  loadoutarray["loadoutSecondary"] = scripts\mp\class::table_getweapon(table, classindex, 1);

  for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxsecondaryattachments(); attachmentindex++) {
    attachstring = scripts\mp\class::getattachmentloadoutstring(attachmentindex, #"secondary");
    loadoutarray[attachstring] = scripts\mp\class::table_getweaponattachment(table, classindex, 1, attachmentindex);
  }

  if(istrue(level.specialdayloadouts)) {
    loadoutarray["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, classindex, 1);
  } else {
    loadoutarray["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, classindex, 1);
  }

  loadoutarray["loadoutSecondaryReticle"] = scripts\mp\class::table_getweaponreticle(table, classindex, 1);
  loadoutarray["loadoutSecondaryVariantID"] = 0;
  loadoutarray["loadoutEquipmentPrimary"] = scripts\mp\class::table_getequipmentprimary(table, classindex);
  loadoutarray["loadoutExtraEquipmentPrimary"] = scripts\mp\class::table_getextraequipmentprimary(table, classindex);
  loadoutarray["loadoutEquipmentSecondary"] = scripts\mp\class::table_getequipmentsecondary(table, classindex);
  loadoutarray["loadoutExtraEquipmentSecondary"] = scripts\mp\class::table_getextraequipmentsecondary(table, classindex);
  loadoutarray["loadoutPerks"] = [];

  for(i = 0; i < 3; i++) {
    perk = scripts\mp\class::table_getperk(table, classindex, i);

    if(perk != "specialty_null") {
      loadoutarray["loadoutPerks"][loadoutarray["loadoutPerks"].size] = perk;
    }
  }

  loadoutarray["loadoutGesture"] = "playerData";
  loadoutarray["loadoutExecution"] = "playerData";
  loadoutarray["loadoutFieldUpgrade1"] = "none";
  loadoutarray["loadoutFieldUpgrade2"] = "none";
  return loadoutarray;
}

function function_a8fc18df76d1aa2f(loadouts, count, overrideweapons, overridechance) {
  classes = [];
  selectedloadouts = [];

  for(num = 0; num < count && loadouts.size > 0; num++) {
    loadout = loadouts[randomint(loadouts.size)];
    var_acfe7336f59b3d76 = loadout["loadoutPrimary"];

    if(isDefined(overrideweapons) && isDefined(overridechance)) {
      var_53877f59f7445553 = function_1ac1e1c43d4cebc(var_acfe7336f59b3d76);
      filteredweapons = function_828b81c9f2465841(overrideweapons, var_53877f59f7445553);

      if(filteredweapons.size > 0) {
        if(randomfloat(1) < overridechance) {
          idxrandom = randomint(filteredweapons.size);
          var_4fc88dfdbd8ddb28 = filteredweapons[idxrandom];
          overrideweapons = array_remove_index(overrideweapons, idxrandom);
          loadout["loadoutPrimaryAddBlueprintAttachments"] = 1;
          loadout["loadoutPrimary"] = var_4fc88dfdbd8ddb28.rootweapon;
          loadout["loadoutPrimaryVariantID"] = var_4fc88dfdbd8ddb28.variantid;
          loadout["loadoutPrimaryCamo"] = "none";
          loadout["loadoutPrimaryReticle"] = "none";

          for(attachmentindex = 0; attachmentindex < scripts\mp\class::getmaxprimaryattachments(); attachmentindex++) {
            attachstring = scripts\mp\class::getattachmentloadoutstring(attachmentindex, #"primary");
            loadout[attachstring] = "none";
          }
        }
      }
    }

    selectedloadouts[selectedloadouts.size] = loadout;
    loadouts = function_f76c0948f37c7855(loadouts, var_acfe7336f59b3d76);
  }

  return selectedloadouts;
}

function function_828b81c9f2465841(var_855a91067674d651, var_53877f59f7445553) {
  filtered = [];

  foreach(struct in var_855a91067674d651) {
    if(function_1ac1e1c43d4cebc(struct.rootweapon) == var_53877f59f7445553) {
      filtered[filtered.size] = struct;
    }
  }

  return filtered;
}

function function_f76c0948f37c7855(loadouts, var_acfe7336f59b3d76) {
  filtered = [];
  group = function_1ac1e1c43d4cebc(var_acfe7336f59b3d76);

  foreach(loadout in loadouts) {
    currgroup = function_1ac1e1c43d4cebc(loadout["loadoutPrimary"]);

    if(group != currgroup) {
      filtered[filtered.size] = loadout;
    }
  }

  return filtered;
}

function function_1ac1e1c43d4cebc(rootweapon) {
  group = "none";

  if(rootweapon != "none") {
    group = getweapongroup(rootweapon);

    if(group == "weapon_dmr") {
      group = "weapon_sniper";
    }
  }

  return group;
}

function updatehighpriorityweapons() {
  self loadweaponsforplayer(level.loadweapons, 1);
}

function function_9ef19af8915ebb2() {
  level.loadweapons = [];
  primaries = [];
  secondaries = [];
  loadout = game["forceRandomLoadout"][game["forceRandomLoadoutIndex"]];
  primary = loadout["loadoutPrimary"];
  secondary = loadout["loadoutSecondary"];

  if(primary != "none") {
    primaries[primaries.size] = function_d08db0c19daacc9c(primary, loadout, 1);
  }

  if(secondary != "none") {
    secondaries[secondaries.size] = function_5c5f49069eb558ec(secondary, loadout, 1);
  }

  if(!isDefined(level.loadoutchangeround)) {
    level.loadoutchangeround = 1;
  }

  if(level.loadoutchangeround != 0) {
    nextloadoutindex = game["forceRandomLoadoutIndex"] + 1;

    if(game["forceRandomLoadoutIndex"] == game["forceRandomLoadout"].size - 1) {
      nextloadoutindex = 0;
    }

    nextloadout = game["forceRandomLoadout"][nextloadoutindex];
    nextprimary = nextloadout["loadoutPrimary"];
    nextsecondary = nextloadout["loadoutSecondary"];

    if(nextprimary != "none") {
      primaries[primaries.size] = function_d08db0c19daacc9c(nextprimary, nextloadout);
    }

    if(nextsecondary != "none") {
      secondaries[secondaries.size] = function_5c5f49069eb558ec(nextsecondary, nextloadout);
    }
  }

  level.loadweapons = array_combine(primaries, secondaries);
}

function function_d08db0c19daacc9c(primary, loadout, currentloadout) {
  allattachments = [];

  for(i = 1; i < 6; i++) {
    concat = i;

    if(i == 1) {
      concat = "";
    }

    attachment = loadout["loadoutPrimaryAttachment" + concat];

    if(attachment != "none") {
      allattachments[allattachments.size] = attachment;
    }
  }

  rootname = getweaponrootname(primary);
  camoname = "none";
  reticleindex = "none";
  variantid = undefined;
  attachmentids = undefined;
  cosmeticattachment = undefined;
  stickers = undefined;
  newweaponobject = scripts\cp_mp\weapon::buildweapon(rootname, allattachments, camoname, reticleindex, variantid, attachmentids, cosmeticattachment, stickers);
  newweapon = getcompleteweaponname(newweaponobject);
  return newweapon;
}

function function_5c5f49069eb558ec(secondary, loadout, currentloadout) {
  allattachments = [];

  for(i = 1; i < 6; i++) {
    concat = i;

    if(i == 1) {
      concat = "";
    }

    attachment = loadout["loadoutSecondaryAttachment" + concat];

    if(attachment != "none") {
      allattachments[allattachments.size] = attachment;
    }
  }

  camoname = "none";
  reticleindex = "none";
  variantid = undefined;
  attachmentids = undefined;
  cosmeticattachment = undefined;
  stickers = undefined;
  rootname = getweaponrootname(secondary);
  newweaponobject = scripts\cp_mp\weapon::buildweapon(rootname, allattachments, camoname, reticleindex);
  newweapon = getcompleteweaponname(newweaponobject);
  return newweapon;
}

function function_9081e2d33d0b53f9() {
  if(getdvarint(@ "scr_game_aiagentsinmp", 0) == 1) {
    level.var_d0d511ba6517842a = 1;

    if(getdvarint(@ "scr_game_aispawnondeath", 0) == 1) {
      level.var_5df506226294aa65 = &function_5df506226294aa65;
      level.var_484f1a4bdb5cda1e = &function_484f1a4bdb5cda1e;
    }

    level thread function_7aba1069126eb717();
    flag_init("stealth_enabled");
    flag_init("level_stealth_initialized");
    flag_init("stealth_spotted");
  }
}

function function_7aba1069126eb717() {
  level.var_72e8a99508b7be1b = getdvarint(@ "hash_742ec92f3f5c3b41", 12);
  scripts\mp\ai_mp_controller::init();

  if(!isDefined(level.difficultytype)) {
    level scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  }

  scripts\engine\utility::registersharedfunc("ai", "dropLootOnAgentDeath", &droplootonagentdeath);

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  foreach(team in level.teamnamelist) {
    var_b5b1784d5a1327c7 = team + "_agents";
    function_ba4022744dce59f6(var_b5b1784d5a1327c7, level.var_72e8a99508b7be1b);
  }
}

function function_5df506226294aa65(victim, attacker) {
  if(victim.deaths % 5 == 0) {
    victim.var_8308e73a11dca140 = 1;
  }

  var_b5b1784d5a1327c7 = victim.team + "_agents";
  totalspawned = function_9368fb9261e4cd0a(var_b5b1784d5a1327c7);
  var_644d90de7685f75 = level.var_72e8a99508b7be1b - totalspawned;

  if(var_644d90de7685f75 <= 0) {
    return;
  }

  goalpos = undefined;
  spawnpoint = victim[[level.getspawnpoint]]();
  team = victim.team;
  wait 0.15;

  if(isDefined(spawnpoint)) {
    if(isDefined(attacker)) {
      goalpos = attacker.origin;
    } else {
      goalpos = spawnpoint.origin;
    }

    if(istrue(victim.var_8308e73a11dca140)) {
      var_40e875a042b82875 = getdvarint(@ "hash_4ec508aa0002244", 1);

      if(var_40e875a042b82875 > 0) {
        for(i = 0; i < var_40e875a042b82875; i++) {
          agent = ai_mp_requestspawnagent("enemy_mp_jugg_base", spawnpoint.origin, spawnpoint.angles, "absolute", var_b5b1784d5a1327c7, "jugg", var_b5b1784d5a1327c7, team);

          if(isDefined(agent)) {
            agent thread function_35c195df2ba46725(agent, team);
            scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418(agent);
            agent thread function_a5117518725da028(agent, goalpos);
            agent.doavoidanceblocking = 0;
          }
        }
      }

      victim.var_8308e73a11dca140 = undefined;
      return;
    }

    numagents = getdvarint(@ "hash_65d94ddfef09716a", 1);

    if(numagents > 0) {
      for(i = 0; i < numagents; i++) {
        aitype = function_d5bc07eabf352abb();
        agent = ai_mp_requestspawnagent(aitype, spawnpoint.origin, spawnpoint.angles, "absolute", var_b5b1784d5a1327c7, "jugg", var_b5b1784d5a1327c7, team);

        if(isDefined(agent)) {
          agent thread function_35c195df2ba46725(agent, team);
          agent thread function_a5117518725da028(agent, goalpos);

          if(team == "allies") {
            agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff("body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1");
          } else {
            agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff("body_spetsnaz_cqc", "head_spetsnaz_cqc");
          }

          agent.doavoidanceblocking = 0;
        }
      }
    }
  }
}

function function_35c195df2ba46725(agent, team) {
  waitframe();
  agent.gameskill = namespace_310bdaa3cf041c47::get_gameskill();
  agent namespace_310bdaa3cf041c47::apply_difficulty_settings(1);
  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "team", team);
}

function function_df3e6ee36363e610(agent) {
  if(agent.team == "axis") {
    body = "body_spetsnaz_cqc";
    head = "head_spetsnaz_cqc";
  } else {
    body = "body_mp_eastern_geist_1_1_lod1";
    head = "head_mp_eastern_bale_1_1";
  }

  weapon = undefined;
  grenade_type = scripts\cp_mp\agents\agent_utils::function_ba0801276542946b();
  grenadeammo = getdvarint(@ "hash_ce85f7cc40b562f5", 0);
  armor = 0;
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor);
  agent.baseaccuracy = getdvarfloat(@ "hash_949a1d9903e71c7a", 0.4);
}

function droplootonagentdeath(agent, agenttype, groupname) {
  agent notify("endLootDropThread");
  agent endon("endLootDropThread");
  agent waittill("death");
  agent[[level.weapondropfunction]](ter_op(isDefined(self.attacker), self.attacker, undefined), ter_op(isDefined(self.damagemod), self.damagemod, "MOD_RIFLE_BULLET"));
}

function function_484f1a4bdb5cda1e(attacker, victim) {
  score = level.scoremod["kill"];

  if(function_f698bfd3efa33302() || function_e9f3a160bbefe208(attacker) || function_e9f3a160bbefe208(victim)) {
    if(matchmakinggame() && isDefined(attacker.cranked)) {
      if(score != 0) {
        score += 1;
        attacker thread scripts\mp\rank::scoreeventpopup(hashcat(#"hash_2c8bcbb02ec7ff9b", score));
      }
    }

    attacker scripts\mp\cranked::oncranked(victim, attacker);
  }

  if(score != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
      return;
    }

    attacker scripts\mp\gamescore::giveplayerscore(#"kill", score, victim);
  }
}

function function_36532a1506f2c161() {
  var_ec3de47ac260ea33 = undefined;

  if(getDvar(@ "ui_gametype") == "arena") {
    objmodifier = 0;

    if(isusingmatchrulesdata()) {
      objmodifier = getmatchrulesdata("arenaData", "objModifier");
    } else {
      objmodifier = dvarintvalue("objModifier", 0, 0, 3);
    }

    if(objmodifier == 3) {
      var_ec3de47ac260ea33 = 1;
    }
  }

  level.var_c3a5ecc6db827a75 = 0;
  matchmakingmatch = getdvarint(@ "onlinegame") && !getdvarint(@ "xblive_privatematch");

  if(matchmakingmatch) {
    level.var_c3a5ecc6db827a75 = getdvarint(@ "hash_750e151e9a3727e7", 0);
  }

  level.var_c3a5ecc6db827a75 = getdvarint(@ "hash_750e151e9a3727e7", 0);

  if(level.var_c3a5ecc6db827a75 || istrue(var_ec3de47ac260ea33)) {
    function_e55c6985b99a0d78();
    level.setupsoccerball = &setupsoccerball;
    level thread[[level.setupsoccerball]]();
    level thread global_physics_sound_monitor();

    if(getdvarint(@ "hash_c8724ebc0f08ec3e", 1) == 1) {
      setupdialog();
      level function_8f38b7a29dad82f();

      if(getdvarint(@ "hash_71c708ca0182656b", 3) > 0) {
        if(!isDefined(game["multiBall"])) {
          game["multiBall"] = 0;
        }
      }
    }
  } else {
    level.var_c3a5ecc6db827a75 = undefined;
  }

  if(getdvarint(@ "hash_ce8358082dfab9e9", 0) == 1) {
    level.var_b6e1c0b3c715b0df["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
    level.var_dd7af80c3eb2c1e0 = 1;
  }
}

function setupsoccerball() {
  level.var_1b6b55efa67ba7a8 = [];
  spawnpositions = [];
  spawnpos = undefined;

  if(getgametype() == "arena") {
    arenaflag = getEntArray("flag_arena", "targetname");
    spawnpos = arenaflag[0].origin + (0, 0, 30);
  } else {
    spawnpositions = [];
    primaryflags = getEntArray("flag_primary", "targetname");

    foreach(flag in primaryflags) {
      if(flag.script_label == "_b") {
        spawnpositions[spawnpositions.size] = flag.origin;
        break;
      }
    }

    if(spawnpositions.size == 0) {
      println("<dev string:x17f>");
      return;
    }

    spawnpositions = array_randomize(spawnpositions);
    spawnpos = spawnpositions[0];

    if(getDvar(@ "ui_mapname") == "mp_firingrange") {
      spawnpos = (-194, -858, 90);
    }
  }

  var_288d5564a47d230a = [];
  var_58553518a66cebe9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in var_58553518a66cebe9) {
    var_288d5564a47d230a[var_288d5564a47d230a.size] = trig.origin;
  }

  level.var_288d5564a47d230a = var_288d5564a47d230a;
  var_2c677cecd807f43e = undefined;

  if(getdvarint(@ "hash_23e676668434d769", 0) == 1 && var_288d5564a47d230a.size > 0) {
    var_2c677cecd807f43e = 1;
    spawnpositions = array_combine(spawnpositions, var_288d5564a47d230a);
    spawnpositions = array_randomize(spawnpositions);
    spawnpos = spawnpositions[0];
  }

  level thread createball(spawnpos, 1);
}

function createball(spawnpos, waittime) {
  if(isDefined(waittime)) {
    wait waittime;
  }

  tracestart = spawnpos + (0, 0, 64);
  traceend = spawnpos + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
  spawnpos = trace["position"] + (0, 0, 30);
  soccerball = spawnStruct();
  soccerball.angles = (0, 0, 0);
  soccerball.visuals = spawn("script_model", spawnpos);
  soccerball.visuals setModel("art_stadium_ball");
  soccerball.visuals dontinterpolate();
  soccerball.resetposition = spawnpos;
  soccerball.var_2bbf24623e85009b = 1;
  soccerball.onreset = &onsoccerballreset;
  soccerball.var_7ab15a1be4cb821b = &function_7ab15a1be4cb821b;
  soccerball.var_5c83a6b4c46d2ff5 = &function_ad9983f20f50cf14;
  angles = (0, 30, 0);
  up = anglestoup(angles);
  forward = anglesToForward(angles);

  if(getDvar(@ "ui_mapname") == "mp_m_stadium") {
    force = up * 500 + (0, 0, 80);
  } else {
    force = up * 50 + (0, 0, 80);
  }

  waittillframeend();
  gameflagwait("prematch_done");
  soccerball.visuals physicslaunchserver(soccerball.visuals.origin, force);
  soccerball thread outofboundswatcher();
  soccerball thread function_5e8d33789dd33052();

  if(getdvarint(@ "hash_c8724ebc0f08ec3e", 1) == 1) {
    soccerball thread function_a21ad1174231d156();
  }

  if(isDefined(soccerball.var_5c83a6b4c46d2ff5)) {
    soccerball[[soccerball.var_5c83a6b4c46d2ff5]]();
  }

  level.var_1b6b55efa67ba7a8[level.var_1b6b55efa67ba7a8.size] = soccerball;
}

function function_ad9983f20f50cf14() {
  self.visuals thread register_physics_collisions();
  self.visuals physics_registerforcollisioncallback();
  register_physics_collision_func(self.visuals, &ball_impact_sounds);
}

function ball_impact_sounds(var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d) {
  bodyid = var_c92ef281c1d335fc physics_getbodyid(0);
  vel = physics_getbodylinvel(bodyid);
  bounceforce = length(vel);

  if(isDefined(var_c92ef281c1d335fc.playing_sound) || bounceforce < 70) {
    return;
  }

  var_c92ef281c1d335fc endon("death");
  var_c92ef281c1d335fc.playing_sound = 1;
  surface = physics_getsurfacetypefromflags(flag1);
  surfacetype = getsubstr(surface["name"], 9);

  if(surfacetype == "user_terrain1") {
    var_c92ef281c1d335fc playSound("soc_ball_bounce_small");
  } else if(bounceforce < 180) {
    var_c92ef281c1d335fc playsurfacesound("soc_ball_bounce_small", surfacetype);
  } else if(bounceforce < 260) {
    var_c92ef281c1d335fc playsurfacesound("soc_ball_bounce_med", surfacetype);
  } else {
    var_c92ef281c1d335fc playsurfacesound("soc_ball_bounce_large", surfacetype);
  }

  wait 0.1;
  var_c92ef281c1d335fc.playing_sound = undefined;
}

function onsoccerballreset(var_8fa61d7d6ced991d) {
  self.ignorereset = 1;

  if(!istrue(var_8fa61d7d6ced991d)) {
    wait 0.5;
    self.visuals playSound("soc_ball_vanish");
    playFX(level.var_f851d61f84f9a7b9["vanish"], self.visuals.origin);
  } else {
    wait 0.1;
    playFX(level.var_f851d61f84f9a7b9["vanish"], self.visuals.origin);
  }

  self.visuals hide();
  wait 1;
  self.visuals.origin = self.resetposition;
  angles = (0, 30, 0);
  up = anglestoup(angles);
  forward = anglesToForward(angles);

  if(level.mapname == "mp_m_stadium") {
    force = up * 500 + (0, 0, 80);
  } else {
    force = up * 50 + (0, 0, 80);
  }

  self.visuals show();
  self.visuals physicslaunchserver(self.visuals.origin, force);
  self.ignorereset = 0;

  if(isDefined(self.var_5c83a6b4c46d2ff5)) {
    self[[self.var_5c83a6b4c46d2ff5]]();
  }
}

function function_7ab15a1be4cb821b(goal) {
  if(istrue(self.ignorereset)) {
    self.ignorereset = 0;
    return;
  }

  if(game["switchedsides"]) {
    goalteam = getotherteam(goal.team)[0];

    if(goalteam == "allies") {
      game["axisGoals"]++;
      exploderid = "goal_1";
    } else {
      game["alliesGoals"]++;
      exploderid = "goal_2";
    }
  } else {
    goalteam = goal.team;

    if(goalteam == "allies") {
      game["alliesGoals"]++;
      exploderid = "goal_2";
    } else {
      game["axisGoals"]++;
      exploderid = "goal_1";
    }
  }

  if(isDefined(exploderid)) {
    exploder(exploderid);
  }

  var_cd96aff84bcc3247 = "tv_goal";

  if(isDefined(var_cd96aff84bcc3247)) {
    exploder(var_cd96aff84bcc3247);
  }

  goal.var_4f853e8e6740b229++;
  level function_2ceffef2d682c49e(goal);
  goal thread function_f0b4b85fd224bce2();

  if(getgametype() == "arena") {
    foreach(player in level.players) {
      if(player.team == goalteam) {
        if(player.team == "allies") {
          player thread function_b6b6cab8242eb686("dx_mpa_rutl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_them");
        } else {
          player thread function_b6b6cab8242eb686("dx_mpa_uktl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_them");
        }

        continue;
      }

      if(player.team == "allies") {
        player thread function_b6b6cab8242eb686("dx_mpa_uktl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_us");
        continue;
      }

      player thread function_b6b6cab8242eb686("dx_mpa_rutl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_us");
    }
  } else {
    foreach(player in level.players) {
      if(player.team == "allies") {
        player thread function_b6b6cab8242eb686("dx_mpa_uktl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_us");
        continue;
      }

      player thread function_b6b6cab8242eb686("dx_mpa_rutl_" + "summer_game_goal" + random(level.goaldialog), "summer_game_goal", 2, "soccer_goal_us");
    }
  }

  self.visuals thread function_f0f8e34f2d693727();
  attacheditems = self.visuals getlinkedchildren();

  foreach(item in attacheditems) {
    if(isDefined(item)) {
      item unlink(1);
    }
  }

  if(isDefined(self.onreset)) {
    self thread[[self.onreset]](1);
  }

  if(goal.var_4f853e8e6740b229 >= 10 && isDefined(game["multiBall"]) && !game["multiBall"] || getdvarint(@ "hash_9fc6cedb80cfd5f7", 0) == 1 && isDefined(game["multiBall"]) && !game["multiBall"]) {
    game["multiBall"] = 1;

    foreach(player in level.players) {
      player thread scripts\mp\hud_message::showsplash("soccer_multiball");
    }

    if(level.var_288d5564a47d230a.size > 0) {
      multiballs = getdvarint(@ "hash_71c708ca0182656b", 3);

      for(i = 0; i < multiballs; i++) {
        createball(level.var_288d5564a47d230a[i]);
      }
    }
  }
}

function function_f0f8e34f2d693727() {
  self playSound("soc_ball_explode");
  wait 1.5;
  self playSound("soc_ball_goal_music");
}

function function_f0b4b85fd224bce2(playsfx, waittime) {
  for(i = 0; i < min(self.var_4f853e8e6740b229, 10); i++) {
    playFX(level.var_b6e1c0b3c715b0df["gos_fireworks"], self.trigger.origin + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-25, 60)), anglesToForward(self.trigger.angles + (randomintrange(int(max(clamp(0 - i * 5, -19, 0), -20)), int(min(20, 1 + i * 5))), randomintrange(int(max(clamp(0 - i * 5, -19, 0), -20)), int(min(20, 1 + i * 5))), 0)), anglestoup(self.trigger.angles + (randomintrange(int(max(clamp(0 - i * 5, -19, 0), -20)), int(min(20, 1 + i * 5))), randomintrange(int(max(clamp(0 - i * 5, -19, 0), -20)), int(min(20, 1 + i * 5))), 0)));

    if(istrue(playsfx)) {
      level thread function_2c3362a9f434fd8d(self.trigger.origin);
    }

    if(isDefined(waittime)) {
      wait waittime;
    }
  }
}

function function_2ceffef2d682c49e(goal) {
  foreach(struct in level.var_8ba3a46d0f5089a4) {
    if(struct.scoreteam == goal.team) {
      if(goal.var_4f853e8e6740b229 >= 10) {
        struct.scriptable setscriptablepartstate("score", "10");
        continue;
      }

      struct.scriptable setscriptablepartstate("score", "0" + string(goal.var_4f853e8e6740b229));
    }
  }
}

function outofboundswatcher() {
  level endon("game_ended");

  while(true) {
    wait 0.5;

    if(istrue(self.ignorereset)) {
      continue;
    }

    if(isDefined(self.resetnow)) {
      self.resetnow = undefined;

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }

      continue;
    }

    for(index = 0; index < level.radtriggers.size; index++) {
      if(!self.visuals istouching(level.radtriggers[index])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    for(index = 0; index < level.minetriggers.size; index++) {
      if(!self.visuals istouching(level.minetriggers[index])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    for(index = 0; index < level.hurttriggers.size; index++) {
      if(!self.visuals istouching(level.hurttriggers[index])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    if(istrue(level.ballallowedtriggers.size)) {
      self.allowedintrigger = 0;

      foreach(trigger in level.ballallowedtriggers) {
        if(self.visuals istouching(trigger)) {
          self.allowedintrigger = 1;
          break;
        }
      }
    }

    if(isDefined(level.outofboundstriggers)) {
      foreach(trigger in level.outofboundstriggers) {
        if(istrue(self.allowedintrigger)) {
          break;
        }

        if(!self.visuals istouching(trigger)) {
          continue;
        }

        if(isDefined(self.onreset)) {
          self thread[[self.onreset]]();
        }
      }
    }

    if(isDefined(self.autoresettime)) {
      wait self.autoresettime;

      if(!isDefined(self.carrier)) {
        if(isDefined(self.onreset)) {
          self thread[[self.onreset]]();
        }
      }
    }
  }
}

function function_5e8d33789dd33052() {
  level endon("game_ended");

  while(true) {
    wait 0.25;

    if(istrue(self.ignorereset)) {
      continue;
    }

    if(distancesquared(self.visuals.origin, self.resetposition) > 9000000) {
      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }
  }
}

function function_8f38b7a29dad82f() {
  var_1d564be0354953b0 = getEntArray("allies_goal", "targetname");
  var_9f9cbf678fd4238d = getEntArray("axis_goal", "targetname");

  if(var_1d564be0354953b0.size > 0 && var_9f9cbf678fd4238d.size > 0) {
    level.alliesgoal = spawnStruct();
    level.alliesgoal.team = "allies";
    level.alliesgoal.trigger = var_1d564be0354953b0[0];
    level.alliesgoal.entsinside = [];
    level.axisgoal = spawnStruct();
    level.axisgoal.team = "axis";
    level.axisgoal.trigger = var_9f9cbf678fd4238d[0];
    level.axisgoal.entsinside = [];
    level.axisgoal.var_4f853e8e6740b229 = 0;

    if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      game["alliesGoals"] = 0;
      level.alliesgoal.var_4f853e8e6740b229 = 0;
      game["axisGoals"] = 0;
      level.axisgoal.var_4f853e8e6740b229 = 0;
    } else if(game["switchedsides"]) {
      level.axisgoal.var_4f853e8e6740b229 = game["alliesGoals"];
      level.alliesgoal.var_4f853e8e6740b229 = game["axisGoals"];
    } else {
      level.alliesgoal.var_4f853e8e6740b229 = game["alliesGoals"];
      level.axisgoal.var_4f853e8e6740b229 = game["axisGoals"];
    }

    level.var_6ffd40b85f9bdc80 = [level.axisgoal, level.alliesgoal];
    level thread function_c3de6082ad64dc54();
    return;
  }

  level notify("stop_soccer_goal");
}

function function_c3de6082ad64dc54() {
  wait 1;
  level.alliesscorestructs = getStructArray("home", "targetname");
  level.axisscorestructs = getStructArray("away", "targetname");
  level.var_8ba3a46d0f5089a4 = array_combine(level.alliesscorestructs, level.axisscorestructs);

  foreach(struct in level.alliesscorestructs) {
    struct.scriptable = spawn("script_model", struct.origin);
    struct.scriptable.angles = struct.angles;
    struct.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    struct.scoreteam = "allies";
  }

  foreach(struct in level.axisscorestructs) {
    struct.scriptable = spawn("script_model", struct.origin);
    struct.scriptable.angles = struct.angles;
    struct.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    struct.scoreteam = "axis";
  }

  level function_2ceffef2d682c49e(level.alliesgoal);
  level function_2ceffef2d682c49e(level.axisgoal);
}

function function_a21ad1174231d156(triggerstruct) {
  level endon("game_ended");
  level endon("stop_soccer_goal");

  while(!isDefined(level.var_6ffd40b85f9bdc80)) {
    waitframe();
  }

  while(true) {
    wait 0.05;

    if(istrue(self.ignorereset)) {
      continue;
    }

    for(index = 0; index < level.var_6ffd40b85f9bdc80.size; index++) {
      if(!function_6a55687e0ac4a408(level.var_6ffd40b85f9bdc80[index], self.visuals)) {
        continue;
      }

      if(!function_4d41453b43a4e638(level.var_6ffd40b85f9bdc80[index], self.visuals)) {
        continue;
      }

      entnum = self.visuals getentitynumber();
      level.var_6ffd40b85f9bdc80[index].entsinside[entnum] = self.visuals;
      self.visuals.var_d98176db59cca89a = level.var_6ffd40b85f9bdc80[index];

      if(isDefined(self.var_7ab15a1be4cb821b)) {
        [[self.var_7ab15a1be4cb821b]](level.var_6ffd40b85f9bdc80[index]);
      }
    }
  }
}

function function_4d41453b43a4e638(triggerstruct, ent) {
  entnum = ent getentitynumber();

  if(isDefined(triggerstruct.entsinside[entnum])) {
    return false;
  }

  return true;
}

function function_6a55687e0ac4a408(triggerstruct, ent) {
  if(!ent istouching(triggerstruct.trigger)) {
    entnum = ent getentitynumber();
    triggerstruct.entsinside[entnum] = undefined;

    if(isDefined(ent.var_d98176db59cca89a) && ent.var_d98176db59cca89a == triggerstruct) {
      ent.var_d98176db59cca89a = undefined;
    }

    return false;
  }

  return true;
}

function function_2c3362a9f434fd8d(origin) {
  sound = "gos_firework_scream_sfx";
  playsoundatpos(origin, sound);
  soundlength = lookupsoundlength(sound);
  wait 1.5;
  playsoundatpos(origin + (0, 0, 600), "gos_firework_explo_sfx");
}

function function_e55c6985b99a0d78() {
  level.var_b6e1c0b3c715b0df["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
  level.var_f851d61f84f9a7b9["vanish"] = loadfx("vfx/iw8_mp/gamemode/vfx_soccer_ball_burst.vfx");
  level.var_f851d61f84f9a7b9["score_00"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_00.vfx");
  level.var_f851d61f84f9a7b9["score_01"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_01.vfx");
  level.var_f851d61f84f9a7b9["score_02"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_02.vfx");
  level.var_f851d61f84f9a7b9["score_03"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_03.vfx");
  level.var_f851d61f84f9a7b9["score_04"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_04.vfx");
  level.var_f851d61f84f9a7b9["score_05"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_05.vfx");
  level.var_f851d61f84f9a7b9["score_06"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_06.vfx");
  level.var_f851d61f84f9a7b9["score_07"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_07.vfx");
  level.var_f851d61f84f9a7b9["score_08"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_08.vfx");
  level.var_f851d61f84f9a7b9["score_09"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_09.vfx");
  level.var_f851d61f84f9a7b9["score_10"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_10.vfx");
}

function setupdialog() {
  game["dialog"]["summer_game_goal_1"] = "summer_game_goal_1";
  game["dialog"]["summer_game_goal_2"] = "summer_game_goal_2";
  game["dialog"]["summer_game_goal_3"] = "summer_game_goal_3";
  level.goaldialog = ["_1", "_2", "_3"];
}

function function_b6b6cab8242eb686(dialog, dialogref, time, splash) {
  self notify("goal_scored");
  self endon("goal_scored");

  if(!isDefined(level.lastteamstatustime["allies"][dialogref])) {
    level.lastteamstatustime["allies"][dialogref] = 0;
  }

  if(gettime() < level.lastteamstatustime["allies"][dialogref] + time * 1000) {
    return;
  }

  self queuedialogforplayer(dialog, dialogref, time);
  level.lastteamstatustime["allies"][dialogref] = gettime();
  thread scripts\mp\hud_message::showsplash(splash);
}

function snowballfighthint() {
  self endon("death");

  if(!gameflag("prematch_done")) {
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/PRACTICE_ROUND", 5);
    wait 6;
    gameflagwait("prematch_done");
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
    return;
  }

  thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
}

function function_30dd74b21bfffe6() {
  if(getdvarint(@ "hash_a88f1329561bc6e1", 0) > 0) {
    level.var_8ce8010175fb9787 = getdvarint(@ "hash_a88f1329561bc6e1", 0);
    level thread randomcarepackagedrops();
  }
}

function randomcarepackagedrops() {
  level endon("game_ended");
  level.var_e1619c97e3fd8a87 = [];
  level thread function_49e45907b10122e4();
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_done");
  wait level.var_8ce8010175fb9787;
  level.grnd_previouscratetypes = [];

  while(true) {
    owner = undefined;
    var_4440147083abaf0a = 1;

    if(currentactivevehiclecount() < maxvehiclesallowed() && level.fauxvehiclecount + var_4440147083abaf0a < maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      cratetype = getdropzonecratetype();
      position = function_43c1d665b215618();

      if(!isDefined(position)) {
        return;
      }

      if(cratetype == "mega") {
        streakinfo = spawnStruct();
        streakinfo.cratetype = undefined;
        streakinfo.numcrates = undefined;
        streakinfo.usephysics = undefined;
        streakinfo.streakname = "airdrop_multiple";
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(owner, undefined, position, randomfloat(360), position, 1, streakinfo);
      } else {
        vehicleisreserved = scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(owner, undefined, cratetype, position, randomfloat(360), position, vehicleisreserved);
      }

      waittime = level.var_8ce8010175fb9787;
    } else {
      waittime = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
  }
}

function getdropzonecratetype() {
  cratetype = undefined;

  if(!isDefined(level.grnd_previouscratetypes["mega"]) && randomintrange(0, 100) < 5) {
    cratetype = "mega";
  } else {
    if(level.grnd_previouscratetypes.size) {
      for(maxtries = 200; maxtries; maxtries--) {
        cratetype = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level.grnd_previouscratetypes[cratetype])) {
          cratetype = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(cratetype)) {
      cratetype = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }
  }

  level.grnd_previouscratetypes[cratetype] = 1;

  if(level.grnd_previouscratetypes.size == 15) {
    level.grnd_previouscratetypes = [];
  }

  return cratetype;
}

function function_43c1d665b215618() {
  dropposition = level.var_e1619c97e3fd8a87[0];
  level.var_e1619c97e3fd8a87[level.var_e1619c97e3fd8a87.size] = level.var_e1619c97e3fd8a87[0];
  level.var_e1619c97e3fd8a87[0] = undefined;
  level.var_e1619c97e3fd8a87 = array_removeundefined(level.var_e1619c97e3fd8a87);
  return dropposition;
}

function function_49e45907b10122e4() {
  switch (level.mapname) {
    case #"hash_32eaa112f8caa7e4":
      level.var_e1619c97e3fd8a87 = [(21298, -15989, 1970), (22131, -18582, 690), (17264, -17920, 1066), (16682, -23069, 230), (21664, -23061, -108), (16208, -13686, -158), (19920, -18069, 157), (25150, -17449, -150), (27173, -14625, -200), (22696, -12784, -158), (22115, -12162, -106), (22278, -10595, 1610), (19963, -14131, 149), (20019, -11243, -194), (16711, -8999, -326), (15772, -5966, -390), (15501, -1873, -446), (19760, -1172, -449), (20464, -2047, -450), (23814, -5888, -382), (26210, -9404, -318), (30288, -8981, -358), (20781, -7208, -366), (18773, -13037, 9), (20091, -21421, -78), (23574, -14769, -134)];
      break;
    case #"hash_7a28db3c5928c489":
      level.var_e1619c97e3fd8a87 = [(25008, 32313, 826), (29171, 32156, 659), (25021, 37011, 841), (30305, 35572, 526), (30779, 33427, 1009), (28913, 38886, 888), (25888, 40248, 1680), (27533, 43285, 1792), (31199, 37768, 722), (33534, 35968, 1103), (34872, 33255, 664), (33704, 39718, 1395), (35903, 39512, 879), (32265, 46424, 1450), (35084, 43008, 960), (38700, 43064, 1087), (36348, 44694, 481), (34805, 48469, 1317), (32313, 39712, 767)];
      break;
    case #"hash_50de71be6e7469ff":
    case #"hash_863773b8960b3944":
      level.var_e1619c97e3fd8a87 = [(51478, -24749, -55), (50222, -21762, -335), (46165, -20091, -409), (49089, -18057, -359), (54074, -16693, -307), (52289, -14523, -335), (48361, -13952, -1), (43445, -16524, -405), (43634, -13100, -51), (47714, -14136, 141), (50498, -12784, -199), (53744, -11930, -510), (52284, -7268, -672), (49723, -7122, 438), (47540, -10295, 266), (48403, -7548, 291), (53225, -3832, -456), (49419, -4336, 141), (49419, -4336, 141), (47101, -1784, 116), (43600, -3193, 340), (42522, -6972, 30), (45959, -5516, 328), (46058, -8625, 136)];
      break;
    case #"hash_12f3765ef24b4037":
      level.var_e1619c97e3fd8a87 = [(40724, -13376, -58), (37115, -14577, -152), (35766, -19268, -508), (38572, -18749, -508), (42023, -19947, -500), (40116, -25824, -247), (38056, -23083, 240), (35024, -24401, -508), (36958, -26270, -112), (36264, -28611, -36), (38229, -28438, -452), (38304, -30376, -172), (33276, -26940, -116), (30526, -27712, -508), (29810, -29730, -508), (33689, -28898, -507), (36498, -33452, -508), (37219, -37142, -506), (34863, -34724, -318), (34304, -36576, -506), (31116, -35074, -508), (32797, -32582, -372)];
      break;
    case #"hash_924a3fbe9fbe15c6":
      level.var_e1619c97e3fd8a87 = [(-28661, -17966, -177), (-30406, -15324, -159), (-26858, -14816, 3), (-26567, -8261, 17), (-23466, -14624, -12), (-24687, -11527, 238), (-24492, -10369, 148), (-25965, -11096, 27), (-29884, -12919, -43), (-30458, -10020, -136), (-28564, -9301, 248), (-29994, -6709, -208), (-28156, -5883, -119), (-30522, -3889, -247), (-28220, -3171, -255), (-25333, -4300, -242), (-28106, -1937, -255), (-30823, -2351, -248), (-29121, -11011, -61)];
      break;
    case #"hash_a8b272dba33a4aed":
      level.var_e1619c97e3fd8a87 = [(2716, -158, 708), (8215, 874, 342), (6524, 1561, 316), (5827, -860, 357), (4268, -47, 452), (2305, -1994, 386), (5172, 2587, 231), (2691, 3096, 302), (-910, 3497, 318), (-3579, -544, 320), (2591, 1659, 545), (1033, -514, 447), (-93, -2789, 169), (-1301, 924, 315), (-2843, 2779, 316)];
      break;
    default:
      level.var_e1619c97e3fd8a87 = getcoremapdropzones();
      break;
  }

  level.var_e1619c97e3fd8a87 = array_randomize(level.var_e1619c97e3fd8a87);
}

function getcoremapdropzones() {
  var_bc115bc1bac87a51 = [];
  trigs = getEntArray("grnd", "targetname");

  if(level.mapname == "mp_shipment") {
    removetrigs = [];

    foreach(trig in trigs) {
      if(trig.script_label == "1" && distance(trig.origin, (-333, 1999, 119)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "2" && distance(trig.origin, (189, 1564, 75)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "3" && distance(trig.origin, (-751, 2416, 81)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "4" && distance(trig.origin, (165, 2420, 79)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "5" && distance(trig.origin, (-823, 1536, 68)) < 5) {
        removetrigs[removetrigs.size] = trig;
      }
    }

    trigs = array_remove_array(trigs, removetrigs);
  }

  if(trigs.size > 0) {
    foreach(trig in trigs) {
      var_bc115bc1bac87a51[var_bc115bc1bac87a51.size] = trig.origin;
    }
  }

  return var_bc115bc1bac87a51;
}

function function_89d441b8cca6251d() {
  return isDefined(level.var_8ce8010175fb9787) && level.var_8ce8010175fb9787 > 0;
}

function function_52343d5c1b190cf0() {
  level.tier1modeenabled = getdvarint(@ "hash_127490a7577f169f", 0);
  level.var_ee05489a095df4d1 = getdvarint(@ "hash_509b01d1370107af", 0) == 1;
  level.var_11d8636343eae20c = getdvarint(@ "hash_e05a6970966d8552", 0);
  level.var_accb27010daa82d = getdvarint(@ "hash_4a592b7d1efa862d", 0);
  level.var_1921cb8dd51a8f73 = getdvarint(@ "hash_4c748c9425636394", 0);
  level.testrandomrealismclients = getdvarint(@ "hash_596700a25033a832", 0) == 1;
  setomnvar("ui_realism_mode", scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924());

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
    }

    setDvar(@ "jump_slowdownenable", 1);
    setDvar(@ "sprintleap_enabled", 0);

    if(!scripts\mp\spawnselection::function_167619fe3d0cff00()) {
      level.disablespawncamera = 1;
    }

    if(istrue(level.var_1921cb8dd51a8f73)) {
      level.var_26109c02a53cea84 = [];
      level.var_26109c02a53cea84["rocketlauncher"] = getdvarfloat(@ "hash_2b6ceef99f7c775", 0.75);
      level.var_26109c02a53cea84["sniper"] = getdvarfloat(@ "hash_2b2aaef99f38272", 0.8);
      level.var_26109c02a53cea84["mg"] = getdvarfloat(@ "hash_263c3ef999d0b4f", 0.85);
      level.var_26109c02a53cea84["rifle"] = getdvarfloat(@ "hash_274c6ef99af1c44", 0.9);
      level.var_26109c02a53cea84["smg"] = getdvarfloat(@ "hash_2b2a9ef99f3803f", 0.95);
      level.var_26109c02a53cea84["spread"] = getdvarfloat(@ "hash_2b2b3ef99f3963d", 0.95);
      level.var_26109c02a53cea84["grenade"] = getdvarfloat(@ "hash_27db6ef99b917c2", 1);
      level.var_26109c02a53cea84["melee"] = getdvarfloat(@ "hash_263c5ef999d0fb5", 1);
      level.var_26109c02a53cea84["pistol"] = getdvarfloat(@ "hash_2bfa5ef9a018bf8", 1);
    }

    setdevdvarifuninitialized(@ "hash_74cf84c8f4c62dd0", 0);
    setdevdvarifuninitialized(@ "hash_1a0e0937636134eb", 0);

    scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&function_3708850eab3864c2);
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_3708850eab3864c2);
  }
}

function function_3708850eab3864c2() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self.isrealismenabled = 1;
      } else {
        self setclientomnvar("ui_realism_hud", 0);
        self.isrealismenabled = 0;
      }
    }

    return;
  }

  self setclientomnvar("ui_realism_hud", scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924());
}

function spawnhealthpickup() {
  droplocation = self.origin;
  startpos = droplocation + (0, 0, 14);
  stance = self getstance();
  zoffset = 35;

  if(stance == "prone") {
    zoffset = 14;
  }

  if(stance == "crouch") {
    zoffset = 25;
  }

  movetostartpos = droplocation + (0, 0, zoffset);
  randomangle = (0, randomfloat(360), 0);
  randomdir = anglesToForward(randomangle);
  randomdst = randomfloatrange(30, 150);
  testpos = startpos + randomdst * randomdir;
  movetoendpos = playerphysicstrace(startpos, testpos);

  if(!isDefined(self.healthpickup)) {
    visuals = [];
    visuals[0] = spawn("script_model", movetostartpos);
    visuals[0] setModel("noglow::lm_heal_first_aid_kit_vfx");
    trigger = spawn("trigger_radius", movetostartpos, 0, 32, 32);
    trigger scripts\engine\utility::trigger_off();
    pickup = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, undefined, undefined, 1);
    pickup.onuse = &function_75c517d33cd52b54;
    pickup.usetime = 0;
    pickup scripts\mp\gameobjects::allowuse("any");
    pickup.owner = self;
    self.healthpickup = pickup;
    self.healthpickup thread monitordisconnect();
  } else {
    self.healthpickup.curorigin = movetostartpos;
    self.healthpickup.visuals[0].origin = movetostartpos;
    self.healthpickup.trigger.origin = movetostartpos;
  }

  self.healthpickup thread function_5c5358ef41543da6(movetostartpos, movetoendpos);

  if(level.var_accb27010daa82d > 0) {
    self.healthpickup thread monitortimeout();
  }
}

function function_5c5358ef41543da6(startpos, endpos) {
  self endon("death");
  initialforce = (endpos - startpos) * 25;
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, initialforce);
  wait 1;

  if(isDefined(self.trigger) && isDefined(self.visuals[0])) {
    self.trigger.origin = self.visuals[0].origin;
    self.curorigin = self.visuals[0].origin;
    self.visuals[0] physicsstopserver();
    self.trigger scripts\engine\utility::trigger_on();
  }
}

function function_75c517d33cd52b54(player, team) {
  if(player.health <= 0 || player.health == player.maxhealth) {
    return;
  }

  if(player isjuggernaut()) {
    return;
  }

  player playsoundtoplayer("br_pickup_generic", player);
  player thread function_427b6f3adc1b7a7d();

  if(level.var_ee05489a095df4d1) {
    if(level.var_11d8636343eae20c == 0) {
      player.health = player.maxhealth;
    } else {
      player.health = min(player.health + level.var_11d8636343eae20c, player.maxhealth);
    }
  } else {
    player notify("force_regeneration");
  }

  function_5dc0c80460e6c6bb();
}

function function_427b6f3adc1b7a7d() {
  self endon("death_or_disconnect");
  superref = scripts\mp\supers::getcurrentsuperref();
  deadsilenceactive = scripts\mp\supers::issuperinuse() && isDefined(superref) && superref == "super_deadsilence";

  if(!deadsilenceactive) {
    self lerpfovbypreset("zombiedefault");
  }

  wait 0.5;
  superref = scripts\mp\supers::getcurrentsuperref();
  deadsilenceactive = scripts\mp\supers::issuperinuse() && isDefined(superref) && superref == "super_deadsilence";

  if(!deadsilenceactive) {
    self lerpfovbypreset("default_2seconds");
  }
}

function monitordisconnect() {
  self waittill("disconnect");
  function_5dc0c80460e6c6bb();
}

function monitortimeout() {
  self endon("death");
  self notify("monitorTimeOut");
  self endon("monitorTimeOut");
  wait level.var_accb27010daa82d;
  function_5dc0c80460e6c6bb();
}

function function_5dc0c80460e6c6bb() {
  if(isDefined(self.owner)) {
    self.owner.healthpickup = undefined;
  }

  self.visuals[0] delete();
  scripts\mp\gameobjects::deleteuseobject();
}

function function_1513c3f71e935d73() {
  level.hardcoremodeenabled = getdvarint(@ "hash_a2c2c2007177185e", 0);

  if(!scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    return;
  }

  if(!isusingmatchrulesdata()) {
    setDvar(@ "scr_game_allowkillcam", 0);
    setDvar(@ "scr_player_healthregentime", 0);
    setDvar(@ "scr_player_maxhealth", 30);
    setDvar(@ "scr_team_fftype", 4);
  }
}

function function_417749e099f041f(killfeeddata, victimid) {
  struct = spawnStruct();
  struct.killfeeddata = killfeeddata;
  struct.victimid = victimid;

  if(!isDefined(self.var_b35c5ea3127572d8)) {
    self.var_b35c5ea3127572d8 = queue_create(32);
  }

  self.var_b35c5ea3127572d8 = function_6cf786a6cf335cb9(self.var_b35c5ea3127572d8, struct);
  thread processkilleventfeed();

  if(getgametype() == "gwtdm") {
    thread awardbonusaftertime();
  }
}

function processkilleventfeed() {
  self endon("disconnect");
  self notify("processKillEventFeed");
  self endon("processKillEventFeed");
  waittillframeend();

  while(isDefined(self.var_b35c5ea3127572d8) && self.var_b35c5ea3127572d8.array.size > 0) {
    struct = queue_peek(self.var_b35c5ea3127572d8);
    self.var_b35c5ea3127572d8 = function_93def91a50927481(self.var_b35c5ea3127572d8);
    self setclientomnvar("ui_killfeed_victim_id", struct.victimid);
    self setclientomnvar("ui_killfeed_data", struct.killfeeddata);
    self setclientomnvar("ui_killfeed_notify", gettime());
    waitframe();
  }
}

function awardbonusaftertime() {
  self endon("disconnect");
  self notify("awardBonusAfterTime");
  self endon("awardBonusAfterTime");

  if(!isDefined(self.var_a4dcda08906719e4)) {
    self.var_a4dcda08906719e4 = 0;
  }

  self.var_a4dcda08906719e4++;
  bonuswindow = getdvarfloat(@ "hash_a44760277d3fe8a5", 5);
  wait bonuswindow;
  var_24d22c13c6fece21 = 0;

  if(self.var_a4dcda08906719e4 > 15) {
    var_24d22c13c6fece21 = 15;
  } else if(self.var_a4dcda08906719e4 > 10) {
    var_24d22c13c6fece21 = 10;
  } else if(self.var_a4dcda08906719e4 > 7) {
    var_24d22c13c6fece21 = 5;
  } else if(self.var_a4dcda08906719e4 > 5) {
    var_24d22c13c6fece21 = 3;
  } else if(self.var_a4dcda08906719e4 > 3) {
    var_24d22c13c6fece21 = 1;
  }

  self.var_a4dcda08906719e4 = 0;

  if(var_24d22c13c6fece21 == 0) {
    return;
  }

  scripts\mp\gamescore::giveteamscoreforobjective(self.team, var_24d22c13c6fece21, 0);

  if(getdvarint(@ "hash_2e405e2912dc4a44", 0) == 1) {
    thread scripts\mp\rank::scoreeventpopup(hashcat(#"hash_2c8bcbb02ec7ff9b", var_24d22c13c6fece21));
  }

  scripts\mp\utility\stats::incpersstat("contribution", var_24d22c13c6fece21);
  scripts\mp\utility\stats::setextrascore0(self.pers["contribution"]);
  killfeeddata = 0;
  killfeeddata += 6;
  killfeeddata += var_24d22c13c6fece21 << 4;
  struct = spawnStruct();
  struct.killfeeddata = killfeeddata;
  struct.victimid = -1;
  self.var_b35c5ea3127572d8 = function_6cf786a6cf335cb9(self.var_b35c5ea3127572d8, struct);
  thread processkilleventfeed();
}
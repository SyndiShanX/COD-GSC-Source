/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_110fd2130c2ed1fe.gsc
*************************************************/

#using script_c255b9dc9a79d15;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_dad6d813fbbde071;

function init() {
  enabled = registerquestcategory("assassination", 1);

  if(!enabled) {
    return;
  }

  registerquestcategorytablevalues("assassination" + "_all");
  registerquestcategorytablevalues("assassination" + "_all_timed");
  level.br_leaderbystreak = getdvarint(@ "hash_22c4c1f9efb1de0a", 0) != 0;
  getquestdata("assassination").questbasetimer = getdvarint(@ "hash_2f9cd2b10d05e2b3", 180);
  getquestdata("assassination").questbonustimer = getdvarint(@ "hash_23b6f8f2af592fc1", 60);
  getquestdata("assassination").resettimeronkill = getdvarint(@ "hash_b18c855819438fde", 1);
  registerquestthink("assassination", &aq_questthink_circleposition, 10);
  registerquestthink("assassination", &aq_questthink_objectivevisibility, 0.2);
  registerremovequestinstance("assassination", &aq_removequestinstance);
  registeronplayerkilled("assassination", &aq_playerdied);
  registeronplayerdisconnect("assassination", &aq_playerdisconnect);
  playerfilter = array_add(level.questinfo.defaultfilter, &filtercondition_hasbeentracked);
  playerfilter = array_add(level.questinfo.defaultfilter, &filtercondition_isdowned);
  registerplayerfilter("assassination", playerfilter, 0);
  questtimerinit("assassination", 1);
  registerontimerupdate("assassination", &aq_ontimerupdate);
  registerontimerexpired("assassination", &aq_ontimerexpired);
  getquestdata("assassination").alltrackedplayers = [];
  allassassin_init();
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
  game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
  game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
  game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
  game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
  game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
}

function filtercondition_hasbeentracked(player) {
  if(isDefined(player.hasbeentracked) && player.hasbeentracked) {
    return false;
  }

  return true;
}

function aq_questthink_circleposition() {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed") {
    return;
  }

  if(!isDefined(self.targetplayer)) {
    getnewtargetplayer();
  }

  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationthreatlevel(self.targetteam);
}

function aq_questthink_objectivevisibility() {
  if(getsubgametype() != "champion") {
    determineobjectivevisibility();
  }
}

function aq_removequestinstance() {
  if(istrue(level.var_59c0b24ba708e3c)) {
    function_93833843135c9a25();
    removeallaqui();
    return;
  }

  releaseteamonquest(self.hunterteam);
  removeallaqui();
}

function takequestitem(pickupent) {
  function_fe3b51cfbf0f97c5();

  if(istrue(level.var_59c0b24ba708e3c)) {
    function_902f03d6a23a0a45(self.team, self.sessionsquadid, #"hash_67eb4b642067882a");
    hunterteam = self.team;
    huntersquad = self.sessionsquadid;
    assert(isDefined(huntersquad));
    besttarget = function_998e39dbcdafdde7(self);
    instance = undefined;

    if(isDefined(besttarget) && besttarget.size >= 2) {
      targetteam = besttarget[0];
      targetsquad = besttarget[1];
      instance = function_a721f329de58f4c3(hunterteam, huntersquad, targetteam, targetsquad, pickupent.index, self, "", pickupent);
    }
  } else {
    giveteampoints(self.team, #"hash_67eb4b642067882a");
    hunterteam = self.team;
    targetteam = determinetargetteam(self);
    instance = givequest(hunterteam, targetteam, pickupent.index, self, "", pickupent);
  }

  if(!isDefined(instance)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
    lootspawnpoint = spawnStruct();
    lootspawnpoint.origin = pickupent.origin;
    lootspawnpoint.angles = pickupent.angles;
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

    if(brgametype == "plunder" || brgametype == "risk") {
      var_6b5e1783915835c1 = "mp/loot_set_cache_contents_dmz.csv";
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder", var_6b5e1783915835c1);
      return;
    }

    lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health");
    lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo");
    lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder");
    return;
  }

  instance givequestsplash(self);
}

function givequestsplash(pickupplayer) {
  function_d2caa40694d469ab();

  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self.targetplayer;

  if(isDefined(pickupplayer)) {
    params.excludedplayers[1] = pickupplayer;
  }

  params.stringvar = self.targetplayer.name;
  function_9d1c5280f5963c8c("target", "br_assassination_quest_start_target_team", params);
  displayplayersplash(self.targetplayer, "br_assassination_quest_start_target_player");

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    thread function_6f8e4ad4812f9004("mission_ass_hunted", "target", 1);
  }

  params.plundervar = getquestplunderrewardinstance(getquestrewardtier(self.hunterteam));
  function_9d1c5280f5963c8c("hunter", "br_assassination_quest_start_hunter_team", params);

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    thread function_6f8e4ad4812f9004("mission_ass_accept", "hunter", 1);
  }

  if(isDefined(pickupplayer)) {
    displayplayersplash(pickupplayer, "br_assassination_quest_start_tablet_finder", params);
    function_448f9af17b797c5a("hunter", pickupplayer, 6, getquestindex("assassination"));
  }
}

function givequest(hunterteam, targetteam, id, player, modifier, rewardscriptable) {
  instance = createquestinstance("assassination", hunterteam, id, rewardscriptable);
  instance.modifier = modifier;

  if(!isDefined(instance.modifier)) {
    instance.modifier = "";
  }

  instance registerteamonquest(hunterteam, player);
  instance.hunterteam = hunterteam;
  instance.targetteam = targetteam;
  instance.targets_killed_by_hunters = 0;
  instance.hunters_killed_by_targets = 0;
  instance.targetteamremaining = 0;

  if(isDefined(targetteam)) {
    instance.targetteamremaining = instance getvalidplayersinteam(targetteam).size;
  }

  if(!isDefined(instance.targetteam)) {
    cancelgivequest(instance);
    return undefined;
  }

  if(instance.modifier != "_all") {
    instance questtimerset(getquestdata("assassination").questbasetimer, 4);
  }

  instance function_6b6b6273f8180522("Assassination_Br");
  instance getnewtargetplayer(player);

  if(!isDefined(instance.targetplayer)) {
    cancelgivequest(instance);
    return undefined;
  }

  if(instance.modifier == "_all_timed") {
    level.teamdata[hunterteam]["hasFailed"] = 0;
  }

  instance determinetrackingcircleposition(instance.targetplayer);
  instance determinetrackingcirclesize();
  instance updateassassinationthreatlevel(instance.targetteam);

  if(getsubgametype() == "champion") {
    level notify("quest_objective_updated_" + hunterteam, instance);
  } else {
    instance determineobjectivevisibility();
  }

  addquestinstance("assassination", instance);
  startteamcontractchallenge("assassination", player, hunterteam);
  return instance;
}

function cancelgivequest(instance) {
  instance function_af5604ce591768e1();
  instance.result = "no_locale";

  if(istrue(level.var_59c0b24ba708e3c)) {
    instance function_93833843135c9a25();
    return;
  }

  instance releaseteamonquest(instance.hunterteam);
}

function determinetargetteam(player) {
  hunterteam = player.team;
  bestteam = undefined;
  potentialtargets = level.players;
  list1 = getquestdata("assassination").alltrackedplayers;
  list2 = getteamdata(hunterteam, "players");
  excludedteams = array_combine_unique(list1, list2);
  search_bounds = 0;
  filter = level.questinfo.quests["assassination"].filters[0];
  searchminradius = 5000;
  searchlimit = 30000;

  if(gametypeoverrideassassinsearchparams()) {
    searchminradius = level.quest_assdistmin;
    searchlimit = level.quest_assdistmax;
  }

  while(!isDefined(bestteam)) {
    search_bounds += 5000;
    playerlist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, searchminradius);
    playerlist = getvalidplayersinarray(playerlist, filter);

    if(!isDefined(playerlist) || playerlist.size == 0) {
      if(search_bounds > searchlimit) {
        playerlist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, undefined, undefined);
        playerlist = getvalidplayersinarray(playerlist, filter);

        if(!isDefined(playerlist) || playerlist.size == 0) {
          return undefined;
        }
      } else {
        continue;
      }
    }

    targetteams = [];

    foreach(targetplayer in playerlist) {
      targetteams[targetplayer.team] = getvalidplayersinteam(targetplayer.team, filter).size;
    }

    var_29f6d200784f77b3 = getteamcenter(hunterteam, filter);
    hunterteamsize = getvalidplayersinteam(hunterteam, filter).size;

    foreach(team, teamsize in targetteams) {
      if(!isDefined(bestteam)) {
        bestteam = team;
        continue;
      }

      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if(brgametype == "plunder" || brgametype == "risk") {
        var_e6a3e80614fbd020 = scripts\mp\gametypes\br_plunder::getteamcarriedplunder(bestteam);
        var_c237b8fc2586f74f = scripts\mp\gametypes\br_plunder::getteamcarriedplunder(team);

        if(var_c237b8fc2586f74f > 100000) {
          if(var_c237b8fc2586f74f > var_e6a3e80614fbd020) {
            bestteam = team;
            continue;
          }
        }
      }

      difference = abs(hunterteamsize - teamsize);

      if(difference < abs(hunterteamsize - targetteams[bestteam])) {
        bestteam = team;
        continue;
      } else if(difference > abs(hunterteamsize - targetteams[bestteam])) {
        continue;
      }

      if(teamsize > targetteams[bestteam]) {
        bestteam = team;
        continue;
      } else if(teamsize < targetteams[bestteam]) {
        continue;
      }

      currentteamcenter = getteamcenter(team, filter);
      var_76e3e3800077282f = getteamcenter(bestteam, filter);

      if(distance2d(var_29f6d200784f77b3, currentteamcenter) < distance2d(var_29f6d200784f77b3, var_76e3e3800077282f)) {
        bestteam = team;
      }
    }
  }

  if(isDefined(bestteam)) {
    getquestdata("assassination").alltrackedplayers = array_combine(getquestdata("assassination").alltrackedplayers, getteamdata(bestteam, "players"));
  }

  return bestteam;
}

function determinetargetplayer(targetteam, hunter) {
  var_6864bee22874201b = undefined;
  var_b803ea87ecf23294 = undefined;
  targetplayer = undefined;
  var_29f6d200784f77b3 = function_87afe756cb5dfde7("hunter");

  foreach(player in function_fc0a70293a565642("target")) {
    if(!isplayervalid(player, getfilterformodifier(self.modifier))) {
      continue;
    }

    if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      if(is_equal(player.script_noteworthy, "assassination_target")) {
        targetplayer = player;
        break;
      }
    }

    if(!isDefined(targetplayer)) {
      targetplayer = player;
    }

    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

    if(brgametype == "plunder" || brgametype == "risk") {
      playerplunder = player.plundercount;

      if(isDefined(playerplunder)) {
        var_2cc640c4cf5d3e6a = distance2dsquared(hunter.origin, player.origin);

        if(!isDefined(var_b803ea87ecf23294) || var_2cc640c4cf5d3e6a <= var_b803ea87ecf23294) {
          if(!isDefined(var_6864bee22874201b) || playerplunder >= var_6864bee22874201b) {
            var_6864bee22874201b = playerplunder;
            var_b803ea87ecf23294 = var_2cc640c4cf5d3e6a;
            targetplayer = player;
          }
        }
      }

      continue;
    }

    if(distance2d(var_29f6d200784f77b3, player.origin) < distance2d(var_29f6d200784f77b3, targetplayer.origin)) {
      targetplayer = player;
    }
  }

  assert(isDefined(targetplayer));
  targetplayer.hasbeentracked = 0;
  self.targetplayer = targetplayer;
}

function determinetrackingcircleposition(targetplayer) {
  function_d2caa40694d469ab();

  search_location = (targetplayer.origin[0], targetplayer.origin[1], getcirclesize());

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    search_location += math::random_vector_2d() * randomfloatrange(getcirclerangemin(), getcirclerangemax());
  }

  function_6e148c8da2e4db13(search_location);
}

function determinetrackingcirclesize() {
  function_d2caa40694d469ab();

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    function_4584ad1c0e2c58ec(level.lootleadermarksize);
    self.threat_level = 2;
    return;
  }

  hunterplayers = function_9f8af67e38f19b5d("hunter");

  if(hunterplayers.size == 0) {
    function_4584ad1c0e2c58ec(3500);
    self.threat_level = 0;
    return;
  }

  closestdist = undefined;

  foreach(player in hunterplayers) {
    dist = distance2d(player.origin, self.targetplayer.origin);

    if(!isDefined(closestdist) || dist < closestdist) {
      closestdist = dist;
    }
  }

  if(closestdist > 5000) {
    function_4584ad1c0e2c58ec(3500);
    self.threat_level = 0;
    return;
  }

  if(closestdist > 2500) {
    function_4584ad1c0e2c58ec(2000);
    self.threat_level = 1;
    return;
  }

  function_4584ad1c0e2c58ec(1500);
  self.threat_level = 2;
}

function determineobjectivevisibility() {
  function_d2caa40694d469ab();

  foreach(player in function_fc0a70293a565642("hunter")) {
    isingulag = player scripts\mp\gametypes\br_public::isplayeringulag();
    hud_enabled = isDefined(player.aq_hudenabled) && player.aq_hudenabled;

    if(isingulag && hud_enabled) {
      player hideassassinationhud(self);
    }

    if(!isingulag && !hud_enabled) {
      player showassassinationhud(self);
    }
  }

  foreach(player in function_fc0a70293a565642("target")) {
    isingulag = player scripts\mp\gametypes\br_public::isplayeringulag();
    hud_enabled = isDefined(player.aq_targethudenabled) && player.aq_targethudenabled;

    if(isingulag && hud_enabled) {
      player hideassassinationtargethud();
    }

    if(!isingulag && !hud_enabled) {
      player showassassinationtargethud(self.targetplayer, self.threat_level);
    }
  }
}

function aq_ontimerupdate() {
  foreach(player in function_fc0a70293a565642("target")) {
    player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);
  }

  if(self.modifier == "_all_timed") {
    thread assassinationtimewarning();
  }
}

function aq_ontimerexpired() {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed") {
    setteamdata(self.targetteam, "hasFailed", 1);
    allassassin_timeout_end(self.hunterteam);
    removequestinstance();
    return;
  }

  function_9d1c5280f5963c8c("hunter", "br_assassination_timer_expire_hunters_lose");
  rewardtier = getquestrewardtier(self.targetteam);
  reward = getquestplunderreward("assassination", rewardtier);
  self.rewardmodifier = "_averted";
  params = spawnStruct();
  missionid = getquestindex("assassination");
  rewardindex = getquestrewardgroupindex(getquestrewardbuildgroupref("assassination", self.rewardmodifier, self.modifier));
  params.packedbits = packsplashparambits(missionid, rewardtier, rewardindex);
  function_9d1c5280f5963c8c("target", "br_assassination_timer_expire_targets_win", params);
  thread function_6f8e4ad4812f9004("mission_ass_fail", "hunter", 1);
  thread function_6f8e4ad4812f9004("mission_ass_hunted_timed_out", "target", 1);
  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(brgametype != "plunder" && brgametype != "risk") {
    givequestrewardsinstance(self.targetteam, self.targetplayer.origin, self.targetplayer.angles, self.rewardscriptable, function_fc0a70293a565642("target"));
  }
}

function aq_playerdied(attacker, victim) {
  function_d2caa40694d469ab();

  if(victim scripts\mp\gametypes\br_public::isplayeringulag() || attacker scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  thread aq_playerremoved(victim, attacker);
}

function aq_playerdisconnect(disconnectplayer) {
  function_d2caa40694d469ab();

  thread aq_playerremoved(disconnectplayer);
}

function aq_playerremoved(removeplayer, attacker) {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed" && getteamdata(self.hunterteam, "hasFailed")) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    if(!isbot(removeplayer)) {
      return;
    }
  }

  if(removeplayer.team == self.targetteam) {
    if(removeplayer == self.targetplayer) {
      attackerlist = removeplayer.attackers;
      wait 0.75;
      params = spawnStruct();
      rewardtier = getquestrewardtier(self.hunterteam);
      missionid = getquestindex("assassination");

      if(isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.hunterteam) {
        splash = "br_assassination_complete_hunters_win";
        self.rewardmodifier = "_target_killed";
        function_448f9af17b797c5a("hunter", attacker, 8, getquestindex("assassination"));

        if(isDefined(level.var_52781be0b4e8a959)) {
          level[[level.var_52781be0b4e8a959]](attacker.team);
        }

        if(getsubgametype() == "rumble_mgl") {
          level notify("assassination_quest_completed", attacker.team, attacker.sessionsquadid);
        }
      } else {
        splash = "br_assassination_complete_target_vanished";
        self.rewardmodifier = "_target_vanished";
      }

      rewardindex = getquestrewardgroupindex(getquestrewardbuildgroupref("assassination", self.rewardmodifier, self.modifier));
      params.packedbits = packsplashparambits(missionid, rewardtier, rewardindex);
      function_9d1c5280f5963c8c("hunter", splash, params);

      if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
        function_6f8e4ad4812f9004("mission_ass_success", "hunter", 1);
      }

      self.rewardorigin = removeplayer.origin;
      self.rewardangles = removeplayer.angles;

      if(isDefined(attackerlist)) {
        foreach(contributingplayer in attackerlist) {
          if(isDefined(contributingplayer.team) && contributingplayer.team == self.hunterteam) {
            registercontributingplayers(contributingplayer);
          }
        }
      }

      self.result = "success";
      removequestinstance();
    }

    if(self.modifier == "_all_timed") {
      if(!isDefined(level.gulag) || isDefined(level.gulag) && !istrue(level.gulag.shutdown)) {
        foreach(player in function_fc0a70293a565642("hunter")) {
          if(istrue(player.inlaststand)) {
            player scripts\mp\laststand::finishreviveplayer("use_hold_revive_success", player);
          }

          if(!isalive(player)) {
            player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
            player thread scripts\mp\gametypes\br_gulag::playergulagautowin("aq");
          }
        }
      }
    }

    return;
  }

  if(removeplayer.team == self.hunterteam) {
    if(!function_daad346821543e6f("hunter", getfilterformodifier(self.modifier))) {
      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if(brgametype == "plunder" || brgametype == "risk") {
        self.result = "fail";
        removequestinstance();
        return;
      }

      self.rewardmodifier = "_averted";
      rewards = givequestrewardsinstance(self.targetteam, removeplayer.origin, removeplayer.angles, self.rewardscriptable, function_fc0a70293a565642("target"));
      params = spawnStruct();
      params.plundervar = get_int_or_0(rewards["plunder"]);
      function_9d1c5280f5963c8c("target", "br_assassination_complete_targets_win", params);
      self.result = "fail";
      removequestinstance();
    }
  }
}

function getnewtargetplayer(hunter) {
  function_d2caa40694d469ab();

  determinetargetplayer(self.targetteam, hunter);
  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationhud();
}

function removeallaqui() {
  function_d2caa40694d469ab();

  foreach(player in function_fc0a70293a565642("hunter")) {
    player hideassassinationhud(self);
  }

  foreach(player in function_fc0a70293a565642("target")) {
    player hideassassinationtargethud();
  }

  function_af5604ce591768e1();
}

function getplayerkills() {
  if(level.br_leaderbystreak) {
    return self.killsthislife.size;
  }

  return self.kills;
}

function getfilterformodifier(modifier) {
  switch (modifier) {
    case #"hash_b62fe7e71b905a1":
    case #"hash_ee90b669e8938abd":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function showassassinationhud(instance) {
  function_fe3b51cfbf0f97c5();

  self.aq_hudenabled = 1;
  uiobjectiveshow("assassination" + instance.modifier);
  instance function_cfd53c8f6878014f(self);
}

function hideassassinationhud(instance) {
  function_fe3b51cfbf0f97c5();

  self.aq_hudenabled = 0;
  uiobjectivehide();
  instance function_d7d113d56ef0ef5b(self);
}

function updateassassinationdataomnvar(targetplayer, threatlevel) {
  if(isDefined(self.aq_targethudenabled) && self.aq_targethudenabled) {
    entitynumber = targetplayer getentitynumber();
  } else {
    entitynumber = -1;
  }

  entitynumber = targetplayer getentitynumber();
  entitynumber += 1;
  value = threatlevel << 8 | entitynumber;
  self setclientomnvar("ui_br_assassination_target", value);
}

function updateassassinationthreatlevel(targetteam) {
  foreach(player in function_fc0a70293a565642("target")) {
    player updateassassinationdataomnvar(self.targetplayer, self.threat_level);
  }
}

function showassassinationtargethud(targetplayer, threatlevel) {
  function_fe3b51cfbf0f97c5();

  self.aq_targethudenabled = 1;
  updateassassinationdataomnvar(targetplayer, threatlevel);
}

function hideassassinationtargethud() {
  function_fe3b51cfbf0f97c5();

  self.aq_targethudenabled = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function updateassassinationhud() {
  foreach(player in function_fc0a70293a565642("hunter")) {
    player showassassinationhud(self);
    player uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(player in function_fc0a70293a565642("target")) {
    player showassassinationtargethud(self.targetplayer, self.threat_level);
  }
}

function assassinationtimewarning() {
  self notify("assassinationTimeWarning");
  self endon("assassinationTimeWarning");
  self endon("removed");
  updates = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(time in updates) {
    secremaining = (self.missiontime - gettime()) / 1000;
    delta = secremaining - time;

    if(delta < 0) {
      continue;
    }

    wait delta;
    mins = int(time / 60);
    hunters = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(function_fc0a70293a565642("hunter"), getfilterformodifier(self.modifier));

    foreach(player in hunters) {
      endtime = gettime() + time * 1000;
      showtime = 5;

      if(time <= 20) {
        showtime = time;
      }

      player scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassin_mission_time_warning", endtime, showtime);

      if(mins >= 2) {
        player iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_MIN", mins);
        continue;
      }

      player iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_SEC", time);
    }
  }
}

function allassassin_init() {
  level thread allassassin_givewait();
}

function allassassin_givewait() {
  scripts\mp\flags::gameflagwait("prematch_done");
  version = getdvarint(@ "hash_4d250e4873e1753e", 0);

  if(!version) {
    return;
  }

  waittime = getdvarint(@ "hash_35c40b91dcc26b01", 120);
  disableteamkillrewards();
  wait waittime;
  allassassin_give(version);
}

function allassassin_give(version) {
  info = spawnStruct();
  info.teamlist = [];
  info.lastmissionendtime = [];
  info.resttimems = int(getdvarfloat(@ "hash_e2df198f0e15683c", 10) * 1000);

  if(version == 1) {
    info.modifier = "_all";
  } else if(version == 2) {
    info.modifier = "_all_timed";
  } else {
    assertmsg("<dev string:x26>" + version);
  }

  if(info.modifier == "_all_timed") {
    info allassassin_initteamlist_timed();
  } else {
    info allassassin_initteamlist();
  }

  info thread allassassin_applyquest();
  info thread allassassin_updatewait();
}

function allassassin_getsortedteams() {
  questcenter = (0, 0, 0);
  teams = allassassin_teams();
  sortedteams = [];

  foreach(team in teams) {
    leader = undefined;
    teamplayers = getteamdata(team, "players");

    foreach(player in teamplayers) {
      if(player scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      if(player scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
        leader = player;
        break;
      }

      if(!isDefined(leader)) {
        leader = player;
      }
    }

    if(!isDefined(leader)) {
      continue;
    }

    sortteam = spawnStruct();
    sortteam.team = team;
    sortteam.pos = leader.origin;
    questcenter += sortteam.pos;
    sortedteams[sortedteams.size] = sortteam;
  }

  if(sortedteams.size < 2) {
    return sortedteams;
  }

  questcenter /= sortedteams.size;

  foreach(sortteam in sortedteams) {
    dir = sortteam.pos - questcenter;
    sortteam.sortvalue = vectortoangles(dir)[1];
  }

  sortedteams = scripts\mp\utility\script::quicksort(sortedteams, &allassassin_teamcompare);
  return sortedteams;
}

function allassassin_initteamlist() {
  sortedteams = allassassin_getsortedteams();
  groupsize = getdvarint(@ "hash_285c13782c4ed68f", 150);
  numteams = sortedteams.size;

  if(isDefined(groupsize)) {
    groupsize = int(min(groupsize, numteams));
  } else {
    groupsize = numteams;
  }

  numgroups = int(numteams / groupsize);
  extrateams = numteams % groupsize;
  groupsizes = [];

  for(i = 0; i < numgroups; i++) {
    groupsizes[i] = groupsize;
  }

  for(i = 0; i < extrateams; i++) {
    groupsizes[i % numgroups]++;
  }

  count = 0;

  for(i = 0; i < groupsizes.size; i++) {
    groupsize = groupsizes[i];

    for(j = 0; j < groupsize; j++) {
      team = sortedteams[count + j].team;
      prev = wrapindex(j - 1, groupsize);
      next = wrapindex(j + 1, groupsize);
      targetedby = sortedteams[count + prev].team;
      targeting = sortedteams[count + next].team;
      teaminfo = spawnStruct();
      teaminfo.targetedby = targetedby;
      teaminfo.targeting = targeting;
      self.teamlist[team] = teaminfo;
    }

    count += groupsize;
  }
}

function allassassin_initteamlist_timed() {
  maxdist = getdvarfloat(@ "hash_f4e01d5ab43ecd85", 10000);
  sortedteams = allassassin_getsortedteams();

  for(i = 0; i < sortedteams.size; i++) {
    hunterteam = sortedteams[i].team;

    if(isDefined(self.teamlist[hunterteam])) {
      continue;
    }

    for(j = 0; j < sortedteams.size - 1; j++) {
      if(j % 2) {
        offset = int(-0.5 * j - 0.5);
      } else {
        offset = int(0.5 * j + 1);
      }

      targetteamindex = wrapindex(i + offset, sortedteams.size);
      targetteam = sortedteams[targetteamindex].team;

      if(isDefined(self.teamlist[targetteam])) {
        continue;
      }

      targetpos = sortedteams[targetteamindex].pos;
      hunterpos = sortedteams[i].pos;

      if(distance(targetpos, hunterpos) > maxdist) {
        continue;
      }

      var_925b356f96c01616 = spawnStruct();
      var_925b356f96c01616.targetedby = targetteam;
      var_925b356f96c01616.targeting = targetteam;
      self.teamlist[hunterteam] = var_925b356f96c01616;
      targetteaminfo = spawnStruct();
      targetteaminfo.targetedby = hunterteam;
      targetteaminfo.targeting = hunterteam;
      self.teamlist[targetteam] = targetteaminfo;
      break;
    }
  }
}

function allassassin_teams() {
  time = gettime();
  teams = [];

  foreach(team, data in level.teamdata) {
    if(isDefined(self.teamlist[team])) {
      continue;
    }

    lastmissionendtime = self.lastmissionendtime[team];

    if(isDefined(lastmissionendtime) && time < lastmissionendtime + self.resttimems) {
      continue;
    }

    if(!isteamvalid(team, getfilterformodifier(self.modifier))) {
      continue;
    }

    teams[teams.size] = team;
  }

  return teams;
}

function allassassin_oninstanceremoved(instance) {
  instance waittill("removed");
  self.lastmissionendtime[instance.hunterteam] = gettime();
  self notify("update");
}

function allassassin_updatewait() {
  updatedelay = getdvarint(@ "hash_8292c07abd783b9b", 10);

  while(true) {
    waittill_notify_or_timeout("update", updatedelay);

    if(self.modifier == "_all_timed") {
      allassassin_update_timed();
      continue;
    }

    allassassin_update();
  }
}

function allassassin_update_timed() {
  invalidteams = [];

  foreach(team, targetinfo in self.teamlist) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[team])) {
      invalidteams[invalidteams.size] = team;
    }
  }

  foreach(team in invalidteams) {
    self.teamlist[team] = undefined;
  }

  allassassin_initteamlist_timed();
  allassassin_applyquest();
}

function allassassin_update() {
  invalidteams = [];

  foreach(team, targetinfo in self.teamlist) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[team])) {
      if(targetinfo.targeting == targetinfo.targetedby) {
        invalidteams[invalidteams.size] = team;
      }
    }
  }

  foreach(team in invalidteams) {
    self.teamlist[team] = undefined;
  }

  var_f17a683b71e14ab7 = allassassin_teams();
  var_d94fd49d5e466dae = var_f17a683b71e14ab7.size;
  invalidteams = [];

  foreach(team, targetinfo in self.teamlist) {
    if(!isteamvalid(team, getfilterformodifier(self.modifier))) {
      if(var_d94fd49d5e466dae > 0) {
        var_d94fd49d5e466dae--;
        insertteam = var_f17a683b71e14ab7[var_d94fd49d5e466dae];
        self.teamlist[insertteam] = spawnStruct();
        self.teamlist[insertteam].targeting = targetinfo.targeting;
        self.teamlist[insertteam].targetedby = targetinfo.targetedby;
        self.teamlist[targetinfo.targetedby].targeting = insertteam;
        self.teamlist[targetinfo.targeting].targetedby = insertteam;
      } else {
        self.teamlist[targetinfo.targetedby].targeting = targetinfo.targeting;
        self.teamlist[targetinfo.targeting].targetedby = targetinfo.targetedby;
      }

      invalidteams[invalidteams.size] = team;
    }
  }

  foreach(team in invalidteams) {
    self.teamlist[team] = undefined;
  }

  if(var_d94fd49d5e466dae >= 2) {
    for(i = 0; i < var_d94fd49d5e466dae; i++) {
      team = var_f17a683b71e14ab7[i];
      prev = wrapindex(i - 1, var_d94fd49d5e466dae);
      next = wrapindex(i + 1, var_d94fd49d5e466dae);
      targetedby = var_f17a683b71e14ab7[prev];
      targeting = var_f17a683b71e14ab7[next];
      teaminfo = spawnStruct();
      teaminfo.targetedby = targetedby;
      teaminfo.targeting = targeting;
      self.teamlist[team] = teaminfo;
    }
  }

  if(self.teamlist.size < 2) {
    return;
  }

  allassassin_applyquest();
}

function allassassin_applyquest() {
  foreach(team, targetinfo in self.teamlist) {
    if(isDefined(level.questinfo.quests["assassination"].instances[team])) {
      continue;
    }

    hunter = team;
    target = targetinfo.targeting;
    id = "all_" + hunter + "_" + target;
    instance = givequest(hunter, target, id, undefined, self.modifier);

    if(isDefined(instance)) {
      instance givequestsplash();

      if(self.modifier == "_all_timed") {
        instance thread allassassin_updatecircle();
      }

      thread allassassin_oninstanceremoved(instance);
    }
  }
}

function allassassin_updatecircle() {
  self endon("removed");
  startupdate = getdvarfloat(@ "hash_5052e7021a993bb7", 10);
  endupdate = getdvarfloat(@ "hash_60dd91fcd2553058", 1);

  while(true) {
    aq_questthink_circleposition();
    determinetrackingcircleposition(self.targetplayer);
    frac = getquesttimefrac();
    delta = startupdate - endupdate;
    wait delta * frac + endupdate;
  }
}

function allassassin_teamcompare(left, right) {
  return left.sortvalue <= right.sortvalue;
}

function allassassin_timeout_end(team) {
  killtargets = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(getteamdata(team, "players"));

  foreach(player in killtargets) {
    if(isalive(player)) {
      player kill(player.origin, player);
    }
  }

  displayteamsplash(team, "br_assassination_timer_expire_hunters_lose");
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_ass_fail", team, 1);
}

function wrapindex(index, maxindex) {
  return (index % maxindex + maxindex) % maxindex;
}

function disableteamkillrewards() {
  getquestdata("assassination").disableteamrewards = 1;
}

function disableplayerkillrewards() {
  getquestdata("assassination").disableplayerrewards = 1;
}

function checkifteamrewardsareenabled() {
  return isDefined(getquestdata("assassination").disableteamrewards) && getquestdata("assassination").disableteamrewards;
}

function checkifplayerrewardsareenabled() {
  return isDefined(getquestdata("assassination").disableplayerrewards) && getquestdata("assassination").disableplayerrewards;
}

function getquesttimefrac() {
  function_d2caa40694d469ab();

  questtime = getquestdata("assassination").questbasetimer;
  timeremaining = (self.missiontime - gettime()) / 1000;
  frac = clamp(timeremaining / questtime, 0, 1);
  return frac;
}

function getcirclesize() {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed") {
    startsize = getdvarfloat(@ "hash_5dfb0eef997d40f", 3000);
    endsize = getdvarfloat(@ "hash_1be2f04ad5c56c28", 200);
    frac = getquesttimefrac();
    delta = startsize - endsize;
    return (delta * frac + endsize);
  }

  return 2000;
}

function getcirclerangemin() {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed") {
    return 0;
  }

  return 100;
}

function getcirclerangemax() {
  function_d2caa40694d469ab();

  if(self.modifier == "_all_timed") {
    circlesize = getcirclesize();
    return (circlesize * 0.5);
  }

  return 900;
}

function gametypeoverrideassassinsearchparams() {
  overrideparams = 0;
  gametype = getsubgametype();

  switch (gametype) {
    case #"hash_59b8e9d05b31ff9":
    case #"hash_5e78ea9021845d4a":
    case #"hash_8299694594ab149d":
    case #"hash_83058a20a2b7cb50":
    case #"hash_bfabc434c59611fa":
      overrideparams = 1;
      break;
  }

  return overrideparams;
}

function function_dd49e0165f8b8c5d() {
  level notify("<dev string:x46>");
  level endon("<dev string:x46>");

  if(istrue(level.var_dd49e0165f8b8c5d)) {
    level.var_dd49e0165f8b8c5d = 0;
    return;
  }

  level.var_dd49e0165f8b8c5d = 1;

  while(true) {
    foreach(instance in level.questinfo.quests["<dev string:x5b>"].instances) {
      foreach(hunter in getteamdata(instance.hunterteam, "<dev string:x6c>")) {
        target = instance.targetplayer;
        start = hunter.origin;
        end = target.origin;
        fwd = end - start;
        len = length(fwd);
        fwd = vectorNormalize(fwd);
        leftdir = vectorcross(fwd, (0, 0, 1));
        line(start, end, (1, 0, 0), 1);
        size = 30;
        left = end + (leftdir - fwd) * size;
        right = left - leftdir * 2 * size;
        line(left, right, (1, 0, 0), 1);
        line(left, end, (1, 0, 0), 1);
        line(right, end, (1, 0, 0), 1);
      }
    }

    waitframe();
  }
}

function function_5f352fb76c54705c() {
  quests = getquestdata("assassination");

  if(!isDefined(quests)) {
    return false;
  }

  foreach(instance in quests.instances) {
    if(instance.targetteam == self.team) {
      return true;
    }
  }

  return false;
}
/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_ui.gsc
**************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\gamestate;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\teams;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\player\player;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\teams\platoons;
#include scripts\mp_common\teams\team_assignment;
#include scripts\mp_common\userspawnselection;
#include scripts\mp_common\util;

#namespace globallogic_ui;

init() {}

setupcallbacks() {
  level.autoassign = &menuautoassign;
  level.spectator = &menuspectator;
  level.curclass = &menuclass;
  level.specialistmenu = &menuspecialist;
  level.teammenu = &menuteam;
  level.draftmenu = &menupositiondraft;
  level.autocontrolplayer = &menuautocontrolplayer;
}

freegameplayhudelems() {

  if(isDefined(self.perkicon)) {
    for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
      if(isDefined(self.perkicon[numspecialties])) {
        self.perkicon[numspecialties] hud::destroyelem();
        self.perkname[numspecialties] hud::destroyelem();
      }
    }
  }

  if(isDefined(self.perkhudelem)) {
    self.perkhudelem hud::destroyelem();
  }

    if(isDefined(self.killstreakicon)) {
      if(isDefined(self.killstreakicon[0])) {
        self.killstreakicon[0] hud::destroyelem();
      }

      if(isDefined(self.killstreakicon[1])) {
        self.killstreakicon[1] hud::destroyelem();
      }

      if(isDefined(self.killstreakicon[2])) {
        self.killstreakicon[2] hud::destroyelem();
      }

      if(isDefined(self.killstreakicon[3])) {
        self.killstreakicon[3] hud::destroyelem();
      }

      if(isDefined(self.killstreakicon[4])) {
        self.killstreakicon[4] hud::destroyelem();
      }
    }

  if(isDefined(self.lowermessage)) {
    self.lowermessage hud::destroyelem();
  }

  if(isDefined(self.lowertimer)) {
    self.lowertimer hud::destroyelem();
  }

  if(isDefined(self.proxbar)) {
    self.proxbar hud::destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext hud::destroyelem();
  }

  if(isDefined(self.carryicon)) {
    self.carryicon hud::destroyelem();
  }
}

  function private function_34a60b2f(original_team, new_team) {
    if(!isDefined(original_team) || original_team == #"spectator" || !isDefined(new_team)) {
      return;
    }

    if(game.everexisted[original_team] && !game.everexisted[new_team] && level.playerlives[original_team]) {
      game.everexisted[original_team] = 0;
      level.everexisted[original_team] = 0;
      level.teameliminated[original_team] = 0;
    }
  }

menuautoassign(comingfrommenu, var_4c542e39) {
  original_team = self.pers[#"team"];
  self luinotifyevent(#"clear_notification_queue");

  if(level.teambased) {
    assignment = teams::function_d22a4fbb(comingfrommenu, var_4c542e39);

    if(assignment === self.pers[#"team"] && (self.sessionstate === "playing" || self.sessionstate === "dead")) {
      self beginclasschoice(0);
      return;
    }
  } else {
    if(self.sessionstate == "playing" || self.sessionstate == "dead") {
      return;
    }

    assignment = teams::function_b55ab4b3(comingfrommenu, var_4c542e39);
  }

  assignmentoverride = getdvarstring(#"autoassignteam");

  if(assignmentoverride != "<dev string:x38>" && (assignmentoverride != #"spectator" || !isbot(self))) {
    assignment = assignmentoverride;
  }

    if(!isDefined(assignment)) {
      assignment = var_4c542e39;
    }

  assert(isDefined(assignment));

  if(assignment === #"spectator" && !level.forceautoassign) {
    self teams::function_dc7eaabd(assignment);
    return;
  }

  if(assignment !== self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = assignment;
    self.leaving_team = self.pers[#"team"];
    self suicide();
  }

  self.pers[#"class"] = "";
  self.curclass = "";
  self.pers[#"weapon"] = undefined;
  self.pers[#"savedmodel"] = undefined;
  self teams::function_dc7eaabd(assignment);
  self platoons::function_4b016b57();
  distribution = teams::function_7d93567f();
  self updateobjectivetext();

  if(!isalive(self)) {
    self.statusicon = "hud_status_dead";
  }

  function_34a60b2f(original_team, assignment);
  self player::function_466d8a4b(comingfrommenu, assignment);

  if(level.var_b3c4b7b7 === 1) {
    draft::assign_remaining_players(self);
  } else {
    self notify(#"end_respawn");
    self beginclasschoice(comingfrommenu);
  }

  self teams::function_58b6d2c9();

}

updateobjectivetext() {
  if(self.pers[#"team"] == #"spectator") {
    self setclientcgobjectivetext("");
    return;
  }

  if(level.scorelimit > 0 || level.roundscorelimit > 0) {
    self setclientcgobjectivetext(util::getobjectivescoretext(self.pers[#"team"]));
    return;
  }

  self setclientcgobjectivetext(util::getobjectivetext(self.pers[#"team"]));
}

closemenus() {
  self closeingamemenu();
}

beginclasschoice(comingfrommenu) {
  if(isbot(self)) {
    return;
  }

  assert(isDefined(level.teams[self.pers[#"team"]]));
  team = self.pers[#"team"];

  if(level.disableclassselection == 1 || getdvarint(#"migration_soak", 0) == 1) {
    self player_role::set(getdvarint(#"auto_select_character", 1));
    started_waiting = gettime();

    while(!self isstreamerready(-1, 1) && started_waiting + 90000 > gettime()) {
      waitframe(1);
    }

    self.pers[#"class"] = level.defaultclass;
    self.curclass = level.defaultclass;

    if(self.sessionstate != "playing" && (game.state == "playing" || game.state == "pregame")) {
      self thread[[level.spawnclient]]();
    }

    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    return;
  }

  util::wait_network_frame();

  if(!draft::is_enabled() || comingfrommenu || !level.inprematchperiod) {
    [[level.spawnspectator]]();
    self userspawnselection::closespawnselect();
    self userspawnselection::clearcacheforplayer();
    self draft::clear_cooldown();

    if(comingfrommenu || !player_role::is_valid(player_role::get())) {
      self draft::open();
    }
  }
}

showmainmenuforteam() {
  assert(isDefined(level.teams[self.pers[#"team"]]));
  team = self.pers[#"team"];
  [[level.spawnspectator]]();
  self draft::open();
}

menuteam(team) {
  if(!level.console && !level.allow_teamchange && isDefined(self.hasdonecombat) && self.hasdonecombat) {
    return;
  }

  if(self.pers[#"team"] != team) {
    function_34a60b2f(self.pers[#"team"], team);

    if(level.ingraceperiod && (!isDefined(self.hasdonecombat) || !self.hasdonecombat)) {
      self.hasspawned = 0;
    }

    if(self.sessionstate == "playing") {
      self.switchedteamsresetgadgets = 1;
      self.joining_team = team;
      self.leaving_team = self.pers[#"team"];
      self suicide();
    }

    self userspawnselection::closespawnselect();
    self userspawnselection::clearcacheforplayer();
    self luinotifyevent(#"clear_notification_queue");
    self.switching_teams = 1;
    self.pers[#"team"] = team;
    self.team = team;
    self.pers[#"class"] = "";
    self.curclass = "";
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();

    if(!level.rankedmatch && !level.leaguematch) {
      self.sessionstate = "spectator";
    }

    self.sessionteam = team;
    self player::function_466d8a4b(1, team);
    self notify(#"end_respawn");
  }

  self beginclasschoice(1);
}

menuspectator() {
  self closemenus();

  if(self.pers[#"team"] != #"spectator") {
    if(isalive(self)) {
      self.switching_teams = 1;
      self.switchedteamsresetgadgets = 1;
      self.joining_team = #"spectator";
      self.leaving_team = self.pers[#"team"];
      self suicide();
    }

    self.pers[#"team"] = #"spectator";
    self.team = #"spectator";
    self.pers[#"class"] = "";
    self.curclass = "";
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = #"spectator";
    [[level.spawnspectator]]();
    self thread player::spectate_player_watcher();
    self player::function_6f6c29e(1);
  }
}

menuclass(response, forcedclass, updatecharacterindex, closemenus) {
  if(!isDefined(self.pers[#"team"]) || !isDefined(level.teams[self.pers[#"team"]])) {
    return 0;
  }

  if(!loadout::function_87bcb1b()) {
    if((game.state == "pregame" || game.state == "playing") && self.sessionstate != "playing") {
      self thread[[level.spawnclient]](0);
    }

    return;
  }

  if(!isDefined(forcedclass)) {
    playerclass = self loadout::function_97d216fa(response);
  } else {
    playerclass = forcedclass;
  }

  if(isDefined(level.disablecac) && level.disablecac && issubstr(playerclass, "CLASS_CUSTOM") && isarray(level.classtoclassnum) && level.classtoclassnum.size > 0) {
    defaultclasses = getarraykeys(level.var_8e1db8ee);
    playerclass = level.var_8e1db8ee[defaultclasses[randomint(defaultclasses.size)]];
  }

  self loadout::function_d7c205b9(playerclass);

  if(!player_role::is_valid(self player_role::get())) {
    return 0;
  }

  if(isDefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass) {
    return 1;
  }

  self.pers[#"changed_class"] = 1;
  self notify(#"changed_class");

  if(isDefined(self.curclass) && self.curclass == playerclass) {
    self.pers[#"changed_class"] = 0;
  }

  var_8d7a946 = !isDefined(self.curclass) || self.curclass == "";
  self.pers[#"class"] = playerclass;
  self.curclass = playerclass;
  self loadout::function_d7c205b9(playerclass);
  self.pers[#"weapon"] = undefined;

  if(gamestate::is_game_over()) {
    return 0;
  }

  if(self.sessionstate != "playing") {
    if(self.sessionstate != "spectator") {
      if(self isinvehicle()) {
        return 0;
      }

      if(self isremotecontrolling()) {
        return 0;
      }

      if(self isweaponviewonlylinked()) {
        return 0;
      }
    }

    if(self.sessionstate != "dead") {
      timepassed = undefined;

      if(isDefined(self.respawntimerstarttime)) {
        timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
      }

      self thread[[level.spawnclient]](timepassed);
      self.respawntimerstarttime = undefined;
    }
  }

  if(self.sessionstate == "playing") {
    supplystationclasschange = isDefined(self.usingsupplystation) && self.usingsupplystation;
    self.usingsupplystation = 0;

    if(isDefined(level.ingraceperiod) && level.ingraceperiod && !(isDefined(self.hasdonecombat) && self.hasdonecombat) || isDefined(supplystationclasschange) && supplystationclasschange || self.pers[#"latejoin"] === 1 && self.pers[#"time_played_alive"] < level.graceperiod && !(isDefined(self.hasdonecombat) && self.hasdonecombat)) {
      self loadout::function_53b62db1(self.pers[#"class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self ability_player::gadgets_save_power(0);
      self loadout::give_loadout(self.pers[#"team"], self.pers[#"class"]);
      self killstreaks::give_owned();
    } else if(!var_8d7a946 && self.pers[#"changed_class"] && !(isDefined(level.var_f46d16f0) && level.var_f46d16f0)) {
      self luinotifyevent(#"hash_6b67aa04e378d681", 1, 6);
    }
  }

  level thread globallogic::updateteamstatus();
  self thread spectating::set_permissions_for_machine();
  return 1;
}

menuspecialist(characterindex) {
  self endon(#"disconnect");

  if(!isDefined(characterindex)) {
    println("<dev string:x3b>");
    return;
  }

  if(!draft::can_select_character(characterindex)) {
    return 0;
  }

  if(player_role::get() != characterindex) {
    self.pers[#"changed_specialist"] = 1;
    self.var_89c4a60f = self getmpdialogname();
    self.pers[#"hash_1b145cf9f0673e9"] = function_b14806c6(self player_role::get(), currentsessionmode());
  } else {
    self.pers[#"changed_specialist"] = 0;
  }

  spawns = self.pers[#"spawns"];
  self draft::select_character(characterindex, 0);
  specialist_name = getcharacterdisplayname(characterindex, currentsessionmode());
  iprintln(#"hash_52f20b5836b29e3", self, specialist_name);

  if(isDefined(self.pers[#"changed_specialist"]) && self.pers[#"changed_specialist"]) {
    self notify(#"changed_specialist_death");
  }

  if(game.state == "playing" && !userspawnselection::function_fed7687f() && spawns != 0 && !(isDefined(level.var_324e2795) && level.var_324e2795)) {
    self suicide("MOD_META");
    waitframe(1);
  } else if(game.state == "pregame") {
    self loadout::give_loadout(self.team, self.curclass);
  }

  if(isDefined(self)) {
    self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
  }
}

menuautocontrolplayer() {
  self closemenus();

  if(self.pers[#"team"] != #"spectator") {
    toggleplayercontrol(self);
  }
}

menupositiondraft(response, intpayload) {
  if(response == "changecharacter") {
    if(self draft::function_904deeb2()) {
      self player_role::clear();
    }

    return;
  }

  if(response == "randomcharacter") {
    self player_role::clear();
    draft::assign_remaining_players(self);

    if(!(isDefined(level.inprematchperiod) && level.inprematchperiod)) {
      self draft::close();

      if(!function_8b1a219a()) {
        self closeingamemenu();
      }
    }

    return;
  }

  if(response == "ready") {
    self draft::client_ready();
    return;
  }

  if(response == "opendraft") {
    self draft::open();
    return;
  }

  if(response == "closedraft") {
    self draft::close();
  }
}

removespawnmessageshortly(delay) {
  self endon(#"disconnect");
  waittillframeend();
  self endon(#"end_respawn");
  wait delay;
  self hud_message::clearlowermessage();
}
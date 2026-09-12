/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility.gsc
***********************************************/

function _giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = undefined;

  if(issameweapon(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = asmdevgetallstates(var_0);
  }

  if(var_4 hasattachment("akimbo", 1) || var_4 hasattachment("g18pap2", 1) || isDefined(var_2) && var_2 == 1) {
    self giveweapon(var_4, var_1, 1, -1, var_3);
  } else {
    self giveweapon(var_4, var_1, 0, -1, var_3);
  }

  thread updatelaststandpistol(var_4);
  return var_4;
}

function setplayerstunned() {
  if(!isDefined(self.isstunned)) {
    self.isstunned = 1;
    return;
  }

  self.isstunned++;
}

function waittillphysicsmodelstops() {
  wait 0.5;

  for(;;) {
    var_0 = self physics_getbodyid(0);
    var_1 = physics_getbodylinvel(var_0);

    if(lengthsquared(var_1) > 0.5) {
      wait 0.1;
      continue;
    }

    break;
  }

  self physicsstopserver();
}

function setplayerunstunned() {
  self.isstunned--;
}

function setupdamagetriggers(var_0) {
  var_0 endon("disconnect");

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_wait("infil_complete");
  }

  wait 1;
  var_1 = getEnt("playable_area", "targetname");
  var_2 = getEnt("boundary_toxic_line", "targetname");
  var_3 = isDefined(var_1);
  var_4 = getDvar("ui_mapname");
  var_5 = getDvar("ui_gametype");
  var_0.last_good_pos = undefined;
  var_0.outofbounds = 1;
  var_6 = undefined;

  if(var_5 == "cp_strike") {
    var_7 = "abandon_mission";
    goto LOC_0000008c;
  }

  var_7 = "turn_back";

  for(;;) {
    var_8 = 0;

    if(var_4) {
      var_8 = var_1 istouching(var_2);
    } else {
      var_8 = !var_1 istouching(var_3);
    }

    var_9 = var_1 isonground();
    var_10 = var_1 isonladder();
    var_11 = scripts\cp\cp_laststand::player_in_laststand(var_1);

    if(!var_9 || var_11 || var_10) {
      wait 0.5;
      continue;
    }

    if(var_8) {
      var_1.last_good_pos = var_1.origin;
      var_7 = undefined;

      if(var_1.outofbounds) {
        thread hint_prompt(var_1, var_7);
      }

      var_1.outofbounds = 0;
    } else if(!var_1.outofbounds) {
      thread hint_prompt(var_1, var_7);
      var_1.outofbounds = 1;
      var_7 = gettime() + 5000;
    } else if(isDefined(var_7) && gettime() > var_7) {
      if(isDefined(var_1.hostagecarried) && isDefined(level.hostage) && isDefined(level.hostage_drop)) {
        level.hostage[[level.hostage_drop]](var_1, level.hostage, var_1.last_good_pos, 0, 0.4);
      }

      var_1 dodamage(var_1.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN");
      thread hint_prompt(var_1, var_7);
      thread warp_to_last_good_pos();
    }

    wait 0.5;
  }
}

function warp_to_last_good_pos() {
  self setOrigin(self.last_good_pos);
}

function updatelaststandpistol(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.last_stand_weapons)) {
      var_1 = getweaponbasename(var_0);

      if(scripts\engine\utility::array_contains(level.last_stand_weapons, var_1)) {
        self.last_stand_pistol = var_0;
        return;
      }
    }
  }

  var_2 = self getweaponslistall();
  var_3 = 0;

  if(isDefined(self.last_stand_pistol)) {
    var_4 = getweaponbasename(self.last_stand_pistol);

    foreach(var_6 in var_2) {
      var_7 = getweaponbasename(var_6);

      if(var_7 == var_4) {
        var_3 = 1;
        return;
      }
    }
  }

  if(!var_3) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(var_6 in var_2) {
        var_7 = getweaponbasename(var_6);

        for(var_10 = level.last_stand_weapons.size - 1; var_10 > -1; var_10--) {
          if(var_7 == level.last_stand_weapons[var_10]) {
            var_3 = 1;
            self.last_stand_pistol = var_6;
            return;
          }
        }
      }
    }

    var_12 = getrawbaseweaponname(self.default_starting_pistol);

    if(isDefined(self.weapon_build_models) && isDefined(self.weapon_build_models[var_12])) {
      self.last_stand_pistol = asmdevgetallstates(self.weapon_build_models[var_12]);
      return;
    }

    self.last_stand_pistol = self.default_starting_pistol;
    return;
  }
}

function giveperk(var_0) {
  if(issubstr(var_0, "specialty_weapon_")) {
    _setperk(var_0);
    return;
  }

  _setperk(var_0);
  _setextraperks(var_0);
}

function _hasperk(var_0) {
  var_1 = self.perks;

  if(!isDefined(var_1)) {
    return false;
  }

  if(isDefined(var_1[var_0])) {
    return true;
  }

  return false;
}

function takeperk(var_0) {
  if(issubstr(var_0, "specialty_weapon_")) {
    _unsetperk(var_0);
    return;
  }

  _unsetperk(var_0);
  _unsetextraperks(var_0);
}

function _setperk(var_0) {
  self.perks[var_0] = 1;
  self.perksperkname[var_0] = var_0;
  var_1 = level.perksetfuncs[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

function _setextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _setperk(var_2);
      _setextraperks(var_2);
    }

    return;
  }
}

function _unsetperk(var_0) {
  self.perks[var_0] = undefined;
  self.perksperkname[var_0] = undefined;

  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

function _unsetextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _unsetperk(var_2);
      _unsetextraperks(var_2);
    }

    return;
  }
}

function _clearperks() {
  foreach(var_1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }
  }

  self.perks = [];
  self.perksperkname = [];
  self clearperks();
}

function clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(var_0 = 0; var_0 < self.lowermessages.size; var_0++) {
      self.lowermessages[var_0] = undefined;
    }
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }

  updatelowermessage();
}

function setlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  if(!isDefined(var_9)) {
    var_9 = 1;
  }

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  updatelowermessage();
}

function play_bink_video(var_0, var_1, var_2) {
  thread play_bink_video_internal(level, var_0, var_1);
}

function play_bink_video_internal(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    freezecontrolswrapper(var_4, 1);
  }

  playcinematicforall(var_0);
  wait var_1;

  foreach(var_4 in level.players) {
    freezecontrolswrapper(var_4, 0);

    if(!isDefined(var_2) || !var_2) {
      thread player_black_screen(var_4, 0, 1, 0.5);
    }
  }
}

function updatelowermessage() {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  var_0 = getlowermessage();

  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage settext("");

      if(isDefined(self.lowertimer)) {
        self.lowertimer.alpha = 0;
      }
    }

    return;
  }

  self.lowermessage settext(var_0.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
  self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;

  if(var_0.shouldfade) {
    self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
    self.lowermessage.alpha = var_0.fadetoalpha;
  }

  if(var_0.time > 0 && var_0.showtimer) {
    self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    return;
  }

  if(var_0.time > 0 && !var_0.showtimer) {
    self.lowertimer settext("");
    self.lowermessage fadeovertime(min(var_0.time, 60));
    self.lowermessage.alpha = 0;
    thread clearondeath(var_0);
    thread clearafterfade(var_0);
    return;
  }

  self.lowertimer settext("");
}

function addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = undefined;

  foreach(var_12 in self.lowermessages) {
    if(var_12.name == var_0) {
      if(var_12.text == var_1 && var_12.priority == var_3) {
        return;
      }

      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_10;
  }

  var_10.name = var_0;
  var_10.text = var_1;
  var_10.time = var_2;
  var_10.addtime = gettime();
  var_10.priority = var_3;
  var_10.showtimer = var_4;
  var_10.shouldfade = var_5;
  var_10.fadetoalpha = var_6;
  var_10.fadetoalphatime = var_7;
  var_10.hidewhenindemo = var_8;
  var_10.hidewheninmenu = var_9;
  sortlowermessages();
}

function sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--) {
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];
    }

    self.lowermessages[var_3 + 1] = var_1;
  }
}

function getlowermessage() {
  if(!isDefined(self.lowermessages)) {
    return undefined;
  }

  return self.lowermessages[0];
}

function clearondeath(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

function clearafterfade(var_0) {
  wait var_0.time;
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

function clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

function removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }

      var_2 = self.lowermessages[var_1 - 1];

      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3])) {
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
    return;
  }
}

function freezecontrolswrapper(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self.controlsfrozen = var_0;
}

function setthirdpersondof(var_0) {
  if(var_0) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
    return;
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

function setusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var_0;

  if(scripts\common\utility::is_offhand_weapons_allowed()) {
    scripts\common\utility::allow_offhand_weapons(0);
  }

  self notify("using_remote");
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

function isusingremote() {
  return isDefined(self.usingremote);
}

function updatesessionstate(var_0, var_1) {
  self.sessionstate = var_0;

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self.statusicon = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

function getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

function gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

function gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

function gameflag(var_0) {
  return game["flags"][var_0];
}

function gameflagwait(var_0) {
  while(!gameflag(var_0)) {
    level waittill(var_0);
  }
}

function matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

function inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

function initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
    return;
  }
}

function initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
    return;
  }
}

function isenemy(var_0) {
  if(level.teambased) {
    return isplayeronenemyteam(var_0);
  }

  return isplayerffaenemy(var_0);
}

function isplayeronenemyteam(var_0) {
  return var_0.team != self.team;
}

function isplayerffaenemy(var_0) {
  if(isDefined(var_0.owner)) {
    return (var_0.owner != self);
  }

  return var_0 != self;
}

function isgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}

function notusableforjoiningplayers(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
  }
}

function setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

function isenvironmentweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(issameweapon(var_0)) {
    if(var_0.basename == "turret_minigun_mp") {
      return true;
    } else {
      return false;
    }
  }

  if(var_0 == "turret_minigun_mp") {
    return true;
  }

  return false;
}

function issuperweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = createheadicon(var_0);
  } else {
    var_1 = var_0;
  }

  if(isDefined(level.superweapons) && isDefined(level.superweapons[var_1])) {
    return true;
  }

  return false;
}

function strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

function playteamfxforclient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(self.team != var_0) {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_3), var_1, self);
  } else {
    var_6 = spawnfxforclient(scripts\engine\utility::getfx(var_2), var_1, self);
  }

  if(isDefined(var_6)) {
    triggerfx(var_6);
  }

  thread delayentdelete(var_6);

  if(isDefined(var_5) && var_5) {
    thread deleteonplayerdeathdisconnect(var_6);
  }

  return var_6;
}

function toggle_team_emp_effects(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(var_6.team != var_0) {
      continue;
    }

    var_4 = var_6;
  }

  if(istrue(var_1)) {
    foreach(var_6 in var_4) {
      thread toggle_player_emp_effects(var_6, 1, var_2);
    }

    return;
  }

  foreach(var_6 in var_4) {
    thread toggle_player_emp_effects(var_6, 0);
  }
}

function toggle_player_emp_effects(var_0, var_1, var_2) {
  if(istrue(var_1)) {
    var_3 = getcompleteweaponname("emp_drone_non_player_mp");
    var_4 = &scripts\cp_mp\utility\damage_utility::packdamagedata;
    var_5 = [[var_4]](var_0, var_0, 1, var_3);
    thread _emp_grenade_apply_player(var_0, var_5);
    return;
  }

  var_0 notify("emp_cleared");
}

function _emp_grenade_apply_player(var_0, var_1) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  _emp_grenade_end_early(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function _emp_grenade_end_early(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);
    return;
  }

  self waittill("emp_cleared");
}

function delayentdelete(var_0) {
  self endon("death");
  wait var_0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function deleteonplayerdeathdisconnect(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::ref_143A5("death", "disconnect");
  self delete();
}

function isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

function getbaseweaponname(var_0) {
  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_1;
  }

  var_2 = strtok(var_1, "_");
  var_3 = 0;

  if(var_2[0] == "alt") {
    var_3++;
  }

  if(var_2[var_3] == "iw7") {
    var_1 = var_2[var_3] + "_" + var_2[var_3 + 1];
  } else if(var_2[var_3] == "iw8" || var_2[var_3] == "s4") {
    var_4 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la"];

    if(scripts\engine\utility::array_contains(var_4, var_2[var_3 + 1])) {
      var_1 = var_2[var_3] + "_" + var_2[var_3 + 1] + "_" + var_2[var_3 + 2];
    } else {
      var_1 = var_2[var_3] + "_" + var_2[var_3 + 1];
    }
  }

  return var_1;
}

function getzbaseweaponname(var_0, var_1) {
  var_2 = strtok(var_0, "_");

  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[0] + "_z" + var_2[1] + var_1;
    } else {
      var_0 = var_2[0] + "_z" + var_2[1];
    }
  } else if(var_2[0] == "alt") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[1] + "_z" + var_2[2] + var_1;
    } else {
      var_0 = var_2[1] + "_z" + var_2[2];
    }
  }

  return var_0;
}

function get_closest_entrance(var_0) {
  if(!isDefined(level.window_entrances)) {
    return undefined;
  }

  var_1 = sortbydistance(level.window_entrances, var_0);

  foreach(var_3 in var_1) {
    if(var_3.enabled) {
      return var_3;
    }
  }

  return undefined;
}

function entrance_is_fully_repaired(var_0) {
  if(!isDefined(var_0.barrier)) {
    return true;
  }

  var_1 = [[level.next_board_to_repair_func]](var_0);

  if(!isDefined(var_1)) {
    return true;
  }

  return false;
}

function is_weapon_purchase_disabled() {
  return istrue(level.weapon_purchase_disabled);
}

function get_attachment_from_interaction(var_0) {
  var_1 = var_0.item.model;
  var_2 = "arkblue";
  var_3 = "stun_ammo";

  switch (var_1) {
    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_2 = "arcane_base";
      break;
    default:
      break;
  }

  return var_2;
}

function are_any_consumables_active() {
  foreach(var_1 in self.consumables) {
    if(var_1.on == 1) {
      return true;
    }
  }

  return false;
}

function getrawbaseweaponname(var_0) {
  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_1;
  }

  var_2 = strtok(var_1, "_");

  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    var_1 = var_2[1];
  } else if(var_2[0] == "alt") {
    var_1 = var_2[2];
  }

  return var_1;
}

function getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

function leaderdialogonplayer(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = self.pers["team"];

  if(isDefined(var_4) && (var_4 == "axis" || var_4 == "allies")) {
    var_5 = game["voice"][var_4] + game["dialog"][var_0];
    self queuedialogforplayer(var_5, var_0, 2, var_1, var_2, var_3);
    return;
  }
}

function _setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0].item = var_2;
  self setactionslot(var_0, var_1, var_2);
}

function getkillstreakweapon(var_0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_COL, var_0, level.global_tables["killstreakTable"].weapon_col);
}

function _objective_delete(var_0) {
  objective_delete(var_0);

  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_0;
    return;
  }

  level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_0;
}

function touchingbadtrigger(var_0) {
  var_1 = getEntArray("trigger_hurt", "classname");

  foreach(var_3 in var_1) {
    if(self istouching(var_3) && (level.mapname != "mp_mine" || var_3.dmg > 0)) {
      return true;
    }
  }

  var_5 = getEntArray("radiation", "targetname");

  foreach(var_3 in var_5) {
    if(self istouching(var_3)) {
      return true;
    }
  }

  if(isDefined(var_0) && var_0 == "gryphon") {
    var_8 = getEntArray("gryphonDeath", "targetname");

    foreach(var_3 in var_8) {
      if(self istouching(var_3)) {
        return true;
      }
    }
  }

  return false;
}

function playsoundinspace(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      var_0 = scripts\engine\utility::random(var_0);
    }

    var_3 = lookupsoundlength(var_0);
    playsoundatpos(var_1, var_0);

    if(isDefined(var_2)) {
      wait var_3 / 1000;
    }

    return var_3;
  }
}

function play_random_sound_in_space(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(!isarray(var_0)) {
      var_3 = [];
      GscBinSkip0(0x2e, 0, var_0);
    }

    var_4 = scripts\engine\utility::random(var_1);
    var_5 = lookupsoundlength(var_4);
    playsoundatpos(var_2, var_4);

    if(isDefined(var_3)) {
      wait var_5;
    }

    return var_5;
  }
}

function play_looping_sound_on_ent(var_0) {
  if(soundexists(var_0)) {
    self playLoopSound(var_0);
    return;
  }
}

function stop_looping_sound_on_ent(var_0) {
  if(soundexists(var_0)) {
    self stoploopsound(var_0);
    return;
  }
}

function playdeathsound() {
  var_0 = randomintrange(1, 8);
  var_1 = "generic";

  if(self hasfemalecustomizationmodel()) {
    var_1 = "female";
  }

  if(self.team == "axis") {
    var_2 = var_1 + "_death_russian_" + var_0;

    if(soundexists(var_2)) {
      self playSound(var_2);
      return;
    }

    return;
  }

  var_2 = var_2 + "_death_american_" + var_1;

  if(soundexists(var_2)) {
    self playSound(var_2);
    return;
  }
}

function isfmjdamage(var_0, var_1, var_2) {
  return isDefined(var_2) && _hasperk(var_2, "specialty_armorpiercing") && isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1);
}

function ischangingweapon() {
  return isDefined(self.changingweapon);
}

function getattachmenttype(var_0) {
  if(!isDefined(var_0)) {
    return "none";
  }

  var_1 = tablelookup("mp/attachmenttable.csv", 4, var_0, 2);

  if(!isDefined(var_1) || isDefined(var_1) && var_1 == "") {
    var_2 = getDvar("g_gametype");

    if(var_2 == "zombie") {
      var_1 = tablelookup("cp/zombies/zombie_attachmentTable.csv", 4, var_0, 2);
    }
  }

  return var_1;
}

function weaponhasattachment(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "") {
    return false;
  }

  var_2 = getweaponattachmentsbasenames(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return true;
    }
  }

  return false;
}

function getweaponattachmentsbasenames(var_0) {
  var_1 = getweaponattachments(var_0);

  foreach(var_3 in var_1) {
    var_1 = attachmentmap_tobase(var_3);
  }

  return var_1;
}

function attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0])) {
    var_0 = level.attachmentmap_uniquetobase[var_0];
  }

  return var_0;
}

function useeventtimestamp(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "barsil_") || var_0 == "barcust2_mpapa5";
}

function useeventtype(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "silencer");
}

function tv_station_fastrope_two_infil_rider_start_targetname(var_0) {
  return var_0 == "calcust" || var_0 == "calsmg" || var_0 == "calsmgdrums";
}

function isjuggernaut() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    return true;
  }

  if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1) {
    return true;
  }

  if(isDefined(self.isjuggernautdef) && self.isjuggernautdef == 1) {
    return true;
  }

  if(isDefined(self.isjuggernautgl) && self.isjuggernautgl == 1) {
    return true;
  }

  if(isDefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1) {
    return true;
  }

  if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1) {
    return true;
  }

  if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1) {
    return true;
  }

  return false;
}

function attachmentmap_tounique(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_1)) {
    var_2 = createheadicon(var_1);
  } else {
    var_2 = var_1;
  }

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_4][level.attachmentmap_uniquetobase[var_0]])) {
      var_5 = level.attachmentmap_uniquetobase[var_0];
      return level.attachmentmap_basetounique[var_4][var_5];
    } else if(isDefined(level.attachmentmap_basetounique[var_5]) && isDefined(level.attachmentmap_basetounique[var_5][var_1])) {
      return level.attachmentmap_basetounique[var_5][var_1];
    } else {
      var_6 = strtok(var_5, "_");

      if(var_6.size > 3) {
        var_7 = var_6[0] + "_" + var_6[1] + "_" + var_6[2];

        if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_1])) {
          return level.attachmentmap_basetounique[var_7][var_1];
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_1])) {
    return level.attachmentmap_basetounique[var_4][var_1];
  } else {
    var_8 = weapongroupmap(var_4);

    if(isDefined(level.attachmentmap_basetounique[var_8]) && isDefined(level.attachmentmap_basetounique[var_8][var_1])) {
      return level.attachmentmap_basetounique[var_8][var_1];
    }
  }

  return var_1;
}

function weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group)) {
    return level.weaponmapdata[var_0].group;
  }

  return undefined;
}

function weaponnumbermap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].number)) {
    return level.weaponmapdata[var_0].number;
  }

  return undefined;
}

function allowridekillstreakplayerexit(var_0, var_1) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  if(isDefined(var_1)) {
    var_2 = self;
  } else {
    if(!isDefined(self.owner)) {
      return;
    }

    var_2 = self.owner;
  }

  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("end_remote");
  var_2 notify("watch_use_exit");
  var_2 endon("diable_use_exit");
  self endon("death");
  thread allow_force_player_exit();

  if(!isDefined(level.framedurationseconds)) {
    level.framedurationseconds = level.frameduration / 1000;
  }

  var_3 = level.framedurationseconds;
  var_4 = 0.75;
  var_5 = 1;

  for(;;) {
    var_6 = 0;

    if(var_5 == 1) {
      var_2 setclientomnvar("ui_exit_progress", 0);
      var_5 = 0;
    }

    while(var_2 useButtonPressed()) {
      var_6 += var_3;
      var_5 = 1;
      var_2 setclientomnvar("ui_exit_progress", var_6 / var_4);

      if(var_6 > var_4) {
        self notify("killstreakExit");
        return;
      }

      wait var_3;
    }

    wait var_3;
  }
}

function allow_force_player_exit() {
  self endon("killstreakExit");
  level waittill("cp_force_killstreak_exit");
  self notify("killstreakExit");
}

function killstreak_createobjective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = nonobjective_requestobjectiveid(1);
  objective_position(var_5, self.origin);
  objective_icon(var_5, var_0);
  objective_state(var_5, "active");
  objective_setbackground(var_5, 1);

  if(!isDefined(self getlinkedparent()) && !istrue(var_3)) {
    update_objective_position(var_5, self.origin);
  } else if(istrue(var_3) && istrue(var_4)) {
    update_objective_onentitywithrotation(var_5, self);
  } else {
    update_objective_onentity(var_5, self);
  }

  if(isDefined(var_1)) {
    objective_setownerteam(var_5, var_1);

    if(!level.teambased && isDefined(self.owner)) {
      if(istrue(var_2)) {
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_5, self.owner);
      } else {
        scripts\mp\objidpoolmanager::objective_teammask_single(var_5, var_1);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_5);
  }

  return var_5;
}

function vo_ten_remain(var_0, var_1, var_2) {
  var_3 = nonobjective_requestobjectiveid(1);

  if(var_3 == -1) {
    return -1;
  }

  objective_delete(var_3);
  objective_state(var_3, "invisible");
  objective_position(var_3, (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_1)) {
    update_objective_position(var_3, self.origin);
  } else if(istrue(var_1) && istrue(var_2)) {
    update_objective_onentitywithrotation(var_3, self);
  } else {
    update_objective_onentity(var_3, self);
  }

  objective_state(var_3, "active");
  objective_icon(var_3, var_0);
  objective_setbackground(var_3, 1);
  objective_setownerteam(var_3, self.team);
  scripts\cp\cp_objectives::minimap_objective_playermask_hidefromall(var_3);
  return var_3;
}

function update_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_position(var_0, var_1);
}

function update_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
}

function update_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

function nonobjective_returnobjectiveid(var_0) {
  scripts\cp\cp_objectives::freeworldidbyobjid(var_0);
}

function nonobjective_requestobjectiveid(var_0) {
  return scripts\cp\cp_objectives::requestworldid("nonobj_marker", 1);
}

function clearusingremote(var_0) {
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    _freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

function cp_add_dialogue_line(var_0) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }

  if(istrue(level.livescount)) {
    return;
  }

  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }

  if(level.dialogue_huds.size == 5) {
    var_1 = level.dialogue_huds[0];
    level.dialogue_huds = scripts\engine\utility::array_remove_index(level.dialogue_huds, 0);
    scripts\engine\utility::update_dialogue_huds();
    var_1 thread scripts\engine\utility::destroy_dialogue_hud();
  }

  if(soundexists("cp_ui_menu_title_decode_text")) {
    foreach(var_3 in level.players) {
      var_3 playlocalsound("cp_ui_menu_title_decode_text");
    }
  }

  var_5 = "^3";
  var_6 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var_6 = level.dialoguelinescale;
  }

  var_7 = newhudelem();
  var_7.elemtype = "font";
  var_7.font = "default";
  var_7.fontscale = var_6;
  var_7.x = 0;
  var_7.y = 0;
  var_7.width = 0;
  var_7.height = int(level.fontheight * var_6);
  var_7.xoffset = 0;
  var_7.yoffset = 0;
  var_8 = level.dialogue_huds.size;
  level.dialogue_huds[var_8] = var_7;
  var_7.foreground = 1;
  var_7.sort = 20;
  var_7.x = 40;
  var_7.y = 260 + var_8 * 12 * var_6;
  var_7.label = var_0;
  var_7.alpha = 0;
  var_7 fadeovertime(0.2);
  var_7.alpha = 1;
  var_7 endon("death");
  wait 8;
  level.dialogue_huds = scripts\engine\utility::array_remove(level.dialogue_huds, var_7);
  scripts\engine\utility::update_dialogue_huds();
  thread cp_destroy_dialogue_hud();
}

function cp_destroy_dialogue_hud() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var_0 = level.dialoguelinescale;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function getfirstprimaryweapon() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

function set_visionset_for_watching_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_players_watching(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");

    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      thread reset_visionset_on_team_change(var_8, self);
      thread reset_visionset_on_disconnect(var_8);

      if(isinkillcam(var_8)) {
        thread reset_visionset_on_spawn();
      }
    }
  }
}

function get_players_watching(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }

    var_6 = 0;

    if(!var_1) {
      if(var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5.forcespectatorclient == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function reset_visionset_on_team_change(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(get_players_watching(var_0), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

function reset_visionset_on_disconnect(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");

  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0);
    return;
  }

  self visionsetnakedforplayer("", 0);
}

function reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");

  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0);
    return;
  }

  self visionsetnakedforplayer("", 0);
}

function isinkillcam() {
  return self.spectatekillcam;
}

function createfontstring(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !var_2) {
    var_3 = newclienthudelem(self);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3.font = var_1;
  var_3.fontscale = var_2;
  var_3.basefontscale = var_2;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_2);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  setparent(var_3, level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

function setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }

  if(isDefined(self.parent)) {
    removechild(self.parent, self);
  }

  self.parent = var_0;
  addchild(self.parent, self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("TOPLEFT");
}

function removechild(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

function addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

function removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  var_0 = [];

  foreach(var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2.index = var_0.size;
    var_0 = var_2;
  }

  self.children = var_0;
}

function setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = getparent();

  if(var_4) {
    self moveovertime(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }

  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }

  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }

  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_8 == "center" || var_7.alignx == "center") {
    var_8 = int(var_7.width / 2);

    if(var_8 == "left_adjustable" || var_7.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_8.width;

    if(var_9 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_9.x + var_9 * var_9;

  if(strip_suffix(var_8, "_adjustable") == var_9.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_9 == "middle" || var_8.aligny == "middle") {
    var_10 = int(var_8.height / 2);

    if(var_9 == "top_adjustable" || var_8.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_10.height;

    if(var_10 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_11.y + var_11 * var_11;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_9, var_8, var_9, var_9);
      break;
  }

  updatechildren();
}

function getparent() {
  return self.parent;
}

function setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }

  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }

  updatebar(self.bar.frac);
}

function updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
    return;
  }
}

function updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / -1 * var_1, 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

function updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    setpoint(var_1, var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

function createicon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_4 = newclienthudelem(self);
  } else {
    var_4 = newhudelem();
  }

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_2;
  var_4.height = var_3;
  var_4.basewidth = var_4.width;
  var_4.baseheight = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  setparent(var_4, level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_1)) {
    var_4 setshader(var_1, var_2, var_3);
    var_4.shader = var_1;
  }

  return var_4;
}

function destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0 = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    setparent(var_0[var_1], getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

function showelem() {
  if(!self.hidden) {
    return;
  }

  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
      return;
    }

    return;
  }

  if(self.alpha != 1) {
    self.alpha = 1;
    return;
  }
}

function hideelem() {
  if(self.hidden) {
    return;
  }

  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
      return;
    }

    return;
  }
}

function createprimaryprogressbartext(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 += 20;
  }

  var_4 = level.primaryprogressbarfontsize;
  var_5 = "default";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = createfontstring(var_5, var_4);
  setpoint(var_6, "CENTER", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_6.sort = -1;
  return var_6;
}

function createprimaryprogressbar(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 += 20;
  }

  if(!isDefined(var_2)) {
    var_2 = level.primaryprogressbarwidth;
  }

  if(!isDefined(var_3)) {
    var_3 = level.primaryprogressbarheight;
  }

  var_4 = createbar((1, 1, 1), var_2, var_3);
  setpoint(var_4, "CENTER", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_4;
}

function createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
  }

  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  setparent(var_5, level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

function isgameparticipant(var_0) {
  if(isaigameparticipant(var_0)) {
    return true;
  }

  if(isPlayer(var_0)) {
    return true;
  }

  return false;
}

function isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1) {
    return true;
  }

  if(isbot(var_0)) {
    return true;
  }

  return false;
}

function setteamheadicon(var_0, var_1) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_2 = game["entity_headicon_" + var_0];
  self.entityheadiconteam = var_0;

  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");

  if(var_0 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_3 = newteamhudelem(var_0);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.z = self.origin[2] + self.entityheadiconoffset[2];
  var_3.alpha = 0.8;
  var_3 setshader(var_2, 10, 10);
  var_3 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_3;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

function setplayerheadicon(var_0, var_1) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(var_0)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_2 = var_0.team;
  self.entityheadiconteam = var_2;

  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var_3 = game["entity_headicon_" + var_2];
  var_4 = newclienthudelem(var_0);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.z = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_4 setshader(var_3, 10, 10);
  var_4 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_4;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

function keepiconpositioned() {
  self.entityheadicon linkwaypointtotargetwithoffset(self, self.entityheadiconoffset);
}

function destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }

  self.entityheadicon destroy();
}

function setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isgameparticipant(var_0) && !isPlayer(var_0)) {
    return;
  }

  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.05;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!isPlayer(var_0) && var_0 == "none") {
    foreach(var_13, var_12 in self.entityheadicons) {
      if(isDefined(var_12)) {
        var_12 destroy();
      }

      self.entityheadicons[var_13] = undefined;
    }

    return;
  }

  if(isPlayer(var_3)) {
    if(isDefined(self.entityheadicons[var_3.guid])) {
      self.entityheadicons[var_3.guid] destroy();
      self.entityheadicons[var_3.guid] = undefined;
    }

    if(var_4 == "") {
      return;
    }

    if(isDefined(var_3.team)) {
      if(isDefined(self.entityheadicons[var_3.team])) {
        self.entityheadicons[var_3.team] destroy();
        self.entityheadicons[var_3.team] = undefined;
      }
    }

    var_12 = newclienthudelem(var_3);
    self.entityheadicons[var_3.guid] = var_12;
  } else {
    if(isDefined(self.entityheadicons[var_4])) {
      self.entityheadicons[var_4] destroy();
      self.entityheadicons[var_4] = undefined;
    }

    jumpiffalse(var_5 == "") LOC_00000175;
    return;
  }

  if(!isDefined(var_7) || !isDefined(var_8)) {
    var_7 = 10;
    var_8 = 10;
  }

  var_12.archived = var_9;
  var_12.x = self.origin[0] + var_6[0];
  var_12.y = self.origin[1] + var_6[1];
  var_12.z = self.origin[2] + var_6[2];
  var_12.alpha = 0.85;
  var_12 setshader(var_5, var_7, var_8);
  var_12 setwaypoint(var_11, var_12, var_13, var_12);
  thread keeppositioned(var_12, self, var_6);
  thread destroyiconsondeath();

  if(isPlayer(var_4)) {
    thread destroyonownerdisconnect(var_12);
  }

  if(isPlayer(self)) {
    thread destroyonownerdisconnect(var_12);
  }

  return var_12;
}

function showheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0.85;
    }
  }
}

function hideheadicon(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0;
    }
  }
}

function getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

function getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var_0 = var_2;
  }

  return var_0;
}

function getplayersinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_player"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

function getactorsinradius(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_actor"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

function getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0) {
    return [];
  }

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_5 = var_3;
    } else {
      var_5 = [var_3];
    }
  }

  var_6 = physics_querypoint(var_0, var_1, var_4, var_5, "physicsquery_all");
  var_7 = [];
  jumpiftrue(isDefined(var_2)) LOC_00000078;

  foreach(var_9 in var_6) {
    var_10 = var_9["entity"];
    var_7 = var_10;
  }

  goto LOC_000000c4;
}

function keeppositioned(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = isDefined(var_0.classname) && !isownercarepakage(var_0);

  if(var_3) {
    self linkwaypointtotargetwithoffset(var_0, var_1);
  }

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!var_3) {
      var_4 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.z = var_4[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait var_2;
  }
}

function isownercarepakage(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "care_package";
}

function destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  if(!isDefined(self.entityheadicons)) {
    return;
  }

  foreach(var_1 in self.entityheadicons) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 destroy();
  }
}

function destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self destroy();
}

function _suicide() {
  if(!isusingremote() && !isDefined(self.fauxdead)) {
    self suicide();
    return;
  }
}

function player_lua_progressbar(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5);
  return var_6;
}

function lua_progress_bar_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = var_1;
  thread create_lua_progress_bar(var_0, self);
  var_0.hasprogressbar = 1;
  var_6 = lua_progress_bar_think_loop(var_0, self, var_2, var_4, var_5);

  if(isalive(var_0)) {
    var_0.hasprogressbar = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var_6;
}

function create_lua_progress_bar(var_0, var_1) {
  self endon("disconnect");
  self setclientomnvar("ui_securing", var_1);
  var_2 = -1;

  while(scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }
    }

    var_2 = var_0.userate;
    self setclientomnvar("ui_securing_progress", var_0.curprogress / var_0.usetime);
    wait 0.05;
  }

  wait 0.5;
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_securing", 0);
}

function lua_progress_bar_think_loop(var_0, var_1, var_2, var_3, var_4) {
  while(!level.gameended && isDefined(self) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && (var_0 useButtonPressed() || isDefined(var_3) || var_0 attackButtonPressed() && isDefined(var_4)) && should_continue_progress_bar_think(var_0)) {
    wait 0.05;

    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2) {
        return 0;
      }
    }

    self.curprogress += 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      var_0 setclientomnvar("ui_securing_progress", 1);
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();
    }
  }

  return 0;
}

function should_continue_progress_bar_think(var_0) {
  if(isDefined(level.should_continue_progress_bar_think)) {
    return [[level.should_continue_progress_bar_think]](var_0);
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

function isplayingsolo() {
  if(getmaxclients() == 1) {
    return true;
  }

  return false;
}

function removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.participants.size - 1) {
        level.participants[var_1] = level.participants[var_1 + 1];
        var_1++;
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

function removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.characters.size - 1) {
        level.characters[var_1] = level.characters[var_1 + 1];
        var_1++;
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

function removefromspawnedgrouparray() {
  if(isDefined(self.group_name)) {
    if(isDefined(level.spawned_group) && isDefined(level.spawned_group[self.group_name])) {
      level.spawned_group[self.group_name] = scripts\engine\utility::array_remove(level.spawned_group[self.group_name], self);
      return;
    }

    return;
  }
}

function createtimer(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  setparent(var_2, level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

function relic_bang_and_boom_dropfunc(var_0) {
  if(var_0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var_0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var_0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var_0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function respawn_flare_wavesv_used_playereffects(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = undefined;

  switch (var_0) {
    case 300:
      if(istrue(var_2) && scripts\engine\utility::cointoss()) {
        var_3 = "dx_cps_lass_timecheck_5min_10";
      } else {
        var_3 = "dx_cps_kama_timecheck_5min_10";
      }

      break;
    case 120:
      if(istrue(var_2) && scripts\engine\utility::cointoss()) {
        var_3 = "dx_cps_lass_timecheck_2min_20";
      } else {
        var_3 = "dx_cps_kama_timecheck_2min_20";
      }

      break;
    case 60:
      if(istrue(var_2) && scripts\engine\utility::cointoss()) {
        var_3 = "dx_cps_lass_timecheck_1min_30";
      } else {
        var_3 = "dx_cps_kama_timecheck_1min_30";
      }

      break;
    case 30:
      if(istrue(var_2) && scripts\engine\utility::cointoss()) {
        var_3 = "dx_cps_lass_timecheck_30sec_40";
      } else {
        var_3 = "dx_cps_kama_timecheck_30sec_40";
      }

      break;
    case 10:
      if(istrue(var_2) && scripts\engine\utility::cointoss()) {
        var_3 = "dx_cps_lass_timecheck_10sec_50";
      } else {
        var_3 = "dx_cps_kama_timecheck_10sec_50";
      }

      break;
  }

  return var_3;
}

function _detachall(var_0) {
  if(!istrue(var_0)) {
    self.headmodel = undefined;
  }

  if(isDefined(self.riotshieldmodel)) {
    riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    riotshield_detach(0);
  }

  self.hasriotshieldequipped = 0;

  if(!istrue(var_0)) {
    self detachall();
  }

  scripts\cp\equipment\nvg::clearnvg(istrue(var_0));
}

function is_valid_perk(var_0) {
  var_1 = getarraykeys(level.alien_perks["perk_0"]);

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  var_2 = getarraykeys(level.alien_perks["perk_1"]);

  if(scripts\engine\utility::array_contains(var_2, var_0)) {
    return 1;
  }

  var_3 = getarraykeys(level.alien_perks["perk_2"]);
  return scripts\engine\utility::array_contains(var_3, var_0);
}

function is_consumable_active(var_0) {
  if(isDefined(self.consumables) && isDefined(self.consumables[var_0]) && isDefined(self.consumables[var_0].on) && self.consumables[var_0].on == 1) {
    return 1;
  }

  return 0;
}

function notify_used_consumable(var_0) {
  self notify(self.consumables[var_0].usednotify);
}

function notify_timeup_consumable(var_0) {
  self notify(level.consumables[var_0].timeupnotify);
}

function drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

function is_upgrade_enabled(var_0) {
  if(!is_using_extinction_tokens()) {
    return 0;
  }

  if(self getplayerdata("cp", "upgrades_enabled_flags", var_0)) {
    return 1;
  }

  return 0;
}

function allow_player_teleport(var_0, var_1) {
  if(var_0) {
    if(!isDefined(self.teleportdisableflags) && isDefined(var_1)) {
      foreach(var_3 in self.teleportdisableflags) {
        if(var_3 == var_1) {
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, var_1);
        }
      }
    }

    self.disabledteleportation--;

    if(!self.disabledteleportation) {
      self.teleportdisableflags = [];
      self.can_teleport = 1;
      self notify("can_teleport");
      return;
    }

    return;
  }

  if(!isDefined(self.teleportdisableflags)) {
    self.teleportdisableflags = [];
  }

  if(isDefined(var_1)) {
    self.teleportdisableflags[self.teleportdisableflags.size] = var_1;
  }

  self.disabledteleportation++;
  self.can_teleport = 0;
}

function ismeleeenabled() {
  return !isDefined(self.disabledmelee) || !self.disabledmelee;
}

function isteleportenabled() {
  return !isDefined(self.disabledteleportation) || !self.disabledteleportation;
}

function allow_player_interactions(var_0) {
  if(var_0) {
    self.disabledinteractions--;

    if(!self.disabledinteractions) {
      self.interactions_disabled = undefined;
      return;
    }

    return;
  }

  self.disabledinteractions++;
  self.interactions_disabled = 1;
}

function areinteractionsenabled() {
  return self.disabledinteractions < 1;
}

function _linkTo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = "tag_origin";
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  if(!isDefined(self.playerlinkedcounter)) {
    self.playerlinkedcounter = 0;
  }

  self.playerlinkedcounter++;

  if(self.playerlinkedcounter == 1) {
    self linkTo(var_1, var_2, var_3, var_4);
    return;
  }
}

function _unlink() {
  if(isplayerlinked()) {
    self.playerlinkedcounter--;

    if(self.playerlinkedcounter <= 0) {
      self.playerlinkedcounter = 0;
      self unlink();
      return;
    }

    return;
  }
}

function get_linked_struct() {
  var_0 = scripts\engine\utility::get_linked_structs();

  if(!var_0.size) {
    return undefined;
  }

  return var_0[0];
}

function isplayerlinked() {
  return isDefined(self.playerlinkedcounter) && self.playerlinkedcounter > 0;
}

function enable_infinite_ammo(var_0) {
  if(var_0) {
    self.infiniteammocounter++;
    self setclientomnvar("zm_ui_unlimited_ammo", 1);
    return;
  }

  if(self.infiniteammocounter > 0) {
    self.infiniteammocounter--;
  }

  if(!self.infiniteammocounter) {
    self setclientomnvar("zm_ui_unlimited_ammo", 0);
    return;
  }
}

function isinfiniteammoenabled() {
  return self.infiniteammocounter >= 1;
}

function brjugg_playerwelcomesplashes(var_0) {
  if(!isDefined(self.move_door_to_pos)) {
    self.move_door_to_pos = 0;
  }

  if(var_0) {
    self.move_door_to_pos++;
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
    return;
  }

  self.move_door_to_pos--;

  if(self.move_door_to_pos < 0) {
    self.move_door_to_pos = 0;
  }

  if(!self.move_door_to_pos) {
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
    return;
  }
}

function brjugg_setconfig(var_0) {
  if(!isDefined(self.move_entity)) {
    self.move_entity = 0;
  }

  if(var_0) {
    self.move_entity++;
    hideminimap(1);
    return;
  }

  self.move_entity--;

  if(self.move_entity < 0) {
    self.move_entity = 0;
  }

  if(!self.move_entity) {
    showminimap();
    return;
  }
}

function trophy_get_part_by_tag() {
  if(isDefined(self.move_entity) && self.move_entity > 0) {
    return true;
  }

  return false;
}

function allow_player_ignore_me(var_0) {
  if(var_0) {
    self.enabledignoreme++;
    self.ignoreme = 1;
    return;
  }

  self.enabledignoreme--;

  if(!self.enabledignoreme) {
    self.ignoreme = 0;
    return;
  }
}

function brjugg_startdelivery(var_0) {
  if(var_0) {
    self.move_hvt_from_under_heli++;
    self.shouldskiplaststand = 1;
    return;
  }

  self.move_hvt_from_under_heli--;

  if(!self.move_hvt_from_under_heli) {
    self.shouldskiplaststand = 0;
    return;
  }
}

function brjugg_setjuggwatchers(var_0) {
  if(var_0) {
    self.move_gate++;
    self.shouldskipdeathsshield = 1;
    return;
  }

  self.move_gate--;

  if(!self.move_gate) {
    self.shouldskipdeathsshield = 0;
    return;
  }
}

function update_bomb_vest_cell_phone_holder_timer() {
  return self.move_hvt_from_under_heli >= 1;
}

function uihidden() {
  return self.move_gate >= 1;
}

function isignoremeenabled() {
  return self.enabledignoreme >= 1;
}

function force_usability_enabled() {
  scripts\common\input_allow::clear_allow_info("usability");
  self enableusability();
}

function is_using_extinction_tokens() {
  return false;
}

function coop_getweaponclass(var_0) {
  if(!isDefined(var_0)) {
    return "none";
  }

  if(issameweapon(var_0) && nullweapon(var_0)) {
    return "none";
  }

  if(isstring(var_0) && var_0 == "none") {
    return "none";
  }

  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup("mp/statstable.csv", 4, var_1, 1);

  if(var_2 == "" && isDefined(level.game_mode_statstable)) {
    if(isDefined(var_0)) {
      var_1 = getbaseweaponname(var_0);
      var_2 = tablelookup(level.game_mode_statstable, 4, var_1, 2);
    }
  }

  if(isenvironmentweapon(var_0)) {
    var_2 = "weapon_mg";
  } else if(issameweapon(var_0) && nullweapon(var_0)) {
    var_2 = "other";
  } else if(isstring(var_0) && var_0 == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  return var_2;
}

function is_holding_deployable() {
  return istrue(self.is_holding_deployable);
}

function has_special_weapon() {
  return istrue(self.has_special_weapon);
}

function filloffhandweapons(var_0, var_1) {
  var_2 = self getweaponslistoffhands();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  foreach(var_7 in var_2) {
    if(var_7 != var_0) {
      if(nullweapon(var_7)) {
        continue;
      }

      var_8 = var_7.basename;

      if(var_8 != "alienthrowingknife_mp" && var_8 != "alientrophy_mp" && var_8 != "iw6_aliendlc21_mp") {
        self takeweapon(var_7);
      }

      continue;
    }

    if(!nullweapon(var_7)) {
      var_5 = self getammocount(var_7);
      self setweaponammostock(var_7, var_5 + var_1);
      var_3 = 1;
      break;
    }
  }

  if(var_3 == 0) {
    _giveweapon(var_0);
    self setweaponammostock(var_0, var_1);
    return;
  }
}

function getequipmenttype(var_0) {
  switch (var_0) {
    case "impalement_spike_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncing_betty_mp":
    case "throwingknifec4_mp":
    case "at_mine_mp":
    case "throwingknifesmokewall_mp":
    case "claymore_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "c4_mp_p":
    case "c4_zm":
    case "frag_grenade_mp":
    case "frag_grenade_zm":
    case "pop_rocket_mp":
    case "throwingknife_mp":
    case "throwingknife":
    case "gas_mp":
    case "molotov_mp":
    case "molotov":
    case "splash_grenade_zm":
    case "semtex_mp":
    case "semtex":
    case "frag":
    case "arc_grenade_mp":
    case "zom_repulsor_mp":
    case "thermite_mp":
    case "splash_grenade_mp":
      var_1 = "lethal";
      break;
    case "ztransponder_mp":
    case "transponder_mp":
    case "blackout_grenade_mp":
    case "player_trophy_system_mp":
    case "proto_ricochet_device_mp":
    case "emp_grenade_mp":
    case "mobile_radar_mp":
    case "gravity_grenade_mp":
    case "alienflare_mp":
    case "concussion_grenade_mp":
    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
    case "thermobaric_grenade_mp":
    case "portal_generator_zm":
    case "portal_generator_mp":
    case "flash_grenade_mp":
    case "dud_grenade_zm":
    case "noisemaker":
    case "teargas":
    case "smoke_tall":
    case "smoke":
    case "flash":
    case "trophy_mp":
    case "signal":
      var_1 = "tactical";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

function giveperkoffhand(var_0) {
  if(var_0 == "none" || var_0 == "specialty_null") {
    self setoffhandsecondaryclass("none");
    return;
  }

  self.secondarygrenade = var_0;

  if(issubstr(var_0, "_mp")) {
    switch (var_0) {
      case "dud_grenade_zm":
      case "splash_grenade_zm":
      case "splash_grenade_mp":
      case "mortar_shelljugg_mp":
      case "cluster_grenade_zm":
      case "semtex_zm":
      case "frag_grenade_mp":
      case "frag_grenade_zm":
      case "semtex_mp":
        self setoffhandsecondaryclass("frag");
        break;
      case "throwingknifejugg_mp":
      case "throwingknifesmokewall_mp":
      case "throwingknifec4_mp":
      case "c4_zm":
      case "throwingknife_mp":
        self setoffhandsecondaryclass("throwingknife");
        break;
      case "player_trophy_system_mp":
      case "proto_ricochet_device_mp":
      case "emp_grenade_mp":
      case "trophy_mp":
      case "mobile_radar_mp":
      case "alienflare_mp":
      case "thermobaric_grenade_mp":
      case "flash_grenade_mp":
        self setoffhandsecondaryclass("flash");
        break;
      case "concussion_grenade_mp":
      case "smoke_grenadejugg_mp":
      case "smoke_grenade_mp":
        self setoffhandsecondaryclass("smoke");
        break;
      case "ztransponder_mp":
      case "transponder_mp":
      case "zom_repulsor_mp":
      default:
        self setoffhandsecondaryclass("other");
        break;
    }

    _giveweapon(var_0, 0);

    switch (var_0) {
      case "ztransponder_mp":
      case "transponder_mp":
      case "player_trophy_system_mp":
      case "proto_ricochet_device_mp":
      case "emp_grenade_mp":
      case "trophy_mp":
      case "mobile_radar_mp":
      case "gravity_grenade_mp":
      case "alienflare_mp":
      case "concussion_grenade_mp":
      case "smoke_grenade_mp":
      case "thermobaric_grenade_mp":
      case "flash_grenade_mp":
        self setweaponammoclip(var_0, 1);
        break;
      default:
        self givestartammo(var_0);
        break;
    }

    _setperk(var_0);
    return;
  }

  _setperk(var_0);
}

function _launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4)) {
    var_6.notthrown = 1;
  } else {
    var_6.notthrown = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

function moveplayerperpendicularly(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1200;
  }

  if(isDefined(var_1)) {
    var_2 = vectorNormalize(var_1);
  } else {
    var_2 = anglesToForward(self.angles);
  }

  var_3 = vectorcross((0, 0, 1), var_2);
  var_4 = vectorNormalize(var_3);
  self knockback(var_4, var_1);
}

function blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    foreach(var_2 in level.extraperkmap) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self.perksblocked[var_4])) {
            self.perksblocked[var_4] = 1;
          } else {
            self.perksblocked[var_4]++;
          }

          if(self.perksblocked[var_4] == 1) {}
        }

        break;
      }
    }

    return;
  }
}

function unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;

  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;

    if(_hasperk(var_0)) {
      foreach(var_2 in level.extraperkmap) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self.perksblocked[var_4]--;

            if(self.perksblocked[var_4] == 0) {
              self.perksblocked[var_4] = undefined;
            }
          }

          break;
        }
      }

      return;
    }

    return;
  }
}

function getweaponclass(var_0) {
  var_1 = getbaseweaponname(var_0);
  var_2 = tablelookup("mp/statstable.csv", 4, var_1, 1);

  if(var_2 == "") {
    var_3 = strip_suffix(var_0.basename, "_zm");
    var_2 = tablelookup("mp/statstable.csv", 4, var_3, 1);
  }

  if(isenvironmentweapon(var_0.basename)) {
    var_2 = "weapon_mg";
  } else if(iskillstreakweapon(var_0.basename)) {
    var_2 = "killstreak";
  } else if(issuperweapon(var_0.basename)) {
    var_2 = "super";
  } else if(var_0.basename == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  return var_2;
}

function removedamagemodifier(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var_0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var_0] = undefined;
}

function adddamagemodifier(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var_0] = var_1;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var_0] = var_1;
}

function getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var_9 in self.additivedamagemodifiers) {
      var_7 += var_9 - 1;
    }
  }

  var_11 = 1;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var_9 in self.multiplicativedamagemodifiers) {
      var_11 *= var_9;
    }
  }

  return var_7 * var_11;
}

function isinventoryprimaryweapon(var_0) {
  switch (weaponinventorytype(var_0)) {
    case "altmode":
    case "primary":
      return 1;
    default:
      return 0;
  }
}

function _enablecollisionnotifies(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
    return;
  }

  if(self.enabledcollisionnotifies == 1) {
    self enablecollisionnotifies(0);
  }

  self.enabledcollisionnotifies--;
}

function has_tag(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_2 = getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1)) {
      return true;
    }
  }

  return false;
}

function is_trap(var_0, var_1) {
  if(isDefined(var_1) && (var_1.basename == "iw7_beamtrap_zm" || var_1.basename == "iw7_escapevelocity_zm" || var_1.basename == "iw7_rockettrap_zm" || var_1.basename == "iw7_discotrap_zm" || var_1.basename == "iw7_chromosphere_zm" || var_1.basename == "iw7_buffertrap_zm" || var_1.basename == "iw7_electrictrap_zm" || var_1.basename == "iw7_fantrap_zm" || var_1.basename == "iw7_hydranttrap_zm" || var_1.basename == "iw7_moshtrap_zm")) {
    return true;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.tesla_type)) {
    return true;
  }

  if(!isDefined(var_0.script_noteworthy) && !isDefined(var_0.targetname)) {
    return false;
  }

  if(isDefined(var_0.targetname) && (var_0.targetname == "fence_generator" || var_0.targetname == "puddle_generator")) {
    return true;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "fire_trap") {
    return true;
  }

  return false;
}

function riotshieldname() {
  var_0 = self getweaponslist("primary");

  if(!self.hasriotshield) {
    return;
  }

  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      return var_2;
    }
  }
}

function player_has_special_ammo(var_0, var_1) {
  return isDefined(var_0.special_ammo_type) && var_0.special_ammo_type == var_1;
}

function has_stun_ammo(var_0) {
  if(isDefined(self.special_ammo_type)) {
    return player_has_special_ammo(self, "stun_ammo");
  }

  if(!isDefined(var_0)) {
    var_1 = self getcurrentweapon();
  } else if(issameweapon(var_1)) {
    var_1 = var_1;
  } else {
    var_1 = asmdevgetallstates(var_1);
  }

  if(nullweapon(var_1)) {
    var_1 = self getweaponslistprimaries()[0];
  }

  var_2 = getrawbaseweaponname(var_1);

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_2]) && self.special_ammocount[var_2] > 0) {
    return true;
  }

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[var_2]) && self.special_ammocount_comb[var_2] > 0) {
    return true;
  }

  return false;
}

function is_ricochet_damage() {
  return level.ricochetdamage;
}

function is_hardcore_mode() {
  return level.hardcoremode;
}

function is_casual_mode() {
  return level.casualmode == 1;
}

function valuehud(var_0) {
  if(isDefined(var_0) && var_0.basename != "none") {
    if(issuperweapon(var_0.basename)) {
      return true;
    }

    var_1 = getequipmenttype(var_0.basename);

    if(isDefined(var_1) && var_1 == "lethal") {
      return true;
    }
  }

  return false;
}

function isriotshield(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return false;
  }

  if(isstring(var_0) && var_0 == "none") {
    return false;
  }

  return weapontype(var_0) == "riotshield";
}

function isaltmodeweapon(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return false;
  }

  return weaponinventorytype(var_0) == "altmode";
}

function hasriotshield() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function is_empty_string(var_0) {
  return var_0 == "";
}

function notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend();
  self notify(var_1);
}

function player_last_death_pos() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.last_death_pos = self.origin;

  for(;;) {
    self waittill("damage");
    self.last_death_pos = self.origin;
  }
}

function isheadshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle") {
        return false;
      }

      if(var_3.code_classname == "misc_turret") {
        return false;
      }

      if(var_3.code_classname == "script_model") {
        return false;
      }
    }

    if(isDefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien") {
        return false;
      }
    }
  }

  return (var_1 == "head" || var_1 == "helmet" || var_1 == "neck") && var_2 != "MOD_MELEE" && var_2 != "MOD_IMPACT" && var_2 != "MOD_SCARAB" && var_2 != "MOD_CRUSH" && var_2 != "MOD_HEAD_SHOT" && !isenvironmentweapon(var_0.basename);
}

function getteamarray(var_0, var_1) {
  var_2 = [];
  jumpiffalse(!isDefined(var_1) || var_1) LOC_00000050;

  foreach(var_4 in level.characters) {
    if(var_4.team == var_0) {
      var_2 = var_4;
    }
  }

  goto LOC_00000089;
}

function getotherteam(var_0) {
  if(level.multiteambased) {}

  if(var_0 == "allies") {
    return "axis";
  }

  if(var_0 == "axis") {
    return "allies";
  }

  return "none";
}

function player_black_screen(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("intermission");
  self endon("death");
  self.player_black_screen = newclienthudelem(self);
  self.player_black_screen.x = 0;
  self.player_black_screen.y = 0;
  self.player_black_screen setshader("black", 640, 480);
  self.player_black_screen.alignx = "left";
  self.player_black_screen.aligny = "top";
  self.player_black_screen.sort = 1;
  self.player_black_screen.horzalign = "fullscreen";
  self.player_black_screen.vertalign = "fullscreen";
  self.player_black_screen.alpha = 0;
  self.player_black_screen.foreground = 1;

  if(!istrue(var_3)) {
    self.player_black_screen fadeovertime(var_0);
  }

  self.player_black_screen.alpha = 1;

  if(!istrue(var_3)) {
    wait var_0 + 0.05;
  }

  wait var_1;
  self.player_black_screen fadeovertime(var_2);
  self.player_black_screen.alpha = 0;
  wait var_2 + 0.05;
  self.player_black_screen destroy();
}

function riotshield_hasweapon() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function riotshield_attach(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "tag_shield_back";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var_2) {
    self.initlocs_donetsk = var_2;
    self attachshieldmodel(var_1, var_2);
  }

  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "j_shield_ri";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "tag_shield_back";
  }

  if(isDefined(self.initlocs_donetsk) && self.initlocs_donetsk == var_2) {
    self.initlocs_donetsk = undefined;
    self detachshieldmodel(var_1, var_2);
  }

  if(var_0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

function launchshield(var_0, var_1) {
  if(riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel)) {
      riotshield_detach(1);
    }

    if(isDefined(self.riotshieldmodelstowed)) {
      riotshield_detach(0);
      return;
    }

    return;
  }
}

function riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "j_shield_ri";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "tag_shield_back";
    var_2 = "j_shield_ri";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var_2) {
    self.initlocs_donetsk = var_2;
    self moveshieldmodel(var_3, var_1, var_2);
  }

  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var_3;
  self.riotshieldmodelstowed = undefined;
}

function riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

function remove_crafting_item() {
  self setclientomnvar("zombie_souvenir_piece_index", 0);

  if(isDefined(level.crafting_remove_func)) {
    self[[level.crafting_remove_func]]();
  }

  self.current_crafting_struct = undefined;
}

function store_weapons_status(var_0, var_1) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, var_1);
  self.copy_weapon_level = [];
  var_2 = [];

  foreach(var_4 in self.copy_fullweaponlist) {
    if(var_4.isalternate) {
      continue;
    }

    if(issubstr(var_4.basename, "iw8_execution_")) {
      continue;
    }

    var_2 = var_4;
  }

  self.copy_fullweaponlist = var_2;

  foreach(var_4 in self.copy_fullweaponlist) {
    var_7 = createheadicon(var_4);
    self.copy_weapon_ammo_clip[var_7] = self getweaponammoclip(var_4);
    self.copy_weapon_ammo_stock[var_7] = self getweaponammostock(var_4);

    if(issubstr(var_4.basename, "akimbo")) {
      self.copy_weapon_ammo_clip_left[var_7] = self getweaponammoclip(var_4, "left");
    }

    var_8 = getrawbaseweaponname(var_4);

    if(isDefined(self.pap[var_8])) {
      self.copy_weapon_level[var_7] = self.pap[var_8].lvl;
    }
  }

  if(isDefined(var_0)) {
    var_10 = [];

    foreach(var_4 in self.copy_fullweaponlist) {
      var_12 = 0;

      foreach(var_14 in var_0) {
        if(var_4 == var_14) {
          var_12 = 1;
          break;
        }

        if(var_4 getbaseweapon() == var_14) {
          var_12 = 1;
          break;
        }
      }

      if(var_12) {
        continue;
      }

      var_10 = var_4;
    }

    self.copy_fullweaponlist = var_10;

    foreach(var_14 in var_0) {
      if(self.copy_weapon_current == var_14) {
        self.copy_weapon_current = isundefinedweapon();
        break;
      }
    }

    return;
  }
}

function get_current_weapon(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(istrue(var_1) && is_melee_weapon(var_2)) {
    var_2 = var_0 getweaponslistall()[1];
  }

  return var_2;
}

function is_melee_weapon(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  switch (var_2) {
    case "alt_iw7_knife_zm_raver":
    case "alt_iw7_knife_zm_grunge":
    case "alt_iw7_knife_zm_hiphop":
    case "iw7_knife_zm_disco":
    case "alt_iw7_knife_zm_survivor":
    case "alt_iw7_knife_zm_chola":
    case "iw7_knife_zm_survivor":
    case "iw7_knife_zm_grunge":
    case "iw7_knife_zm_hiphop":
    case "iw7_knife_zm_raver":
    case "iw7_knife_zm_chola":
    case "alt_iw7_knife_zm_vgirl":
    case "alt_iw7_knife_zm_rapper":
    case "alt_iw7_knife_zm_nerd":
    case "alt_iw7_knife_zm_jock":
    case "alt_iw7_knife_zm":
    case "iw7_knife_zm_vgirl":
    case "iw7_knife_zm_rapper":
    case "iw7_knife_zm_nerd":
    case "iw7_knife_zm_jock":
    case "alt_iw7_knife_zm_hoff":
    case "iw7_knife_zm_hoff":
    case "iw8_knife_mp":
      return 1;
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
    case "iw7_fists_zm_kevinsmith":
    case "iw7_fists_zm_raver":
    case "iw7_fists_zm_hiphop":
    case "iw7_fists_zm_grunge":
    case "iw7_fists_zm_chola":
    case "iw7_fists_zm":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
      if(istrue(var_1)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

function is_primary_melee_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return true;
  }

  return false;
}

function restore_weapons_status(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_3) && !in_inclusion_list(var_0, var_3)) {
      self takeweapon(var_3);
    }
  }

  if(isDefined(self.ref_12D4D)) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.ref_12D4D)) {
      self.copy_fullweaponlist[self.copy_fullweaponlist.size] = self.ref_12D4D;
    }

    self.ref_12D4D = undefined;
  }

  foreach(var_3 in self.copy_fullweaponlist) {
    if(!self hasweapon(var_3)) {
      self giveweapon(var_3, -1, 0, -1, 1);
    }

    var_6 = createheadicon(var_3);

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var_6) {
      self assignweaponoffhandprimary(var_3);
    }

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var_6) {
      self assignweaponoffhandsecondary(var_3);
    }

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var_6) {
      self assignweaponoffhandspecial(var_3);
    }

    if(isDefined(self.copy_weapon_ammo_clip[var_6])) {
      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_6]);
    }

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[var_6])) {
        self setweaponammoclip(var_3, self.copy_weapon_ammo_clip_left[var_6], "left");
      }
    }

    if(isDefined(self.copy_weapon_ammo_stock[var_6])) {
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_6]);
    }

    if(isDefined(self.copy_weapon_level[var_6])) {
      var_7 = spawnStruct();
      var_7.lvl = self.copy_weapon_level[var_6];
      self.pap[getrawbaseweaponname(var_3)] = var_7;
    }
  }

  var_9 = self.copy_weapon_current;

  if(getqueuedspleveltransients(var_9)) {
    foreach(var_11 in self.copy_fullweaponlist) {
      if(scripts\cp\cp_weapon::isbulletweapon(var_11)) {
        var_9 = var_11;
        break;
      }
    }
  }

  if(scripts\common\utility::is_weapon_switch_allowed()) {
    self switchtoweaponimmediate(var_9);
  }

  if(!istrue(self.bspawningviaac130)) {
    self.copy_fullweaponlist = undefined;
    self.copy_weapon_current = undefined;
    self.copy_weapon_ammo_clip = undefined;
    self.copy_weapon_ammo_stock = undefined;
    self.copy_weapon_ammo_clip_left = undefined;
  }

  if(isDefined(level.arcade_last_stand_power_func)) {
    self[[level.arcade_last_stand_power_func]]();
    return;
  }
}

function restore_primary_weapons_only(var_0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  var_1 = 0;

  foreach(var_3 in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(var_3)) {
      self.primary_weapons[var_1] = var_3;
      var_1 += 1;
    }
  }

  var_5 = 0;

  foreach(var_3 in self.primary_weapons) {
    if(var_5 < 3) {
      if(var_3.isalternate) {
        continue;
      }

      if(!self hasweapon(var_3)) {
        self giveweapon(var_3, -1, 0, -1, 1);
      }

      var_7 = createheadicon(var_3);
      self setweaponammoclip(var_3, self.copy_weapon_ammo_clip[var_7]);
      self setweaponammostock(var_3, self.copy_weapon_ammo_stock[var_7]);

      if(isDefined(self.copy_weapon_level[var_7])) {
        var_8 = spawnStruct();
        var_8.lvl = self.copy_weapon_level[var_7];
        self.pap[getrawbaseweaponname(var_3)] = var_8;
      }

      var_5++;
    }
  }

  var_10 = self.copy_weapon_current;

  if(!isDefined(var_10) || !self hasweapon(var_10) || nullweapon(var_10)) {
    var_10 = getweapontoswitchbackto();
  }

  self switchtoweaponimmediate(var_10);
  self.copy_fullweaponlist = undefined;
  self.copy_weapon_current = undefined;
  self.copy_weapon_ammo_clip = undefined;
  self.copy_weapon_ammo_stock = undefined;
}

function clear_weapons_status() {
  self.copy_fullweaponlist = [];
  self.copy_weapon_current = isundefinedweapon();
  self.copy_weapon_ammo_clip = [];
  self.copy_weapon_ammo_clip_left = [];
  self.copy_weapon_ammo_stock = [];
  self.copy_weapon_level = [];
}

function add_to_weapons_status(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = undefined;

    if(issameweapon(var_5)) {
      var_6 = var_5;
      var_7 = createheadicon(var_5);
    } else {
      var_6 = asmdevgetallstates(var_5);
      var_7 = var_5;
    }

    self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_6;
    self.copy_weapon_ammo_clip[var_7] = var_1[var_7];
    self.copy_weapon_ammo_stock[var_7] = var_2[var_7];
  }

  self.copy_weapon_current = var_3;
}

function in_inclusion_list(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_0, var_1);
}

function vec_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

function restore_super_weapon() {
  self giveweapon("super_default_zm");
  self assignweaponoffhandspecial("super_default_zm");
  self.specialoffhandgrenade = "super_default_zm";

  if(istrue(self.consumable_meter_full)) {
    self setweaponammoclip("super_default_zm", 1);
    return;
  }
}

function getcloseststruct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "script_noteworthy");
  var_4 = sortbydistance(var_3, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_4.origin) > squared(var_2)) {
    return undefined;
  }

  return var_4;
}

function is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && (self.species == "humanoid" || self.species == "zombie");
}

function is_soldier_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "human";
}

function coop_mode_has(var_0) {
  if(!isDefined(level.coop_mode_feature)) {
    return false;
  }

  return isDefined(level.coop_mode_feature[var_0]);
}

function coop_mode_enable(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level.coop_mode_feature)) {
      level.coop_mode_feature = [];
    }

    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        level.coop_mode_feature[var_2] = 1;
      }

      return;
    }

    level.coop_mode_feature[var_0] = 1;
    return;
  }
}

function make_entity_sentient_cp(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    return self makeentitysentient(var_0, 1);
  }

  return self makeentitysentient(var_0);
}

function get_attacker_as_player(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0)) {
      return var_0;
    }

    if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
      return var_0.owner;
    }
  }

  return undefined;
}

function removeexcludedattachments(var_0) {
  if(isDefined(level.excludedattachments)) {
    foreach(var_2 in level.excludedattachments) {
      foreach(var_4 in var_0) {
        if(attachmentmap_tobase(var_4) == var_2) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_4);
        }
      }
    }
  }

  return var_0;
}

function getrandomweaponattachments(var_0, var_1, var_2) {
  var_3 = [];

  if(weaponhaspassive(var_0, var_1, "passive_random_attachments")) {
    if(false) {
      var_4 = getavailableattachments(var_0, var_2, 0);
      var_3 = var_4[randomint(var_4.size)];
    } else {
      var_5 = int(max(0, 5 - var_2.size));

      if(var_5 > 0) {
        var_6 = randomintrange(1, var_5 + 1);
        var_3 = buildrandomattachmentarray(var_0, var_6, var_2);
      }
    }
  }

  return var_3;
}

function weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0) {
    return false;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return true;
    }
  }

  return false;
}

function buildrandomattachmentarray(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\cp\cp_weapon::getattachmenttypeslist(var_0, var_2);

  if(var_4.size > 0) {
    var_3 = [];
    var_5 = scripts\engine\utility::array_randomize_objects(var_4);

    foreach(var_7 in var_5) {
      if(var_1 <= 0) {
        break;
      }

      var_8 = 1;

      switch (var_10) {
        case "undermount":
        case "barrel":
          var_8 = 1;
          break;
        case "rail":
        case "pap":
        case "perk":
          var_8 = 0;
          break;
        default:
          var_8 = randomintrange(1, var_1 + 1);
          break;
      }

      if(var_8 > 0) {
        if(var_8 > var_7.size) {
          var_8 = var_7.size;
        }

        var_1 -= var_8;
        var_7 = scripts\engine\utility::array_randomize_objects(var_7);

        while(var_8 > 0) {
          var_9 = var_7[var_7.size - var_8];

          if(!issubstr(var_9, "ark") && !issubstr(var_9, "arcane")) {
            var_3 = var_9;
          }

          var_8--;
        }
      }
    }
  }

  return var_3;
}

function getavailableattachments(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = getweaponattachmentarrayfromstats(var_0);
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = getattachmenttype(var_6);

    if(!var_2 && var_7 == "rail") {
      continue;
    }

    if(isDefined(var_1) && listhasattachment(var_1, var_6)) {
      continue;
    }

    var_4 = var_6;
  }

  return var_4;
}

function listhasattachment(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return true;
    }
  }

  return false;
}

function getweaponattachmentarrayfromstats(var_0) {
  var_1 = getweaponrootname(var_0);

  if(!isDefined(level.weaponattachments)) {
    level.weaponattachments = [];
  }

  if(!isDefined(level.weaponattachments[var_1])) {
    var_2 = [];

    for(var_3 = 0; var_3 < 10; var_3++) {
      var_4 = tablelookup("mp/statstable.csv", 4, var_1, 10 + var_3);

      if(var_4 == "") {
        break;
      }

      var_2 = var_4;
    }

    level.weaponattachments[var_1] = var_2;
  }

  return level.weaponattachments[var_1];
}

function getweaponpaintjobid(var_0) {
  return -1;
}

function getweaponcamo(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "camo");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

function getweaponcosmeticattachment(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "cosmeticAttachment");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

function getweaponreticle(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "reticle");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  }

  return "none";
}

function mpbuildweaponname(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = weaponattachdefaultmap(var_0);
  var_10 = buildweaponassetname(var_0, var_4);
  var_11 = coop_getweaponclass(var_10);

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);
  }

  var_1 = weaponattachremoveextraattachments(var_1);
  var_1 = removeexcludedattachments(var_1);

  for(var_12 = 0; var_12 < var_1.size; var_12++) {
    var_1 = attachmentmap_tounique(var_1[var_12], var_10);
  }

  if(isDefined(var_9)) {
    for(var_12 = 0; var_12 < var_9.size; var_12++) {
      var_9 = attachmentmap_tounique(var_9[var_12], var_10);
    }
  }

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_9);
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");

  if(isDefined(var_8) && var_8 != "none") {
    var_1 = var_8;
  }

  if(var_1.size > 0) {
    var_1 = filterattachments(var_1);
  }

  var_13 = [];

  foreach(var_15 in var_1) {
    var_16 = attachmentmap_toextra(var_15);

    if(isDefined(var_16)) {
      var_13 = attachmentmap_tounique(var_16, var_10);
    }
  }

  if(var_13.size > 0) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, var_13);
  }

  if(var_1.size > 0) {
    var_1 = scripts\engine\utility::alphabetize(var_1);
  }

  var_10 = reassign_weapon_name(var_10, var_1);

  foreach(var_19 in var_1) {
    var_10 += "+" + var_19;
  }

  if(issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_2, var_4);
    var_21 = 0;

    if(isholidayweapon(var_10, var_4)) {
      var_21 = isholidayweaponusingdefaultscope(var_10, var_1);
    }

    if(var_21) {
      var_10 += "+scope1";
    } else {
      var_10 = buildweaponnamereticle(var_10, var_3);
    }

    var_10 = buildweaponnamevariantid(var_10, var_4);
  }

  return var_10;
}

function reassign_weapon_name(var_0, var_1) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return var_0;
  } else {
    switch (var_0) {
      case "iw7_machete_mp":
        if(istrue(self.base_weapon)) {
          var_0 = "iw7_machete_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_machete_mp";
          } else {
            var_0 = "iw7_machete_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_machete_mp_pap1";
          } else {
            var_0 = "iw7_machete_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_machete_mp_pap2";
        }

        break;
      case "iw7_two_headed_axe_mp":
        if(istrue(self.base_weapon)) {
          var_0 = "iw7_two_headed_axe_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_two_headed_axe_mp";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_two_headed_axe_mp_pap2";
        }

        break;
      case "iw7_spiked_bat_mp":
        if(istrue(self.base_weapon)) {
          var_0 = "iw7_spiked_bat_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_spiked_bat_mp";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_spiked_bat_mp_pap1";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_spiked_bat_mp_pap2";
        }

        break;
      case "iw7_golf_club_mp":
        if(istrue(self.base_weapon)) {
          var_0 = "iw7_golf_club_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_golf_club_mp";
          } else {
            var_0 = "iw7_golf_club_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var_0 = "iw7_golf_club_mp_pap1";
          } else {
            var_0 = "iw7_golf_club_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var_0)]) && self.pap[getrawbaseweaponname(var_0)].lvl == 3) {
          var_0 = "iw7_golf_club_mp_pap2";
        }

        break;
      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(var_1, "axepap1")) {
          var_0 = "iw7_axe_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "axepap2")) {
          var_0 = "iw7_axe_zm_pap2";
        }

        break;
      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(var_1, "katanapap1")) {
          var_0 = "iw7_katana_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "katanapap2")) {
          var_0 = "iw7_katana_zm_pap2";
        }

        break;
      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(var_1, "nunchuckspap1")) {
          var_0 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "nunchuckspap2")) {
          var_0 = "iw7_nunchucks_zm_pap2";
        }

        break;
      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(var_1, "freezepap1")) {
          var_0 = "iw7_forgefreeze_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "freezepap2")) {
          var_0 = "iw7_forgefreeze_zm_pap2";
        }

        break;
      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(var_1, "shredderpap1")) {
          var_0 = "iw7_shredder_zm_pap1";
        }

        break;
      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(var_1, "dischordpap1")) {
          var_0 = "iw7_dischord_zm_pap1";
        }

        break;
      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(var_1, "fmpap1")) {
          var_0 = "iw7_facemelter_zm_pap1";
        }

        break;
      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(var_1, "hcpap1")) {
          var_0 = "iw7_headcutter_zm_pap1";
        }

        break;
    }
  }

  return var_0;
}

function get_weapon_variant_id(var_0, var_1) {
  var_2 = getbaseweaponname(var_1);
  return -1;
}

function weaponhasvariants(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_0) {
    case "iw7_glprox":
    case "iw7_lockon":
    case "iw7_chargeshot":
    case "iw7_axe":
    case "iw7_g18c":
    case "iw7_arclassic":
    case "iw7_spasc":
    case "iw7_cheytacc":
    case "iw7_ump45c":
    case "iw7_m1c":
      return 0;
    default:
      return 1;
  }
}

function weaponattachremoveextraattachments(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = attachmentmap_tounique(var_4, var_1);
    var_6 = attachmentmap_toextra(var_5);

    if(isDefined(var_6)) {
      var_2 = var_6;
    }
  }

  var_8 = [];

  foreach(var_4 in var_0) {
    var_10 = 0;

    foreach(var_6 in var_2) {
      if(var_4 == var_6) {
        var_10 = 1;
        break;
      }
    }

    if(!var_10) {
      var_8 = var_4;
    }
  }

  return var_8;
}

function weaponattachdefaultmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaults)) {
    return level.weaponmapdata[var_0].attachdefaults;
  }

  return undefined;
}

function weaponassetnamemap(var_0, var_1) {
  if(iskillstreakweapon(var_0)) {
    return var_0;
  }

  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].assetoverridename)) {
      return level.weaponlootmapdata[var_2].assetoverridename;
    }
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].assetname)) {
    return level.weaponmapdata[var_0].assetname;
  }

  return var_0;
}

function iskillstreakweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var_1])) {
    return true;
  }

  return false;
}

function buildweaponassetname(var_0, var_1) {
  return weaponassetnamemap(var_0, var_1);
}

function getweaponassetfromrootweapon(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = tablelookup(var_2, 0, var_1, 3);
  return var_3;
}

function getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = getpassiveattachment(var_5);

      if(!isDefined(var_6)) {
        continue;
      }

      var_2 = var_6;
    }
  }

  return var_2;
}

function getpassiveattachment(var_0) {
  var_1 = getpassivestruct(var_0);

  if(!isDefined(var_1) || !isDefined(var_1.attachmentref)) {
    return undefined;
  }

  return var_1.attachmentref;
}

function getweaponpassives(var_0, var_1) {
  return getpassivesforweapon(var_0, var_1);
}

function getpassivesforweapon(var_0, var_1) {
  var_2 = getlootinfoforweapon(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2.passives;
  }

  return undefined;
}

function getlootinfoforweapon(var_0, var_1) {
  var_2 = getweaponrootname(var_0);

  if(!isDefined(level.lootweaponcache)) {
    level.lootweaponcache = [];
  }

  if(isDefined(level.lootweaponcache[var_2]) && isDefined(level.lootweaponcache[var_2][var_1])) {
    var_3 = level.lootweaponcache[var_2][var_1];
    return var_3;
  }

  var_3 = cachelootweaponweaponinfo(var_1, var_3, var_2);

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

function getweaponrootname(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = level.weaponrootcache[var_1];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = var_1;
  var_4 = strtok(var_1, "_");
  var_5 = 0;

  if(var_4[0] == "alt") {
    var_5++;
  }

  if(var_4[var_5] == "iw8" || var_4[var_5] == "s4") {
    var_6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me"];

    if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1])) {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1] + "_" + var_4[var_5 + 2];
    } else {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1];
    }
  }

  if(level.weaponrootcache.size < 100) {
    level.weaponrootcache[var_3] = var_1;
  }

  return var_1;
}

function relic_nuketimer_globalthread(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level.weaponmapdata[var_1]) && isDefined(level.weaponmapdata[var_1].assetname)) {
    var_0 = level.weaponmapdata[var_1].assetname;
  }

  return var_0;
}

function weapon_is_a_cp_mod(var_0, var_1) {
  if(isDefined(var_0[var_1 + 3]) && isDefined(var_0[var_1 + 4])) {
    return true;
  }

  return false;
}

function weapon_is_cp_loot(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "commmon") || issubstr(var_1, "uncommon") || issubstr(var_1, "rare") || issubstr(var_1, "legendary") || issubstr(var_1, "epic") || issubstr(var_1, "godtier");
}

function weapon_is_dlc2_melee(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "katana") || issubstr(var_1, "nunchucks");
}

function weapon_is_dlc_melee(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "two_headed") || issubstr(var_1, "spiked_bat") || issubstr(var_1, "machete") || issubstr(var_1, "golf_club");
}

function cachelootweaponweaponinfo(var_0, var_1, var_2) {
  if(!isDefined(level.lootweaponcache[var_1])) {
    level.lootweaponcache[var_1] = [];
  }

  var_3 = getweaponloottable(var_0);
  var_4 = readweaponinfofromtable(var_3, var_2);
  level.lootweaponcache[var_1][var_2] = var_4;
  return var_4;
}

function readweaponinfofromtable(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3.ref = tablelookupbyrow(var_0, var_2, 1);
  var_3.weaponasset = tablelookupbyrow(var_0, var_2, 3);
  var_3.passives = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "") {
      var_3.passives[var_3.passives.size] = var_5;
    }
  }

  return var_3;
}

function init_drop_locations(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("container_ammo_box_01_nophysics");
  var_1.angles = var_0.angles;
  var_1.targetname = var_0.targetname;
  return var_1;
}

function create_fake_loot(var_0) {
  if(istrue(self.available)) {
    return;
  }

  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    return;
  }

  self show();
  self.available = 1;
  var_1 = undefined;

  if(isDefined(var_0)) {
    if(isstring(var_0)) {
      var_1 = [var_0];
    } else {
      var_1 = var_0;
    }
  } else if(istrue(level.little_bird_mg_cp_onexitvehicle)) {
    var_1 = ["brloot_munition_grenade_crate", "brloot_munition_armor"];
  } else {
    var_1 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  }

  self.loot_type = scripts\engine\utility::random(var_1);
  var_2 = &"COOP_CRAFTING/AMMO_CRATE";

  switch (self.loot_type) {
    case "brloot_munition_grenade_crate":
      var_2 = &"CP_BR/GRENADE_CRATE";
      break;
    case "brloot_munition_armor":
      var_2 = &"CP_BR/ARMOR_CRATE";
      break;
    case "brloot_munition_deployable_cover":
      var_2 = &"EQUIPMENT/TACTICAL_COVER";
      break;
  }

  self setModel("offhand_wm_supportbox_killstreak");
  self.origin += (0, 0, 16);

  if(self tagexists("tag_use")) {
    sethintobject("tag_use", "HINT_BUTTON", undefined, var_2, 25, "duration_none", "show", 128, 80, 128, 80);
    goto LOC_00000142;
  }

  sethintobject(undefined, "HINT_BUTTON", undefined, var_2, 25, "duration_none", "show", 128, 80, 128, 80);

  for(;;) {
    self waittill("trigger", var_3);

    if(!is_valid_player(var_3)) {
      continue;
    }

    if(!scripts\cp\loot_system::give_munition(self.loot_type, var_3)) {
      continue;
    }

    self playsoundtoplayer("scavenger_pack_pickup", var_3);
    self makeunusable();
    self hide();
    self.available = 0;
    return;
  }
}

function filterattachments(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_0[var_2];

      if(var_3 == "none") {
        continue;
      }

      var_4 = 1;

      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(var_3 == var_1[var_5]) {
          var_4 = 0;
          break;
        }

        var_6 = scripts\cp\cp_weapon::attachmentsconflict(var_3, var_1[var_5]);

        if(var_6 != "") {
          var_4 = 0;
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_5);
          var_7 = [];
          var_7 = strtok(var_6, " ");

          foreach(var_9 in var_7) {
            var_0 = scripts\engine\utility::array_insert(var_0, var_9, var_2 + 1 + var_10);
          }

          break;
        }
      }

      if(var_4) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function attachmentiscosmetic(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "cos_");
}

function attachmentmap_toextra(var_0) {
  var_1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var_0])) {
    var_1 = level.attachmentmap_uniquetoextra[var_0];
  }

  return var_1;
}

function getpassivestruct(var_0) {
  if(!isDefined(level.passivemap[var_0])) {
    return undefined;
  }

  var_1 = level.passivemap[var_0];
  return var_1;
}

function map_check(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
    case 0:
      if(level.script == "cp_zmb") {
        return 1;
      } else {
        return 0;
      }
    case 1:
      if(level.script == "cp_rave") {
        return 1;
      } else {
        return 0;
      }
    case 2:
      if(level.script == "cp_disco") {
        return 1;
      } else {
        return 0;
      }
    case 3:
      if(level.script == "cp_town") {
        return 1;
      } else {
        return 0;
      }
    default:
      return 1;
  }
}

function buildweaponname(var_0, var_1, var_2, var_3, var_4) {
  if(isstrstart(var_0, "iw7_")) {
    var_2 = 0;
  }

  var_5 = [];

  foreach(var_7 in var_1) {
    var_5 = attachmentmap_tounique(var_7, var_0);
  }

  var_9 = getrawbaseweaponname(var_0);
  var_10 = var_0;
  var_11 = var_9 == "kbs" || var_9 == "cheytac" || var_9 == "m8" || var_9 == "ripper" || var_9 == "erad" || var_9 == "ar57";

  if(var_11) {
    var_12 = 0;

    foreach(var_7 in var_5) {
      if(getattachmenttype(var_7) == "rail") {
        var_12 = 1;
        break;
      }
    }

    if(!var_12) {
      var_5 = var_9 + "scope";
    }
  }

  if(var_5.size > 0) {
    var_15 = scripts\engine\utility::array_remove_duplicates(var_5);
    var_5 = scripts\engine\utility::alphabetize(var_15);
  }

  foreach(var_7 in var_5) {
    var_10 += "+" + var_7;
  }

  if(issubstr(var_10, "iw6") || issubstr(var_10, "iw7")) {
    var_10 = buildweaponnamecamo(var_10, var_2);

    if(var_4 != "weapon_sniper" && isDefined(var_3)) {
      var_10 = buildweaponnamereticle(var_10, var_3);
    }
  } else if(!scripts\cp\cp_weapon::isvalidzombieweapon(var_10 + "_mp")) {
    var_10 = var_0 + "_mp";
  } else {
    var_10 = buildweaponnamecamo(var_10, var_2);
    var_10 = buildweaponnamereticle(var_10, var_3);
    var_10 += "_mp";
  }

  return var_10;
}

function buildweaponnamevariantid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return var_0;
  }

  var_0 += "+loot" + var_1;
  return var_0;
}

function isholidayweapon(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return false;
  }

  if(var_1 == 6) {
    var_2 = getweaponrootname(var_0);
    return (var_2 == "iw7_ripper" || var_2 == "iw7_lmg03" || var_2 == "iw7_ar57");
  }

  return false;
}

function ismark2weapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return var_0 >= 32;
}

function isholidayweaponusingdefaultscope(var_0, var_1) {
  var_2 = attachmentmap_tounique("scope", getweaponbasename(var_0));
  return isDefined(var_2) && scripts\engine\utility::array_contains(var_1, var_2);
}

function is_pap_camo(var_0) {
  if(isDefined(level.pap_1_camo) && var_0 == level.pap_1_camo) {
    return true;
  } else if(isDefined(level.pap_2_camo) && var_0 == level.pap_2_camo) {
    return true;
  }

  return false;
}

function buildweaponnamecamo(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(var_1 == "none") {
    return var_0;
  }

  return var_0 + "+camo|" + var_1;
}

function getweaponqualitybyid(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = getweaponloottable(var_0);
  var_3 = int(tablelookup(var_2, 0, var_1, 4));
  return var_3;
}

function buildweaponnamereticle(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  var_2 = int(tablelookup("mp/reticleTable.csv", 1, var_1, 5));

  if(!isDefined(var_2) || var_2 == 0) {
    return var_0;
  }

  var_0 += "+scope" + var_2;
  return var_0;
}

function has_zombie_perk(var_0) {
  if(!isDefined(self.zombies_perks)) {
    return false;
  }

  return istrue(self.zombies_perks[var_0]);
}

function drawsphere(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);
  }

  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

function has_auto_revive() {
  return istrue(self.has_auto_revive) || istrue(self.c130_revive);
}

function set_alien_emissive(var_0, var_1) {
  var_2 = self.maxemissive - self.defaultemissive;
  var_3 = var_1 * var_2 + self.defaultemissive;
  self emissiveblend(var_0, var_3);
}

function get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var_0 + level.deployablebox_vest_rank[var_1];
}

function alien_mode_has(var_0) {
  var_0 = tolower(var_0);

  if(!isDefined(level.alien_mode_feature)) {
    return 0;
  }

  if(!isDefined(level.alien_mode_feature[var_0])) {
    return 0;
  }

  return level.alien_mode_feature[var_0];
}

function enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
}

function is_normal_upright(var_0) {
  var_1 = (0, 0, 1);
  var_2 = 0.85;
  return vectordot(var_0, var_1) > var_2;
}

function get_synch_direction_list(var_0) {
  if(!isDefined(self.synch_attack_setup)) {
    return [];
  }

  if(!isDefined(self.synch_attack_setup.synch_directions)) {
    return [];
  }

  if(!self.synch_attack_setup.type_specific) {
    return self.synch_attack_setup.synch_directions;
  }

  var_1 = scripts\cp\cp_agent_utils::get_agent_type(var_0);

  if(!isDefined(self.synch_attack_setup.synch_directions[var_1])) {
    var_2 = "Synch attack on " + self.synch_attack_setup.identifier + " doesn't handle type: " + var_1;
  }

  return self.synch_attack_setup.synch_directions[var_1];
}

function getrandomindex(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 += var_3;
  }

  var_5 = randomintrange(0, var_1);
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 += var_3;

    if(var_5 <= var_1) {
      return var_7;
    }
  }

  return 0;
}

function get_closest_living_player(var_0, var_1) {
  var_2 = 1073741824;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  var_3 = undefined;
  var_4 = level.players;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  foreach(var_6 in var_4) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, var_6)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_6)) {
      continue;
    }

    var_7 = distancesquared(self.origin, var_6.origin);

    if(var_6 scripts\cp_mp\utility\player_utility::_isalive() && var_7 < var_2) {
      var_3 = var_6;
      var_2 = var_7;
    }
  }

  return var_3;
}

function get_array_of_valid_players(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(is_valid_player(level.players[var_3])) {
      var_2 = level.players[var_3];
    }
  }

  if(!isDefined(var_0) || !var_0) {
    return var_2;
  }

  return scripts\engine\utility::get_array_of_closest(var_1, var_2);
}

function is_valid_player(var_0, var_1) {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self.sessionstate == "spectator") {
    return false;
  }

  if(!isDefined(var_0) && scripts\cp\cp_laststand::player_in_laststand(self)) {
    return false;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!istrue(var_1) && (istrue(self.infreefall) || istrue(self.inparachute))) {
    return false;
  }

  return true;
}

function any_player_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1) {
      return true;
    }
  }

  return false;
}

function give_closest_player_nearby(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_5.team != var_2) {
      continue;
    }

    if(distancesquared(var_5.origin, var_0) < var_1) {
      var_3 = var_5;
    }
  }

  if(var_3.size > 0) {
    var_7 = sortbydistance(var_3, var_0);
    return var_7[0];
  }

  return undefined;
}

function are_all_players_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) > var_1) {
      return false;
    }

    wait 0.05;
  }

  return true;
}

function give_all_players_nearby(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(level.players[var_3].origin, var_0) < var_1) {
      var_2 = level.players[var_3];
    }
  }

  return var_2;
}

function player_pain_vo(var_0) {
  self endon("disconnect");

  if(getdvarint("scr_no_player_pain_vo", 0) == 1) {
    return;
  }

  var_1 = 5500;
  var_2 = gettime();

  if(!isDefined(self.next_pain_vo_time)) {
    self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < self.next_pain_vo_time) {
    return;
  }

  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait 0.1;
  }

  if(isDefined(self.vo_prefix)) {
    if(soundexists(self.vo_prefix + "plr_pain")) {
      playlocalsound_safe(self.vo_prefix + "plr_pain");
    } else if(soundexists(self.vo_prefix + "pain")) {
      playlocalsound_safe(self.vo_prefix + "pain");
    }
  }

  var_3 = "injured_pain_vocal";

  if(isDefined(var_0)) {
    if(isDefined(var_0.agent_type)) {
      switch (var_0.agent_type) {
        case "skater":
          var_3 = "injured_pain_skater";
          break;
        case "ratking":
          var_3 = scripts\engine\utility::random(["injured_pain_ratking1", "injured_pain_ratking2", "injured_pain_ratking3"]);
          break;
        default:
          var_3 = "injured_pain_vocal";
          break;
      }
    }
  }

  scripts\cp\cp_vo::try_to_play_vo(var_3, "zmb_comment_vo");
  self.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
}

function player_pain_breathing_sfx() {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("scr_no_player_pain_vo", 0) == 1) {
    return;
  }

  if(is_playing_pain_breathing_sfx(self)) {
    return;
  }

  if(above_pain_breathing_sfx_threshold(self)) {
    return;
  }

  set_is_playing_pain_breathing_sfx(self, 1);
  var_0 = get_pain_breathing_sfx_alias(self);

  if(isDefined(var_0)) {
    if(soundexists(var_0)) {
      while(!above_pain_breathing_sfx_threshold(self) && !level.gameended) {
        if(!istrue(self.vo_system_playing_vo)) {
          playlocalsound_safe(var_0);
        }

        wait 1.5;
      }
    }

    set_is_playing_pain_breathing_sfx(self, 0);
    return;
  }
}

function is_playing_pain_breathing_sfx(var_0) {
  return istrue(var_0.is_playing_pain_breathing_sfx);
}

function above_pain_breathing_sfx_threshold(var_0) {
  var_1 = 0.3;
  return var_0.health / var_0.maxhealth > var_1;
}

function set_is_playing_pain_breathing_sfx(var_0, var_1) {
  var_0.is_playing_pain_breathing_sfx = var_1;
}

function get_pain_breathing_sfx_alias(var_0) {
  if(!level.gameended) {
    if(var_0.vo_prefix == "p1_") {
      return "p1_plr_pain";
    }

    if(var_0.vo_prefix == "p2_") {
      return "p2_plr_pain";
    }

    if(var_0.vo_prefix == "p3_") {
      return "p3_plr_pain";
    }

    if(var_0.vo_prefix == "p4_") {
      return "p4_plr_pain";
    }

    if(var_0.vo_prefix == "p5_") {
      return "p5_plr_pain";
    }

    return "p3_plr_pain";
  }
}

function playvoforpillage(var_0) {
  var_1 = var_0.vo_prefix + "good_loot";

  if(scripts\cp\cp_vo::alias_2d_version_exists(var_0, var_1)) {
    playlocalsound_safe(var_0, scripts\cp\cp_vo::get_alias_2d_version(var_0, var_1));
    return;
  }

  if(soundexists(var_1)) {
    playlocalsound_safe(var_0, var_1);
    return;
  }
}

function deployable_box_onuse_message(var_0) {
  var_1 = "";

  if(isDefined(var_0) && isDefined(var_0.boxtype) && isDefined(level.boxsettings[var_0.boxtype].eventstring)) {
    var_1 = level.boxsettings[var_0.boxtype].eventstring;
  }

  thread setlowermessage("deployable_use", var_1, 3);
}

function is_goon(var_0) {
  switch (var_0) {
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;
    default:
      return 0;
  }
}

function mark_dangerous_nodes(var_0, var_1, var_2) {}

function healthregeninit(var_0) {
  level.healthregendisabled = var_0;
}

function alien_health_per_player_init() {
  level.alien_health_per_player_scalar = [];
  level.alien_health_per_player_scalar[1] = 0.9;
  level.alien_health_per_player_scalar[2] = 1;
  level.alien_health_per_player_scalar[3] = 1.3;
  level.alien_health_per_player_scalar[4] = 1.8;
}

function playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143A5("damage", "health_perk_upgrade");

    if(!canregenhealth()) {
      continue;
    }

    var_0 = scripts\cp\cp_laststand::gethealthcap();
    var_1 = self.health / var_0;

    if(var_1 >= 1) {
      self.health = var_0;
      continue;
    }

    thread healthregen(gettime(), var_1);
    thread breathingmanager(gettime(), var_1);
  }
}

function get_within_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2) {
      var_3 = var_1[var_4];
    }
  }

  return var_3;
}

function healthregen(var_0, var_1) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self.selfdamaging) && self.selfdamaging) {
    wait 0.2;
  }

  if(ishealthregendisabled()) {
    return;
  }

  var_2 = spawnStruct();
  getregendata(var_2);
  wait var_2.activatetime;
  var_3 = gettime();

  for(;;) {
    var_4 = scripts\cp\cp_laststand::gethealthcap();
    var_2 = spawnStruct();
    getregendata(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2.regenamount);

      if(var_5 > var_4) {
        var_5 = var_4;
      }

      self.health = var_5;
    } else {
      break;
    }

    scripts\engine\utility::ref_143B9(var_2.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level.playerinitinvulnerability)) {
    self[[level.playerinitinvulnerability]]();
  }

  resetattackerlist();
}

function breathingmanager(var_0, var_1) {
  self notify("breathingManager");
  self endon("breathingManager");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(isusingremote()) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self.breathingstoptime = var_0 + 6000 * self.regenduration;
  wait 6 * self.regenduration;

  if(!level.gameended) {
    if(!isDefined(self.vo_prefix)) {
      return;
    }

    if(!istrue(self.vo_system_playing_vo)) {
      if(isfemale()) {
        playlocalsound_safe("Fem_breathing_better");
        return;
      }

      playlocalsound_safe("breathing_better");
      return;
    }

    return;
  }
}

function getregendata(var_0) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\cp_prestige::prestige_getslowhealthregenscalar();
  var_1 = 1;

  if(isDefined(self.perk_data)) {
    if(isDefined(self.perk_data["regen_time_scalar"])) {
      var_1 = self.perk_data["regen_time_scalar"];
    } else {
      var_1 = self.perk_data["health"].regen_time_scalar;
    }
  }

  if(self.prestigehealthregennerfscalar == 1) {
    if(is_consumable_active("faster_health_regen_upgrade")) {
      var_0.activatetime = 0.45;
      var_0.waittimebetweenregen = 0.045;
      var_0.regenamount = 0.1;
      return;
    }

    var_0.activatetime = 6;
    var_0.waittimebetweenregen = 0.05;
    var_0.regenamount = 6 * var_1;
    return;
  }

  var_0.activatetime = 6 * self.prestigehealthregennerfscalar;
  var_0.waittimebetweenregen = 0.05 * self.prestigehealthregennerfscalar;
  var_0.regenamount = 6;
}

function resetattackerlist(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.75;
  resetattackerlist_internal();
}

function resetattackerlist_internal() {
  self.attackers = [];
  self.attackerdata = [];
}

function canregenhealth() {
  if(getdvarint("scr_disable_regen_health", 0) == 1) {
    return false;
  }

  if(istrue(self.isjuggernaut)) {
    return false;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    return false;
  }

  if(istrue(self.fauxdead)) {
    return false;
  }

  if(istrue(self.little_bird)) {
    return false;
  }

  if(istrue(self.ref_12B72)) {
    return false;
  }

  return true;
}

function playerpainbreathingsound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  wait 2;

  for(;;) {
    wait 0.2;

    if(shouldplaypainbreathingsound()) {
      if(self.vo_prefix == "p1_") {
        if(soundexists("Fem_breathing_hurt")) {
          playlocalsound_safe("Fem_breathing_hurt");
        }
      } else {
        playlocalsound_safe("breathing_hurt");
      }

      wait 0.784;
      wait 0.1 + randomfloat(0.8);
    }
  }
}

function shouldplaypainbreathingsound() {
  if(ishealthregendisabled() || isusingremote() || isDefined(self.breathingstoptime) && gettime() < self.breathingstoptime || self.health > self.maxhealth * 0.55 || level.gameended) {
    return 0;
  }

  return 1;
}

function ishealthregendisabled() {
  return isDefined(level.healthregendisabled) && level.healthregendisabled || isDefined(self.healthregendisabled) && self.healthregendisabled;
}

function playerarmor() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("game_ended");

  if(!isDefined(self.bodyarmorhp)) {
    self.bodyarmorhp = 0;
  }

  var_0 = self getentitynumber();
  var_1 = 0;
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_0, "playerArmor", 0);

  for(;;) {
    scripts\engine\utility::ref_143A5("player_damaged", "enable_armor");

    if(!isDefined(self.bodyarmorhp)) {
      if(var_1 > 0) {
        scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_0, "playerArmor", 0);
        var_1 = 0;
      }

      continue;
    }

    if(var_1 != self.bodyarmorhp) {
      var_2 = int(self.bodyarmorhp);
      scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_0, "playerArmor", var_1);
      var_1 = self.bodyarmorhp;
    }
  }
}

function allow_secondary_offhand_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledsecondaryoffhandweapons)) {
      self.disabledsecondaryoffhandweapons = 0;
    }

    self.disabledsecondaryoffhandweapons--;

    if(!self.disabledsecondaryoffhandweapons) {
      self enableoffhandsecondaryweapons();
      return;
    }

    return;
  }

  if(!isDefined(self.disabledsecondaryoffhandweapons)) {
    self.disabledsecondaryoffhandweapons = 0;
  }

  self.disabledsecondaryoffhandweapons++;
  self disableoffhandsecondaryweapons();
}

function register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

function global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0.phys_sound_func)) {
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

function register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

function addtotraplist() {
  if(!scripts\engine\utility::array_contains(level.placed_crafted_traps, self)) {
    level.placed_crafted_traps = scripts\engine\utility::array_add_safe(level.placed_crafted_traps, self);
  }

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

function removefromtraplist() {
  if(scripts\engine\utility::array_contains(level.placed_crafted_traps, self)) {
    level.placed_crafted_traps = scripts\engine\utility::array_remove(level.placed_crafted_traps, self);
  }

  level.placed_crafted_traps = scripts\engine\utility::array_removeundefined(level.placed_crafted_traps);
}

function ent_is_near_equipment(var_0) {
  var_1 = 16384;

  if(level.turrets.size) {
    var_2 = sortbydistance(level.turrets, var_0.origin);

    if(distance2dsquared(var_2[0].origin, var_0.origin) < var_1) {
      return 1;
    }
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(var_4 in level.placed_crafted_traps) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(distance2dsquared(var_4.origin, var_0.origin) < var_1) {
        return 1;
      }
    }
  }

  if(isDefined(level.near_equipment_func)) {
    return [[level.near_equipment_func]](var_0);
  }

  return 0;
}

function set_crafted_inventory_item(var_0, var_1, var_2) {
  if(isDefined(var_2.current_crafted_inventory)) {
    var_2.current_crafted_inventory = undefined;
  }

  var_2.current_crafted_inventory = spawnStruct();
  var_2.current_crafted_inventory.item = var_0;
  var_2.current_crafted_inventory.restore_func = var_1;
}

function remove_crafted_item_from_inventory(var_0) {
  var_0.current_crafted_inventory = undefined;
}

function remove_crafted_item_from_dpad(var_0, var_1) {
  switch (var_1) {
    case "up_dpad":
      break;
    case "down_dpad":
      break;
    case "left_dpad":
      break;
    case "right_dpad":
      break;
  }
}

function add_crafted_item_to_dpad(var_0, var_1, var_2) {
  switch (var_1) {
    case "up_dpad":
      break;
    case "down_dpad":
      break;
    case "left_dpad":
      break;
    case "right_dpad":
      break;
  }
}

function item_handleownerdisconnect(var_0) {
  self endon("death");
  level endon("game_ended");
  self notify(var_0);
  self endon(var_0);
  self.owner waittill("disconnect");

  foreach(var_2 in level.players) {
    if(is_valid_player(var_2, 1)) {
      self.owner = var_2;

      if(self.classname != "script_model") {
        self setsentryowner(self.owner);
      }

      break;
    }
  }

  thread item_handleownerdisconnect(var_0);
}

function restore_player_perk() {
  if(isDefined(self.restoreperk)) {
    giveperk(self.restoreperk);
    self.restoreperk = undefined;
    return;
  }
}

function wait_restore_player_perk() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restore_player_perk();
}

function remove_player_perks() {
  if(_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    _unsetperk("specialty_explosivebullets");
    return;
  }
}

function item_timeout(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.lifespan)) {
    self.lifespan = var_1;
  }

  if(isDefined(var_0)) {
    self.lifespan = var_0;
  }

  while(self.lifespan) {
    wait 1;
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      self.lifespan = max(0, self.lifespan - 1);
    }
  }

  while(isDefined(self) && isDefined(self.inuseby)) {
    wait 0.05;
  }

  if(isDefined(self.zap_model)) {
    self.zap_model delete();
  }

  if(isDefined(var_2)) {
    self notify(var_2);
    return;
  }

  self notify("death");
}

function item_oncarrierdeath(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_1 = var_0 scripts\engine\utility::ref_143AD("death", "last_stand");
  var_0 notify("force_cancel_placement");
}

function item_oncarrierdisconnect(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");

  if(isDefined(self.carriedgascan)) {
    self.carriedgascan delete();
  } else if(isDefined(self.carriedmedusa)) {
    self.carriedmedusa delete();
  } else if(isDefined(self.carried_trap)) {
    self.carried_trap delete();
  } else if(isDefined(self.carriedboombox)) {
    self.carriedboombox delete();
  } else if(isDefined(self.carried_fireworks_trap)) {
    self.carried_fireworks_trap delete();
  } else if(isDefined(self.carriedrevocator)) {
    self.carriedrevocator delete();
  }

  self delete();
}

function item_ongameended(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  self delete();
}

function should_be_affected_by_trap(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(!isagent(var_0)) {
    return false;
  }

  if(!isDefined(var_0.agent_type)) {
    return false;
  }

  if(!isDefined(var_0.isactive) || !var_0.isactive) {
    return false;
  }

  if(!isDefined(var_1) && isDefined(var_0.entered_playspace) && !var_0.entered_playspace) {
    return false;
  }

  if(istrue(var_0.marked_for_death)) {
    return false;
  }

  if(!isDefined(var_0.team)) {
    return false;
  }

  if(var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_ghost" || var_0.agent_type == "zombie_grey") {
    return false;
  }

  if(!istrue(var_2) && istrue(var_0.is_suicide_bomber)) {
    return false;
  }

  if(istrue(var_0.is_coaster_zombie)) {
    return false;
  }

  return true;
}

function set_quest_icon(var_0) {
  increment_num_of_quest_piece_completed();
  set_quest_icon_internal(var_0);
}

function set_quest_icon_internal(var_0) {
  setomnvarbit("zombie_quest_piece", var_0, 1);
  setclientmatchdata("questPieces", "quest_piece_" + var_0, 1);
}

function set_completed_quest_mark(var_0) {
  setomnvarbit("zm_completed_quest_marks", var_0, 1);
}

function increment_num_of_quest_piece_completed() {
  if(!isDefined(level.num_of_quest_pieces_completed)) {
    level.num_of_quest_pieces_completed = 0;
  }

  level.num_of_quest_pieces_completed++;

  if(level.num_of_quest_pieces_completed == level.cp_zmb_number_of_quest_pieces) {
    foreach(var_1 in level.players) {
      var_1 scripts\cp\cp_achievement::update_achievement("STICKER_COLLECTOR", 24);
    }

    return;
  }
}

function playplayerandnpcsounds(var_0, var_1, var_2) {
  playlocalsound_safe(var_0, var_1);
  var_0 playsoundtoteam(var_2, "allies", var_0);
  var_0 playsoundtoteam(var_2, "axis", var_0);
}

function roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5) {
    return int(var_0 + 1);
  }

  return int(var_0);
}

function damage_over_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!should_apply_dot(var_0)) {
    return;
  }

  var_0 endon("death");

  if(!isDefined(var_3)) {
    var_3 = 600;
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(!isDefined(var_4)) {
    var_4 = "MOD_UNKNOWN";
  }

  if(!isDefined(var_5)) {
    var_5 = "iw7_dot_zm";
  }

  if(isDefined(var_7)) {
    setscriptablestateflag(var_0, var_0, var_7, 1);

    if(isDefined(level.scriptablestatefunc)) {
      var_0 thread[[level.scriptablestatefunc]](var_0);
    }
  }

  var_9 = 0;
  var_10 = 6;
  var_11 = var_2 / var_10;
  var_12 = var_3 / var_10;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    wait var_11;

    if(isalive(var_0)) {
      var_0.flame_damage_time = gettime() + 500;

      if(var_0.health - var_12 <= 0) {
        if(isDefined(var_8)) {
          level notify(var_8);
        }
      }

      if(isDefined(var_1)) {
        var_0 dodamage(var_12, var_0.origin, var_1, var_1, var_4, var_5);
        continue;
      }

      var_0 dodamage(var_12, var_0.origin, undefined, undefined, var_4, var_5);
    }
  }

  if(isDefined(var_7)) {
    setscriptablestateflag(var_0, var_0, var_7);
  }

  if(istrue(var_0.marked_for_death)) {
    var_0.marked_for_death = undefined;
  }

  if(istrue(var_0.flame_damage_time)) {
    var_0.flame_damage_time = undefined;
    return;
  }
}

function setscriptablestateflag(var_0, var_1, var_2) {
  switch (var_1) {
    case "combinedArcane":
    case "combinedarcane":
      if(istrue(var_2)) {
        var_0.is_afflicted = 1;
      } else {
        var_0.is_afflicted = undefined;
      }

      break;
    case "burning":
      if(istrue(var_2)) {
        var_0.is_burning = var_2;
      } else {
        var_0.is_burning = undefined;
      }

      break;
    case "electrified":
      if(istrue(var_2)) {
        var_0.is_electrified = var_2;
        var_0.allowpain = 1;
        var_0.stun_hit_time = gettime() + 3000;
      } else {
        var_0.is_electrified = undefined;
        var_0.allowpain = 0;
      }

      break;
    case "shocked":
      if(istrue(var_2)) {
        var_0.stunned = var_2;
      } else {
        var_0.stunned = undefined;
      }

      break;
    case "chemBurn":
    case "chemburn":
      if(istrue(var_2)) {
        var_0.is_chem_burning = 1;
      } else {
        var_0.is_chem_burning = undefined;
      }

      break;
    default:
      break;
  }
}

function door_entitylessscriptable_togglelock(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_1, 64);

    if(var_5.size > 0) {
      var_3 = undefined;

      if(var_5.size == 1) {
        var_3 = var_5[0];
        var_4 = 1;
      } else {
        var_6 = var_5.size;
        var_7 = 9999999;

        for(var_8 = 0; var_8 < var_6; var_8++) {
          var_9 = distancesquared(var_5[var_8].origin, var_1);

          if(var_9 < var_7) {
            var_7 = var_9;
            var_3 = var_5[var_8];
            var_4 = 1;
          }
        }
      }
    }
  }

  if(isDefined(var_1) && !istrue(var_4)) {
    return;
  }

  if(istrue(var_2)) {
    var_3 setscriptablepartstate("door", "closed");
  }

  if(var_0) {
    var_3 scriptabledoorfreeze(1);
    return;
  }

  var_3 scriptabledoorfreeze(0);
}

function should_apply_dot(var_0) {
  if(isDefined(var_0.agent_type) && (var_0.agent_type == "c6" || var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost")) {
    return false;
  }

  return true;
}

function update_trap_placement_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_5 = var_2.carriedtrapoffset;
  var_6 = var_2.carriedtrapangles;
  var_7 = var_2.placementradius;
  var_8 = var_2.placementheighttolerance;
  var_9 = var_2.modelplacement;
  var_10 = var_2.modelplacementfailed;
  var_11 = var_2.placecancelablestring;
  var_12 = var_2.placestring;
  var_13 = var_2.cannotplacestring;
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_14 = -1;

  for(;;) {
    var_15 = self canplayerplacesentry(1, var_7);
    var_0.origin = var_15["origin"];
    var_0.angles = var_15["angles"];
    var_1.origin = var_0.origin + var_5;
    var_1.angles = var_0.angles + var_6;

    if(isDefined(self.onslide)) {
      var_0.canbeplaced = 0;
    } else {
      var_0.canbeplaced = self isonground() && var_15["result"] && abs(var_0.origin[2] - self.origin[2]) < var_8;
    }

    if(ent_is_near_equipment(var_0)) {
      var_0.canbeplaced = 0;
    }

    if(isDefined(var_3) && isDefined(level.discotrap_active) && isDefined(level.dance_floor_volume)) {
      if(var_0 istouching(level.dance_floor_volume)) {
        var_0.canbeplaced = 0;
      }
    }

    if(isDefined(var_15["entity"])) {
      var_0.moving_platform = var_15["entity"];
    } else {
      var_0.moving_platform = undefined;
    }

    if(var_0.canbeplaced != var_14) {
      if(var_0.canbeplaced) {
        if(!isDefined(var_4)) {
          var_1 setModel(var_9);
        }

        if(isDefined(var_0.firstplacement)) {
          self forceusehinton(var_11);
        } else {
          self forceusehinton(var_12);
        }
      } else {
        if(!isDefined(var_4)) {
          var_1 setModel(var_10);
        }

        self forceusehinton(var_13);
      }
    }

    var_14 = var_0.canbeplaced;
    wait 0.05;
  }
}

function usegrenadegesture(var_0, var_1) {
  if(cangiveandfireoffhand(var_0, getvalidtakeweapon(var_0)) && !var_0 isgestureplaying()) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
    return;
  }
}

function is_codxp() {
  return getDvar("scr_codxp", "") != "";
}

function too_close_to_other_interactions(var_0) {
  var_1 = sortbydistance(level.current_interaction_structs, var_0);

  if(var_1.size >= 1) {
    if(distancesquared(var_1[0].origin, var_0) < 9216) {
      return true;
    }
  }

  return false;
}

function getweapontoswitchbackto() {
  var_0 = undefined;

  if(isDefined(self.last_weapon)) {
    var_0 = self.last_weapon;
  } else {
    var_0 = self getcurrentweapon();
  }

  var_1 = 0;
  var_2 = level.additional_laststand_weapon_exclusion;

  if(nullweapon(var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0 getbaseweapon())) {
    var_1 = 1;
  } else if(is_melee_weapon(var_0, 1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_3 = self getweaponslistall();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(nullweapon(var_3[var_4])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_2, var_3[var_4])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_2, var_3[var_4] getbaseweapon())) {
        continue;
      }

      if(is_melee_weapon(var_3[var_4], 1)) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isprimaryweapon(var_3[var_4])) {
        continue;
      }

      var_1 = 0;
      var_0 = var_3[var_4];
      break;
    }
  }

  if(var_1) {
    var_0 = getcompleteweaponname("iw7_fists_zm");

    if(!self hasweapon(var_0)) {
      _giveweapon(var_0, undefined, undefined, 1);
    }
  }

  return var_0;
}

function getvalidtakeweapon(var_0) {
  var_1 = self getcurrentweapon();
  var_2 = 0;
  var_3 = level.additional_laststand_weapon_exclusion;

  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::array_combine(var_0, var_3);
  }

  if(nullweapon(var_1)) {
    var_2 = 1;
  } else if(isDefined(var_1.inventorytype) && var_1.inventorytype == "model_only") {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, var_1 getbaseweapon())) {
    var_2 = 1;
  } else if(!turn_off_sniper_laser() && is_melee_weapon(var_1, 1)) {
    var_2 = 1;
  }

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_2) {
    var_1 = self.last_valid_weapon;

    if(nullweapon(var_1)) {
      var_2 = 1;
    } else if(isDefined(var_1.inventorytype) && var_1.inventorytype == "model_only") {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, var_1 getbaseweapon())) {
      var_2 = 1;
    } else if(is_melee_weapon(var_1, 1)) {
      var_2 = 1;
    } else {
      var_2 = 0;
    }
  }

  if(var_2) {
    var_4 = self getweaponslistall();

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(nullweapon(var_4[var_5])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_3, var_4[var_5])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var_3, var_4[var_5] getbaseweapon())) {
        continue;
      }

      if(is_melee_weapon(var_4[var_5], 1)) {
        continue;
      }

      if(isDefined(var_4[var_5].inventorytype) && var_4[var_5].inventorytype == "model_only") {
        continue;
      }

      var_2 = 0;
      var_1 = var_4[var_5];
      break;
    }
  }

  return var_1;
}

function getcurrentcamoname(var_0) {
  var_1 = getweaponcamoname(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  switch (var_1) {
    case "camo0":
      return "camo00";
    case "camo1":
      return "camo01";
    case "camo2":
      return "camo02";
    case "camo3":
      return "camo03";
    case "camo4":
      return "camo04";
    case "camo5":
      return "camo05";
    case "camo6":
      return "camo06";
    case "camo7":
      return "camo07";
    case "camo8":
      return "camo08";
    case "camo9":
      return "camo09";
    default:
      return var_1;
  }

  return undefined;
}

function add_to_notify_queue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self.notify_queue)) {
    self.notify_queue = [];
  }

  if(!isDefined(self.notify_queue[var_0])) {
    self.notify_queue[var_0] = 0;
  } else {
    self.notify_queue[var_0]++;
  }

  if(self.notify_queue[var_0] > 0) {
    wait 0.05 * self.notify_queue[var_0];
  }

  if(isDefined(self)) {
    self notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  waittillframeend();

  if(isDefined(self)) {
    if(isDefined(self.notify_queue[var_0])) {
      self.notify_queue[var_0]--;

      if(self.notify_queue[var_0] < 1) {
        self.notify_queue[var_0] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function take_fists_weapon(var_0) {
  foreach(var_2 in var_0 getweaponslistall()) {
    if(issubstr(var_2.basename, "iw7_fists")) {
      var_0 takeweapon(var_2);
    }
  }
}

function playlocalsound_safe(var_0) {
  if(soundexists(var_0)) {
    self playlocalsound(var_0);
    return;
  }
}

function stoplocalsound_safe(var_0) {
  if(soundexists(var_0)) {
    self stoplocalsound(var_0);
    return;
  }
}

function playsoundatpos_safe(var_0, var_1) {
  if(soundexists(var_1)) {
    playsoundatpos(var_0, var_1);
    return;
  }
}

function playsoundtoplayer_safe(var_0, var_1) {
  if(soundexists(var_0)) {
    var_1 playsoundtoplayer(var_0, var_1);
    return;
  }
}

function agentcantbeignored() {
  return isDefined(self.agent_type) && isDefined(level.ignoreimmune) && scripts\engine\utility::array_contains(level.ignoreimmune, self.agent_type);
}

function agentisfnfimmune() {
  return isDefined(self.agent_type) && isDefined(level.fnfimmune) && scripts\engine\utility::array_contains(level.fnfimmune, self.agent_type);
}

function agentisinstakillimmune() {
  return isDefined(self.agent_type) && isDefined(level.instakillimmune) && scripts\engine\utility::array_contains(level.instakillimmune, self.agent_type);
}

function agentisspecialzombie() {
  return isDefined(self.agent_type) && isDefined(level.specialzombie) && scripts\engine\utility::array_contains(level.specialzombie, self.agent_type);
}

function firegesturegrenade(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(cangiveandfireoffhand(var_2)) {
    var_0 setweaponammostock(var_1, 1);
    var_0 giveandfireoffhand(var_1);
    return;
  }
}

function cangiveandfireoffhand(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(var_0)])) {
      return 0;
    }

    return 1;
  }

  return 1;
}

function play_interaction_gesture(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "iw7_powerlever_zm";
  }

  if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp") {
    thread firegesturegrenade(self, var_0);
    return;
  }
}

function playerplaypickupanim(var_0) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || isplayerads()) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = "iw8_ges_pickup";
  }

  var_1 = getcompleteweaponname("none");
  var_2 = self getcurrentprimaryweapon();

  if(isnullweapon(var_2, var_1)) {
    return;
  }

  if(self isgestureplaying(var_0)) {
    self stopgestureviewmodel(var_0, 0, 1);
    wait 0.05;
  }

  self forceplaygestureviewmodel(var_0);
}

function playerplaytakephotoanim() {
  var_0 = "intel_take_photo";
  var_1 = self getcurrentweapon();
  var_2 = getcompleteweaponname(var_0);
  thread _freeze_until_phototaken();
  _giveweapon(var_2);
  self switchtoweapon(var_2);
  self setclientomnvar("ui_tablet_usb", 7);
  var_3 = 3;
  wait var_3;

  if(isPlayer(self)) {
    self takeweapon(var_2);
    self switchtoweapon(var_1);
    self setclientomnvar("ui_tablet_usb", 0);
    return true;
  }

  return false;
}

function _freeze_until_phototaken() {
  var_0 = self getstance();
  _togglecellphoneallows(1);
  restrict_player_stance_to_this(1, var_0);
  var_1 = 1.6;
  wait var_1;
  _togglecellphoneallows(0);
  restrict_player_stance_to_this(0, var_0);
}

function _togglecellphoneallows(var_0) {
  _freezelookcontrols(var_0);
  scripts\common\utility::allow_movement(!var_0);
  scripts\common\utility::allow_jump(!var_0);
  scripts\common\utility::allow_usability(!var_0);
  scripts\common\utility::allow_melee(!var_0);
  scripts\common\utility::allow_offhand_weapons(!var_0);
  scripts\common\utility::allow_weapon_switch(!var_0);
  scripts\common\utility::allow_sprint(!var_0);
}

function restrict_player_stance_to_this(var_0, var_1) {
  if(istrue(var_0)) {
    _player_allowed_stances(1, var_1);
    return;
  }

  _player_allowed_stances(0, var_1);
}

function _player_allowed_stances(var_0, var_1) {
  if(istrue(var_0)) {
    switch (var_1) {
      case "stand":
        scripts\common\utility::allow_crouch(0);
        scripts\common\utility::allow_prone(0);
        break;
      case "crouch":
        scripts\common\utility::allow_stand(0);
        scripts\common\utility::allow_prone(0);
        break;
      case "prone":
        scripts\common\utility::allow_crouch(0);
        scripts\common\utility::allow_stand(0);
        break;
    }

    return;
  }

  switch (var_1) {
    case "stand":
      scripts\common\utility::allow_crouch(1);
      scripts\common\utility::allow_prone(1);
      break;
    case "crouch":
      scripts\common\utility::allow_stand(1);
      scripts\common\utility::allow_prone(1);
      break;
    case "prone":
      scripts\common\utility::allow_crouch(1);
      scripts\common\utility::allow_stand(1);
      break;
  }
}

function deactivatebrushmodel(var_0, var_1) {
  var_0 notsolid();

  if(istrue(var_1)) {
    var_0 hide();
    return;
  }
}

function rankingenabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return level.onlinegame && !self.usingonlinedataoffline;
}

function debugprintline(var_0) {}

function ent_createheadicon(var_0, var_1, var_2, var_3, var_4) {
  if(!level.teambased) {
    return undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = "allies";
  }

  var_5 = deleteheadicon(var_0);
  setheadiconenemyimage(var_5, var_3);
  addclienttoheadiconmask(var_5, var_1);
  setheadiconmaxdistance(var_5, 0);
  setheadiconsnaptoedges(var_5, 2250);
  setheadiconowner(var_5, var_2);

  if(isDefined(var_4)) {
    setheadiconzoffset(var_5, var_4);
  }

  removeclientfromheadiconmask(var_5, var_2);
  hideheadiconfromplayersinmask(var_5);
  thread watchheadicon(var_0, var_5);
  return var_5;
}

function watchheadicon(var_0, var_1) {
  var_0 endon("head_icon_deleted_" + var_1);
  var_0 waittill("death");
  thread ent_deleteheadicon(var_0, var_1);
}

function ent_deleteheadicon(var_0, var_1) {
  var_0 notify("head_icon_deleted_" + var_1);

  if(isDefined(var_1) && var_1 != -1) {
    setheadiconimage(var_1);
    return;
  }
}

function getlastweapon() {
  return self.lastweaponobj;
}

function isnmlactive() {
  return istrue(level.nml_proto);
}

function addtostructarray(var_0, var_1, var_2) {
  if(!isDefined(level.struct_class_names[var_0][var_1])) {
    level.struct_class_names[var_0][var_1] = [];
  }

  level.struct_class_names[var_0][var_1][level.struct_class_names[var_0][var_1].size] = var_2;
}

function is_in_active_volume(var_0) {
  if(!isDefined(level.active_spawn_volumes)) {
    return true;
  }

  var_1 = sortbydistance(level.active_spawn_volumes, var_0);

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return true;
    }
  }

  return false;
}

function give_max_ammo_to_player(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 givemaxammo(var_3);

    if(weaponmaxammo(var_3) == weaponclipsize(var_3)) {
      var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
    }
  }

  var_5 = getarraykeys(var_0.powers);

  foreach(var_7 in var_5) {
    if(var_0.powers[var_7].slot == "secondary") {
      continue;
    }

    thread recharge_power(var_0);
  }
}

function recharge_power(var_0) {
  var_1 = self.powers[var_0].slot;

  if(istrue(self.powers[var_0].active)) {
    while(istrue(self.powers[var_0].active)) {
      wait 0.05;
    }
  }

  if(istrue(self.powers[var_0].updating)) {
    while(istrue(self.powers[var_0].updating)) {
      wait 0.05;
    }
  }

  thread scripts\cp\cp_powers::givepower(var_0, var_1, undefined, undefined, undefined, undefined, 1);

  if(istrue(level.secondary_power)) {
    if(isDefined(level.power_modifycooldownrate)) {
      self[[level.power_modifycooldownrate]](10, "secondary");
    }
  }

  if(istrue(level.infinite_grenades)) {
    if(isDefined(level.power_modifycooldownrate)) {
      self[[level.power_modifycooldownrate]](100);
      return;
    }

    return;
  }
}

function objective_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\cp\cp_objectives::objective_update_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

function obj(var_0) {
  if(!isDefined(level.objectives)) {
    level.objectives = [];
  }

  if(!isDefined(level.objectives[var_0])) {
    level.objectives[var_0] = level.objectives.size + 1;
  }

  return level.objectives[var_0];
}

function objective_complete(var_0) {
  scripts\cp\cp_objectives::delete_objective(var_0);
  var_1 = scripts\cp\cp_objectives::get_objective_type(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "global") {
      return;
    }
  }

  scripts\cp\cp_objectives::reset_objective_omnvars(var_0);
}

function hint_prompt(var_0, var_1, var_2) {
  if(istrue(var_1)) {
    var_3 = int(tablelookup("cp/cp_hints.csv", 1, var_0, 0));
  } else {
    var_3 = 0;
  }

  self setclientomnvar("zm_hint_index", var_3);

  if(isDefined(var_3)) {
    wait var_3;
    self setclientomnvar("zm_hint_index", 0);
    return;
  }
}

function processed_tilt(var_0) {
  var_1 = tablelookup("cp/carry_items.csv", 1, var_0, 0);

  if(isDefined(var_1)) {
    return var_1;
  }

  return 0;
}

function ref_13070(var_0, var_1) {
  var_2 = processed_tilt(var_1);
  var_3 = 1;

  if(!isDefined(var_0.get_track_setting) || var_0.get_track_setting == 0) {
    var_0.get_track_setting = int(var_2);
  } else {
    var_0.get_track_end_struct = int(var_2);
    var_3 = 2;
  }

  var_4 = spawnStruct();
  var_4.get_total_successful_vehicle_spawns_from_module = var_1;
  var_4.slot = var_3;
  scripts\cp\cp_globallogic::elevator_model(var_0);
  return var_4;
}

function ref_12BC6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 == 1) {
    var_0.get_track_setting = 0;
  } else if(var_1 == 2) {
    var_0.get_track_end_struct = 0;
  }

  scripts\cp\cp_globallogic::elevator_model(var_0);
}

function addentrytodevgui(var_0) {
  thread addentrytodevgui_internal(level);
}

function addentrytodevgui_internal(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("ready_for_devgui")) {
    scripts\engine\utility::flag_wait("ready_for_devgui");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  wait 2;
  var_1 = "";
  var_2 = strtok(var_0, "/");
  var_3 = " ";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, " ");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9) {
        var_1 = var_1 + var_11 + var_3;
      } else {
        var_1 += var_11;
      }

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size) {
      var_1 += "/";
    }
  }
}

function array_sort_by_handler(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = &defaultsortfunc;
  }

  var_2 = istrue(var_2);

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    for(var_4 = var_3 + 1; var_4 < var_0.size; var_4++) {
      if(var_2) {
        if(var_0[var_4][[var_1]]() > var_0[var_3][[var_1]]()) {
          var_5 = var_0[var_4];
          var_0 = var_0[var_3];
          var_0 = var_5;
        }

        continue;
      }

      if(var_0[var_4][[var_1]]() < var_0[var_3][[var_1]]()) {
        var_5 = var_0[var_4];
        var_0 = var_0[var_3];
        var_0 = var_5;
      }
    }
  }

  return var_0;
}

function array_compare(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return false;
    }

    var_4 = var_1[var_5];

    if(var_4 != var_3) {
      return false;
    }
  }

  return true;
}

function defaultsortfunc(var_0, var_1) {
  return randomint(100);
}

function set_segmented_health_regen_parameters(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.max_health_cap = var_0 / 100;
  var_6.min_health_cap = var_1 / 100;
  var_6.segment_size = var_2 / 100;
  var_6.pre_regen_wait = var_3;
  var_6.per_regen_amount = var_4 / 100;
  var_6.between_regen_wait = var_5;
  level.segmented_health_regen_parameters = var_6;
}

function segmented_health_regen(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("one_instance_of_segmented_health");
  var_0 endon("one_instance_of_segmented_health");
  var_0 waittill("spawned_player");
  var_1 = level.segmented_health_regen_parameters;
  var_0.max_health_cap = int(var_0.maxhealth * var_1.max_health_cap);
  var_0.min_health_cap = int(var_0.maxhealth * var_1.min_health_cap);
  var_0.segment_size = int(var_0.maxhealth * var_1.segment_size);
  var_0.pre_regen_wait = var_1.pre_regen_wait;
  var_0.per_regen_amount = int(var_0.maxhealth * var_1.per_regen_amount);
  var_0.between_regen_wait = var_1.between_regen_wait;
  set_current_health_regen_segment(var_0, var_0.max_health_cap);

  for(;;) {
    var_0 scripts\engine\utility::ref_143AD("damage", "revive");
    update_current_health_regen_segment(var_0);

    if(!can_do_segmented_health_regen(var_0)) {
      continue;
    }

    thread segmented_health_regen_internal(var_0);
  }
}

function segmented_health_regen_internal(var_0) {
  var_0 notify("segmented_health_regen_internal");
  level endon("game_ended");
  var_0 endon("segmented_health_regen_internal");
  var_0 endon("disconnect");
  var_0 endon("damage");
  var_0 endon("last_stand");
  wait var_0.pre_regen_wait;

  for(;;) {
    var_0.health = int(min(int(min(var_0.health + var_0.per_regen_amount, var_0.current_health_regen_segment_ceiling)), var_0.maxhealth));

    if(var_0.health == var_0.current_health_regen_segment_ceiling) {
      return;
    }

    wait var_0.between_regen_wait;
  }
}

function set_current_health_regen_segment(var_0, var_1) {
  var_0.current_health_regen_segment_ceiling = int(var_1);
  var_0.current_health_regen_segment_floor = int(var_1 - var_0.segment_size);
}

function update_current_health_regen_segment(var_0) {
  if(var_0.current_health_regen_segment_ceiling == var_0.min_health_cap) {
    return;
  }

  if(var_0.health < var_0.current_health_regen_segment_floor) {
    set_current_health_regen_segment(var_0, find_new_health_regen_segment_ceiling(var_0));
    return;
  }
}

function find_new_health_regen_segment_ceiling(var_0) {
  var_1 = int((var_0.max_health_cap - var_0.min_health_cap) / var_0.segment_size);

  for(var_2 = 0; var_2 <= var_1 + 1; var_2++) {
    var_3 = var_0.min_health_cap + var_2 * var_0.segment_size;

    if(var_3 >= var_0.health) {
      return int(min(var_3, var_0.maxhealth));
    }
  }
}

function can_do_segmented_health_regen(var_0) {
  if(is_segmented_health_regen_disabled(var_0)) {
    return false;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return false;
  }

  return true;
}

function is_segmented_health_regen_disabled(var_0) {
  return istrue(var_0.segmented_health_regen_disabled);
}

function disable_segmented_health_regen(var_0) {
  var_0.segmented_health_regen_disabled = 1;
}

function enable_segmented_health_regen(var_0) {
  var_0.segmented_health_regen_disabled = 0;
}

function is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return true;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return true;
    }
  }

  return false;
}

function draw_debug_rectangle(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_1[0];
  var_4 = var_0[1];
  var_5 = var_1[1];
  var_6 = max(var_0[2], var_1[2]);
  var_7 = (var_2, var_5, var_6);
  var_8 = (var_3, var_4, var_6);
}

function vehicle_createhealthbar(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_2 = var_0 gettagorigin("tag_origin", 1);

  if(isDefined(var_2)) {
    var_1 linkTo(var_0, "tag_origin", (0, 0, 190), (0, 0, 0));
  } else {
    var_1 linkTo(var_0);
  }

  var_3 = vehicle_gethealthbarid();

  if(!isDefined(var_3)) {
    return;
  }

  var_0.healthbarid = var_3;
  var_4 = 1;

  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  level.healthbars[var_0.healthbarid] = var_1;
  setomnvar("ui_ingame_light_tank_ent_" + var_0.healthbarid, var_1);
  setomnvar("ui_ingame_light_tank_team_" + var_0.healthbarid, var_4);
  setomnvar("ui_ingame_light_tank_health_" + var_0.healthbarid, 1);
}

function vehicle_gethealthbarid() {
  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  var_0 = undefined;

  for(var_1 = 0; var_1 < 7; var_1++) {
    if(!isDefined(level.healthbars[var_1])) {
      var_0 = var_1;
      break;
    }
  }

  return var_0;
}

function vehicle_freehealthbarui() {
  if(isDefined(self.healthbarid)) {
    var_0 = level.healthbars[self.healthbarid];
    var_0 delete();
    setomnvar("ui_ingame_light_tank_ent_" + self.healthbarid, undefined);
    setomnvar("ui_ingame_light_tank_health_" + self.healthbarid, 0);
    setomnvar("ui_ingame_light_tank_team_" + self.healthbarid, 0);
    level.healthbars[self.healthbarid] = undefined;
    self.healthbarid = undefined;
    return;
  }
}

function vehile_updatehealthbar(var_0) {
  if(isDefined(self.healthbarid)) {
    setomnvar("ui_ingame_light_tank_health_" + self.healthbarid, var_0);
    return;
  }
}

function create_waypoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  var_6 = undefined;

  if(var_2 != "all") {
    var_6 = newteamhudelem(var_2);
  } else {
    var_6 = newhudelem();
  }

  var_6.id = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6.z = var_1[2];
  var_6.team = var_2;
  var_6.isflashing = 0;
  var_6.isshown = 1;

  if(issplitscreen()) {
    var_6 setshader(var_3, 8, 8);
  } else {
    var_6 setshader(var_3, 15, 15);
  }

  var_6 setwaypoint(0, 1, 1);

  if(isDefined(var_4)) {
    var_6.alpha = var_4;
  } else {
    var_6.alpha = 0.75;
  }

  var_6.basealpha = var_6.alpha;
  return var_6;
}

function waypoint_delete(var_0) {
  var_0 destroy();
}

function _freezecontrols(var_0, var_1, var_2) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
    return;
  }

  self freezecontrols(1);
  self.controlsfrozen = 1;
}

function _freezelookcontrols(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerLookFreezeStack"] = 0;
  } else {
    self.pers["controllerLookFreezeStack"]--;
  }

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self.lookcontrolsfrozen = 0;
    return;
  }

  self freezelookcontrols(1);
  self.lookcontrolsfrozen = 1;
}

function _setdof_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self)) {
    return;
  }

  var_0 = max(var_0, 0);
  var_1 = clamp(var_1, 1, 9994);
  var_2 = clamp(var_2, 2, 9998);
  var_3 = clamp(var_3, 3, 9999);

  if(var_2 > 9994) {
    var_5 = 0;
  }

  self setdepthoffield(var_0, var_1, var_2, var_3, var_4, var_5);
}

function setdof_dynamic() {
  self endon("disconnect");
  self endon("death");
  setdof_default();

  if(isai(self)) {
    return;
  }

  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["physicscontents_player"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  GscBinSkip0(0x2e, "geo", spawnStruct());
}

function setdof_killer() {
  self endon("disconnect");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

function setdof_killer_update() {
  self endon("disconnect");
  self endon("death_delay_finished");
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120;
  var_5 = scripts\engine\trace::sphere_trace(var_3, var_4, 2, self, var_1, 0);
  var_6 = var_5["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var_7 = distance(var_6, self.lastkilledby.origin);
    var_8 = 0;
    var_9 = max(var_7 - 12, 1);
    var_10 = var_7 + 12;
    var_11 = var_10 + 50;
    var_12 = 8;
    var_13 = 4.5;
    _setdof_internal(var_8, var_9, var_10, var_11, var_12, var_13);
    waitframe();
  }
}

function setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

function setdof_spectator() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

function setdof_infil() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

function setdof_apache() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

function setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

function setdof_cruisefirst() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

function setdof_tank() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 120, 1000, 6500, 7, 3.5);
}

function setdof_thirdperson() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 110, 512, 4096, 6, 1.8);
}

function draw_line_until_endons(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      foreach(var_7 in var_4) {
        self endon(var_7);
      }
    } else {
      self endon(var_4);
    }
  }

  if(!isDefined(var_5)) {
    var_5 = var_0 + (0, 0, 256);
  }

  for(;;) {
    waitframe();
  }
}

function play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
    return;
  }

  playsoundatpos(self.origin, var_0);
}

function get_point_in_local_ent_space(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = anglestoup(var_0.angles);
  var_4 = anglestoleft(var_0.angles);
  var_5 = anglesToForward(var_0.angles);
  var_6 = var_1[0] * var_5[0] + var_1[1] * var_4[0] + var_1[2] * var_3[0] + var_2[0];
  var_7 = var_1[0] * var_5[1] + var_1[1] * var_4[1] + var_1[2] * var_3[1] + var_2[1];
  var_8 = var_1[0] * var_5[2] + var_1[1] * var_4[2] + var_1[2] * var_3[2] + var_2[2];
  var_9 = (var_6, var_7, var_8);
  return var_9;
}

function _scriptnoteworthycheck(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(!isDefined(var_0.script_noteworthy)) {
    return false;
  }

  if(var_0.script_noteworthy != var_1) {
    return false;
  }

  return true;
}

function show_self_pressed_buttons() {
  for(;;) {
    var_0 = "";

    if(self buttonPressed("BUTTON_Y")) {
      var_0 += ",y";
    }

    if(self buttonPressed("BUTTON_BACK")) {
      var_0 += ",guide";
    }

    if(self stancebuttonPressed()) {
      var_0 += ",stance";
    }

    if(self useButtonPressed()) {
      var_0 += ",use";
    }

    if(self fragButtonPressed()) {
      var_0 += ",frag";
    }

    if(self meleeButtonPressed()) {
      var_0 += ",melee";
    }

    if(self jumpbuttonPressed()) {
      var_0 += ",jump";
    }

    if(self attackButtonPressed()) {
      var_0 += ",attack";
    }

    if(self secondaryoffhandbuttonPressed()) {
      var_0 += ",secondary";
    }

    if(self adsButtonPressed()) {
      var_0 += ",ADS";
    }

    self iprintln(var_0);
    wait 0.05;
  }
}

function remove_cursor_hint() {
  var_0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var_0 = self.cursor_hint_ent;
    var_0 scripts\engine\utility::delaycall(0.5, &delete);
  }

  if(isDefined(var_0) && !isstruct(var_0)) {
    var_0 makeunusable();
  }

  if(isDefined(self)) {
    notify_delay("hint_destroyed", 0.05);
    return;
  }
}

function notify_delay(var_0, var_1) {
  self endon("death");

  if(var_1 > 0) {
    wait var_1;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(var_0);
}

function create_cursor_hint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = self;

  if(isstruct(var_14) || var_14.classname == "script_origin" || isDefined(var_1)) {
    var_14 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var_14;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var_1)) {
    var_15 = "tag_origin";

    if(isDefined(var_0)) {
      var_15 = var_0;
      var_14.origin = self gettagorigin(var_15);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var_15)) {
      var_14 linkTo(self, var_15, var_1, (0, 0, 0));
    } else if(isDefined(var_0)) {
      var_14 linkTo(self, var_15, var_1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var_14.origin += rotatevector(var_1, self.angles);

      if(isent(self)) {
        var_14 linkTo(self);
      }
    } else {
      var_14.origin += var_1;

      if(isent(self)) {
        var_14 linkTo(self);
      }
    }
  } else if(isDefined(var_0)) {
    var_14 sethinttag(var_0);
  }

  if(isDefined(var_8) && var_8) {
    var_14 setCursorHint("HINT_NOICON");
  } else {
    var_14 setCursorHint("HINT_BUTTON");
  }

  if(isDefined(var_2)) {
    var_14 setHintString(var_2);
  }

  var_16 = 360;

  if(isDefined(var_3)) {
    var_16 = var_3;
  }

  var_14 sethintdisplayfov(var_16);
  var_17 = 65;

  if(isDefined(var_13)) {
    var_17 = var_13;
  }

  var_14 setusefov(var_17);
  var_18 = 500;

  if(isDefined(var_4)) {
    var_18 = var_4;
  }

  var_14 sethintdisplayrange(var_18);
  var_19 = 80;

  if(isDefined(var_5)) {
    var_19 = var_5;
  }

  var_14 setuserange(var_19);

  if(isDefined(var_6) && var_6) {
    var_14 sethintonobstruction("show");
  } else {
    var_14 sethintonobstruction("hide");
  }

  if(isDefined(var_7) && var_7) {
    var_14 sethintrequiresmashing(var_7);
  }

  if(!isDefined(var_10)) {
    var_10 = "duration_short";
  }

  var_14 setuseholdduration(var_10);

  if(var_10 == "duration_medium" || var_10 == "duration_long") {
    var_14 sethintrequiresholding(1);
  }

  thread hint_delete_on_trigger();

  if(isDefined(var_9)) {
    var_14 sethinticon(var_9);
  }

  if(isDefined(var_11)) {
    var_14 setusecommand(var_11);
  }

  if(isDefined(var_12)) {
    var_14 sethintlockplayermovement(1);
  } else {
    var_14 sethintlockplayermovement(0);
  }

  var_14 makeusable();
  return var_14;
}

function hint_ent_notify_trigger() {
  self endon("death");
  self endon("hint_destroyed");
  self.cursor_hint_ent waittill("trigger", var_0);
  self notify("trigger", var_0);
}

function hint_delete_on_trigger() {
  self endon("hint_destroyed");
  var_0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var_0 = self.cursor_hint_ent;
  }

  hint_delete_on_trigger_waittill(var_0);
  thread remove_cursor_hint();
}

function hint_delete_on_trigger_waittill(var_0) {
  self endon("entitydeleted");
  var_0 waittill("trigger");
}

function outline_fade_alpha_for_index(var_0, var_1, var_2) {
  thread outline_fade_alpha_for_index_internal(var_0, var_1, var_2);
}

function outline_fade_alpha_for_index_internal(var_0, var_1, var_2) {
  level notify("hud_outline_alpha_fade_" + var_0);
  level endon("hud_outline_alpha_fade_" + var_0);
  var_0++;
  var_3 = "cg_hud_outline_colors_" + var_0;
  var_4 = getDvar(var_3);
  var_4 = strtok(var_4, " ");
  var_5 = var_4[0] + " " + var_4[1] + " " + var_4[2] + " ";
  var_6 = float(var_4[3]);
  var_7 = var_1 - var_6;
  var_8 = 0.05;
  var_9 = int(var_2 / var_8);

  if(var_9 > 0) {
    var_10 = var_7 / var_9;

    while(var_9) {
      var_6 += var_10;
      var_6 = clamp(var_6, 0, 1);
      setsaveddvar(var_3, var_5 + var_6);
      wait var_8;
      var_9--;
    }
  }

  setsaveddvar(var_3, var_5 + var_1);
}

function add_wait(var_0, var_1, var_2, var_3) {
  init_waits();
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1)) {
    var_4.parms[var_4.parms.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4.parms[var_4.parms.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4.parms[var_4.parms.size] = var_3;
  }

  if(!isDefined(level.waits.wait_any_func_array)) {
    level.waits.wait_any_func_array = [var_4];
    return;
  }

  level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = var_4;
}

function init_waits() {
  if(!scripts\engine\utility::add_init_script("waits", &init_waits)) {
    return;
  }

  level.waits = spawnStruct();
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
}

function add_wait_asserter() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_0 = 0; var_0 < 20; var_0++) {
    waittillframeend();
  }
}

function do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

function do_wait(var_0) {
  init_waits();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = spawnStruct();
  var_2 = level.waits.wait_any_func_array;
  var_3 = level.waits.do_wait_endons_array;
  var_4 = level.waits.run_func_after_wait_array;
  var_5 = level.waits.run_call_after_wait_array;
  var_6 = level.waits.run_noself_call_after_wait_array;
  var_7 = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  var_1.count = var_2.size;
  var_1 scripts\engine\utility::array_levelthread(var_2, &waittill_func_ends, var_3);
  thread do_abort(var_1);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    var_1 waittill("func_ended");
  }

  LOC_000000f7:
    var_1 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var_4, &exec_func, []);
  scripts\engine\utility::array_levelthread(var_5, &exec_call);
  scripts\engine\utility::array_levelthread(var_6, &exec_call_noself);
}

function exec_call(var_0) {
  if(var_0.parms.size == 0) {
    var_0.caller builtin[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function exec_call_noself(var_0) {
  if(var_0.parms.size == 0) {
    builtin[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    builtin[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function exec_func(var_0, var_1) {
  if(!isDefined(var_0.caller)) {
    return;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].caller endon(var_1[var_2].ender);
  }

  if(var_0.parms.size == 0) {
    var_0.caller[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    var_0.caller[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function do_abort(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }

  var_1 = 0;
  self.abort_count = var_0.size;
  var_2 = [];
  scripts\engine\utility::array_levelthread(var_0, &waittill_abort_func_ends, var_2);

  for(;;) {
    if(self.abort_count <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

function waittill_abort_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.abort_count--;
  self notify("abort_func_ended");
}

function waittill_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.count--;
  self notify("func_ended");
}

function waittill_msg(var_0) {
  self waittill(var_0);
}

function create_client_overlay(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newclienthudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader(var_1, 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_2;
  var_3.foreground = 1;
  return var_3;
}

function createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11)) {
    var_12 = var_11;
  } else {
    var_12 = spawn("script_model", var_0);
  }

  sethintobject(var_12, undefined, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(!isDefined(var_4)) {
    var_12 setusepriority(0);
  }

  if(!isDefined(var_11)) {
    return var_12;
  }
}

function clearhintobject(var_0) {}

function get_actual_time_from_civil(var_0, var_1, var_2) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = getsystemtime();

    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings) {
      var_3 += 3600;
    }
  }

  if(isDefined(var_1)) {
    var_3 -= 3600 * var_1;
  }

  var_4 = 1970;
  var_5 = floor(var_3 / 31536000);

  if(var_5 != 0) {
    var_6 = floor((var_5 + 2) / 4);
  } else {
    var_6 = 0;
  }

  var_4 -= var_6 * 31536000;
  var_4 -= var_6 * 86400;
  var_5 += var_6;

  if(!is_divisible_by(var_5, 4)) {
    var_7 = floor(var_6 / 4);
    var_8 = var_6 / 4;
    var_9 = var_8 - var_7;

    if(var_9 >= 0.75) {
      var_10 = 1;
    } else {
      var_10 = 0;
    }
  } else {
    var_10 = 0;
  }

  if(var_5 != 0) {
    var_11 = floor(var_5 / 86400);
    var_5 -= var_11 * 86400;
  } else {
    var_11 = 0;
  }

  if(var_6 != 0) {
    var_12 = floor(var_6 / 3600);
    var_6 -= var_12 * 3600;
  } else {
    var_12 = 0;
  }

  if(var_6 != 0) {
    var_13 = floor(var_6 / 60);
    var_6 -= var_13 * 60;
  } else {
    var_13 = 0;
  }

  var_14 = determine_correct_month(var_12 + 1, var_12);
  GscBinSkip0(0x2e, "year", var_10);
}

function is_daylight_savings(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_0["month_string"] == "March" && var_0["year"] == 2017) {
    var_3 = 1;
  } else if(var_0["month_string"] == "December" || var_0["month_string"] == "January" || var_0["month_string"] == "February") {
    var_3 = 0;
  } else if(var_0["month_string"] != "March" && var_0["month_string"] != "April") {
    var_3 = 1;
  } else if(var_0["month_string"] == "March" && var_0["days"] >= 14) {
    var_3 = 1;
  } else if(var_0["month_string"] == "November" && var_0["days"] <= 6) {
    var_3 = 0;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    level.isdaylightsavings = 1;
    var_0 = get_actual_time_from_civil(var_1, var_2, 1);
  } else {
    level.isdaylightsavings = 0;
  }

  return var_0;
}

function does_day_fit_in_current_month(var_0, var_1, var_2) {
  var_3 = 30;

  switch (var_1) {
    case "January":
      var_3 = 31;
      break;
    case "February":
      if(var_2) {
        var_3 = 29;
      } else {
        var_3 = 28;
      }

      break;
    case "March":
      var_3 = 31;
      break;
    case "April":
      var_3 = 30;
      break;
    case "May":
      var_3 = 31;
      break;
    case "June":
      var_3 = 30;
      break;
    case "July":
      var_3 = 31;
      break;
    case "August":
      var_3 = 31;
      break;
    case "September":
      var_3 = 30;
      break;
    case "October":
      var_3 = 31;
      break;
    case "November":
      var_3 = 30;
      break;
    case "December":
      var_3 = 31;
      break;
    default:
      break;
  }

  if(var_0 > var_3) {
    return 1;
  }

  return 0;
}

function determine_correct_month(var_0, var_1) {
  var_2 = [];
  var_2["month"] = undefined;
  var_2["month_string"] = undefined;
  var_2["days"] = undefined;
  var_3 = int(istrue(var_1));

  if(var_0 <= 31) {
    var_2 = 1;
    var_2 = "January";
    var_2 = var_0;
    return var_2;
  }

  if(var_0 <= 59 + var_3) {
    var_2 = 2;
    var_2 = "February";
    var_2 = var_0 - 31;
    return var_2;
  }

  if(var_0 <= 90 + var_3) {
    var_2 = 3;
    var_2 = "March";
    var_2 = var_0 - 59 + var_3;
    return var_2;
  }

  if(var_0 <= 120 + var_3) {
    var_2 = 4;
    var_2 = "April";
    var_2 = var_0 - 90 + var_3;
    return var_2;
  }

  if(var_0 <= 151 + var_3) {
    var_2 = 5;
    var_2 = "May";
    var_2 = var_0 - 120 + var_3;
    return var_2;
  }

  if(var_0 <= 182 + var_3) {
    var_2 = 6;
    var_2 = "June";
    var_2 = var_0 - 151 + var_3;
    return var_2;
  }

  if(var_0 <= 212 + var_3) {
    var_2 = 7;
    var_2 = "July";
    var_2 = var_0 - 182 + var_3;
    return var_2;
  }

  if(var_0 <= 243 + var_3) {
    var_2 = 8;
    var_2 = "August";
    var_2 = var_0 - 212 + var_3;
    return var_2;
  }

  if(var_0 <= 273 + var_3) {
    var_2 = 9;
    var_2 = "September";
    var_2 = var_0 - 243 + var_3;
    return var_2;
  }

  if(var_0 <= 304 + var_3) {
    var_2 = 10;
    var_2 = "Octobor";
    var_2 = var_0 - 273 + var_3;
    return var_2;
  }

  if(var_0 <= 335 + var_3) {
    var_2 = 11;
    var_2 = "November";
    var_2 = var_0 - 304 + var_3;
    return var_2;
  }

  var_2 = 12;
  var_2 = "December";
  var_2 = var_0 - 335 + var_3;
  return var_2;
}

function set_friendlyfire_warnings(var_0) {
  if(var_0) {
    self.friendlyfire_warnings_disable = undefined;
    return;
  }

  self.friendlyfire_warnings_disable = 1;
}

function battlechatter_on(var_0) {
  thread battlechatter_on_thread(var_0);
}

function battlechatter_on_thread(var_0) {
  level endon("battlechatter_off_thread");
  scripts\cp\cp_battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized)) {
    waitframe();
  }

  anim.bcs_enabled = 1;
  wait 1.5;
  jumpiffalse(isDefined(var_0)) LOC_00000042;
  scripts\cp\cp_battlechatter::set_battlechatter_variable(var_0, 1);
  var_1 = getaiarray(var_0);
  goto LOC_00000077;
}

function set_battlechatter(var_0) {
  if(!isDefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }

  if(istrue(self.battlechatter_removed)) {
    return;
  }

  if(var_0) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog) {
      self.battlechatterallowed = 0;
      return;
    }

    self.battlechatterallowed = 1;
    return;
  }

  self.battlechatterallowed = 0;

  if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking)) {
    self waittill("done speaking");
    return;
  }
}

function getvehiclearray() {
  return vehicle_getarray();
}

function get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self)) {
      return level.player;
    }

    return self;
  }

  return level.players[0];
}

function player_looking_at(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.8;
  }

  var_4 = get_player_from_self();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1) {
    return 0;
  }

  if(isDefined(var_2)) {
    return 1;
  }

  return scripts\engine\trace::ray_trace_detail_passed(var_0, var_5, var_3, scripts\engine\trace::create_default_contents(1));
}

function is_divisible_by(var_0, var_1) {
  if(floor(var_0 / var_1) > var_0 / var_1) {
    return 1;
  }

  return 0;
}

function array_merge(var_0, var_1) {
  if(var_0.size == 0) {
    return var_1;
  }

  if(var_1.size == 0) {
    return var_0;
  }

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function create_sunflare_setting(var_0) {
  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

function vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

function createuseent(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1.curprogress = 0;
  var_1.usetime = 0;
  var_1.userate = 8000;
  var_1.inuse = 0;
  return var_1;
}

function getinteractionbynoteworthy(var_0) {
  foreach(var_2 in level.current_interaction_structs) {
    if(var_2.script_noteworthy == var_0) {
      return var_2;
    }
  }

  return undefined;
}

function quicksort(var_0, var_1) {
  return quicksortmid(var_0, 0, var_0.size - 1, var_1);
}

function quicksortmid(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isDefined(var_3)) {
    var_3 = &quicksort_compare;
  }

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4].patrolscore, var_6.patrolscore) && var_4 <= var_2 && var_5 > var_4) {
        var_4++;
      }

      while(![[var_3]](var_0[var_5].patrolscore, var_6.patrolscore) && var_5 >= var_1 && var_5 >= var_4) {
        var_5--;
      }

      if(var_5 > var_4) {
        var_0 = swap(var_0, var_4, var_5);
      }
    }

    var_0 = swap(var_0, var_1, var_5);
    var_0 = quicksortmid(var_0, var_1, var_5 - 1, var_3);
    var_0 = quicksortmid(var_0, var_5 + 1, var_2, var_3);
  } else {
    return var_1;
  }

  return var_0;
}

function quicksort_compare(var_0, var_1) {
  return var_0 <= var_1;
}

function swap(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0 = var_0[var_2];
  var_0 = var_3;
  return var_0;
}

function hideminimap(var_0) {
  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0) {
    self.minimapstatetracker = 0;
  }

  if(istrue(var_0) || self.minimapstatetracker == 0 && var_1 > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var_0)) {
      self.minimapstatetracker = 0;
      return;
    }

    return;
  }
}

function showminimap() {
  if(trophy_get_part_by_tag()) {
    return;
  }

  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var_0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var_0 < self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 0);
    return;
  }
}

function getplayerdataloadoutgroup() {
  if(getdvarint("systemlink")) {
    return "privateloadouts";
  }

  return "rankedloadouts";
}

function disableplayerminimap() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("giveLoadout");
    hideminimap(1);
  }
}

function allow_change_stance(var_0) {
  var_1 = self getstance();

  switch (var_1) {
    case "stand":
      scripts\common\utility::allow_crouch(var_0);
      scripts\common\utility::allow_prone(var_0);
      break;
    case "crouch":
      scripts\common\utility::allow_stand(var_0);
      scripts\common\utility::allow_prone(var_0);
      break;
    case "prone":
      scripts\common\utility::allow_stand(var_0);
      scripts\common\utility::allow_crouch(var_0);
      break;
  }
}

function getplayersinteam(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "allies";
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function teleportallplayersinteamtostructs(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(!isDefined(var_3) || var_3.size < 4) {
    return;
  }

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var_4 = 0;

  foreach(var_6 in getplayersinteam(var_0)) {
    var_3[var_4].angles = scripts\engine\utility::ter_op(isDefined(var_3[var_4].angles), var_3[var_4].angles, (0, 0, 0));
    var_6 setOrigin(var_3[var_4].origin);
    var_6 setplayerangles(var_3[var_4].angles);
    var_6 dontinterpolate();
    var_4++;
  }

  if(!istrue(var_2)) {
    return;
  }

  thread thread_teleportplayertoteamstructs_latejoin(level, var_0);
}

function thread_teleportplayertoteamstructs_latejoin(var_0, var_1) {
  level endon("game_ended");
  level notify("waiting_for_team_teleports_" + var_0);
  level endon("waiting_for_team_teleports_" + var_0);

  for(;;) {
    level waittill("connected", var_2);
    thread teleportplayertoteamstructs_latejoin(level, var_2);
  }
}

function teleportplayertoteamstructs_latejoin(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  waitframe();
  teleportplayertoteamstructs(var_0, var_1);
}

function teleportplayertoteamstructs(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(!isDefined(var_2) || var_2.size < 4) {
    return;
  }

  var_3 = randomintrange(0, var_2.size);
  var_2[var_3].angles = scripts\engine\utility::ter_op(isDefined(var_2[var_3].angles), var_2[var_3].angles, (0, 0, 0));
  var_0 setOrigin(var_2[var_3].origin);
  var_0 setplayerangles(var_2[var_3].angles);
  var_0 dontinterpolate();
}

function string_is_single_digit_integer(var_0) {
  if(var_0.size > 1) {
    return false;
  }

  var_1 = [];
  GscBinSkip0(0x2e, "0", 1);
}

function init_vehicle_omnvars() {
  self setclientomnvar("ui_veh_vehicle", -1);
  self setclientomnvar("ui_veh_occupant_0", -1);
  self setclientomnvar("ui_veh_occupant_1", -1);
  self setclientomnvar("ui_veh_occupant_2", -1);
  self setclientomnvar("ui_veh_occupant_3", -1);
  self setclientomnvar("ui_veh_occupant_4", -1);
}

function printgameaction(var_0, var_1) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }

  var_2 = "";

  if(isDefined(var_1)) {
    var_2 = "[" + var_1 getentitynumber() + ":" + var_1.name + "] ";
  }
}

function isplayerads() {
  return self playerads() > 0.5;
}

function isairdenied() {
  if(isai(self)) {
    return false;
  }

  if(self.team == "spectator") {
    return false;
  }

  return false;
}

function get_center_point_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

function sethintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self makeusable();

  if(isDefined(var_0)) {
    self sethinttag(var_0);
  }

  if(isDefined(var_1)) {
    self setCursorHint(var_1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    self sethinticon(var_2);
  }

  if(isDefined(var_3)) {
    self setHintString(var_3);
  }

  if(isDefined(var_4)) {
    var_4 = int(clamp(var_4, -10, 1));
    self setusepriority(var_4);
  } else {
    self setusepriority(-10);
  }

  if(isDefined(var_5)) {
    self setuseholdduration(var_5);

    if(var_5 == "duration_medium" || var_5 == "duration_long") {
      self sethintrequiresholding(1);
    }
  } else {
    self setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    self sethintonobstruction(var_6);
  } else {
    self sethintonobstruction("hide");
  }

  if(isDefined(var_7)) {
    self sethintdisplayrange(var_7);
  } else {
    self sethintdisplayrange(200);
  }

  if(isDefined(var_8)) {
    self sethintdisplayfov(var_8);
  } else {
    self sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    self setuserange(var_9);
  } else {
    self setuserange(50);
  }

  if(isDefined(var_10)) {
    self setusefov(var_10);
    return;
  }

  self setusefov(120);
}

function is_indoors(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0)) {
    var_2 = var_0.origin;
  } else if(isvector(var_0)) {
    var_2 = var_0;
  } else if(isstruct(var_0)) {
    var_2 = var_0.origin;
  }

  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3)) {
    var_1 = 1;
  }

  return var_1;
}

function is_indoors_vehicleignored(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0)) {
    var_2 = var_0.origin;
  } else if(isvector(var_0)) {
    var_2 = var_0;
  } else if(isstruct(var_0)) {
    var_2 = var_0.origin;
  }

  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3)) {
    var_1 = 1;
  }

  return var_1;
}

function isgesture(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(issubstr(var_1, "ges_plyr")) {
    return 1;
  }

  if(issubstr(var_1, "devilhorns_mp")) {
    return 1;
  }

  return 0;
}

function actionslotoverride(var_0, var_1, var_2, var_3) {
  self setweaponhudiconoverride("actionslot" + var_0, var_1);

  if(isDefined(var_2)) {
    setactionslotoverrideammo(var_0, var_2);
  }

  if(isDefined(var_3)) {
    thread actionslotoverridecallback(var_0, var_3);
    return;
  }
}

function actionslotoverridecallback(var_0, var_1) {
  self endon("death");
  self endon("removeActionslot" + var_0);
  self notifyonplayercommand("actionslot" + var_0, "+actionslot " + var_0);

  for(;;) {
    self waittill("actionslot" + var_0);
    self thread[[var_1]]();
  }
}

function actionslotoverrideremove(var_0) {
  self notify("removeActionslot" + var_0);
  self setweaponhudiconoverrideammo("actionslot" + var_0, -1);
  self setweaponhudiconoverride("actionslot" + var_0, "none");
}

function setactionslotoverrideammo(var_0, var_1) {
  self setweaponhudiconoverrideammo("actionslot" + var_0, var_1);
}

function demo_button_combo_debug_watcher() {
  self endon("disconnect");

  if(!isDefined(self.debug_button_combos)) {
    setup_debug_button_combos_for_player();
  }

  self notifyonplayercommand("up", "+actionslot 1");
  self notifyonplayercommand("up_release", "-actionslot 1");
  self notifyonplayercommand("down", "+actionslot 2");
  self notifyonplayercommand("down_release", "-actionslot 2");
  self notifyonplayercommand("use", "+usereload");
  self notifyonplayercommand("use", "+activate");
  self notifyonplayercommand("use_release", "-usereload");
  self notifyonplayercommand("use_release", "-activate");
  self notifyonplayercommand("stance", "+stance");
  self notifyonplayercommand("stance_release", "-stance");
  self notifyonplayercommand("ads", "+speed_throw");
  self notifyonplayercommand("ads_release", "-speed_throw");
  self notifyonplayercommand("attack", "+attack");
  self notifyonplayercommand("attack_release", "-attack");
  self notifyonplayercommand("touchpad", "+focus");
  self notifyonplayercommand("touchpad", "+togglescores");
  self notifyonplayercommand("touchpad", "togglescores");
  self notifyonplayercommand("touchpad_release", "-focus");
  self notifyonplayercommand("touchpad_release", "-togglescores");
  self notifyonplayercommand("swap_weapon", "+weapnext");
  self notifyonplayercommand("swap_weapon_release", "-weapnext");
  self notifyonplayercommand("A", "+gostand");
  self notifyonplayercommand("A_release", "-gostand");
  self notifyonplayercommand("RIGHT", "+actionslot 4");
  var_0 = ["up", "up_release", "down", "down_release", "use", "use_release", "stance", "stance_release", "A", "A_release", "right", "ads", "ads_release", "attack", "attack_release", "touchpad", "touchpad_release", "swap_weapon", "swap_weapon_release"];
  var_1 = [];
  var_2 = 2;

  for(var_3 = undefined;; var_3 = undefined) {
    var_4 = level.demo_button_combos;
    var_5 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_0);

    if(getdvarint("scr_demo_debug", 0)) {
      var_6 = gettime();

      if(!isDefined(var_3)) {
        var_3 = var_6 + var_2 * 1000;
      }

      var_1 = var_5;

      if(var_6 >= var_3) {
        var_3 = undefined;
        var_1 = [];
        continue;
      }

      var_3 = var_6 + var_2 * 1000;
      var_1 = validate_button_combo(var_1);

      if(var_1.size < 1) {}
    }
  }
}

function setup_debug_button_combos_for_player() {}

function add_demo_button_combo(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.button_combo = var_0;
  var_4.func = var_1;
  var_4.message = var_2;
  var_4.timeout = var_3;
  level.demo_button_combos[level.demo_button_combos.size] = var_4;
}

function validate_button_combo(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.demo_button_combos.size; var_2++) {
    var_3 = level.demo_button_combos[var_2];
    var_4 = level.demo_button_combos[var_2].button_combo;

    if(var_0.size <= var_4.size) {
      if(var_0[var_0.size - 1] == var_4[var_0.size - 1]) {
        if(var_0.size == var_4.size) {
          if(isDefined(var_3.message)) {
            announcement(var_3.message);
          }

          var_0 = [];
          self thread[[var_3.func]]();
        }

        var_1 = var_0;
        break;
      }
    }
  }

  return var_1;
}

function getenemyteams(var_0) {
  var_1 = level.teamnamelist;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  return var_1;
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function getgametype() {
  return level.gametype;
}

function register_create_script(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;
  }

  if(isDefined(var_1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;
  }

  if(isDefined(var_2)) {
    level.create_script_file_ids[var_0] = "cs" + var_2;
  }

  if(isDefined(var_3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
    return;
  }
}

function array_notify(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 notify(var_1, var_2);
  }
}

function addtoactivekillstreaklist(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_4)) {
    var_7 = 0;

    if(isusingremote(var_2)) {
      var_7 = 1;
    }

    var_8 = undefined;

    if(level.teambased) {
      var_8 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_5, 1, 10000, undefined, undefined, 1, var_7);
    } else {
      var_8 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, "hud_icon_head_equipment_friendly", var_5, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(var_8, var_6);
    return;
  }
}

function removeteamheadicononnotify(var_0, var_1) {
  var_2 = ["death"];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_2.size, var_1);
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0);
}

function killstreak_make_vehicle(var_0, var_1, var_2, var_3, var_4) {
  self.vehiclename = var_0;
  self.scorepopup = var_1;
  self.vodestroyed = var_2;
  self.votimeout = var_3;
  self.destroyedsplash = var_4;
  self enableplayermarks("killstreak");
  self filteroutplayermarks(self.team);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);

  if(isDefined(self.owner)) {
    self.owner notify("killstreak_vehicle_made", self);
    return;
  }
}

function killstreak_set_pre_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback(var_0, level.kspremoddamagecallback);
  self.kspremoddamagecallback = var_1;
}

function killstreak_set_post_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback(var_0, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = var_1;
}

function killstreak_set_death_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_death_callback(var_0, level.ksdeathcallback);
  self.ksdeathcallback = var_1;
}

function killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = &killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = &killstreak_post_mod_damage_callback;
    level.ksdeathcallback = &killstreak_death_callback;
    return;
  }
}

function killstreak_pre_mod_damage_callback(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(var_2) && isDefined(self.owner) && var_2 == self.owner) {
      var_1 = int(ceil(var_1 * 0.5));
    }

    var_0.damage = var_1;
  }

  var_3 = 1;
  var_4 = self.kspremoddamagecallback;

  if(isDefined(var_4)) {
    var_3 = self[[var_4]](var_0);
  }

  return var_3;
}

function killstreak_post_mod_damage_callback(var_0) {
  killstreakhit(var_0.attacker, var_0.objweapon, self, var_0.meansofdeath, var_0.damage);
  var_1 = 1;
  var_2 = self.kspostmoddamagecallback;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

function killstreak_death_callback(var_0) {
  onkillstreakkilled(self.streakname, var_0.attacker, var_0.objweapon, var_0.meansofdeath, var_0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  var_1 = 1;
  var_2 = self.ksdeathcallback;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

function killstreakhit(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner)) {
      if(iskillstreakweapon(var_1.basename)) {
        return;
      }

      var_5 = createheadicon(var_1);

      if(!isDefined(var_0.lasthittime[var_5])) {
        var_0.lasthittime[var_5] = 0;
      }

      if(var_0.lasthittime[var_5] == gettime()) {
        return;
      }

      var_0.lasthittime[var_5] = gettime();

      if(onlinestatsenabled()) {}

      if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || isprojectiledamage(var_3)) {
        var_0.lastdamagetime = gettime();
        var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);

        if(var_6 == "weapon_lmg") {
          if(!isDefined(var_0.shotslandedlmg)) {
            var_0.shotslandedlmg = 1;
            return;
          }

          var_0.shotslandedlmg++;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function isprojectiledamage(var_0) {
  var_1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return true;
  }

  return false;
}

function onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }
  } else if(isDefined(var_1) && isDefined(self.team) && isDefined(var_1.team)) {
    if(isenemy(var_1) && isPlayer(var_1)) {
      var_10 = var_1;
    }
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7)) {
      var_10 scripts\cp\cp_player_battlechatter::killstreakdestroyed(var_0);
    }

    thread scripts\mp\mp_agent_damage::killedkillstreak(var_0, var_10, var_2);

    if(!tryingtoleave()) {
      thread scripts\mp\ammorestock::killstreakkilled(var_0, self.owner, self, var_10, var_4, var_3, var_2, var_5);
    }

    scripts\cp_mp\gestures::processcalloutdeath(self, var_10);
    var_9 = 1;
  }

  if(isDefined(self.owner) && isDefined(var_6)) {}

  if(!istrue(var_8)) {
    self notify("death");
  }

  return var_9;
}

function skydivestreamhintdvars(var_0) {
  skydiveontacinsertplacement();
  skydivehintnotify(var_0 + "_heli_entrance", var_0 + "_heli_goal");
}

function skydivehintnotify(var_0, var_1) {
  if(!isDefined(level.heli_structs_entrances)) {
    level.heli_structs_entrances = [];
  }

  if(!isDefined(level.heli_structs_goals)) {
    level.heli_structs_goals = [];
  }

  var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");
  var_3 = scripts\engine\utility::getStruct(var_1, "script_noteworthy");
  level.heli_structs_entrances[level.heli_structs_entrances.size] = var_2;
  level.heli_structs_goals[level.heli_structs_goals.size] = var_3;
}

function skydiveontacinsertplacement() {
  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size >= 1) {
    level.heli_structs_entrances = [];
  }

  if(isDefined(level.heli_structs_goals) && level.heli_structs_goals.size >= 1) {
    level.heli_structs_goals = [];
    return;
  }
}

function try_start_driving_func() {
  if(getdvarint("scr_fake_raid_mode", 0)) {
    return true;
  }

  return level.script == "cp_raid_complex" || level.script == "cp_dntsk_raid" || level.script == "cp_trap_room" || level.script == "cp_raid_phase1";
}

function turn_off_sniper_laser() {
  if(level.gametype == "cp_wave_sv") {
    return true;
  }

  return false;
}

function tryingtoleave() {
  return level.gametype == "cp_specops";
}

function truck_detachvehiclefromairdropsequence() {
  if(level.gametype == "cp_survival") {
    return true;
  }

  return false;
}

function trialympic_fire() {
  var_0 = getDvar("ui_mapname");

  if(var_0 == "cp_raid_complex" || var_0 == "cp_dntsk_raid") {
    return true;
  }

  return false;
}

function issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled)) {
    level.simultaneouskillenabled = getdvarint("killswitch_simultaneous_deaths", 0) == 0;
  }

  return level.simultaneouskillenabled;
}

function onlinestatsenabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

function privatematch() {
  return level.onlinegame && getdvarint("xblive_privatematch");
}

function getenemycount(var_0, var_1) {
  var_2 = 0;
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    var_2 += getteamcount(var_5, istrue(var_1));
  }

  return var_2;
}

function getteamcount(var_0, var_1) {
  if(istrue(var_1)) {
    return level.teamdata[var_0]["alivePlayers"].size;
  }

  return level.teamdata[var_0]["players"].size;
}

function getenemyplayers(var_0, var_1) {
  var_2 = [];
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level.teamdata[var_5]["alivePlayers"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7.fauxdead)) {
          var_2 = var_7;
        }
      }

      continue;
    }

    foreach(var_7 in level.teamdata[var_5]["players"]) {
      var_2 = var_7;
    }
  }

  return var_2;
}

function ref_123FE(var_0, var_1) {
  var_2 = level.players;

  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_2 = [var_1];
    } else {
      var_2 = var_1;
    }
  }

  foreach(var_4 in var_2) {
    var_4 setplayermusicstate(var_0);
  }
}

function ref_14441(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  var_1 = self;
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 64);
  var_2 = 1.5;
  var_3 = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    var_4 = [];
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_1.origin, var_0);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] scriptableisdoor()) {
        var_4 = var_5[var_6];
      }
    }

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      var_4[var_7] setscriptablepartstate("door", "left_30", 0);
    }

    wait var_2;
  }
}

function questtimeradd() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(is_valid_player(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

function ref_13C3E(var_0, var_1) {
  self endon("death");
  self notify("track_last_good_position");
  self endon("track_last_good_position");

  if(!isDefined(var_1)) {
    var_1 = 0.1;
  }

  for(;;) {
    wait var_1;

    if(!isDefined(self)) {
      continue;
    }

    if(!isDefined(self.origin)) {
      continue;
    }

    if(isDefined(self.last_good_pos) && self.origin == self.last_good_pos) {
      continue;
    }

    if(!isalive(self)) {
      continue;
    }

    if(self isjumping()) {
      continue;
    }

    if(self isparachuting()) {
      continue;
    }

    if(self isonladder()) {
      continue;
    }

    if(!self isonground()) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    if(isDefined(level.outofboundstriggers)) {
      foreach(var_3 in level.outofboundstriggers) {
        if(self istouching(var_3)) {}
      }
    }

    if(isDefined(level.landmine_trig) && self istouching(level.landmine_trig)) {
      continue;
    }

    if(istrue(self.spectating)) {
      continue;
    }

    if(istrue(self.spawner_dropoff)) {
      continue;
    }

    if(istrue(self.landmine_active)) {
      continue;
    }

    if(istrue(var_0) && !ispointonnavmesh(self.origin)) {
      continue;
    }

    self.last_good_pos = self.origin;
  }
}
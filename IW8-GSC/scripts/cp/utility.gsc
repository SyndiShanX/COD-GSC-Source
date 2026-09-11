/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility.gsc
***********************************************/

function _giveweapon(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = -1;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = undefined;

  if(issameweapon(var0)) {
    var4 = var0;
  } else {
    var4 = asmdevgetallstates(var0);
  }

  if(var4 hasattachment("akimbo", 1) || var4 hasattachment("g18pap2", 1) || isDefined(var2) && var2 == 1) {
    self giveweapon(var4, var1, 1, -1, var3);
  } else {
    self giveweapon(var4, var1, 0, -1, var3);
  }

  thread updatelaststandpistol(var4);
  return var4;
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
    var0 = self physics_getbodyid(0);
    var1 = physics_getbodylinvel(var0);

    if(lengthsquared(var1) > 0.5) {
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

function setupdamagetriggers(var0) {
  var0 endon("disconnect");

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_wait("infil_complete");
  }

  wait 1;
  var1 = getEnt("playable_area", "targetname");
  var2 = getEnt("boundary_toxic_line", "targetname");
  var3 = isDefined(var1);
  var4 = getDvar("NSQLTTMRMP");
  var5 = getDvar("MOLPOSLOMO");
  var0.last_good_pos = undefined;
  var0.outofbounds = 1;
  var6 = undefined;

  if(var5 == "cp_strike") {
    var7 = "abandon_mission";
    goto LOC_0000008c;
  }

  var7 = "turn_back";

  for(;;) {
    var8 = 0;

    if(var4) {
      var8 = var1 istouching(var2);
    } else {
      var8 = !var1 istouching(var3);
    }

    var9 = var1 isonground();
    var10 = var1 isonladder();
    var11 = scripts\cp\cp_laststand::player_in_laststand(var1);

    if(!var9 || var11 || var10) {
      wait 0.5;
      continue;
    }

    if(var8) {
      var1.last_good_pos = var1.origin;
      var7 = undefined;

      if(var1.outofbounds) {
        thread hint_prompt(var1, var7);
      }

      var1.outofbounds = 0;
    } else if(!var1.outofbounds) {
      thread hint_prompt(var1, var7);
      var1.outofbounds = 1;
      var7 = gettime() + 5000;
    } else if(isDefined(var7) && gettime() > var7) {
      if(isDefined(var1.hostagecarried) && isDefined(level.hostage) && isDefined(level.hostage_drop)) {
        level.hostage[[level.hostage_drop]](var1, level.hostage, var1.last_good_pos, 0, 0.4);
      }

      var1 dodamage(var1.health + 1000, var1.origin, var2, var2, "MOD_UNKNOWN");
      thread hint_prompt(var1, var7);
      thread warp_to_last_good_pos();
    }

    wait 0.5;
  }
}

function warp_to_last_good_pos() {
  self setOrigin(self.last_good_pos);
}

function updatelaststandpistol(var0) {
  if(isDefined(var0)) {
    if(isDefined(level.last_stand_weapons)) {
      var1 = getweaponbasename(var0);

      if(scripts\engine\utility::array_contains(level.last_stand_weapons, var1)) {
        self.last_stand_pistol = var0;
        return;
      }
    }
  }

  var2 = self getweaponslistall();
  var3 = 0;

  if(isDefined(self.last_stand_pistol)) {
    var4 = getweaponbasename(self.last_stand_pistol);

    foreach(var6 in var2) {
      var7 = getweaponbasename(var6);

      if(var7 == var4) {
        var3 = 1;
        return;
      }
    }
  }

  if(!var3) {
    if(isDefined(level.last_stand_weapons)) {
      foreach(var6 in var2) {
        var7 = getweaponbasename(var6);

        for(var10 = level.last_stand_weapons.size - 1; var10 > -1; var10--) {
          if(var7 == level.last_stand_weapons[var10]) {
            var3 = 1;
            self.last_stand_pistol = var6;
            return;
          }
        }
      }
    }

    var12 = getrawbaseweaponname(self.default_starting_pistol);

    if(isDefined(self.weapon_build_models) && isDefined(self.weapon_build_models[var12])) {
      self.last_stand_pistol = asmdevgetallstates(self.weapon_build_models[var12]);
      return;
    }

    self.last_stand_pistol = self.default_starting_pistol;
    return;
  }
}

function giveperk(var0) {
  if(issubstr(var0, "specialty_weapon_")) {
    _setperk(var0);
    return;
  }

  _setperk(var0);
  _setextraperks(var0);
}

function _hasperk(var0) {
  var1 = self.perks;

  if(!isDefined(var1)) {
    return false;
  }

  if(isDefined(var1[var0])) {
    return true;
  }

  return false;
}

function takeperk(var0) {
  if(issubstr(var0, "specialty_weapon_")) {
    _unsetperk(var0);
    return;
  }

  _unsetperk(var0);
  _unsetextraperks(var0);
}

function _setperk(var0) {
  self.perks[var0] = 1;
  self.perksperkname[var0] = var0;
  var1 = level.perksetfuncs[var0];

  if(isDefined(var1)) {
    self thread[[var1]]();
  }

  self setperk(var0, !isDefined(level.scriptperks[var0]));
}

function _setextraperks(var0) {
  if(isDefined(level.extraperkmap[var0])) {
    foreach(var2 in level.extraperkmap[var0]) {
      _setperk(var2);
      _setextraperks(var2);
    }

    return;
  }
}

function _unsetperk(var0) {
  self.perks[var0] = undefined;
  self.perksperkname[var0] = undefined;

  if(isDefined(level.perkunsetfuncs[var0])) {
    self thread[[level.perkunsetfuncs[var0]]]();
  }

  self unsetperk(var0, !isDefined(level.scriptperks[var0]));
}

function _unsetextraperks(var0) {
  if(isDefined(level.extraperkmap[var0])) {
    foreach(var2 in level.extraperkmap[var0]) {
      _unsetperk(var2);
      _unsetextraperks(var2);
    }

    return;
  }
}

function _clearperks() {
  foreach(var1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var2])) {
      self[[level.perkunsetfuncs[var2]]]();
    }
  }

  self.perks = [];
  self.perksperkname = [];
  self clearperks();
}

function clearlowermessages() {
  if(isDefined(self.lowermessages)) {
    for(var0 = 0; var0 < self.lowermessages.size; var0++) {
      self.lowermessages[var0] = undefined;
    }
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }

  updatelowermessage();
}

function setlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var6)) {
    var6 = 0.85;
  }

  if(!isDefined(var7)) {
    var7 = 3;
  }

  if(!isDefined(var8)) {
    var8 = 0;
  }

  if(!isDefined(var9)) {
    var9 = 1;
  }

  addlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  updatelowermessage();
}

function play_bink_video(var0, var1, var2) {
  thread play_bink_video_internal(level, var0, var1);
}

function play_bink_video_internal(var0, var1, var2) {
  foreach(var4 in level.players) {
    freezecontrolswrapper(var4, 1);
  }

  playcinematicforall(var0);
  wait var1;

  foreach(var4 in level.players) {
    freezecontrolswrapper(var4, 0);

    if(!isDefined(var2) || !var2) {
      thread player_black_screen(var4, 0, 1, 0.5);
    }
  }
}

function updatelowermessage() {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  var0 = getlowermessage();

  if(!isDefined(var0)) {
    if(isDefined(self.lowermessage)) {
      self.lowermessage.alpha = 0;
      self.lowermessage settext("");

      if(isDefined(self.lowertimer)) {
        self.lowertimer.alpha = 0;
      }
    }

    return;
  }

  self.lowermessage settext(var0.text);
  self.lowermessage.alpha = 0.85;
  self.lowertimer.alpha = 1;
  self.lowermessage.hidewhenindemo = var0.hidewhenindemo;
  self.lowermessage.hidewheninmenu = var0.hidewheninmenu;

  if(var0.shouldfade) {
    self.lowermessage fadeovertime(min(var0.fadetoalphatime, 60));
    self.lowermessage.alpha = var0.fadetoalpha;
  }

  if(var0.time > 0 && var0.showtimer) {
    self.lowertimer settimer(max(var0.time - (gettime() - var0.addtime) / 1000, 0.1));
    return;
  }

  if(var0.time > 0 && !var0.showtimer) {
    self.lowertimer settext("");
    self.lowermessage fadeovertime(min(var0.time, 60));
    self.lowermessage.alpha = 0;
    thread clearondeath(var0);
    thread clearafterfade(var0);
    return;
  }

  self.lowertimer settext("");
}

function addlowermessage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = undefined;

  foreach(var12 in self.lowermessages) {
    if(var12.name == var0) {
      if(var12.text == var1 && var12.priority == var3) {
        return;
      }

      var10 = var12;
      break;
    }
  }

  if(!isDefined(var10)) {
    var10 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var10;
  }

  var10.name = var0;
  var10.text = var1;
  var10.time = var2;
  var10.addtime = gettime();
  var10.priority = var3;
  var10.showtimer = var4;
  var10.shouldfade = var5;
  var10.fadetoalpha = var6;
  var10.fadetoalphatime = var7;
  var10.hidewhenindemo = var8;
  var10.hidewheninmenu = var9;
  sortlowermessages();
}

function sortlowermessages() {
  for(var0 = 1; var0 < self.lowermessages.size; var0++) {
    var1 = self.lowermessages[var0];
    var2 = var1.priority;

    for(var3 = var0 - 1; var3 >= 0 && var2 > self.lowermessages[var3].priority; var3--) {
      self.lowermessages[var3 + 1] = self.lowermessages[var3];
    }

    self.lowermessages[var3 + 1] = var1;
  }
}

function getlowermessage() {
  if(!isDefined(self.lowermessages)) {
    return undefined;
  }

  return self.lowermessages[0];
}

function clearondeath(var0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var0.name);
}

function clearafterfade(var0) {
  wait var0.time;
  clearlowermessage(var0.name);
  self notify("message_cleared");
}

function clearlowermessage(var0) {
  removelowermessage(var0);
  updatelowermessage();
}

function removelowermessage(var0) {
  if(isDefined(self.lowermessages)) {
    for(var1 = self.lowermessages.size; var1 > 0; var1--) {
      if(self.lowermessages[var1 - 1].name != var0) {
        continue;
      }

      var2 = self.lowermessages[var1 - 1];

      for(var3 = var1; var3 < self.lowermessages.size; var3++) {
        if(isDefined(self.lowermessages[var3])) {
          self.lowermessages[var3 - 1] = self.lowermessages[var3];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
    return;
  }
}

function freezecontrolswrapper(var0) {
  if(isDefined(level.hostmigrationtimer)) {
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var0);
  self.controlsfrozen = var0;
}

function setthirdpersondof(var0) {
  if(var0) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
    return;
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

function setusingremote(var0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var0;

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

function updatesessionstate(var0, var1) {
  self.sessionstate = var0;

  if(!isDefined(var1)) {
    var1 = "";
  }

  self.statusicon = var1;
  self setclientomnvar("ui_session_state", var0);
}

function getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var0 = self getguid();

  if(var0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var0;
  return self.pers["guid"];
}

function gameflagset(var0) {
  game["flags"][var0] = 1;
  level notify(var0);
}

function gameflaginit(var0, var1) {
  game["flags"][var0] = var1;
}

function gameflag(var0) {
  return game["flags"][var0];
}

function gameflagwait(var0) {
  while(!gameflag(var0)) {
    level waittill(var0);
  }
}

function matchmakinggame() {
  return level.onlinegame && !getdvarint("LSTLQTSSRM");
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

function isenemy(var0) {
  if(level.teambased) {
    return isplayeronenemyteam(var0);
  }

  return isplayerffaenemy(var0);
}

function isplayeronenemyteam(var0) {
  return var0.team != self.team;
}

function isplayerffaenemy(var0) {
  if(isDefined(var0.owner)) {
    return (var0.owner != self);
  }

  return var0 != self;
}

function isgameplayteam(var0) {
  return isDefined(var0) && scripts\engine\utility::array_contains(level.teamnamelist, var0);
}

function notusableforjoiningplayers(var0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var1);

    if(isDefined(var1) && var1 != var0) {
      self disableplayeruse(var1);
    }
  }
}

function setselfusable(var0) {
  self makeusable();

  foreach(var2 in level.players) {
    if(var2 != var0) {
      self disableplayeruse(var2);
      continue;
    }

    self enableplayeruse(var2);
  }
}

function isenvironmentweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(issameweapon(var0)) {
    if(var0.basename == "turret_minigun_mp") {
      return true;
    } else {
      return false;
    }
  }

  if(var0 == "turret_minigun_mp") {
    return true;
  }

  return false;
}

function issuperweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = createheadicon(var0);
  } else {
    var1 = var0;
  }

  if(isDefined(level.superweapons) && isDefined(level.superweapons[var1])) {
    return true;
  }

  return false;
}

function strip_suffix(var0, var1) {
  if(var0.size <= var1.size) {
    return var0;
  }

  if(getsubstr(var0, var0.size - var1.size, var0.size) == var1) {
    return getsubstr(var0, 0, var0.size - var1.size);
  }

  return var0;
}

function playteamfxforclient(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(self.team != var0) {
    var6 = spawnfxforclient(scripts\engine\utility::getfx(var3), var1, self);
  } else {
    var6 = spawnfxforclient(scripts\engine\utility::getfx(var2), var1, self);
  }

  if(isDefined(var6)) {
    triggerfx(var6);
  }

  thread delayentdelete(var6);

  if(isDefined(var5) && var5) {
    thread deleteonplayerdeathdisconnect(var6);
  }

  return var6;
}

function toggle_team_emp_effects(var0, var1, var2, var3) {
  var4 = [];

  foreach(var6 in level.players) {
    if(!var6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(var6.team != var0) {
      continue;
    }

    var4 = var6;
  }

  if(istrue(var1)) {
    foreach(var6 in var4) {
      thread toggle_player_emp_effects(var6, 1, var2);
    }

    return;
  }

  foreach(var6 in var4) {
    thread toggle_player_emp_effects(var6, 0);
  }
}

function toggle_player_emp_effects(var0, var1, var2) {
  if(istrue(var1)) {
    var3 = getcompleteweaponname("emp_drone_non_player_mp");
    var4 = &scripts\cp_mp\utility\damage_utility::packdamagedata;
    var5 = [[var4]](var0, var0, 1, var3);
    thread _emp_grenade_apply_player(var0, var5);
    return;
  }

  var0 notify("emp_cleared");
}

function _emp_grenade_apply_player(var0, var1) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  _emp_grenade_end_early(var0, var1);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function _emp_grenade_end_early(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(var1)) {
    var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);
    return;
  }

  self waittill("emp_cleared");
}

function delayentdelete(var0) {
  self endon("death");
  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function deleteonplayerdeathdisconnect(var0) {
  self endon("death");
  var0 scripts\engine\utility::ref_143a5("death", "disconnect");
  self delete();
}

function isstrstart(var0, var1) {
  return getsubstr(var0, 0, var1.size) == var1;
}

function getbaseweaponname(var0) {
  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var1;
  }

  var2 = strtok(var1, "_");
  var3 = 0;

  if(var2[0] == "alt") {
    var3++;
  }

  if(var2[var3] == "iw7") {
    var1 = var2[var3] + "_" + var2[var3 + 1];
  } else if(var2[var3] == "iw8" || var2[var3] == "s4") {
    var4 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la"];

    if(scripts\engine\utility::array_contains(var4, var2[var3 + 1])) {
      var1 = var2[var3] + "_" + var2[var3 + 1] + "_" + var2[var3 + 2];
    } else {
      var1 = var2[var3] + "_" + var2[var3 + 1];
    }
  }

  return var1;
}

function getzbaseweaponname(var0, var1) {
  var2 = strtok(var0, "_");

  if(var2[0] == "iw5" || var2[0] == "iw6" || var2[0] == "iw7") {
    if(isDefined(var1) && var1 > 1) {
      var0 = var2[0] + "_z" + var2[1] + var1;
    } else {
      var0 = var2[0] + "_z" + var2[1];
    }
  } else if(var2[0] == "alt") {
    if(isDefined(var1) && var1 > 1) {
      var0 = var2[1] + "_z" + var2[2] + var1;
    } else {
      var0 = var2[1] + "_z" + var2[2];
    }
  }

  return var0;
}

function get_closest_entrance(var0) {
  if(!isDefined(level.window_entrances)) {
    return undefined;
  }

  var1 = sortbydistance(level.window_entrances, var0);

  foreach(var3 in var1) {
    if(var3.enabled) {
      return var3;
    }
  }

  return undefined;
}

function entrance_is_fully_repaired(var0) {
  if(!isDefined(var0.barrier)) {
    return true;
  }

  var1 = [[level.next_board_to_repair_func]](var0);

  if(!isDefined(var1)) {
    return true;
  }

  return false;
}

function is_weapon_purchase_disabled() {
  return istrue(level.weapon_purchase_disabled);
}

function get_attachment_from_interaction(var0) {
  var1 = var0.item.model;
  var2 = "arkblue";
  var3 = "stun_ammo";

  switch (var1) {
    case "attachment_zmb_arcane_muzzlebrake_wm":
      var2 = "arcane_base";
      break;
    default:
      break;
  }

  return var2;
}

function are_any_consumables_active() {
  foreach(var1 in self.consumables) {
    if(var1.on == 1) {
      return true;
    }
  }

  return false;
}

function getrawbaseweaponname(var0) {
  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var1;
  }

  var2 = strtok(var1, "_");

  if(var2[0] == "iw5" || var2[0] == "iw6" || var2[0] == "iw7") {
    var1 = var2[1];
  } else if(var2[0] == "alt") {
    var1 = var2[2];
  }

  return var1;
}

function getintproperty(var0, var1) {
  var2 = var1;
  var2 = getdvarint(var0, var1);
  return var2;
}

function leaderdialogonplayer(var0, var1, var2, var3) {
  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  var4 = self.pers["team"];

  if(isDefined(var4) && (var4 == "axis" || var4 == "allies")) {
    var5 = game["voice"][var4] + game["dialog"][var0];
    self queuedialogforplayer(var5, var0, 2, var1, var2, var3);
    return;
  }
}

function _setactionslot(var0, var1, var2) {
  self.saved_actionslotdata[var0].type = var1;
  self.saved_actionslotdata[var0].item = var2;
  self setactionslot(var0, var1, var2);
}

function getkillstreakweapon(var0) {
  return tablelookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, var0, level.global_tables["killstreakTable"].weapon_col);
}

function _objective_delete(var0) {
  objective_delete(var0);

  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var0;
    return;
  }

  level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var0;
}

function touchingbadtrigger(var0) {
  var1 = getEntArray("trigger_hurt", "classname");

  foreach(var3 in var1) {
    if(self istouching(var3) && (level.mapname != "mp_mine" || var3.dmg > 0)) {
      return true;
    }
  }

  var5 = getEntArray("radiation", "targetname");

  foreach(var3 in var5) {
    if(self istouching(var3)) {
      return true;
    }
  }

  if(isDefined(var0) && var0 == "gryphon") {
    var8 = getEntArray("gryphonDeath", "targetname");

    foreach(var3 in var8) {
      if(self istouching(var3)) {
        return true;
      }
    }
  }

  return false;
}

function playsoundinspace(var0, var1, var2) {
  if(isDefined(var0)) {
    if(isarray(var0)) {
      var0 = scripts\engine\utility::random(var0);
    }

    var3 = lookupsoundlength(var0);
    playsoundatpos(var1, var0);

    if(isDefined(var2)) {
      wait var3 / 1000;
    }

    return var3;
  }
}

function play_random_sound_in_space(var0, var1, var2) {
  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var3 = [];
      GscBinSkip0(0x2e, 0, var0);
    }

    var4 = scripts\engine\utility::random(var1);
    var5 = lookupsoundlength(var4);
    playsoundatpos(var2, var4);

    if(isDefined(var3)) {
      wait var5;
    }

    return var5;
  }
}

function play_looping_sound_on_ent(var0) {
  if(soundexists(var0)) {
    self playLoopSound(var0);
    return;
  }
}

function stop_looping_sound_on_ent(var0) {
  if(soundexists(var0)) {
    self stoploopsound(var0);
    return;
  }
}

function playdeathsound() {
  var0 = randomintrange(1, 8);
  var1 = "generic";

  if(self hasfemalecustomizationmodel()) {
    var1 = "female";
  }

  if(self.team == "axis") {
    var2 = var1 + "_death_russian_" + var0;

    if(soundexists(var2)) {
      self playSound(var2);
      return;
    }

    return;
  }

  var2 = var2 + "_death_american_" + var1;

  if(soundexists(var2)) {
    self playSound(var2);
    return;
  }
}

function isfmjdamage(var0, var1, var2) {
  return isDefined(var2) && _hasperk(var2, "specialty_armorpiercing") && isDefined(var1) && scripts\engine\utility::isbulletdamage(var1);
}

function ischangingweapon() {
  return isDefined(self.changingweapon);
}

function getattachmenttype(var0) {
  if(!isDefined(var0)) {
    return "none";
  }

  var1 = tablelookup("mp/attachmenttable.csv", 4, var0, 2);

  if(!isDefined(var1) || isDefined(var1) && var1 == "") {
    var2 = getDvar("NKTMKRMSKR");

    if(var2 == "zombie") {
      var1 = tablelookup("cp/zombies/zombie_attachmentTable.csv", 4, var0, 2);
    }
  }

  return var1;
}

function weaponhasattachment(var0, var1) {
  if(!isDefined(var0) || var0 == "none" || var0 == "") {
    return false;
  }

  var2 = getweaponattachmentsbasenames(var0);

  foreach(var4 in var2) {
    if(var4 == var1) {
      return true;
    }
  }

  return false;
}

function getweaponattachmentsbasenames(var0) {
  var1 = getweaponattachments(var0);

  foreach(var3 in var1) {
    var1 = attachmentmap_tobase(var3);
  }

  return var1;
}

function attachmentmap_tobase(var0) {
  if(isDefined(level.attachmentmap_uniquetobase[var0])) {
    var0 = level.attachmentmap_uniquetobase[var0];
  }

  return var0;
}

function useeventtimestamp(var0) {
  return scripts\engine\utility::string_starts_with(var0, "barsil_") || var0 == "barcust2_mpapa5";
}

function useeventtype(var0) {
  return scripts\engine\utility::string_starts_with(var0, "silencer");
}

function tv_station_fastrope_two_infil_rider_start_targetname(var0) {
  return var0 == "calcust" || var0 == "calsmg" || var0 == "calsmgdrums";
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

function attachmentmap_tounique(var0, var1) {
  var2 = undefined;

  if(issameweapon(var1)) {
    var2 = createheadicon(var1);
  } else {
    var2 = var1;
  }

  var3 = getweaponrootname(var1);

  if(var3 != var2) {
    var4 = getweaponbasename(var1);

    if(isDefined(level.attachmentmap_basetounique[var4]) && isDefined(level.attachmentmap_uniquetobase[var0]) && isDefined(level.attachmentmap_basetounique[var4][level.attachmentmap_uniquetobase[var0]])) {
      var5 = level.attachmentmap_uniquetobase[var0];
      return level.attachmentmap_basetounique[var4][var5];
    } else if(isDefined(level.attachmentmap_basetounique[var5]) && isDefined(level.attachmentmap_basetounique[var5][var1])) {
      return level.attachmentmap_basetounique[var5][var1];
    } else {
      var6 = strtok(var5, "_");

      if(var6.size > 3) {
        var7 = var6[0] + "_" + var6[1] + "_" + var6[2];

        if(isDefined(level.attachmentmap_basetounique[var7]) && isDefined(level.attachmentmap_basetounique[var7][var1])) {
          return level.attachmentmap_basetounique[var7][var1];
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var4]) && isDefined(level.attachmentmap_basetounique[var4][var1])) {
    return level.attachmentmap_basetounique[var4][var1];
  } else {
    var8 = weapongroupmap(var4);

    if(isDefined(level.attachmentmap_basetounique[var8]) && isDefined(level.attachmentmap_basetounique[var8][var1])) {
      return level.attachmentmap_basetounique[var8][var1];
    }
  }

  return var1;
}

function weapongroupmap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].group)) {
    return level.weaponmapdata[var0].group;
  }

  return undefined;
}

function weaponnumbermap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].number)) {
    return level.weaponmapdata[var0].number;
  }

  return undefined;
}

function allowridekillstreakplayerexit(var0, var1) {
  if(isDefined(var0)) {
    self endon(var0);
  }

  if(isDefined(var1)) {
    var2 = self;
  } else {
    if(!isDefined(self.owner)) {
      return;
    }

    var2 = self.owner;
  }

  level endon("game_ended");
  var2 endon("disconnect");
  var2 endon("end_remote");
  var2 notify("watch_use_exit");
  var2 endon("diable_use_exit");
  self endon("death");
  thread allow_force_player_exit();

  if(!isDefined(level.framedurationseconds)) {
    level.framedurationseconds = level.frameduration / 1000;
  }

  var3 = level.framedurationseconds;
  var4 = 0.75;
  var5 = 1;

  for(;;) {
    var6 = 0;

    if(var5 == 1) {
      var2 setclientomnvar("ui_exit_progress", 0);
      var5 = 0;
    }

    while(var2 useButtonPressed()) {
      var6 += var3;
      var5 = 1;
      var2 setclientomnvar("ui_exit_progress", var6 / var4);

      if(var6 > var4) {
        self notify("killstreakExit");
        return;
      }

      wait var3;
    }

    wait var3;
  }
}

function allow_force_player_exit() {
  self endon("killstreakExit");
  level waittill("cp_force_killstreak_exit");
  self notify("killstreakExit");
}

function killstreak_createobjective(var0, var1, var2, var3, var4) {
  var5 = nonobjective_requestobjectiveid(1);
  objective_position(var5, self.origin);
  objective_icon(var5, var0);
  objective_state(var5, "active");
  objective_setbackground(var5, 1);

  if(!isDefined(self getlinkedparent()) && !istrue(var3)) {
    update_objective_position(var5, self.origin);
  } else if(istrue(var3) && istrue(var4)) {
    update_objective_onentitywithrotation(var5, self);
  } else {
    update_objective_onentity(var5, self);
  }

  if(isDefined(var1)) {
    objective_setownerteam(var5, var1);

    if(!level.teambased && isDefined(self.owner)) {
      if(istrue(var2)) {
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var5, self.owner);
      } else {
        scripts\mp\objidpoolmanager::objective_teammask_single(var5, var1);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var5);
  }

  return var5;
}

function vo_ten_remain(var0, var1, var2) {
  var3 = nonobjective_requestobjectiveid(1);

  if(var3 == -1) {
    return -1;
  }

  objective_delete(var3);
  objective_state(var3, "invisible");
  objective_position(var3, (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var1)) {
    update_objective_position(var3, self.origin);
  } else if(istrue(var1) && istrue(var2)) {
    update_objective_onentitywithrotation(var3, self);
  } else {
    update_objective_onentity(var3, self);
  }

  objective_state(var3, "active");
  objective_icon(var3, var0);
  objective_setbackground(var3, 1);
  objective_setownerteam(var3, self.team);
  scripts\cp\cp_objectives::minimap_objective_playermask_hidefromall(var3);
  return var3;
}

function update_objective_position(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_position(var0, var1);
}

function update_objective_onentity(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
}

function update_objective_onentitywithrotation(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
  objective_setrotateonminimap(var0, 1);
}

function nonobjective_returnobjectiveid(var0) {
  scripts\cp\cp_objectives::freeworldidbyobjid(var0);
}

function nonobjective_requestobjectiveid(var0) {
  return scripts\cp\cp_objectives::requestworldid("nonobj_marker", 1);
}

function clearusingremote(var0) {
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::allow_ads(1);

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;

  if(!isDefined(var0)) {
    scripts\common\utility::allow_offhand_weapons(1);
    _freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

function cp_add_dialogue_line(var0) {
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
    var1 = level.dialogue_huds[0];
    level.dialogue_huds = scripts\engine\utility::array_remove_index(level.dialogue_huds, 0);
    scripts\engine\utility::update_dialogue_huds();
    var1 thread scripts\engine\utility::destroy_dialogue_hud();
  }

  if(soundexists("cp_ui_menu_title_decode_text")) {
    foreach(var3 in level.players) {
      var3 playlocalsound("cp_ui_menu_title_decode_text");
    }
  }

  var5 = "^3";
  var6 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var6 = level.dialoguelinescale;
  }

  var7 = newhudelem();
  var7.elemtype = "font";
  var7.font = "default";
  var7.fontscale = var6;
  var7.x = 0;
  var7.y = 0;
  var7.width = 0;
  var7.height = int(level.fontheight * var6);
  var7.xoffset = 0;
  var7.yoffset = 0;
  var8 = level.dialogue_huds.size;
  level.dialogue_huds[var8] = var7;
  var7.foreground = 1;
  var7.sort = 20;
  var7.x = 40;
  var7.y = 260 + var8 * 12 * var6;
  var7.label = var0;
  var7.alpha = 0;
  var7 fadeovertime(0.2);
  var7.alpha = 1;
  var7 endon("death");
  wait 8;
  level.dialogue_huds = scripts\engine\utility::array_remove(level.dialogue_huds, var7);
  scripts\engine\utility::update_dialogue_huds();
  thread cp_destroy_dialogue_hud();
}

function cp_destroy_dialogue_hud() {
  var0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var0 = level.dialoguelinescale;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12 * var0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function getfirstprimaryweapon() {
  var0 = self getweaponslistprimaries();
  return var0[0];
}

function set_visionset_for_watching_players(var0, var1, var2, var3, var4, var5) {
  var6 = get_players_watching(var4, var5);

  foreach(var8 in var6) {
    var8 notify("changing_watching_visionset");

    if(isDefined(var3) && var3) {
      var8 visionsetmissilecamforplayer(var0, var1);
    } else {
      var8 visionsetnakedforplayer(var0, var1);
    }

    if(var0 != "" && isDefined(var2)) {
      thread reset_visionset_on_team_change(var8, self);
      thread reset_visionset_on_disconnect(var8);

      if(isinkillcam(var8)) {
        thread reset_visionset_on_spawn();
      }
    }
  }
}

function get_players_watching(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = self getentitynumber();
  var3 = [];

  foreach(var5 in level.players) {
    if(var5 == self) {
      continue;
    }

    var6 = 0;

    if(!var1) {
      if(var5.team == "spectator" || var5.sessionstate == "spectator") {
        var7 = var5 getspectatingplayer();

        if(isDefined(var7) && var7 == self) {
          var6 = 1;
        }
      }

      if(var5.forcespectatorclient == var2) {
        var6 = 1;
      }
    }

    if(!var0) {
      if(var5.killcamentity == var2) {
        var6 = 1;
      }
    }

    if(var6) {
      var3 = var5;
    }
  }

  return var3;
}

function reset_visionset_on_team_change(var0, var1) {
  self endon("changing_watching_visionset");
  var2 = gettime();
  var3 = self.team;

  while(gettime() - var2 < var1 * 1000) {
    if(self.team != var3 || !scripts\engine\utility::array_contains(get_players_watching(var0), self)) {
      self visionsetnakedforplayer("", 0);
      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

function reset_visionset_on_disconnect(var0) {
  self endon("changing_watching_visionset");
  var0 waittill("disconnect");

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

function createfontstring(var0, var1, var2) {
  if(!isDefined(var2) || !var2) {
    var3 = newclienthudelem(self);
  } else {
    var3 = newhudelem();
  }

  var3.elemtype = "font";
  var3.font = var1;
  var3.fontscale = var2;
  var3.basefontscale = var2;
  var3.x = 0;
  var3.y = 0;
  var3.width = 0;
  var3.height = int(level.fontheight * var2);
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  setparent(var3, level.uiparent);
  var3.hidden = 0;
  return var3;
}

function setparent(var0) {
  if(isDefined(self.parent) && self.parent == var0) {
    return;
  }

  if(isDefined(self.parent)) {
    removechild(self.parent, self);
  }

  self.parent = var0;
  addchild(self.parent, self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("TOPLEFT");
}

function removechild(var0) {
  var0.parent = undefined;

  if(self.children[self.children.size - 1] != var0) {
    self.children[var0.index] = self.children[self.children.size - 1];
    self.children[var0.index].index = var0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var0.index = undefined;
}

function addchild(var0) {
  var0.index = self.children.size;
  self.children[self.children.size] = var0;
  removedestroyedchildren();
}

function removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  var0 = [];

  foreach(var2 in self.children) {
    if(!isDefined(var2)) {
      continue;
    }

    var2.index = var0.size;
    var0 = var2;
  }

  self.children = var0;
}

function setpoint(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = getparent();

  if(var4) {
    self moveovertime(var4);
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  self.xoffset = var2;

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self.yoffset = var3;
  self.point = var0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var1)) {
    var1 = var0;
  }

  self.relativepoint = var1;
  var6 = "center_adjustable";
  var7 = "middle";

  if(issubstr(var1, "TOP")) {
    var7 = "top_adjustable";
  }

  if(issubstr(var1, "BOTTOM")) {
    var7 = "bottom_adjustable";
  }

  if(issubstr(var1, "LEFT")) {
    var6 = "left_adjustable";
  }

  if(issubstr(var1, "RIGHT")) {
    var6 = "right_adjustable";
  }

  if(var5 == level.uiparent) {
    self.horzalign = var6;
    self.vertalign = var7;
  } else {
    self.horzalign = var5.horzalign;
    self.vertalign = var5.vertalign;
  }

  if(strip_suffix(var6, "_adjustable") == var5.alignx) {
    var8 = 0;
    var9 = 0;
  } else if(var8 == "center" || var7.alignx == "center") {
    var8 = int(var7.width / 2);

    if(var8 == "left_adjustable" || var7.alignx == "right") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  } else {
    var8 = var8.width;

    if(var9 == "left_adjustable") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  }

  self.x = var9.x + var9 * var9;

  if(strip_suffix(var8, "_adjustable") == var9.aligny) {
    var10 = 0;
    var11 = 0;
  } else if(var9 == "middle" || var8.aligny == "middle") {
    var10 = int(var8.height / 2);

    if(var9 == "top_adjustable" || var8.aligny == "bottom") {
      var11 = -1;
    } else {
      var11 = 1;
    }
  } else {
    var10 = var10.height;

    if(var10 == "top_adjustable") {
      var11 = -1;
    } else {
      var11 = 1;
    }
  }

  self.y = var11.y + var11 * var11;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var9, var8, var9, var9);
      break;
  }

  updatechildren();
}

function getparent() {
  return self.parent;
}

function setpointbar(var0, var1, var2, var3) {
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

function updatebar(var0, var1) {
  if(self.elemtype == "bar") {
    updatebarscale(var0, var1);
    return;
  }
}

function updatebarscale(var0, var1) {
  var2 = int(self.width * var0 + 0.5);

  if(!var2) {
    var2 = 1;
  }

  self.bar.frac = var0;
  self.bar setshader(self.bar.shader, var2, self.height);

  if(isDefined(var1) && var2 < self.width) {
    if(var1 > 0) {
      self.bar scaleovertime((1 - var0) / var1, self.width, self.height);
    } else if(var1 < 0) {
      self.bar scaleovertime(var0 / -1 * var1, 1, self.height);
    }
  }

  self.bar.rateofchange = var1;
  self.bar.lastupdatetime = gettime();
}

function updatechildren() {
  for(var0 = 0; var0 < self.children.size; var0++) {
    var1 = self.children[var0];
    setpoint(var1, var1.point, var1.relativepoint, var1.xoffset, var1.yoffset);
  }
}

function createicon(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var4 = newclienthudelem(self);
  } else {
    var4 = newhudelem();
  }

  var4.elemtype = "icon";
  var4.x = 0;
  var4.y = 0;
  var4.width = var2;
  var4.height = var3;
  var4.basewidth = var4.width;
  var4.baseheight = var4.height;
  var4.xoffset = 0;
  var4.yoffset = 0;
  var4.children = [];
  setparent(var4, level.uiparent);
  var4.hidden = 0;

  if(isDefined(var1)) {
    var4 setshader(var1, var2, var3);
    var4.shader = var1;
  }

  return var4;
}

function destroyelem() {
  var0 = [];

  for(var1 = 0; var1 < self.children.size; var1++) {
    if(isDefined(self.children[var1])) {
      var0 = self.children[var1];
    }
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    setparent(var0[var1], getparent());
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

function createprimaryprogressbartext(var0, var1, var2, var3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = -25;
  }

  if(self issplitscreenplayer()) {
    var1 += 20;
  }

  var4 = level.primaryprogressbarfontsize;
  var5 = "default";

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(isDefined(var3)) {
    var5 = var3;
  }

  var6 = createfontstring(var5, var4);
  setpoint(var6, "CENTER", undefined, level.primaryprogressbartextx + var0, level.primaryprogressbartexty + var1);
  var6.sort = -1;
  return var6;
}

function createprimaryprogressbar(var0, var1, var2, var3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = -25;
  }

  if(self issplitscreenplayer()) {
    var1 += 20;
  }

  if(!isDefined(var2)) {
    var2 = level.primaryprogressbarwidth;
  }

  if(!isDefined(var3)) {
    var3 = level.primaryprogressbarheight;
  }

  var4 = createbar((1, 1, 1), var2, var3);
  setpoint(var4, "CENTER", undefined, level.primaryprogressbarx + var0, level.primaryprogressbary + var1);
  return var4;
}

function createbar(var0, var1, var2, var3) {
  var4 = newclienthudelem(self);
  var4.x = 0;
  var4.y = 0;
  var4.frac = 0;
  var4.color = var0;
  var4.sort = -2;
  var4.shader = "progress_bar_fill";
  var4 setshader("progress_bar_fill", var1, var2);
  var4.hidden = 0;

  if(isDefined(var3)) {
    var4.flashfrac = var3;
  }

  var5 = newclienthudelem(self);
  var5.elemtype = "bar";
  var5.width = var1;
  var5.height = var2;
  var5.xoffset = 0;
  var5.yoffset = 0;
  var5.bar = var4;
  var5.children = [];
  var5.sort = -3;
  var5.color = (0, 0, 0);
  var5.alpha = 0.5;
  setparent(var5, level.uiparent);
  var5 setshader("progress_bar_bg", var1 + 4, var2 + 4);
  var5.hidden = 0;
  return var5;
}

function isgameparticipant(var0) {
  if(isaigameparticipant(var0)) {
    return true;
  }

  if(isPlayer(var0)) {
    return true;
  }

  return false;
}

function isaigameparticipant(var0) {
  if(isagent(var0) && isDefined(var0.agent_gameparticipant) && var0.agent_gameparticipant == 1) {
    return true;
  }

  if(isbot(var0)) {
    return true;
  }

  return false;
}

function setteamheadicon(var0, var1) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var2 = game["entity_headicon_" + var0];
  self.entityheadiconteam = var0;

  if(isDefined(var1)) {
    self.entityheadiconoffset = var1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");

  if(var0 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var3 = newteamhudelem(var0);
  var3.archived = 1;
  var3.x = self.origin[0] + self.entityheadiconoffset[0];
  var3.y = self.origin[1] + self.entityheadiconoffset[1];
  var3.z = self.origin[2] + self.entityheadiconoffset[2];
  var3.alpha = 0.8;
  var3 setshader(var2, 10, 10);
  var3 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var3;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

function setplayerheadicon(var0, var1) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(var0)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var2 = var0.team;
  self.entityheadiconteam = var2;

  if(isDefined(var1)) {
    self.entityheadiconoffset = var1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var3 = game["entity_headicon_" + var2];
  var4 = newclienthudelem(var0);
  var4.archived = 1;
  var4.x = self.origin[0] + self.entityheadiconoffset[0];
  var4.y = self.origin[1] + self.entityheadiconoffset[1];
  var4.z = self.origin[2] + self.entityheadiconoffset[2];
  var4.alpha = 0.8;
  var4 setshader(var3, 10, 10);
  var4 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var4;
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

function setheadicon(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(isgameparticipant(var0) && !isPlayer(var0)) {
    return;
  }

  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(!isDefined(var6)) {
    var6 = 0.05;
  }

  if(!isDefined(var7)) {
    var7 = 1;
  }

  if(!isDefined(var8)) {
    var8 = 1;
  }

  if(!isDefined(var9)) {
    var9 = 0;
  }

  if(!isDefined(var10)) {
    var10 = 1;
  }

  if(!isPlayer(var0) && var0 == "none") {
    foreach(var13, var12 in self.entityheadicons) {
      if(isDefined(var12)) {
        var12 destroy();
      }

      self.entityheadicons[var13] = undefined;
    }

    return;
  }

  if(isPlayer(var3)) {
    if(isDefined(self.entityheadicons[var3.guid])) {
      self.entityheadicons[var3.guid] destroy();
      self.entityheadicons[var3.guid] = undefined;
    }

    if(var4 == "") {
      return;
    }

    if(isDefined(var3.team)) {
      if(isDefined(self.entityheadicons[var3.team])) {
        self.entityheadicons[var3.team] destroy();
        self.entityheadicons[var3.team] = undefined;
      }
    }

    var12 = newclienthudelem(var3);
    self.entityheadicons[var3.guid] = var12;
  } else {
    if(isDefined(self.entityheadicons[var4])) {
      self.entityheadicons[var4] destroy();
      self.entityheadicons[var4] = undefined;
    }

    jumpiffalse(var5 == "") LOC_00000175;
    return;
  }

  if(!isDefined(var7) || !isDefined(var8)) {
    var7 = 10;
    var8 = 10;
  }

  var12.archived = var9;
  var12.x = self.origin[0] + var6[0];
  var12.y = self.origin[1] + var6[1];
  var12.z = self.origin[2] + var6[2];
  var12.alpha = 0.85;
  var12 setshader(var5, var7, var8);
  var12 setwaypoint(var11, var12, var13, var12);
  thread keeppositioned(var12, self, var6);
  thread destroyiconsondeath();

  if(isPlayer(var4)) {
    thread destroyonownerdisconnect(var12);
  }

  if(isPlayer(self)) {
    thread destroyonownerdisconnect(var12);
  }

  return var12;
}

function showheadicon(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2.alpha = 0.85;
    }
  }
}

function hideheadicon(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2.alpha = 0;
    }
  }
}

function getplayerforguid(var0) {
  foreach(var2 in level.players) {
    if(var2.guid == var0) {
      return var2;
    }
  }

  return undefined;
}

function getpotentiallivingplayers() {
  var0 = [];

  foreach(var2 in level.players) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function getplayersinradius(var0, var1, var2, var3) {
  var4 = ["physicscontents_player"];
  return getentitiesinradius(var0, var1, var2, var3, physics_createcontents(var4));
}

function getactorsinradius(var0, var1, var2, var3) {
  var4 = ["physicscontents_actor"];
  return getentitiesinradius(var0, var1, var2, var3, physics_createcontents(var4));
}

function getentitiesinradius(var0, var1, var2, var3, var4) {
  if(var1 <= 0) {
    return [];
  }

  var5 = undefined;

  if(isDefined(var3)) {
    if(isarray(var3)) {
      var5 = var3;
    } else {
      var5 = [var3];
    }
  }

  var6 = physics_querypoint(var0, var1, var4, var5, "physicsquery_all");
  var7 = [];
  jumpiftrue(isDefined(var2)) LOC_00000078;

  foreach(var9 in var6) {
    var10 = var9["entity"];
    var7 = var10;
  }

  goto LOC_000000c4;
}

function keeppositioned(var0, var1, var2) {
  self endon("death");
  var0 endon("death");
  var0 endon("disconnect");
  var3 = isDefined(var0.classname) && !isownercarepakage(var0);

  if(var3) {
    self linkwaypointtotargetwithoffset(var0, var1);
  }

  for(;;) {
    if(!isDefined(var0)) {
      return;
    }

    if(!var3) {
      var4 = var0.origin;
      self.x = var4[0] + var1[0];
      self.y = var4[1] + var1[1];
      self.z = var4[2] + var1[2];
    }

    if(var2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var2);
      self.alpha = 0;
    }

    wait var2;
  }
}

function isownercarepakage(var0) {
  return isDefined(var0.targetname) && var0.targetname == "care_package";
}

function destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  if(!isDefined(self.entityheadicons)) {
    return;
  }

  foreach(var1 in self.entityheadicons) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 destroy();
  }
}

function destroyonownerdisconnect(var0) {
  self endon("death");
  var0 waittill("disconnect");
  self destroy();
}

function _suicide() {
  if(!isusingremote() && !isDefined(self.fauxdead)) {
    self suicide();
    return;
  }
}

function player_lua_progressbar(var0, var1, var2, var3, var4, var5) {
  var6 = lua_progress_bar_think(var0, var1, var2, var3, var4, var5);
  return var6;
}

function lua_progress_bar_think(var0, var1, var2, var3, var4, var5) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 1;
  self.usetime = var1;
  thread create_lua_progress_bar(var0, self);
  var0.hasprogressbar = 1;
  var6 = lua_progress_bar_think_loop(var0, self, var2, var4, var5);

  if(isalive(var0)) {
    var0.hasprogressbar = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var6;
}

function create_lua_progress_bar(var0, var1) {
  self endon("disconnect");
  self setclientomnvar("ui_securing", var1);
  var2 = -1;

  while(scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var0) && var0.inuse && !level.gameended) {
    if(var2 != var0.userate) {
      if(var0.curprogress > var0.usetime) {
        var0.curprogress = var0.usetime;
      }
    }

    var2 = var0.userate;
    self setclientomnvar("ui_securing_progress", var0.curprogress / var0.usetime);
    wait 0.05;
  }

  wait 0.5;
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_securing", 0);
}

function lua_progress_bar_think_loop(var0, var1, var2, var3, var4) {
  while(!level.gameended && isDefined(self) && var0 scripts\cp_mp\utility\player_utility::_isalive() && (var0 useButtonPressed() || isDefined(var3) || var0 attackButtonPressed() && isDefined(var4)) && should_continue_progress_bar_think(var0)) {
    wait 0.05;

    if(isDefined(var1) && isDefined(var2)) {
      if(distancesquared(var0.origin, var1.origin) > var2) {
        return 0;
      }
    }

    self.curprogress += 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      var0 setclientomnvar("ui_securing_progress", 1);
      return var0 scripts\cp_mp\utility\player_utility::_isalive();
    }
  }

  return 0;
}

function should_continue_progress_bar_think(var0) {
  if(isDefined(level.should_continue_progress_bar_think)) {
    return [[level.should_continue_progress_bar_think]](var0);
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var0);
}

function isplayingsolo() {
  if(getmaxclients() == 1) {
    return true;
  }

  return false;
}

function removefromparticipantsarray() {
  var0 = 0;

  for(var1 = 0; var1 < level.participants.size; var1++) {
    if(level.participants[var1] == self) {
      var0 = 1;

      while(var1 < level.participants.size - 1) {
        level.participants[var1] = level.participants[var1 + 1];
        var1++;
      }

      level.participants[var1] = undefined;
      break;
    }
  }
}

function removefromcharactersarray() {
  var0 = 0;

  for(var1 = 0; var1 < level.characters.size; var1++) {
    if(level.characters[var1] == self) {
      var0 = 1;

      while(var1 < level.characters.size - 1) {
        level.characters[var1] = level.characters[var1 + 1];
        var1++;
      }

      level.characters[var1] = undefined;
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

function createtimer(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "timer";
  var2.font = var0;
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  var2.hidden = 0;
  return var2;
}

function relic_bang_and_boom_dropfunc(var0) {
  if(var0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function respawn_flare_wavesv_used_playereffects(var0, var1) {
  var2 = 1;

  if(isDefined(var1)) {
    var2 = var1;
  }

  var3 = undefined;

  switch (var0) {
    case 300:
      if(istrue(var2) && scripts\engine\utility::cointoss()) {
        var3 = "dx_cps_lass_timecheck_5min_10";
      } else {
        var3 = "dx_cps_kama_timecheck_5min_10";
      }

      break;
    case 120:
      if(istrue(var2) && scripts\engine\utility::cointoss()) {
        var3 = "dx_cps_lass_timecheck_2min_20";
      } else {
        var3 = "dx_cps_kama_timecheck_2min_20";
      }

      break;
    case 60:
      if(istrue(var2) && scripts\engine\utility::cointoss()) {
        var3 = "dx_cps_lass_timecheck_1min_30";
      } else {
        var3 = "dx_cps_kama_timecheck_1min_30";
      }

      break;
    case 30:
      if(istrue(var2) && scripts\engine\utility::cointoss()) {
        var3 = "dx_cps_lass_timecheck_30sec_40";
      } else {
        var3 = "dx_cps_kama_timecheck_30sec_40";
      }

      break;
    case 10:
      if(istrue(var2) && scripts\engine\utility::cointoss()) {
        var3 = "dx_cps_lass_timecheck_10sec_50";
      } else {
        var3 = "dx_cps_kama_timecheck_10sec_50";
      }

      break;
  }

  return var3;
}

function _detachall(var0) {
  if(!istrue(var0)) {
    self.headmodel = undefined;
  }

  if(isDefined(self.riotshieldmodel)) {
    riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    riotshield_detach(0);
  }

  self.hasriotshieldequipped = 0;

  if(!istrue(var0)) {
    self detachall();
  }

  scripts\cp\equipment\nvg::clearnvg(istrue(var0));
}

function is_valid_perk(var0) {
  var1 = getarraykeys(level.alien_perks["perk_0"]);

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return 1;
  }

  var2 = getarraykeys(level.alien_perks["perk_1"]);

  if(scripts\engine\utility::array_contains(var2, var0)) {
    return 1;
  }

  var3 = getarraykeys(level.alien_perks["perk_2"]);
  return scripts\engine\utility::array_contains(var3, var0);
}

function is_consumable_active(var0) {
  if(isDefined(self.consumables) && isDefined(self.consumables[var0]) && isDefined(self.consumables[var0].on) && self.consumables[var0].on == 1) {
    return 1;
  }

  return 0;
}

function notify_used_consumable(var0) {
  self notify(self.consumables[var0].usednotify);
}

function notify_timeup_consumable(var0) {
  self notify(level.consumables[var0].timeupnotify);
}

function drawline(var0, var1, var2, var3) {
  var4 = int(var2 * 20);

  for(var5 = 0; var5 < var4; var5++) {
    wait 0.05;
  }
}

function is_upgrade_enabled(var0) {
  if(!is_using_extinction_tokens()) {
    return 0;
  }

  if(self getplayerdata("cp", "upgrades_enabled_flags", var0)) {
    return 1;
  }

  return 0;
}

function allow_player_teleport(var0, var1) {
  if(var0) {
    if(!isDefined(self.teleportdisableflags) && isDefined(var1)) {
      foreach(var3 in self.teleportdisableflags) {
        if(var3 == var1) {
          self.teleportdisableflags = scripts\engine\utility::array_remove(self.teleportdisableflags, var1);
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

  if(isDefined(var1)) {
    self.teleportdisableflags[self.teleportdisableflags.size] = var1;
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

function allow_player_interactions(var0) {
  if(var0) {
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

function _linkTo(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = "tag_origin";
  }

  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  if(!isDefined(self.playerlinkedcounter)) {
    self.playerlinkedcounter = 0;
  }

  self.playerlinkedcounter++;

  if(self.playerlinkedcounter == 1) {
    self linkTo(var1, var2, var3, var4);
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
  var0 = scripts\engine\utility::get_linked_structs();

  if(!var0.size) {
    return undefined;
  }

  return var0[0];
}

function isplayerlinked() {
  return isDefined(self.playerlinkedcounter) && self.playerlinkedcounter > 0;
}

function enable_infinite_ammo(var0) {
  if(var0) {
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

function brjugg_playerwelcomesplashes(var0) {
  if(!isDefined(self.move_door_to_pos)) {
    self.move_door_to_pos = 0;
  }

  if(var0) {
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

function brjugg_setconfig(var0) {
  if(!isDefined(self.move_entity)) {
    self.move_entity = 0;
  }

  if(var0) {
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

function allow_player_ignore_me(var0) {
  if(var0) {
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

function brjugg_startdelivery(var0) {
  if(var0) {
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

function brjugg_setjuggwatchers(var0) {
  if(var0) {
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

function coop_getweaponclass(var0) {
  if(!isDefined(var0)) {
    return "none";
  }

  if(issameweapon(var0) && nullweapon(var0)) {
    return "none";
  }

  if(isstring(var0) && var0 == "none") {
    return "none";
  }

  var1 = getbaseweaponname(var0);
  var2 = tablelookup("mp/statstable.csv", 4, var1, 1);

  if(var2 == "" && isDefined(level.game_mode_statstable)) {
    if(isDefined(var0)) {
      var1 = getbaseweaponname(var0);
      var2 = tablelookup(level.game_mode_statstable, 4, var1, 2);
    }
  }

  if(isenvironmentweapon(var0)) {
    var2 = "weapon_mg";
  } else if(issameweapon(var0) && nullweapon(var0)) {
    var2 = "other";
  } else if(isstring(var0) && var0 == "none") {
    var2 = "other";
  } else if(var2 == "") {
    var2 = "other";
  }

  return var2;
}

function is_holding_deployable() {
  return istrue(self.is_holding_deployable);
}

function has_special_weapon() {
  return istrue(self.has_special_weapon);
}

function filloffhandweapons(var0, var1) {
  var2 = self getweaponslistoffhands();
  var3 = 0;
  var4 = undefined;
  var5 = 0;

  foreach(var7 in var2) {
    if(var7 != var0) {
      if(nullweapon(var7)) {
        continue;
      }

      var8 = var7.basename;

      if(var8 != "alienthrowingknife_mp" && var8 != "alientrophy_mp" && var8 != "iw6_aliendlc21_mp") {
        self takeweapon(var7);
      }

      continue;
    }

    if(!nullweapon(var7)) {
      var5 = self getammocount(var7);
      self setweaponammostock(var7, var5 + var1);
      var3 = 1;
      break;
    }
  }

  if(var3 == 0) {
    _giveweapon(var0);
    self setweaponammostock(var0, var1);
    return;
  }
}

function getequipmenttype(var0) {
  switch (var0) {
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
      var1 = "lethal";
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
      var1 = "tactical";
      break;
    default:
      var1 = undefined;
      break;
  }

  return var1;
}

function giveperkoffhand(var0) {
  if(var0 == "none" || var0 == "specialty_null") {
    self setoffhandsecondaryclass("none");
    return;
  }

  self.secondarygrenade = var0;

  if(issubstr(var0, "_mp")) {
    switch (var0) {
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

    _giveweapon(var0, 0);

    switch (var0) {
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
        self setweaponammoclip(var0, 1);
        break;
      default:
        self givestartammo(var0);
        break;
    }

    _setperk(var0);
    return;
  }

  _setperk(var0);
}

function _launchgrenade(var0, var1, var2, var3, var4, var5) {
  var6 = self launchgrenade(var0, var1, var2, var3, var5);

  if(!isDefined(var4)) {
    var6.notthrown = 1;
  } else {
    var6.notthrown = var4;
  }

  var6 setotherent(self);
  return var6;
}

function moveplayerperpendicularly(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 1200;
  }

  if(isDefined(var1)) {
    var2 = vectorNormalize(var1);
  } else {
    var2 = anglesToForward(self.angles);
  }

  var3 = vectorcross((0, 0, 1), var2);
  var4 = vectorNormalize(var3);
  self knockback(var4, var1);
}

function blockperkfunction(var0) {
  if(!isDefined(self.perksblocked[var0])) {
    self.perksblocked[var0] = 1;
  } else {
    self.perksblocked[var0]++;
  }

  if(self.perksblocked[var0] == 1 && _hasperk(var0)) {
    foreach(var2 in level.extraperkmap) {
      if(var0 == var6) {
        foreach(var4 in var2) {
          if(!isDefined(self.perksblocked[var4])) {
            self.perksblocked[var4] = 1;
          } else {
            self.perksblocked[var4]++;
          }

          if(self.perksblocked[var4] == 1) {}
        }

        break;
      }
    }

    return;
  }
}

function unblockperkfunction(var0) {
  self.perksblocked[var0]--;

  if(self.perksblocked[var0] == 0) {
    self.perksblocked[var0] = undefined;

    if(_hasperk(var0)) {
      foreach(var2 in level.extraperkmap) {
        if(var0 == var6) {
          foreach(var4 in var2) {
            self.perksblocked[var4]--;

            if(self.perksblocked[var4] == 0) {
              self.perksblocked[var4] = undefined;
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

function getweaponclass(var0) {
  var1 = getbaseweaponname(var0);
  var2 = tablelookup("mp/statstable.csv", 4, var1, 1);

  if(var2 == "") {
    var3 = strip_suffix(var0.basename, "_zm");
    var2 = tablelookup("mp/statstable.csv", 4, var3, 1);
  }

  if(isenvironmentweapon(var0.basename)) {
    var2 = "weapon_mg";
  } else if(iskillstreakweapon(var0.basename)) {
    var2 = "killstreak";
  } else if(issuperweapon(var0.basename)) {
    var2 = "super";
  } else if(var0.basename == "none") {
    var2 = "other";
  } else if(var2 == "") {
    var2 = "other";
  }

  return var2;
}

function removedamagemodifier(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var1) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[var0] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[var0] = undefined;
}

function adddamagemodifier(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[var0] = var1;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[var0] = var1;
}

function getdamagemodifiertotal(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 1;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(var9 in self.additivedamagemodifiers) {
      var7 += var9 - 1;
    }
  }

  var11 = 1;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(var9 in self.multiplicativedamagemodifiers) {
      var11 *= var9;
    }
  }

  return var7 * var11;
}

function isinventoryprimaryweapon(var0) {
  switch (weaponinventorytype(var0)) {
    case "altmode":
    case "primary":
      return 1;
    default:
      return 0;
  }
}

function _enablecollisionnotifies(var0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var0) {
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

function has_tag(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  var2 = getnumparts(var0);

  for(var3 = 0; var3 < var2; var3++) {
    if(tolower(getpartname(var0, var3)) == tolower(var1)) {
      return true;
    }
  }

  return false;
}

function is_trap(var0, var1) {
  if(isDefined(var1) && (var1.basename == "iw7_beamtrap_zm" || var1.basename == "iw7_escapevelocity_zm" || var1.basename == "iw7_rockettrap_zm" || var1.basename == "iw7_discotrap_zm" || var1.basename == "iw7_chromosphere_zm" || var1.basename == "iw7_buffertrap_zm" || var1.basename == "iw7_electrictrap_zm" || var1.basename == "iw7_fantrap_zm" || var1.basename == "iw7_hydranttrap_zm" || var1.basename == "iw7_moshtrap_zm")) {
    return true;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0.tesla_type)) {
    return true;
  }

  if(!isDefined(var0.script_noteworthy) && !isDefined(var0.targetname)) {
    return false;
  }

  if(isDefined(var0.targetname) && (var0.targetname == "fence_generator" || var0.targetname == "puddle_generator")) {
    return true;
  }

  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "fire_trap") {
    return true;
  }

  return false;
}

function riotshieldname() {
  var0 = self getweaponslist("primary");

  if(!self.hasriotshield) {
    return;
  }

  foreach(var2 in var0) {
    if(weapontype(var2) == "riotshield") {
      return var2;
    }
  }
}

function player_has_special_ammo(var0, var1) {
  return isDefined(var0.special_ammo_type) && var0.special_ammo_type == var1;
}

function has_stun_ammo(var0) {
  if(isDefined(self.special_ammo_type)) {
    return player_has_special_ammo(self, "stun_ammo");
  }

  if(!isDefined(var0)) {
    var1 = self getcurrentweapon();
  } else if(issameweapon(var1)) {
    var1 = var1;
  } else {
    var1 = asmdevgetallstates(var1);
  }

  if(nullweapon(var1)) {
    var1 = self getweaponslistprimaries()[0];
  }

  var2 = getrawbaseweaponname(var1);

  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var2]) && self.special_ammocount[var2] > 0) {
    return true;
  }

  if(isDefined(self.special_ammocount_comb) && isDefined(self.special_ammocount_comb[var2]) && self.special_ammocount_comb[var2] > 0) {
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

function valuehud(var0) {
  if(isDefined(var0) && var0.basename != "none") {
    if(issuperweapon(var0.basename)) {
      return true;
    }

    var1 = getequipmenttype(var0.basename);

    if(isDefined(var1) && var1 == "lethal") {
      return true;
    }
  }

  return false;
}

function isriotshield(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return false;
  }

  if(isstring(var0) && var0 == "none") {
    return false;
  }

  return weapontype(var0) == "riotshield";
}

function isaltmodeweapon(var0) {
  if(!isDefined(var0) || var0 == "none") {
    return false;
  }

  return weaponinventorytype(var0) == "altmode";
}

function hasriotshield() {
  var0 = 0;
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(isriotshield(var3)) {
      var0 = 1;
      break;
    }
  }

  return var0;
}

function is_empty_string(var0) {
  return var0 == "";
}

function notifyafterframeend(var0, var1) {
  self waittill(var0);
  waittillframeend();
  self notify(var1);
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

function isheadshot(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    if(isDefined(var3.owner)) {
      if(var3.code_classname == "script_vehicle") {
        return false;
      }

      if(var3.code_classname == "misc_turret") {
        return false;
      }

      if(var3.code_classname == "script_model") {
        return false;
      }
    }

    if(isDefined(var3.agent_type)) {
      if(var3.agent_type == "dog" || var3.agent_type == "alien") {
        return false;
      }
    }
  }

  return (var1 == "head" || var1 == "helmet" || var1 == "neck") && var2 != "MOD_MELEE" && var2 != "MOD_IMPACT" && var2 != "MOD_SCARAB" && var2 != "MOD_CRUSH" && var2 != "MOD_HEAD_SHOT" && !isenvironmentweapon(var0.basename);
}

function getteamarray(var0, var1) {
  var2 = [];
  jumpiffalse(!isDefined(var1) || var1) LOC_00000050;

  foreach(var4 in level.characters) {
    if(var4.team == var0) {
      var2 = var4;
    }
  }

  goto LOC_00000089;
}

function getotherteam(var0) {
  if(level.multiteambased) {}

  if(var0 == "allies") {
    return "axis";
  }

  if(var0 == "axis") {
    return "allies";
  }

  return "none";
}

function player_black_screen(var0, var1, var2, var3) {
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

  if(!istrue(var3)) {
    self.player_black_screen fadeovertime(var0);
  }

  self.player_black_screen.alpha = 1;

  if(!istrue(var3)) {
    wait var0 + 0.05;
  }

  wait var1;
  self.player_black_screen fadeovertime(var2);
  self.player_black_screen.alpha = 0;
  wait var2 + 0.05;
  self.player_black_screen destroy();
}

function riotshield_hasweapon() {
  var0 = 0;
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(isriotshield(var3)) {
      var0 = 1;
      break;
    }
  }

  return var0;
}

function riotshield_attach(var0, var1) {
  var2 = undefined;

  if(var0) {
    self.riotshieldmodel = var1;
    var2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = var1;
    var2 = "tag_shield_back";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var2) {
    self.initlocs_donetsk = var2;
    self attachshieldmodel(var1, var2);
  }

  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_detach(var0) {
  var1 = undefined;
  var2 = undefined;

  if(var0) {
    var1 = self.riotshieldmodel;
    var2 = "j_shield_ri";
  } else {
    var1 = self.riotshieldmodelstowed;
    var2 = "tag_shield_back";
  }

  if(isDefined(self.initlocs_donetsk) && self.initlocs_donetsk == var2) {
    self.initlocs_donetsk = undefined;
    self detachshieldmodel(var1, var2);
  }

  if(var0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

function launchshield(var0, var1) {
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

function riotshield_move(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  if(var0) {
    var3 = self.riotshieldmodel;
    var1 = "j_shield_ri";
    var2 = "tag_shield_back";
  } else {
    var3 = self.riotshieldmodelstowed;
    var1 = "tag_shield_back";
    var2 = "j_shield_ri";
  }

  if(!isDefined(self.initlocs_donetsk) || self.initlocs_donetsk != var2) {
    self.initlocs_donetsk = var2;
    self moveshieldmodel(var3, var1, var2);
  }

  if(var0) {
    self.riotshieldmodelstowed = var3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var3;
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

function store_weapons_status(var0, var1) {
  self.copy_fullweaponlist = self getweaponslistall();
  self.copy_weapon_current = get_current_weapon(self, var1);
  self.copy_weapon_level = [];
  var2 = [];

  foreach(var4 in self.copy_fullweaponlist) {
    if(var4.isalternate) {
      continue;
    }

    if(issubstr(var4.basename, "iw8_execution_")) {
      continue;
    }

    var2 = var4;
  }

  self.copy_fullweaponlist = var2;

  foreach(var4 in self.copy_fullweaponlist) {
    var7 = createheadicon(var4);
    self.copy_weapon_ammo_clip[var7] = self getweaponammoclip(var4);
    self.copy_weapon_ammo_stock[var7] = self getweaponammostock(var4);

    if(issubstr(var4.basename, "akimbo")) {
      self.copy_weapon_ammo_clip_left[var7] = self getweaponammoclip(var4, "left");
    }

    var8 = getrawbaseweaponname(var4);

    if(isDefined(self.pap[var8])) {
      self.copy_weapon_level[var7] = self.pap[var8].lvl;
    }
  }

  if(isDefined(var0)) {
    var10 = [];

    foreach(var4 in self.copy_fullweaponlist) {
      var12 = 0;

      foreach(var14 in var0) {
        if(var4 == var14) {
          var12 = 1;
          break;
        }

        if(var4 getbaseweapon() == var14) {
          var12 = 1;
          break;
        }
      }

      if(var12) {
        continue;
      }

      var10 = var4;
    }

    self.copy_fullweaponlist = var10;

    foreach(var14 in var0) {
      if(self.copy_weapon_current == var14) {
        self.copy_weapon_current = isundefinedweapon();
        break;
      }
    }

    return;
  }
}

function get_current_weapon(var0, var1) {
  var2 = var0 getcurrentweapon();

  if(istrue(var1) && is_melee_weapon(var2)) {
    var2 = var0 getweaponslistall()[1];
  }

  return var2;
}

function is_melee_weapon(var0, var1) {
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0.basename;
  } else {
    var2 = var0;
  }

  switch (var2) {
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
      if(istrue(var1)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

function is_primary_melee_weapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function restore_weapons_status(var0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  var1 = self getweaponslistall();

  foreach(var3 in var1) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, var3) && !in_inclusion_list(var0, var3)) {
      self takeweapon(var3);
    }
  }

  if(isDefined(self.ref_12d4d)) {
    if(!scripts\engine\utility::array_contains(self.copy_fullweaponlist, self.ref_12d4d)) {
      self.copy_fullweaponlist[self.copy_fullweaponlist.size] = self.ref_12d4d;
    }

    self.ref_12d4d = undefined;
  }

  foreach(var3 in self.copy_fullweaponlist) {
    if(!self hasweapon(var3)) {
      self giveweapon(var3, -1, 0, -1, 1);
    }

    var6 = createheadicon(var3);

    if(isDefined(self.powerprimarygrenade) && self.powerprimarygrenade == var6) {
      self assignweaponoffhandprimary(var3);
    }

    if(isDefined(self.powersecondarygrenade) && self.powersecondarygrenade == var6) {
      self assignweaponoffhandsecondary(var3);
    }

    if(isDefined(self.specialoffhandgrenade) && self.specialoffhandgrenade == var6) {
      self assignweaponoffhandspecial(var3);
    }

    if(isDefined(self.copy_weapon_ammo_clip[var6])) {
      self setweaponammoclip(var3, self.copy_weapon_ammo_clip[var6]);
    }

    if(isDefined(self.copy_weapon_ammo_clip_left)) {
      if(isDefined(self.copy_weapon_ammo_clip_left[var6])) {
        self setweaponammoclip(var3, self.copy_weapon_ammo_clip_left[var6], "left");
      }
    }

    if(isDefined(self.copy_weapon_ammo_stock[var6])) {
      self setweaponammostock(var3, self.copy_weapon_ammo_stock[var6]);
    }

    if(isDefined(self.copy_weapon_level[var6])) {
      var7 = spawnStruct();
      var7.lvl = self.copy_weapon_level[var6];
      self.pap[getrawbaseweaponname(var3)] = var7;
    }
  }

  var9 = self.copy_weapon_current;

  if(getqueuedspleveltransients(var9)) {
    foreach(var11 in self.copy_fullweaponlist) {
      if(scripts\cp\cp_weapon::isbulletweapon(var11)) {
        var9 = var11;
        break;
      }
    }
  }

  if(scripts\common\utility::is_weapon_switch_allowed()) {
    self switchtoweaponimmediate(var9);
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

function restore_primary_weapons_only(var0) {
  if(!isDefined(self.copy_fullweaponlist) || !isDefined(self.copy_weapon_current) || !isDefined(self.copy_weapon_ammo_clip) || !isDefined(self.copy_weapon_ammo_stock)) {}

  self.primary_weapons = [];
  var1 = 0;

  foreach(var3 in self.copy_fullweaponlist) {
    if(isinventoryprimaryweapon(var3)) {
      self.primary_weapons[var1] = var3;
      var1 += 1;
    }
  }

  var5 = 0;

  foreach(var3 in self.primary_weapons) {
    if(var5 < 3) {
      if(var3.isalternate) {
        continue;
      }

      if(!self hasweapon(var3)) {
        self giveweapon(var3, -1, 0, -1, 1);
      }

      var7 = createheadicon(var3);
      self setweaponammoclip(var3, self.copy_weapon_ammo_clip[var7]);
      self setweaponammostock(var3, self.copy_weapon_ammo_stock[var7]);

      if(isDefined(self.copy_weapon_level[var7])) {
        var8 = spawnStruct();
        var8.lvl = self.copy_weapon_level[var7];
        self.pap[getrawbaseweaponname(var3)] = var8;
      }

      var5++;
    }
  }

  var10 = self.copy_weapon_current;

  if(!isDefined(var10) || !self hasweapon(var10) || nullweapon(var10)) {
    var10 = getweapontoswitchbackto();
  }

  self switchtoweaponimmediate(var10);
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

function add_to_weapons_status(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var6 = undefined;
    var7 = undefined;

    if(issameweapon(var5)) {
      var6 = var5;
      var7 = createheadicon(var5);
    } else {
      var6 = asmdevgetallstates(var5);
      var7 = var5;
    }

    self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var6;
    self.copy_weapon_ammo_clip[var7] = var1[var7];
    self.copy_weapon_ammo_stock[var7] = var2[var7];
  }

  self.copy_weapon_current = var3;
}

function in_inclusion_list(var0, var1) {
  if(!isDefined(var0)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var0, var1);
}

function vec_multiply(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
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

function getcloseststruct(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var1, "script_noteworthy");
  var4 = sortbydistance(var3, var0)[0];

  if(isDefined(var2) && distancesquared(var0, var4.origin) > squared(var2)) {
    return undefined;
  }

  return var4;
}

function is_zombie_agent() {
  return isagent(self) && isDefined(self.species) && (self.species == "humanoid" || self.species == "zombie");
}

function is_soldier_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "human";
}

function coop_mode_has(var0) {
  if(!isDefined(level.coop_mode_feature)) {
    return false;
  }

  return isDefined(level.coop_mode_feature[var0]);
}

function coop_mode_enable(var0) {
  if(isDefined(var0)) {
    if(!isDefined(level.coop_mode_feature)) {
      level.coop_mode_feature = [];
    }

    if(isarray(var0)) {
      foreach(var2 in var0) {
        level.coop_mode_feature[var2] = 1;
      }

      return;
    }

    level.coop_mode_feature[var0] = 1;
    return;
  }
}

function make_entity_sentient_cp(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var1) {
    return self makeentitysentient(var0, 1);
  }

  return self makeentitysentient(var0);
}

function get_attacker_as_player(var0) {
  if(isDefined(var0)) {
    if(isPlayer(var0)) {
      return var0;
    }

    if(isDefined(var0.owner) && isPlayer(var0.owner)) {
      return var0.owner;
    }
  }

  return undefined;
}

function removeexcludedattachments(var0) {
  if(isDefined(level.excludedattachments)) {
    foreach(var2 in level.excludedattachments) {
      foreach(var4 in var0) {
        if(attachmentmap_tobase(var4) == var2) {
          var0 = scripts\engine\utility::array_remove(var0, var4);
        }
      }
    }
  }

  return var0;
}

function getrandomweaponattachments(var0, var1, var2) {
  var3 = [];

  if(weaponhaspassive(var0, var1, "passive_random_attachments")) {
    if(false) {
      var4 = getavailableattachments(var0, var2, 0);
      var3 = var4[randomint(var4.size)];
    } else {
      var5 = int(max(0, 5 - var2.size));

      if(var5 > 0) {
        var6 = randomintrange(1, var5 + 1);
        var3 = buildrandomattachmentarray(var0, var6, var2);
      }
    }
  }

  return var3;
}

function weaponhaspassive(var0, var1, var2) {
  var3 = getweaponpassives(var0, var1);

  if(!isDefined(var3) || var3.size <= 0) {
    return false;
  }

  foreach(var5 in var3) {
    if(var2 == var5) {
      return true;
    }
  }

  return false;
}

function buildrandomattachmentarray(var0, var1, var2) {
  var3 = [];
  var4 = scripts\cp\cp_weapon::getattachmenttypeslist(var0, var2);

  if(var4.size > 0) {
    var3 = [];
    var5 = scripts\engine\utility::array_randomize_objects(var4);

    foreach(var7 in var5) {
      if(var1 <= 0) {
        break;
      }

      var8 = 1;

      switch (var10) {
        case "undermount":
        case "barrel":
          var8 = 1;
          break;
        case "rail":
        case "pap":
        case "perk":
          var8 = 0;
          break;
        default:
          var8 = randomintrange(1, var1 + 1);
          break;
      }

      if(var8 > 0) {
        if(var8 > var7.size) {
          var8 = var7.size;
        }

        var1 -= var8;
        var7 = scripts\engine\utility::array_randomize_objects(var7);

        while(var8 > 0) {
          var9 = var7[var7.size - var8];

          if(!issubstr(var9, "ark") && !issubstr(var9, "arcane")) {
            var3 = var9;
          }

          var8--;
        }
      }
    }
  }

  return var3;
}

function getavailableattachments(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = getweaponattachmentarrayfromstats(var0);
  var4 = [];

  foreach(var6 in var3) {
    var7 = getattachmenttype(var6);

    if(!var2 && var7 == "rail") {
      continue;
    }

    if(isDefined(var1) && listhasattachment(var1, var6)) {
      continue;
    }

    var4 = var6;
  }

  return var4;
}

function listhasattachment(var0, var1) {
  foreach(var3 in var0) {
    if(var3 == var1) {
      return true;
    }
  }

  return false;
}

function getweaponattachmentarrayfromstats(var0) {
  var1 = getweaponrootname(var0);

  if(!isDefined(level.weaponattachments)) {
    level.weaponattachments = [];
  }

  if(!isDefined(level.weaponattachments[var1])) {
    var2 = [];

    for(var3 = 0; var3 < 10; var3++) {
      var4 = tablelookup("mp/statstable.csv", 4, var1, 10 + var3);

      if(var4 == "") {
        break;
      }

      var2 = var4;
    }

    level.weaponattachments[var1] = var2;
  }

  return level.weaponattachments[var1];
}

function getweaponpaintjobid(var0) {
  return -1;
}

function getweaponcamo(var0) {
  var1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var0, "camo");

  if(isDefined(var1) && var1 != "none") {
    return var1;
  }

  return "none";
}

function getweaponcosmeticattachment(var0) {
  var1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var0, "cosmeticAttachment");

  if(isDefined(var1) && var1 != "none") {
    return var1;
  }

  return "none";
}

function getweaponreticle(var0) {
  var1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var0, "reticle");

  if(isDefined(var1) && var1 != "none") {
    return var1;
  }

  return "none";
}

function mpbuildweaponname(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = weaponattachdefaultmap(var0);
  var10 = buildweaponassetname(var0, var4);
  var11 = coop_getweaponclass(var10);

  if(isDefined(var9)) {
    var1 = scripts\engine\utility::array_combine_unique(var1, var9);
  }

  var1 = weaponattachremoveextraattachments(var1);
  var1 = removeexcludedattachments(var1);

  for(var12 = 0; var12 < var1.size; var12++) {
    var1 = attachmentmap_tounique(var1[var12], var10);
  }

  if(isDefined(var9)) {
    for(var12 = 0; var12 < var9.size; var12++) {
      var9 = attachmentmap_tounique(var9[var12], var10);
    }
  }

  if(isDefined(var9)) {
    var1 = scripts\engine\utility::array_combine_unique(var1, var9);
  }

  var1 = scripts\engine\utility::array_remove(var1, "none");

  if(isDefined(var8) && var8 != "none") {
    var1 = var8;
  }

  if(var1.size > 0) {
    var1 = filterattachments(var1);
  }

  var13 = [];

  foreach(var15 in var1) {
    var16 = attachmentmap_toextra(var15);

    if(isDefined(var16)) {
      var13 = attachmentmap_tounique(var16, var10);
    }
  }

  if(var13.size > 0) {
    var1 = scripts\engine\utility::array_combine_unique(var1, var13);
  }

  if(var1.size > 0) {
    var1 = scripts\engine\utility::alphabetize(var1);
  }

  var10 = reassign_weapon_name(var10, var1);

  foreach(var19 in var1) {
    var10 += "+" + var19;
  }

  if(issubstr(var10, "iw7")) {
    var10 = buildweaponnamecamo(var10, var2, var4);
    var21 = 0;

    if(isholidayweapon(var10, var4)) {
      var21 = isholidayweaponusingdefaultscope(var10, var1);
    }

    if(var21) {
      var10 += "+scope1";
    } else {
      var10 = buildweaponnamereticle(var10, var3);
    }

    var10 = buildweaponnamevariantid(var10, var4);
  }

  return var10;
}

function reassign_weapon_name(var0, var1) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var0)])) {
    return var0;
  } else {
    switch (var0) {
      case "iw7_machete_mp":
        if(istrue(self.base_weapon)) {
          var0 = "iw7_machete_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_machete_mp";
          } else {
            var0 = "iw7_machete_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_machete_mp_pap1";
          } else {
            var0 = "iw7_machete_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 3) {
          var0 = "iw7_machete_mp_pap2";
        }

        break;
      case "iw7_two_headed_axe_mp":
        if(istrue(self.base_weapon)) {
          var0 = "iw7_two_headed_axe_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_two_headed_axe_mp";
          } else {
            var0 = "iw7_two_headed_axe_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_two_headed_axe_mp_pap1";
          } else {
            var0 = "iw7_two_headed_axe_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 3) {
          var0 = "iw7_two_headed_axe_mp_pap2";
        }

        break;
      case "iw7_spiked_bat_mp":
        if(istrue(self.base_weapon)) {
          var0 = "iw7_spiked_bat_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_spiked_bat_mp";
          } else {
            var0 = "iw7_spiked_bat_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_spiked_bat_mp_pap1";
          } else {
            var0 = "iw7_spiked_bat_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 3) {
          var0 = "iw7_spiked_bat_mp_pap2";
        }

        break;
      case "iw7_golf_club_mp":
        if(istrue(self.base_weapon)) {
          var0 = "iw7_golf_club_mp";
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 1 || istrue(self.ephemeral_downgrade)) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_golf_club_mp";
          } else {
            var0 = "iw7_golf_club_mp_pap1";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 2) {
          if(istrue(self.bang_bangs)) {
            var0 = "iw7_golf_club_mp_pap1";
          } else {
            var0 = "iw7_golf_club_mp_pap2";
          }
        } else if(isDefined(self.pap[getrawbaseweaponname(var0)]) && self.pap[getrawbaseweaponname(var0)].lvl == 3) {
          var0 = "iw7_golf_club_mp_pap2";
        }

        break;
      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(var1, "axepap1")) {
          var0 = "iw7_axe_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var1, "axepap2")) {
          var0 = "iw7_axe_zm_pap2";
        }

        break;
      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(var1, "katanapap1")) {
          var0 = "iw7_katana_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var1, "katanapap2")) {
          var0 = "iw7_katana_zm_pap2";
        }

        break;
      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(var1, "nunchuckspap1")) {
          var0 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var1, "nunchuckspap2")) {
          var0 = "iw7_nunchucks_zm_pap2";
        }

        break;
      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(var1, "freezepap1")) {
          var0 = "iw7_forgefreeze_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var1, "freezepap2")) {
          var0 = "iw7_forgefreeze_zm_pap2";
        }

        break;
      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(var1, "shredderpap1")) {
          var0 = "iw7_shredder_zm_pap1";
        }

        break;
      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(var1, "dischordpap1")) {
          var0 = "iw7_dischord_zm_pap1";
        }

        break;
      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(var1, "fmpap1")) {
          var0 = "iw7_facemelter_zm_pap1";
        }

        break;
      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(var1, "hcpap1")) {
          var0 = "iw7_headcutter_zm_pap1";
        }

        break;
    }
  }

  return var0;
}

function get_weapon_variant_id(var0, var1) {
  var2 = getbaseweaponname(var1);
  return -1;
}

function weaponhasvariants(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var0) {
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

function weaponattachremoveextraattachments(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    var5 = attachmentmap_tounique(var4, var1);
    var6 = attachmentmap_toextra(var5);

    if(isDefined(var6)) {
      var2 = var6;
    }
  }

  var8 = [];

  foreach(var4 in var0) {
    var10 = 0;

    foreach(var6 in var2) {
      if(var4 == var6) {
        var10 = 1;
        break;
      }
    }

    if(!var10) {
      var8 = var4;
    }
  }

  return var8;
}

function weaponattachdefaultmap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].attachdefaults)) {
    return level.weaponmapdata[var0].attachdefaults;
  }

  return undefined;
}

function weaponassetnamemap(var0, var1) {
  if(iskillstreakweapon(var0)) {
    return var0;
  }

  if(isDefined(var1)) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].assetoverridename)) {
      return level.weaponlootmapdata[var2].assetoverridename;
    }
  }

  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].assetname)) {
    return level.weaponmapdata[var0].assetname;
  }

  return var0;
}

function iskillstreakweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var1])) {
    return true;
  }

  return false;
}

function buildweaponassetname(var0, var1) {
  return weaponassetnamemap(var0, var1);
}

function getweaponassetfromrootweapon(var0, var1) {
  var2 = "mp/loot/weapon/" + var0 + ".csv";
  var3 = tablelookup(var2, 0, var1, 3);
  return var3;
}

function getweaponvariantattachments(var0, var1) {
  var2 = [];
  var3 = getweaponpassives(var0, var1);

  if(isDefined(var3)) {
    foreach(var5 in var3) {
      var6 = getpassiveattachment(var5);

      if(!isDefined(var6)) {
        continue;
      }

      var2 = var6;
    }
  }

  return var2;
}

function getpassiveattachment(var0) {
  var1 = getpassivestruct(var0);

  if(!isDefined(var1) || !isDefined(var1.attachmentref)) {
    return undefined;
  }

  return var1.attachmentref;
}

function getweaponpassives(var0, var1) {
  return getpassivesforweapon(var0, var1);
}

function getpassivesforweapon(var0, var1) {
  var2 = getlootinfoforweapon(var0, var1);

  if(isDefined(var2)) {
    return var2.passives;
  }

  return undefined;
}

function getlootinfoforweapon(var0, var1) {
  var2 = getweaponrootname(var0);

  if(!isDefined(level.lootweaponcache)) {
    level.lootweaponcache = [];
  }

  if(isDefined(level.lootweaponcache[var2]) && isDefined(level.lootweaponcache[var2][var1])) {
    var3 = level.lootweaponcache[var2][var1];
    return var3;
  }

  var3 = cachelootweaponweaponinfo(var1, var3, var2);

  if(isDefined(var3)) {
    return var3;
  }

  return undefined;
}

function getweaponrootname(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  var2 = level.weaponrootcache[var1];

  if(isDefined(var2)) {
    return var2;
  }

  var3 = var1;
  var4 = strtok(var1, "_");
  var5 = 0;

  if(var4[0] == "alt") {
    var5++;
  }

  if(var4[var5] == "iw8" || var4[var5] == "s4") {
    var6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me"];

    if(scripts\engine\utility::array_contains(var6, var4[var5 + 1])) {
      var1 = var4[var5] + "_" + var4[var5 + 1] + "_" + var4[var5 + 2];
    } else {
      var1 = var4[var5] + "_" + var4[var5 + 1];
    }
  }

  if(level.weaponrootcache.size < 100) {
    level.weaponrootcache[var3] = var1;
  }

  return var1;
}

function relic_nuketimer_globalthread(var0) {
  var1 = getweaponrootname(var0);

  if(isDefined(level.weaponmapdata[var1]) && isDefined(level.weaponmapdata[var1].assetname)) {
    var0 = level.weaponmapdata[var1].assetname;
  }

  return var0;
}

function weapon_is_a_cp_mod(var0, var1) {
  if(isDefined(var0[var1 + 3]) && isDefined(var0[var1 + 4])) {
    return true;
  }

  return false;
}

function weapon_is_cp_loot(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  return issubstr(var1, "commmon") || issubstr(var1, "uncommon") || issubstr(var1, "rare") || issubstr(var1, "legendary") || issubstr(var1, "epic") || issubstr(var1, "godtier");
}

function weapon_is_dlc2_melee(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  return issubstr(var1, "katana") || issubstr(var1, "nunchucks");
}

function weapon_is_dlc_melee(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  return issubstr(var1, "two_headed") || issubstr(var1, "spiked_bat") || issubstr(var1, "machete") || issubstr(var1, "golf_club");
}

function cachelootweaponweaponinfo(var0, var1, var2) {
  if(!isDefined(level.lootweaponcache[var1])) {
    level.lootweaponcache[var1] = [];
  }

  var3 = getweaponloottable(var0);
  var4 = readweaponinfofromtable(var3, var2);
  level.lootweaponcache[var1][var2] = var4;
  return var4;
}

function readweaponinfofromtable(var0, var1) {
  var2 = tablelookuprownum(var0, 0, var1);
  var3 = spawnStruct();
  var3.ref = tablelookupbyrow(var0, var2, 1);
  var3.weaponasset = tablelookupbyrow(var0, var2, 3);
  var3.passives = [];

  for(var4 = 0; var4 < 3; var4++) {
    var5 = tablelookupbyrow(var0, var2, 5 + var4);

    if(isDefined(var5) && var5 != "") {
      var3.passives[var3.passives.size] = var5;
    }
  }

  return var3;
}

function init_drop_locations(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("container_ammo_box_01_nophysics");
  var1.angles = var0.angles;
  var1.targetname = var0.targetname;
  return var1;
}

function create_fake_loot(var0) {
  if(istrue(self.available)) {
    return;
  }

  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    return;
  }

  self show();
  self.available = 1;
  var1 = undefined;

  if(isDefined(var0)) {
    if(isstring(var0)) {
      var1 = [var0];
    } else {
      var1 = var0;
    }
  } else if(istrue(level.little_bird_mg_cp_onexitvehicle)) {
    var1 = ["brloot_munition_grenade_crate", "brloot_munition_armor"];
  } else {
    var1 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  }

  self.loot_type = scripts\engine\utility::random(var1);
  var2 = &"COOP_CRAFTING/AMMO_CRATE";

  switch (self.loot_type) {
    case "brloot_munition_grenade_crate":
      var2 = &"CP_BR/GRENADE_CRATE";
      break;
    case "brloot_munition_armor":
      var2 = &"CP_BR/ARMOR_CRATE";
      break;
    case "brloot_munition_deployable_cover":
      var2 = &"EQUIPMENT/TACTICAL_COVER";
      break;
  }

  self setModel("offhand_wm_supportbox_killstreak");
  self.origin += (0, 0, 16);

  if(self tagexists("tag_use")) {
    sethintobject("tag_use", "HINT_BUTTON", undefined, var2, 25, "duration_none", "show", 128, 80, 128, 80);
    goto LOC_00000142;
  }

  sethintobject(undefined, "HINT_BUTTON", undefined, var2, 25, "duration_none", "show", 128, 80, 128, 80);

  for(;;) {
    self waittill("trigger", var3);

    if(!is_valid_player(var3)) {
      continue;
    }

    if(!scripts\cp\loot_system::give_munition(self.loot_type, var3)) {
      continue;
    }

    self playsoundtoplayer("scavenger_pack_pickup", var3);
    self makeunusable();
    self hide();
    self.available = 0;
    return;
  }
}

function filterattachments(var0) {
  var1 = [];

  if(isDefined(var0)) {
    for(var2 = 0; var2 < var0.size; var2++) {
      var3 = var0[var2];

      if(var3 == "none") {
        continue;
      }

      var4 = 1;

      for(var5 = 0; var5 < var1.size; var5++) {
        if(var3 == var1[var5]) {
          var4 = 0;
          break;
        }

        var6 = scripts\cp\cp_weapon::attachmentsconflict(var3, var1[var5]);

        if(var6 != "") {
          var4 = 0;
          var1 = scripts\engine\utility::array_remove_index(var1, var5);
          var7 = [];
          var7 = strtok(var6, " ");

          foreach(var9 in var7) {
            var0 = scripts\engine\utility::array_insert(var0, var9, var2 + 1 + var10);
          }

          break;
        }
      }

      if(var4) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function attachmentiscosmetic(var0) {
  return isDefined(var0) && scripts\engine\utility::string_starts_with(var0, "cos_");
}

function attachmentmap_toextra(var0) {
  var1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var0])) {
    var1 = level.attachmentmap_uniquetoextra[var0];
  }

  return var1;
}

function getpassivestruct(var0) {
  if(!isDefined(level.passivemap[var0])) {
    return undefined;
  }

  var1 = level.passivemap[var0];
  return var1;
}

function map_check(var0) {
  if(!isDefined(var0)) {
    return 1;
  }

  switch (var0) {
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

function buildweaponname(var0, var1, var2, var3, var4) {
  if(isstrstart(var0, "iw7_")) {
    var2 = 0;
  }

  var5 = [];

  foreach(var7 in var1) {
    var5 = attachmentmap_tounique(var7, var0);
  }

  var9 = getrawbaseweaponname(var0);
  var10 = var0;
  var11 = var9 == "kbs" || var9 == "cheytac" || var9 == "m8" || var9 == "ripper" || var9 == "erad" || var9 == "ar57";

  if(var11) {
    var12 = 0;

    foreach(var7 in var5) {
      if(getattachmenttype(var7) == "rail") {
        var12 = 1;
        break;
      }
    }

    if(!var12) {
      var5 = var9 + "scope";
    }
  }

  if(var5.size > 0) {
    var15 = scripts\engine\utility::array_remove_duplicates(var5);
    var5 = scripts\engine\utility::alphabetize(var15);
  }

  foreach(var7 in var5) {
    var10 += "+" + var7;
  }

  if(issubstr(var10, "iw6") || issubstr(var10, "iw7")) {
    var10 = buildweaponnamecamo(var10, var2);

    if(var4 != "weapon_sniper" && isDefined(var3)) {
      var10 = buildweaponnamereticle(var10, var3);
    }
  } else if(!scripts\cp\cp_weapon::isvalidzombieweapon(var10 + "_mp")) {
    var10 = var0 + "_mp";
  } else {
    var10 = buildweaponnamecamo(var10, var2);
    var10 = buildweaponnamereticle(var10, var3);
    var10 += "_mp";
  }

  return var10;
}

function buildweaponnamevariantid(var0, var1) {
  if(!isDefined(var1) || var1 < 0) {
    return var0;
  }

  var0 += "+loot" + var1;
  return var0;
}

function isholidayweapon(var0, var1) {
  if(!isDefined(var1) || var1 < 0) {
    return false;
  }

  if(var1 == 6) {
    var2 = getweaponrootname(var0);
    return (var2 == "iw7_ripper" || var2 == "iw7_lmg03" || var2 == "iw7_ar57");
  }

  return false;
}

function ismark2weapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return var0 >= 32;
}

function isholidayweaponusingdefaultscope(var0, var1) {
  var2 = attachmentmap_tounique("scope", getweaponbasename(var0));
  return isDefined(var2) && scripts\engine\utility::array_contains(var1, var2);
}

function is_pap_camo(var0) {
  if(isDefined(level.pap_1_camo) && var0 == level.pap_1_camo) {
    return true;
  } else if(isDefined(level.pap_2_camo) && var0 == level.pap_2_camo) {
    return true;
  }

  return false;
}

function buildweaponnamecamo(var0, var1, var2) {
  if(!isDefined(var1)) {
    return var0;
  }

  if(var1 == "none") {
    return var0;
  }

  return var0 + "+camo|" + var1;
}

function getweaponqualitybyid(var0, var1) {
  if(!isDefined(var1) || var1 < 0) {
    return 0;
  }

  var2 = getweaponloottable(var0);
  var3 = int(tablelookup(var2, 0, var1, 4));
  return var3;
}

function buildweaponnamereticle(var0, var1) {
  if(!isDefined(var1)) {
    return var0;
  }

  var2 = int(tablelookup("mp/reticleTable.csv", 1, var1, 5));

  if(!isDefined(var2) || var2 == 0) {
    return var0;
  }

  var0 += "+scope" + var2;
  return var0;
}

function has_zombie_perk(var0) {
  if(!isDefined(self.zombies_perks)) {
    return false;
  }

  return istrue(self.zombies_perks[var0]);
}

function drawsphere(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = (1, 1, 1);
  }

  var4 = int(var2 * 20);

  for(var5 = 0; var5 < var4; var5++) {
    wait 0.05;
  }
}

function has_auto_revive() {
  return istrue(self.has_auto_revive) || istrue(self.c130_revive);
}

function set_alien_emissive(var0, var1) {
  var2 = self.maxemissive - self.defaultemissive;
  var3 = var1 * var2 + self.defaultemissive;
  self emissiveblend(var0, var3);
}

function get_adjusted_armor(var0, var1) {
  if(var0 + level.deployablebox_vest_rank[var1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var0 + level.deployablebox_vest_rank[var1];
}

function alien_mode_has(var0) {
  var0 = tolower(var0);

  if(!isDefined(level.alien_mode_feature)) {
    return 0;
  }

  if(!isDefined(level.alien_mode_feature[var0])) {
    return 0;
  }

  return level.alien_mode_feature[var0];
}

function enable_alien_scripted() {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
}

function is_normal_upright(var0) {
  var1 = (0, 0, 1);
  var2 = 0.85;
  return vectordot(var0, var1) > var2;
}

function get_synch_direction_list(var0) {
  if(!isDefined(self.synch_attack_setup)) {
    return [];
  }

  if(!isDefined(self.synch_attack_setup.synch_directions)) {
    return [];
  }

  if(!self.synch_attack_setup.type_specific) {
    return self.synch_attack_setup.synch_directions;
  }

  var1 = scripts\cp\cp_agent_utils::get_agent_type(var0);

  if(!isDefined(self.synch_attack_setup.synch_directions[var1])) {
    var2 = "Synch attack on " + self.synch_attack_setup.identifier + " doesn't handle type: " + var1;
  }

  return self.synch_attack_setup.synch_directions[var1];
}

function getrandomindex(var0) {
  var1 = 0;

  foreach(var3 in var0) {
    var1 += var3;
  }

  var5 = randomintrange(0, var1);
  var1 = 0;

  foreach(var3 in var0) {
    var1 += var3;

    if(var5 <= var1) {
      return var7;
    }
  }

  return 0;
}

function get_closest_living_player(var0, var1) {
  var2 = 1073741824;

  if(isDefined(var0)) {
    var2 = var0;
  }

  var3 = undefined;
  var4 = level.players;

  if(isDefined(var1)) {
    var4 = var1;
  }

  foreach(var6 in var4) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, var6)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var6)) {
      continue;
    }

    var7 = distancesquared(self.origin, var6.origin);

    if(var6 scripts\cp_mp\utility\player_utility::_isalive() && var7 < var2) {
      var3 = var6;
      var2 = var7;
    }
  }

  return var3;
}

function get_array_of_valid_players(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(is_valid_player(level.players[var3])) {
      var2 = level.players[var3];
    }
  }

  if(!isDefined(var0) || !var0) {
    return var2;
  }

  return scripts\engine\utility::get_array_of_closest(var1, var2);
}

function is_valid_player(var0, var1) {
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

  if(!isDefined(var0) && scripts\cp\cp_laststand::player_in_laststand(self)) {
    return false;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!istrue(var1) && (istrue(self.infreefall) || istrue(self.inparachute))) {
    return false;
  }

  return true;
}

function any_player_nearby(var0, var1) {
  foreach(var3 in level.players) {
    if(distancesquared(var3.origin, var0) < var1) {
      return true;
    }
  }

  return false;
}

function give_closest_player_nearby(var0, var1, var2) {
  var3 = [];

  foreach(var5 in level.players) {
    if(isDefined(var2) && var5.team != var2) {
      continue;
    }

    if(distancesquared(var5.origin, var0) < var1) {
      var3 = var5;
    }
  }

  if(var3.size > 0) {
    var7 = sortbydistance(var3, var0);
    return var7[0];
  }

  return undefined;
}

function are_all_players_nearby(var0, var1) {
  foreach(var3 in level.players) {
    if(distancesquared(var3.origin, var0) > var1) {
      return false;
    }

    wait 0.05;
  }

  return true;
}

function give_all_players_nearby(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(distancesquared(level.players[var3].origin, var0) < var1) {
      var2 = level.players[var3];
    }
  }

  return var2;
}

function player_pain_vo(var0) {
  self endon("disconnect");

  if(getdvarint("scr_no_player_pain_vo", 0) == 1) {
    return;
  }

  var1 = 5500;
  var2 = gettime();

  if(!isDefined(self.next_pain_vo_time)) {
    self.next_pain_vo_time = var2 + randomintrange(var1, var1 + 2000);
  } else if(var2 < self.next_pain_vo_time) {
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

  var3 = "injured_pain_vocal";

  if(isDefined(var0)) {
    if(isDefined(var0.agent_type)) {
      switch (var0.agent_type) {
        case "skater":
          var3 = "injured_pain_skater";
          break;
        case "ratking":
          var3 = scripts\engine\utility::random(["injured_pain_ratking1", "injured_pain_ratking2", "injured_pain_ratking3"]);
          break;
        default:
          var3 = "injured_pain_vocal";
          break;
      }
    }
  }

  scripts\cp\cp_vo::try_to_play_vo(var3, "zmb_comment_vo");
  self.next_pain_vo_time = var2 + randomintrange(var1, var1 + 1500);
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
  var0 = get_pain_breathing_sfx_alias(self);

  if(isDefined(var0)) {
    if(soundexists(var0)) {
      while(!above_pain_breathing_sfx_threshold(self) && !level.gameended) {
        if(!istrue(self.vo_system_playing_vo)) {
          playlocalsound_safe(var0);
        }

        wait 1.5;
      }
    }

    set_is_playing_pain_breathing_sfx(self, 0);
    return;
  }
}

function is_playing_pain_breathing_sfx(var0) {
  return istrue(var0.is_playing_pain_breathing_sfx);
}

function above_pain_breathing_sfx_threshold(var0) {
  var1 = 0.3;
  return var0.health / var0.maxhealth > var1;
}

function set_is_playing_pain_breathing_sfx(var0, var1) {
  var0.is_playing_pain_breathing_sfx = var1;
}

function get_pain_breathing_sfx_alias(var0) {
  if(!level.gameended) {
    if(var0.vo_prefix == "p1_") {
      return "p1_plr_pain";
    }

    if(var0.vo_prefix == "p2_") {
      return "p2_plr_pain";
    }

    if(var0.vo_prefix == "p3_") {
      return "p3_plr_pain";
    }

    if(var0.vo_prefix == "p4_") {
      return "p4_plr_pain";
    }

    if(var0.vo_prefix == "p5_") {
      return "p5_plr_pain";
    }

    return "p3_plr_pain";
  }
}

function playvoforpillage(var0) {
  var1 = var0.vo_prefix + "good_loot";

  if(scripts\cp\cp_vo::alias_2d_version_exists(var0, var1)) {
    playlocalsound_safe(var0, scripts\cp\cp_vo::get_alias_2d_version(var0, var1));
    return;
  }

  if(soundexists(var1)) {
    playlocalsound_safe(var0, var1);
    return;
  }
}

function deployable_box_onuse_message(var0) {
  var1 = "";

  if(isDefined(var0) && isDefined(var0.boxtype) && isDefined(level.boxsettings[var0.boxtype].eventstring)) {
    var1 = level.boxsettings[var0.boxtype].eventstring;
  }

  thread setlowermessage("deployable_use", var1, 3);
}

function is_goon(var0) {
  switch (var0) {
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;
    default:
      return 0;
  }
}

function mark_dangerous_nodes(var0, var1, var2) {}

function healthregeninit(var0) {
  level.healthregendisabled = var0;
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
    scripts\engine\utility::ref_143a5("damage", "health_perk_upgrade");

    if(!canregenhealth()) {
      continue;
    }

    var0 = scripts\cp\cp_laststand::gethealthcap();
    var1 = self.health / var0;

    if(var1 >= 1) {
      self.health = var0;
      continue;
    }

    thread healthregen(gettime(), var1);
    thread breathingmanager(gettime(), var1);
  }
}

function get_within_range(var0, var1, var2) {
  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    if(distance(var1[var4].origin, var0) <= var2) {
      var3 = var1[var4];
    }
  }

  return var3;
}

function healthregen(var0, var1) {
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

  var2 = spawnStruct();
  getregendata(var2);
  wait var2.activatetime;
  var3 = gettime();

  for(;;) {
    var4 = scripts\cp\cp_laststand::gethealthcap();
    var2 = spawnStruct();
    getregendata(var2);
    var1 = self.health / self.maxhealth;

    if(self.health < int(var4)) {
      var5 = int(self.health + var2.regenamount);

      if(var5 > var4) {
        var5 = var4;
      }

      self.health = var5;
    } else {
      break;
    }

    scripts\engine\utility::ref_143b9(var2.waittimebetweenregen, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level.playerinitinvulnerability)) {
    self[[level.playerinitinvulnerability]]();
  }

  resetattackerlist();
}

function breathingmanager(var0, var1) {
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

  self.breathingstoptime = var0 + 6000 * self.regenduration;
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

function getregendata(var0) {
  level.longregentime = 5000;
  level.healthoverlaycutoff = 0.2;
  level.invultime_preshield = 0.35;
  level.invultime_onshield = 0.5;
  level.invultime_postshield = 0.3;
  level.playerhealth_regularregendelay = 2400;
  level.worthydamageratio = 0.1;
  self.prestigehealthregennerfscalar = scripts\cp\perks\cp_prestige::prestige_getslowhealthregenscalar();
  var1 = 1;

  if(isDefined(self.perk_data)) {
    if(isDefined(self.perk_data["regen_time_scalar"])) {
      var1 = self.perk_data["regen_time_scalar"];
    } else {
      var1 = self.perk_data["health"].regen_time_scalar;
    }
  }

  if(self.prestigehealthregennerfscalar == 1) {
    if(is_consumable_active("faster_health_regen_upgrade")) {
      var0.activatetime = 0.45;
      var0.waittimebetweenregen = 0.045;
      var0.regenamount = 0.1;
      return;
    }

    var0.activatetime = 6;
    var0.waittimebetweenregen = 0.05;
    var0.regenamount = 6 * var1;
    return;
  }

  var0.activatetime = 6 * self.prestigehealthregennerfscalar;
  var0.waittimebetweenregen = 0.05 * self.prestigehealthregennerfscalar;
  var0.regenamount = 6;
}

function resetattackerlist(var0) {
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

  if(istrue(self.ref_12b72)) {
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

  var0 = self getentitynumber();
  var1 = 0;
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var0, "playerArmor", 0);

  for(;;) {
    scripts\engine\utility::ref_143a5("player_damaged", "enable_armor");

    if(!isDefined(self.bodyarmorhp)) {
      if(var1 > 0) {
        scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var0, "playerArmor", 0);
        var1 = 0;
      }

      continue;
    }

    if(var1 != self.bodyarmorhp) {
      var2 = int(self.bodyarmorhp);
      scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var0, "playerArmor", var1);
      var1 = self.bodyarmorhp;
    }
  }
}

function allow_secondary_offhand_weapons(var0) {
  if(var0) {
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
    self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);
    level notify("physSnd", self, var0, var1, var2, var3, var4, var5, var6, var7);
  }
}

function global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var0, var1, var2, var3, var4, var5, var6, var7, var8);

    if(isDefined(var0) && isDefined(var0.phys_sound_func)) {
      level thread[[var0.phys_sound_func]](var0, var1, var2, var3, var4, var5, var6, var7, var8);
    }
  }
}

function register_physics_collision_func(var0, var1) {
  var0.phys_sound_func = var1;
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

function ent_is_near_equipment(var0) {
  var1 = 16384;

  if(level.turrets.size) {
    var2 = sortbydistance(level.turrets, var0.origin);

    if(distance2dsquared(var2[0].origin, var0.origin) < var1) {
      return 1;
    }
  }

  if(isDefined(level.placed_crafted_traps) && level.placed_crafted_traps.size) {
    foreach(var4 in level.placed_crafted_traps) {
      if(!isDefined(var4)) {
        continue;
      }

      if(distance2dsquared(var4.origin, var0.origin) < var1) {
        return 1;
      }
    }
  }

  if(isDefined(level.near_equipment_func)) {
    return [[level.near_equipment_func]](var0);
  }

  return 0;
}

function set_crafted_inventory_item(var0, var1, var2) {
  if(isDefined(var2.current_crafted_inventory)) {
    var2.current_crafted_inventory = undefined;
  }

  var2.current_crafted_inventory = spawnStruct();
  var2.current_crafted_inventory.item = var0;
  var2.current_crafted_inventory.restore_func = var1;
}

function remove_crafted_item_from_inventory(var0) {
  var0.current_crafted_inventory = undefined;
}

function remove_crafted_item_from_dpad(var0, var1) {
  switch (var1) {
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

function add_crafted_item_to_dpad(var0, var1, var2) {
  switch (var1) {
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

function item_handleownerdisconnect(var0) {
  self endon("death");
  level endon("game_ended");
  self notify(var0);
  self endon(var0);
  self.owner waittill("disconnect");

  foreach(var2 in level.players) {
    if(is_valid_player(var2, 1)) {
      self.owner = var2;

      if(self.classname != "script_model") {
        self setsentryowner(self.owner);
      }

      break;
    }
  }

  thread item_handleownerdisconnect(var0);
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

function item_timeout(var0, var1, var2) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.lifespan)) {
    self.lifespan = var1;
  }

  if(isDefined(var0)) {
    self.lifespan = var0;
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

  if(isDefined(var2)) {
    self notify(var2);
    return;
  }

  self notify("death");
}

function item_oncarrierdeath(var0) {
  self endon("placed");
  self endon("death");
  var0 endon("disconnect");
  var1 = var0 scripts\engine\utility::ref_143ad("death", "last_stand");
  var0 notify("force_cancel_placement");
}

function item_oncarrierdisconnect(var0) {
  self endon("placed");
  self endon("death");
  var0 endon("last_stand");
  var0 waittill("disconnect");

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

function item_ongameended(var0) {
  self endon("placed");
  self endon("death");
  var0 endon("last_stand");
  level waittill("game_ended");
  self delete();
}

function should_be_affected_by_trap(var0, var1, var2) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  if(!isagent(var0)) {
    return false;
  }

  if(!isDefined(var0.agent_type)) {
    return false;
  }

  if(!isDefined(var0.isactive) || !var0.isactive) {
    return false;
  }

  if(!isDefined(var1) && isDefined(var0.entered_playspace) && !var0.entered_playspace) {
    return false;
  }

  if(istrue(var0.marked_for_death)) {
    return false;
  }

  if(!isDefined(var0.team)) {
    return false;
  }

  if(var0.agent_type == "zombie_brute" || var0.agent_type == "zombie_ghost" || var0.agent_type == "zombie_grey") {
    return false;
  }

  if(!istrue(var2) && istrue(var0.is_suicide_bomber)) {
    return false;
  }

  if(istrue(var0.is_coaster_zombie)) {
    return false;
  }

  return true;
}

function set_quest_icon(var0) {
  increment_num_of_quest_piece_completed();
  set_quest_icon_internal(var0);
}

function set_quest_icon_internal(var0) {
  setomnvarbit("zombie_quest_piece", var0, 1);
  setclientmatchdata("questPieces", "quest_piece_" + var0, 1);
}

function set_completed_quest_mark(var0) {
  setomnvarbit("zm_completed_quest_marks", var0, 1);
}

function increment_num_of_quest_piece_completed() {
  if(!isDefined(level.num_of_quest_pieces_completed)) {
    level.num_of_quest_pieces_completed = 0;
  }

  level.num_of_quest_pieces_completed++;

  if(level.num_of_quest_pieces_completed == level.cp_zmb_number_of_quest_pieces) {
    foreach(var1 in level.players) {
      var1 scripts\cp\cp_achievement::update_achievement("STICKER_COLLECTOR", 24);
    }

    return;
  }
}

function playplayerandnpcsounds(var0, var1, var2) {
  playlocalsound_safe(var0, var1);
  var0 playsoundtoteam(var2, "allies", var0);
  var0 playsoundtoteam(var2, "axis", var0);
}

function roundup(var0) {
  if(var0 - int(var0) >= 0.5) {
    return int(var0 + 1);
  }

  return int(var0);
}

function damage_over_time(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!should_apply_dot(var0)) {
    return;
  }

  var0 endon("death");

  if(!isDefined(var3)) {
    var3 = 600;
  }

  if(!isDefined(var2)) {
    var2 = 5;
  }

  if(!isDefined(var4)) {
    var4 = "MOD_UNKNOWN";
  }

  if(!isDefined(var5)) {
    var5 = "iw7_dot_zm";
  }

  if(isDefined(var7)) {
    setscriptablestateflag(var0, var0, var7, 1);

    if(isDefined(level.scriptablestatefunc)) {
      var0 thread[[level.scriptablestatefunc]](var0);
    }
  }

  var9 = 0;
  var10 = 6;
  var11 = var2 / var10;
  var12 = var3 / var10;

  for(var13 = 0; var13 < var10; var13++) {
    wait var11;

    if(isalive(var0)) {
      var0.flame_damage_time = gettime() + 500;

      if(var0.health - var12 <= 0) {
        if(isDefined(var8)) {
          level notify(var8);
        }
      }

      if(isDefined(var1)) {
        var0 dodamage(var12, var0.origin, var1, var1, var4, var5);
        continue;
      }

      var0 dodamage(var12, var0.origin, undefined, undefined, var4, var5);
    }
  }

  if(isDefined(var7)) {
    setscriptablestateflag(var0, var0, var7);
  }

  if(istrue(var0.marked_for_death)) {
    var0.marked_for_death = undefined;
  }

  if(istrue(var0.flame_damage_time)) {
    var0.flame_damage_time = undefined;
    return;
  }
}

function setscriptablestateflag(var0, var1, var2) {
  switch (var1) {
    case "combinedArcane":
    case "combinedarcane":
      if(istrue(var2)) {
        var0.is_afflicted = 1;
      } else {
        var0.is_afflicted = undefined;
      }

      break;
    case "burning":
      if(istrue(var2)) {
        var0.is_burning = var2;
      } else {
        var0.is_burning = undefined;
      }

      break;
    case "electrified":
      if(istrue(var2)) {
        var0.is_electrified = var2;
        var0.allowpain = 1;
        var0.stun_hit_time = gettime() + 3000;
      } else {
        var0.is_electrified = undefined;
        var0.allowpain = 0;
      }

      break;
    case "shocked":
      if(istrue(var2)) {
        var0.stunned = var2;
      } else {
        var0.stunned = undefined;
      }

      break;
    case "chemBurn":
    case "chemburn":
      if(istrue(var2)) {
        var0.is_chem_burning = 1;
      } else {
        var0.is_chem_burning = undefined;
      }

      break;
    default:
      break;
  }
}

function door_entitylessscriptable_togglelock(var0, var1, var2) {
  var3 = self;
  var4 = undefined;

  if(isDefined(var1)) {
    var5 = getentitylessscriptablearrayinradius(undefined, undefined, var1, 64);

    if(var5.size > 0) {
      var3 = undefined;

      if(var5.size == 1) {
        var3 = var5[0];
        var4 = 1;
      } else {
        var6 = var5.size;
        var7 = 9999999;

        for(var8 = 0; var8 < var6; var8++) {
          var9 = distancesquared(var5[var8].origin, var1);

          if(var9 < var7) {
            var7 = var9;
            var3 = var5[var8];
            var4 = 1;
          }
        }
      }
    }
  }

  if(isDefined(var1) && !istrue(var4)) {
    return;
  }

  if(istrue(var2)) {
    var3 setscriptablepartstate("door", "closed");
  }

  if(var0) {
    var3 scriptabledoorfreeze(1);
    return;
  }

  var3 scriptabledoorfreeze(0);
}

function should_apply_dot(var0) {
  if(isDefined(var0.agent_type) && (var0.agent_type == "c6" || var0.agent_type == "zombie_brute" || var0.agent_type == "zombie_grey" || var0.agent_type == "zombie_ghost")) {
    return false;
  }

  return true;
}

function update_trap_placement_internal(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var5 = var2.carriedtrapoffset;
  var6 = var2.carriedtrapangles;
  var7 = var2.placementradius;
  var8 = var2.placementheighttolerance;
  var9 = var2.modelplacement;
  var10 = var2.modelplacementfailed;
  var11 = var2.placecancelablestring;
  var12 = var2.placestring;
  var13 = var2.cannotplacestring;
  var0 endon("placed");
  var0 endon("death");
  var0.canbeplaced = 1;
  var14 = -1;

  for(;;) {
    var15 = self canplayerplacesentry(1, var7);
    var0.origin = var15["origin"];
    var0.angles = var15["angles"];
    var1.origin = var0.origin + var5;
    var1.angles = var0.angles + var6;

    if(isDefined(self.onslide)) {
      var0.canbeplaced = 0;
    } else {
      var0.canbeplaced = self isonground() && var15["result"] && abs(var0.origin[2] - self.origin[2]) < var8;
    }

    if(ent_is_near_equipment(var0)) {
      var0.canbeplaced = 0;
    }

    if(isDefined(var3) && isDefined(level.discotrap_active) && isDefined(level.dance_floor_volume)) {
      if(var0 istouching(level.dance_floor_volume)) {
        var0.canbeplaced = 0;
      }
    }

    if(isDefined(var15["entity"])) {
      var0.moving_platform = var15["entity"];
    } else {
      var0.moving_platform = undefined;
    }

    if(var0.canbeplaced != var14) {
      if(var0.canbeplaced) {
        if(!isDefined(var4)) {
          var1 setModel(var9);
        }

        if(isDefined(var0.firstplacement)) {
          self forceusehinton(var11);
        } else {
          self forceusehinton(var12);
        }
      } else {
        if(!isDefined(var4)) {
          var1 setModel(var10);
        }

        self forceusehinton(var13);
      }
    }

    var14 = var0.canbeplaced;
    wait 0.05;
  }
}

function usegrenadegesture(var0, var1) {
  if(cangiveandfireoffhand(var0, getvalidtakeweapon(var0)) && !var0 isgestureplaying()) {
    var0 setweaponammostock(var1, 1);
    var0 giveandfireoffhand(var1);
    return;
  }
}

function is_codxp() {
  return getDvar("scr_codxp", "") != "";
}

function too_close_to_other_interactions(var0) {
  var1 = sortbydistance(level.current_interaction_structs, var0);

  if(var1.size >= 1) {
    if(distancesquared(var1[0].origin, var0) < 9216) {
      return true;
    }
  }

  return false;
}

function getweapontoswitchbackto() {
  var0 = undefined;

  if(isDefined(self.last_weapon)) {
    var0 = self.last_weapon;
  } else {
    var0 = self getcurrentweapon();
  }

  var1 = 0;
  var2 = level.additional_laststand_weapon_exclusion;

  if(nullweapon(var0)) {
    var1 = 1;
  } else if(scripts\engine\utility::array_contains(var2, var0)) {
    var1 = 1;
  } else if(scripts\engine\utility::array_contains(var2, var0 getbaseweapon())) {
    var1 = 1;
  } else if(is_melee_weapon(var0, 1)) {
    var1 = 1;
  }

  if(var1) {
    var3 = self getweaponslistall();

    for(var4 = 0; var4 < var3.size; var4++) {
      if(nullweapon(var3[var4])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var2, var3[var4])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var2, var3[var4] getbaseweapon())) {
        continue;
      }

      if(is_melee_weapon(var3[var4], 1)) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isprimaryweapon(var3[var4])) {
        continue;
      }

      var1 = 0;
      var0 = var3[var4];
      break;
    }
  }

  if(var1) {
    var0 = getcompleteweaponname("iw7_fists_zm");

    if(!self hasweapon(var0)) {
      _giveweapon(var0, undefined, undefined, 1);
    }
  }

  return var0;
}

function getvalidtakeweapon(var0) {
  var1 = self getcurrentweapon();
  var2 = 0;
  var3 = level.additional_laststand_weapon_exclusion;

  if(isDefined(var0)) {
    var3 = scripts\engine\utility::array_combine(var0, var3);
  }

  if(nullweapon(var1)) {
    var2 = 1;
  } else if(isDefined(var1.inventorytype) && var1.inventorytype == "model_only") {
    var2 = 1;
  } else if(scripts\engine\utility::array_contains(var3, var1)) {
    var2 = 1;
  } else if(scripts\engine\utility::array_contains(var3, var1 getbaseweapon())) {
    var2 = 1;
  } else if(!turn_off_sniper_laser() && is_melee_weapon(var1, 1)) {
    var2 = 1;
  }

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var2) {
    var1 = self.last_valid_weapon;

    if(nullweapon(var1)) {
      var2 = 1;
    } else if(isDefined(var1.inventorytype) && var1.inventorytype == "model_only") {
      var2 = 1;
    } else if(scripts\engine\utility::array_contains(var3, var1)) {
      var2 = 1;
    } else if(scripts\engine\utility::array_contains(var3, var1 getbaseweapon())) {
      var2 = 1;
    } else if(is_melee_weapon(var1, 1)) {
      var2 = 1;
    } else {
      var2 = 0;
    }
  }

  if(var2) {
    var4 = self getweaponslistall();

    for(var5 = 0; var5 < var4.size; var5++) {
      if(nullweapon(var4[var5])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var3, var4[var5])) {
        continue;
      }

      if(scripts\engine\utility::array_contains(var3, var4[var5] getbaseweapon())) {
        continue;
      }

      if(is_melee_weapon(var4[var5], 1)) {
        continue;
      }

      if(isDefined(var4[var5].inventorytype) && var4[var5].inventorytype == "model_only") {
        continue;
      }

      var2 = 0;
      var1 = var4[var5];
      break;
    }
  }

  return var1;
}

function getcurrentcamoname(var0) {
  var1 = getweaponcamoname(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  switch (var1) {
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
      return var1;
  }

  return undefined;
}

function add_to_notify_queue(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(self.notify_queue)) {
    self.notify_queue = [];
  }

  if(!isDefined(self.notify_queue[var0])) {
    self.notify_queue[var0] = 0;
  } else {
    self.notify_queue[var0]++;
  }

  if(self.notify_queue[var0] > 0) {
    wait 0.05 * self.notify_queue[var0];
  }

  if(isDefined(self)) {
    self notify(var0, var1, var2, var3, var4, var5, var6, var7, var8);
  }

  waittillframeend();

  if(isDefined(self)) {
    if(isDefined(self.notify_queue[var0])) {
      self.notify_queue[var0]--;

      if(self.notify_queue[var0] < 1) {
        self.notify_queue[var0] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function take_fists_weapon(var0) {
  foreach(var2 in var0 getweaponslistall()) {
    if(issubstr(var2.basename, "iw7_fists")) {
      var0 takeweapon(var2);
    }
  }
}

function playlocalsound_safe(var0) {
  if(soundexists(var0)) {
    self playlocalsound(var0);
    return;
  }
}

function stoplocalsound_safe(var0) {
  if(soundexists(var0)) {
    self stoplocalsound(var0);
    return;
  }
}

function playsoundatpos_safe(var0, var1) {
  if(soundexists(var1)) {
    playsoundatpos(var0, var1);
    return;
  }
}

function playsoundtoplayer_safe(var0, var1) {
  if(soundexists(var0)) {
    var1 playsoundtoplayer(var0, var1);
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

function firegesturegrenade(var0, var1) {
  var2 = var0 getcurrentweapon();

  if(cangiveandfireoffhand(var2)) {
    var0 setweaponammostock(var1, 1);
    var0 giveandfireoffhand(var1);
    return;
  }
}

function cangiveandfireoffhand(var0) {
  if(!isDefined(var0)) {
    return 1;
  }

  if(isDefined(level.invalid_gesture_weapon)) {
    if(isDefined(level.invalid_gesture_weapon[getweaponbasename(var0)])) {
      return 0;
    }

    return 1;
  }

  return 1;
}

function play_interaction_gesture(var0) {
  if(!isDefined(var0)) {
    var0 = "iw7_powerlever_zm";
  }

  if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp") {
    thread firegesturegrenade(self, var0);
    return;
  }
}

function playerplaypickupanim(var0) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || isplayerads()) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = "iw8_ges_pickup";
  }

  var1 = getcompleteweaponname("none");
  var2 = self getcurrentprimaryweapon();

  if(isnullweapon(var2, var1)) {
    return;
  }

  if(self isgestureplaying(var0)) {
    self stopgestureviewmodel(var0, 0, 1);
    wait 0.05;
  }

  self forceplaygestureviewmodel(var0);
}

function playerplaytakephotoanim() {
  var0 = "intel_take_photo";
  var1 = self getcurrentweapon();
  var2 = getcompleteweaponname(var0);
  thread _freeze_until_phototaken();
  _giveweapon(var2);
  self switchtoweapon(var2);
  self setclientomnvar("ui_tablet_usb", 7);
  var3 = 3;
  wait var3;

  if(isPlayer(self)) {
    self takeweapon(var2);
    self switchtoweapon(var1);
    self setclientomnvar("ui_tablet_usb", 0);
    return true;
  }

  return false;
}

function _freeze_until_phototaken() {
  var0 = self getstance();
  _togglecellphoneallows(1);
  restrict_player_stance_to_this(1, var0);
  var1 = 1.6;
  wait var1;
  _togglecellphoneallows(0);
  restrict_player_stance_to_this(0, var0);
}

function _togglecellphoneallows(var0) {
  _freezelookcontrols(var0);
  scripts\common\utility::allow_movement(!var0);
  scripts\common\utility::allow_jump(!var0);
  scripts\common\utility::allow_usability(!var0);
  scripts\common\utility::allow_melee(!var0);
  scripts\common\utility::allow_offhand_weapons(!var0);
  scripts\common\utility::allow_weapon_switch(!var0);
  scripts\common\utility::allow_sprint(!var0);
}

function restrict_player_stance_to_this(var0, var1) {
  if(istrue(var0)) {
    _player_allowed_stances(1, var1);
    return;
  }

  _player_allowed_stances(0, var1);
}

function _player_allowed_stances(var0, var1) {
  if(istrue(var0)) {
    switch (var1) {
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

  switch (var1) {
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

function deactivatebrushmodel(var0, var1) {
  var0 notsolid();

  if(istrue(var1)) {
    var0 hide();
    return;
  }
}

function rankingenabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return level.onlinegame && !self.usingonlinedataoffline;
}

function debugprintline(var0) {}

function ent_createheadicon(var0, var1, var2, var3, var4) {
  if(!level.teambased) {
    return undefined;
  }

  if(!isDefined(var2)) {
    var2 = "allies";
  }

  var5 = deleteheadicon(var0);
  setheadiconenemyimage(var5, var3);
  addclienttoheadiconmask(var5, var1);
  setheadiconmaxdistance(var5, 0);
  setheadiconsnaptoedges(var5, 2250);
  setheadiconowner(var5, var2);

  if(isDefined(var4)) {
    setheadiconzoffset(var5, var4);
  }

  removeclientfromheadiconmask(var5, var2);
  hideheadiconfromplayersinmask(var5);
  thread watchheadicon(var0, var5);
  return var5;
}

function watchheadicon(var0, var1) {
  var0 endon("head_icon_deleted_" + var1);
  var0 waittill("death");
  thread ent_deleteheadicon(var0, var1);
}

function ent_deleteheadicon(var0, var1) {
  var0 notify("head_icon_deleted_" + var1);

  if(isDefined(var1) && var1 != -1) {
    setheadiconimage(var1);
    return;
  }
}

function getlastweapon() {
  return self.lastweaponobj;
}

function isnmlactive() {
  return istrue(level.nml_proto);
}

function addtostructarray(var0, var1, var2) {
  if(!isDefined(level.struct_class_names[var0][var1])) {
    level.struct_class_names[var0][var1] = [];
  }

  level.struct_class_names[var0][var1][level.struct_class_names[var0][var1].size] = var2;
}

function is_in_active_volume(var0) {
  if(!isDefined(level.active_spawn_volumes)) {
    return true;
  }

  var1 = sortbydistance(level.active_spawn_volumes, var0);

  foreach(var3 in var1) {
    if(ispointinvolume(var0, var3)) {
      return true;
    }
  }

  return false;
}

function give_max_ammo_to_player(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    var0 givemaxammo(var3);

    if(weaponmaxammo(var3) == weaponclipsize(var3)) {
      var0 setweaponammoclip(var3, weaponclipsize(var3));
    }
  }

  var5 = getarraykeys(var0.powers);

  foreach(var7 in var5) {
    if(var0.powers[var7].slot == "secondary") {
      continue;
    }

    thread recharge_power(var0);
  }
}

function recharge_power(var0) {
  var1 = self.powers[var0].slot;

  if(istrue(self.powers[var0].active)) {
    while(istrue(self.powers[var0].active)) {
      wait 0.05;
    }
  }

  if(istrue(self.powers[var0].updating)) {
    while(istrue(self.powers[var0].updating)) {
      wait 0.05;
    }
  }

  thread scripts\cp\cp_powers::givepower(var0, var1, undefined, undefined, undefined, undefined, 1);

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

function objective_update(var0, var1, var2, var3, var4, var5, var6, var7) {
  scripts\cp\cp_objectives::objective_update_internal(var0, var1, var2, var3, var4, var5, var6, var7);
}

function obj(var0) {
  if(!isDefined(level.objectives)) {
    level.objectives = [];
  }

  if(!isDefined(level.objectives[var0])) {
    level.objectives[var0] = level.objectives.size + 1;
  }

  return level.objectives[var0];
}

function objective_complete(var0) {
  scripts\cp\cp_objectives::delete_objective(var0);
  var1 = scripts\cp\cp_objectives::get_objective_type(var0);

  if(isDefined(var1)) {
    if(var1 == "global") {
      return;
    }
  }

  scripts\cp\cp_objectives::reset_objective_omnvars(var0);
}

function hint_prompt(var0, var1, var2) {
  if(istrue(var1)) {
    var3 = int(tablelookup("cp/cp_hints.csv", 1, var0, 0));
  } else {
    var3 = 0;
  }

  self setclientomnvar("zm_hint_index", var3);

  if(isDefined(var3)) {
    wait var3;
    self setclientomnvar("zm_hint_index", 0);
    return;
  }
}

function processed_tilt(var0) {
  var1 = tablelookup("cp/carry_items.csv", 1, var0, 0);

  if(isDefined(var1)) {
    return var1;
  }

  return 0;
}

function ref_13070(var0, var1) {
  var2 = processed_tilt(var1);
  var3 = 1;

  if(!isDefined(var0.get_track_setting) || var0.get_track_setting == 0) {
    var0.get_track_setting = int(var2);
  } else {
    var0.get_track_end_struct = int(var2);
    var3 = 2;
  }

  var4 = spawnStruct();
  var4.get_total_successful_vehicle_spawns_from_module = var1;
  var4.slot = var3;
  scripts\cp\cp_globallogic::elevator_model(var0);
  return var4;
}

function ref_12bc6(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var1 == 1) {
    var0.get_track_setting = 0;
  } else if(var1 == 2) {
    var0.get_track_end_struct = 0;
  }

  scripts\cp\cp_globallogic::elevator_model(var0);
}

function addentrytodevgui(var0) {
  thread addentrytodevgui_internal(level);
}

function addentrytodevgui_internal(var0) {
  if(!isDefined(var0)) {
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
  var1 = "";
  var2 = strtok(var0, "/");
  var3 = " ";
  var4 = 0;

  foreach(var6 in var2) {
    var7 = strtok(var6, " ");
    var8 = 1;
    var9 = var7.size;

    foreach(var11 in var7) {
      if(var8 < var9) {
        var1 = var1 + var11 + var3;
      } else {
        var1 += var11;
      }

      var8++;
    }

    var4++;

    if(var4 < var2.size) {
      var1 += "/";
    }
  }
}

function array_sort_by_handler(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = &defaultsortfunc;
  }

  var2 = istrue(var2);

  for(var3 = 0; var3 < var0.size - 1; var3++) {
    for(var4 = var3 + 1; var4 < var0.size; var4++) {
      if(var2) {
        if(var0[var4][[var1]]() > var0[var3][[var1]]()) {
          var5 = var0[var4];
          var0 = var0[var3];
          var0 = var5;
        }

        continue;
      }

      if(var0[var4][[var1]]() < var0[var3][[var1]]()) {
        var5 = var0[var4];
        var0 = var0[var3];
        var0 = var5;
      }
    }
  }

  return var0;
}

function array_compare(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(var4 != var3) {
      return false;
    }
  }

  return true;
}

function defaultsortfunc(var0, var1) {
  return randomint(100);
}

function set_segmented_health_regen_parameters(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6.max_health_cap = var0 / 100;
  var6.min_health_cap = var1 / 100;
  var6.segment_size = var2 / 100;
  var6.pre_regen_wait = var3;
  var6.per_regen_amount = var4 / 100;
  var6.between_regen_wait = var5;
  level.segmented_health_regen_parameters = var6;
}

function segmented_health_regen(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("one_instance_of_segmented_health");
  var0 endon("one_instance_of_segmented_health");
  var0 waittill("spawned_player");
  var1 = level.segmented_health_regen_parameters;
  var0.max_health_cap = int(var0.maxhealth * var1.max_health_cap);
  var0.min_health_cap = int(var0.maxhealth * var1.min_health_cap);
  var0.segment_size = int(var0.maxhealth * var1.segment_size);
  var0.pre_regen_wait = var1.pre_regen_wait;
  var0.per_regen_amount = int(var0.maxhealth * var1.per_regen_amount);
  var0.between_regen_wait = var1.between_regen_wait;
  set_current_health_regen_segment(var0, var0.max_health_cap);

  for(;;) {
    var0 scripts\engine\utility::ref_143ad("damage", "revive");
    update_current_health_regen_segment(var0);

    if(!can_do_segmented_health_regen(var0)) {
      continue;
    }

    thread segmented_health_regen_internal(var0);
  }
}

function segmented_health_regen_internal(var0) {
  var0 notify("segmented_health_regen_internal");
  level endon("game_ended");
  var0 endon("segmented_health_regen_internal");
  var0 endon("disconnect");
  var0 endon("damage");
  var0 endon("last_stand");
  wait var0.pre_regen_wait;

  for(;;) {
    var0.health = int(min(int(min(var0.health + var0.per_regen_amount, var0.current_health_regen_segment_ceiling)), var0.maxhealth));

    if(var0.health == var0.current_health_regen_segment_ceiling) {
      return;
    }

    wait var0.between_regen_wait;
  }
}

function set_current_health_regen_segment(var0, var1) {
  var0.current_health_regen_segment_ceiling = int(var1);
  var0.current_health_regen_segment_floor = int(var1 - var0.segment_size);
}

function update_current_health_regen_segment(var0) {
  if(var0.current_health_regen_segment_ceiling == var0.min_health_cap) {
    return;
  }

  if(var0.health < var0.current_health_regen_segment_floor) {
    set_current_health_regen_segment(var0, find_new_health_regen_segment_ceiling(var0));
    return;
  }
}

function find_new_health_regen_segment_ceiling(var0) {
  var1 = int((var0.max_health_cap - var0.min_health_cap) / var0.segment_size);

  for(var2 = 0; var2 <= var1 + 1; var2++) {
    var3 = var0.min_health_cap + var2 * var0.segment_size;

    if(var3 >= var0.health) {
      return int(min(var3, var0.maxhealth));
    }
  }
}

function can_do_segmented_health_regen(var0) {
  if(is_segmented_health_regen_disabled(var0)) {
    return false;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(var0)) {
    return false;
  }

  return true;
}

function is_segmented_health_regen_disabled(var0) {
  return istrue(var0.segmented_health_regen_disabled);
}

function disable_segmented_health_regen(var0) {
  var0.segmented_health_regen_disabled = 1;
}

function enable_segmented_health_regen(var0) {
  var0.segmented_health_regen_disabled = 0;
}

function is_friendly_damage(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(var1.team) && var1.team == var0.team) {
      return true;
    }

    if(isDefined(var1.owner) && isDefined(var1.owner.team) && var1.owner.team == var0.team) {
      return true;
    }
  }

  return false;
}

function draw_debug_rectangle(var0, var1) {
  var2 = var0[0];
  var3 = var1[0];
  var4 = var0[1];
  var5 = var1[1];
  var6 = max(var0[2], var1[2]);
  var7 = (var2, var5, var6);
  var8 = (var3, var4, var6);
}

function vehicle_createhealthbar(var0) {
  var1 = spawn("script_model", var0.origin);
  var2 = var0 gettagorigin("tag_origin", 1);

  if(isDefined(var2)) {
    var1 linkTo(var0, "tag_origin", (0, 0, 190), (0, 0, 0));
  } else {
    var1 linkTo(var0);
  }

  var3 = vehicle_gethealthbarid();

  if(!isDefined(var3)) {
    return;
  }

  var0.healthbarid = var3;
  var4 = 1;

  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  level.healthbars[var0.healthbarid] = var1;
  setomnvar("ui_ingame_light_tank_ent_" + var0.healthbarid, var1);
  setomnvar("ui_ingame_light_tank_team_" + var0.healthbarid, var4);
  setomnvar("ui_ingame_light_tank_health_" + var0.healthbarid, 1);
}

function vehicle_gethealthbarid() {
  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  var0 = undefined;

  for(var1 = 0; var1 < 7; var1++) {
    if(!isDefined(level.healthbars[var1])) {
      var0 = var1;
      break;
    }
  }

  return var0;
}

function vehicle_freehealthbarui() {
  if(isDefined(self.healthbarid)) {
    var0 = level.healthbars[self.healthbarid];
    var0 delete();
    setomnvar("ui_ingame_light_tank_ent_" + self.healthbarid, undefined);
    setomnvar("ui_ingame_light_tank_health_" + self.healthbarid, 0);
    setomnvar("ui_ingame_light_tank_team_" + self.healthbarid, 0);
    level.healthbars[self.healthbarid] = undefined;
    self.healthbarid = undefined;
    return;
  }
}

function vehile_updatehealthbar(var0) {
  if(isDefined(self.healthbarid)) {
    setomnvar("ui_ingame_light_tank_health_" + self.healthbarid, var0);
    return;
  }
}

function create_waypoint(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var5)) {
    var5 = 1;
  }

  var6 = undefined;

  if(var2 != "all") {
    var6 = newteamhudelem(var2);
  } else {
    var6 = newhudelem();
  }

  var6.id = var0;
  var6.x = var1[0];
  var6.y = var1[1];
  var6.z = var1[2];
  var6.team = var2;
  var6.isflashing = 0;
  var6.isshown = 1;

  if(issplitscreen()) {
    var6 setshader(var3, 8, 8);
  } else {
    var6 setshader(var3, 15, 15);
  }

  var6 setwaypoint(0, 1, 1);

  if(isDefined(var4)) {
    var6.alpha = var4;
  } else {
    var6.alpha = 0.75;
  }

  var6.basealpha = var6.alpha;
  return var6;
}

function waypoint_delete(var0) {
  var0 destroy();
}

function _freezecontrols(var0, var1, var2) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(var0) {
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(var1)) {
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

function _freezelookcontrols(var0, var1) {
  if(!isDefined(self.pers)) {
    return;
  }

  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(var0) {
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(var1)) {
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

function _setdof_internal(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(self)) {
    return;
  }

  var0 = max(var0, 0);
  var1 = clamp(var1, 1, 9994);
  var2 = clamp(var2, 2, 9998);
  var3 = clamp(var3, 3, 9999);

  if(var2 > 9994) {
    var5 = 0;
  }

  self setdepthoffield(var0, var1, var2, var3, var4, var5);
}

function setdof_dynamic() {
  self endon("disconnect");
  self endon("death");
  setdof_default();

  if(isai(self)) {
    return;
  }

  var0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var1 = physics_createcontents(var0);
  var2 = ["physicscontents_player"];
  var3 = physics_createcontents(var2);
  var4 = 1;
  var5 = 1;
  var6 = cos(27);
  var7 = 1;
  var8 = 0;
  var9 = [];
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
  var0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var1 = physics_createcontents(var0);
  var2 = vectorNormalize(self.origin - self.lastkilledby.origin);
  var3 = self.origin + (0, 0, 42);
  var4 = var3 + var2 * 120;
  var5 = scripts\engine\trace::sphere_trace(var3, var4, 2, self, var1, 0);
  var6 = var5["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    var7 = distance(var6, self.lastkilledby.origin);
    var8 = 0;
    var9 = max(var7 - 12, 1);
    var10 = var7 + 12;
    var11 = var10 + 50;
    var12 = 8;
    var13 = 4.5;
    _setdof_internal(var8, var9, var10, var11, var12, var13);
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

function draw_line_until_endons(var0, var1, var2, var3, var4, var5) {
  self endon("death");

  if(isDefined(var4)) {
    if(isarray(var4)) {
      foreach(var7 in var4) {
        self endon(var7);
      }
    } else {
      self endon(var4);
    }
  }

  if(!isDefined(var5)) {
    var5 = var0 + (0, 0, 256);
  }

  for(;;) {
    waitframe();
  }
}

function play_sound_on_tag(var0, var1) {
  if(isDefined(var1)) {
    playsoundatpos(self gettagorigin(var1), var0);
    return;
  }

  playsoundatpos(self.origin, var0);
}

function get_point_in_local_ent_space(var0, var1) {
  var2 = var0.origin;
  var3 = anglestoup(var0.angles);
  var4 = anglestoleft(var0.angles);
  var5 = anglesToForward(var0.angles);
  var6 = var1[0] * var5[0] + var1[1] * var4[0] + var1[2] * var3[0] + var2[0];
  var7 = var1[0] * var5[1] + var1[1] * var4[1] + var1[2] * var3[1] + var2[1];
  var8 = var1[0] * var5[2] + var1[1] * var4[2] + var1[2] * var3[2] + var2[2];
  var9 = (var6, var7, var8);
  return var9;
}

function _scriptnoteworthycheck(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(!isDefined(var0.script_noteworthy)) {
    return false;
  }

  if(var0.script_noteworthy != var1) {
    return false;
  }

  return true;
}

function show_self_pressed_buttons() {
  for(;;) {
    var0 = "";

    if(self buttonPressed("BUTTON_Y")) {
      var0 += ",y";
    }

    if(self buttonPressed("BUTTON_BACK")) {
      var0 += ",guide";
    }

    if(self stancebuttonPressed()) {
      var0 += ",stance";
    }

    if(self useButtonPressed()) {
      var0 += ",use";
    }

    if(self fragButtonPressed()) {
      var0 += ",frag";
    }

    if(self meleeButtonPressed()) {
      var0 += ",melee";
    }

    if(self jumpbuttonPressed()) {
      var0 += ",jump";
    }

    if(self attackButtonPressed()) {
      var0 += ",attack";
    }

    if(self secondaryoffhandbuttonPressed()) {
      var0 += ",secondary";
    }

    if(self adsButtonPressed()) {
      var0 += ",ADS";
    }

    self iprintln(var0);
    wait 0.05;
  }
}

function remove_cursor_hint() {
  var0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var0 = self.cursor_hint_ent;
    var0 scripts\engine\utility::delaycall(0.5, &delete);
  }

  if(isDefined(var0) && !isstruct(var0)) {
    var0 makeunusable();
  }

  if(isDefined(self)) {
    notify_delay("hint_destroyed", 0.05);
    return;
  }
}

function notify_delay(var0, var1) {
  self endon("death");

  if(var1 > 0) {
    wait var1;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(var0);
}

function create_cursor_hint(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = self;

  if(isstruct(var14) || var14.classname == "script_origin" || isDefined(var1)) {
    var14 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var14;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var1)) {
    var15 = "tag_origin";

    if(isDefined(var0)) {
      var15 = var0;
      var14.origin = self gettagorigin(var15);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var15)) {
      var14 linkTo(self, var15, var1, (0, 0, 0));
    } else if(isDefined(var0)) {
      var14 linkTo(self, var15, var1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var14.origin += rotatevector(var1, self.angles);

      if(isent(self)) {
        var14 linkTo(self);
      }
    } else {
      var14.origin += var1;

      if(isent(self)) {
        var14 linkTo(self);
      }
    }
  } else if(isDefined(var0)) {
    var14 sethinttag(var0);
  }

  if(isDefined(var8) && var8) {
    var14 setCursorHint("HINT_NOICON");
  } else {
    var14 setCursorHint("HINT_BUTTON");
  }

  if(isDefined(var2)) {
    var14 setHintString(var2);
  }

  var16 = 360;

  if(isDefined(var3)) {
    var16 = var3;
  }

  var14 sethintdisplayfov(var16);
  var17 = 65;

  if(isDefined(var13)) {
    var17 = var13;
  }

  var14 setusefov(var17);
  var18 = 500;

  if(isDefined(var4)) {
    var18 = var4;
  }

  var14 sethintdisplayrange(var18);
  var19 = 80;

  if(isDefined(var5)) {
    var19 = var5;
  }

  var14 setuserange(var19);

  if(isDefined(var6) && var6) {
    var14 sethintonobstruction("show");
  } else {
    var14 sethintonobstruction("hide");
  }

  if(isDefined(var7) && var7) {
    var14 sethintrequiresmashing(var7);
  }

  if(!isDefined(var10)) {
    var10 = "duration_short";
  }

  var14 setuseholdduration(var10);

  if(var10 == "duration_medium" || var10 == "duration_long") {
    var14 sethintrequiresholding(1);
  }

  thread hint_delete_on_trigger();

  if(isDefined(var9)) {
    var14 sethinticon(var9);
  }

  if(isDefined(var11)) {
    var14 setusecommand(var11);
  }

  if(isDefined(var12)) {
    var14 sethintlockplayermovement(1);
  } else {
    var14 sethintlockplayermovement(0);
  }

  var14 makeusable();
  return var14;
}

function hint_ent_notify_trigger() {
  self endon("death");
  self endon("hint_destroyed");
  self.cursor_hint_ent waittill("trigger", var0);
  self notify("trigger", var0);
}

function hint_delete_on_trigger() {
  self endon("hint_destroyed");
  var0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var0 = self.cursor_hint_ent;
  }

  hint_delete_on_trigger_waittill(var0);
  thread remove_cursor_hint();
}

function hint_delete_on_trigger_waittill(var0) {
  self endon("entitydeleted");
  var0 waittill("trigger");
}

function outline_fade_alpha_for_index(var0, var1, var2) {
  thread outline_fade_alpha_for_index_internal(var0, var1, var2);
}

function outline_fade_alpha_for_index_internal(var0, var1, var2) {
  level notify("hud_outline_alpha_fade_" + var0);
  level endon("hud_outline_alpha_fade_" + var0);
  var0++;
  var3 = "cg_hud_outline_colors_" + var0;
  var4 = getDvar(var3);
  var4 = strtok(var4, " ");
  var5 = var4[0] + " " + var4[1] + " " + var4[2] + " ";
  var6 = float(var4[3]);
  var7 = var1 - var6;
  var8 = 0.05;
  var9 = int(var2 / var8);

  if(var9 > 0) {
    var10 = var7 / var9;

    while(var9) {
      var6 += var10;
      var6 = clamp(var6, 0, 1);
      setsaveddvar(var3, var5 + var6);
      wait var8;
      var9--;
    }
  }

  setsaveddvar(var3, var5 + var1);
}

function add_wait(var0, var1, var2, var3) {
  init_waits();
  var4 = spawnStruct();
  var4.caller = self;
  var4.func = var0;
  var4.parms = [];

  if(isDefined(var1)) {
    var4.parms[var4.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var4.parms[var4.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var4.parms[var4.parms.size] = var3;
  }

  if(!isDefined(level.waits.wait_any_func_array)) {
    level.waits.wait_any_func_array = [var4];
    return;
  }

  level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = var4;
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

  for(var0 = 0; var0 < 20; var0++) {
    waittillframeend();
  }
}

function do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

function do_wait(var0) {
  init_waits();

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = spawnStruct();
  var2 = level.waits.wait_any_func_array;
  var3 = level.waits.do_wait_endons_array;
  var4 = level.waits.run_func_after_wait_array;
  var5 = level.waits.run_call_after_wait_array;
  var6 = level.waits.run_noself_call_after_wait_array;
  var7 = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  var1.count = var2.size;
  var1 scripts\engine\utility::array_levelthread(var2, &waittill_func_ends, var3);
  thread do_abort(var1);
  var1 endon("any_funcs_aborted");

  for(;;) {
    var1 waittill("func_ended");
  }

  LOC_000000f7:
    var1 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var4, &exec_func, []);
  scripts\engine\utility::array_levelthread(var5, &exec_call);
  scripts\engine\utility::array_levelthread(var6, &exec_call_noself);
}

function exec_call(var0) {
  if(var0.parms.size == 0) {
    var0.caller builtin[[var0.func]]();
  } else if(var0.parms.size == 1) {
    var0.caller builtin[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function exec_call_noself(var0) {
  if(var0.parms.size == 0) {
    builtin[[var0.func]]();
  } else if(var0.parms.size == 1) {
    builtin[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function exec_func(var0, var1) {
  if(!isDefined(var0.caller)) {
    return;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var1[var2].caller endon(var1[var2].ender);
  }

  if(var0.parms.size == 0) {
    var0.caller[[var0.func]]();
  } else if(var0.parms.size == 1) {
    var0.caller[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function do_abort(var0) {
  self endon("all_funcs_ended");

  if(!var0.size) {
    return;
  }

  var1 = 0;
  self.abort_count = var0.size;
  var2 = [];
  scripts\engine\utility::array_levelthread(var0, &waittill_abort_func_ends, var2);

  for(;;) {
    if(self.abort_count <= var1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

function waittill_abort_func_ends(var0, var1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var0, var1);
  self.abort_count--;
  self notify("abort_func_ended");
}

function waittill_func_ends(var0, var1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var0, var1);
  self.count--;
  self notify("func_ended");
}

function waittill_msg(var0) {
  self waittill(var0);
}

function create_client_overlay(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = newclienthudelem(var2);
  } else {
    var3 = newhudelem();
  }

  var3.x = 0;
  var3.y = 0;
  var3 setshader(var1, 640, 480);
  var3.alignx = "left";
  var3.aligny = "top";
  var3.sort = 1;
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.alpha = var2;
  var3.foreground = 1;
  return var3;
}

function createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = undefined;

  if(isDefined(var11)) {
    var12 = var11;
  } else {
    var12 = spawn("script_model", var0);
  }

  sethintobject(var12, undefined, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

  if(!isDefined(var4)) {
    var12 setusepriority(0);
  }

  if(!isDefined(var11)) {
    return var12;
  }
}

function clearhintobject(var0) {}

function get_actual_time_from_civil(var0, var1, var2) {
  level endon("game_ended");

  if(isDefined(var1)) {
    var3 = var1;
  } else {
    var3 = getsystemtime();

    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings) {
      var3 += 3600;
    }
  }

  if(isDefined(var1)) {
    var3 -= 3600 * var1;
  }

  var4 = 1970;
  var5 = floor(var3 / 31536000);

  if(var5 != 0) {
    var6 = floor((var5 + 2) / 4);
  } else {
    var6 = 0;
  }

  var4 -= var6 * 31536000;
  var4 -= var6 * 86400;
  var5 += var6;

  if(!is_divisible_by(var5, 4)) {
    var7 = floor(var6 / 4);
    var8 = var6 / 4;
    var9 = var8 - var7;

    if(var9 >= 0.75) {
      var10 = 1;
    } else {
      var10 = 0;
    }
  } else {
    var10 = 0;
  }

  if(var5 != 0) {
    var11 = floor(var5 / 86400);
    var5 -= var11 * 86400;
  } else {
    var11 = 0;
  }

  if(var6 != 0) {
    var12 = floor(var6 / 3600);
    var6 -= var12 * 3600;
  } else {
    var12 = 0;
  }

  if(var6 != 0) {
    var13 = floor(var6 / 60);
    var6 -= var13 * 60;
  } else {
    var13 = 0;
  }

  var14 = determine_correct_month(var12 + 1, var12);
  GscBinSkip0(0x2e, "year", var10);
}

function is_daylight_savings(var0, var1, var2) {
  var3 = 0;

  if(var0["month_string"] == "March" && var0["year"] == 2017) {
    var3 = 1;
  } else if(var0["month_string"] == "December" || var0["month_string"] == "January" || var0["month_string"] == "February") {
    var3 = 0;
  } else if(var0["month_string"] != "March" && var0["month_string"] != "April") {
    var3 = 1;
  } else if(var0["month_string"] == "March" && var0["days"] >= 14) {
    var3 = 1;
  } else if(var0["month_string"] == "November" && var0["days"] <= 6) {
    var3 = 0;
  } else {
    var3 = 0;
  }

  if(var3) {
    level.isdaylightsavings = 1;
    var0 = get_actual_time_from_civil(var1, var2, 1);
  } else {
    level.isdaylightsavings = 0;
  }

  return var0;
}

function does_day_fit_in_current_month(var0, var1, var2) {
  var3 = 30;

  switch (var1) {
    case "January":
      var3 = 31;
      break;
    case "February":
      if(var2) {
        var3 = 29;
      } else {
        var3 = 28;
      }

      break;
    case "March":
      var3 = 31;
      break;
    case "April":
      var3 = 30;
      break;
    case "May":
      var3 = 31;
      break;
    case "June":
      var3 = 30;
      break;
    case "July":
      var3 = 31;
      break;
    case "August":
      var3 = 31;
      break;
    case "September":
      var3 = 30;
      break;
    case "October":
      var3 = 31;
      break;
    case "November":
      var3 = 30;
      break;
    case "December":
      var3 = 31;
      break;
    default:
      break;
  }

  if(var0 > var3) {
    return 1;
  }

  return 0;
}

function determine_correct_month(var0, var1) {
  var2 = [];
  var2["month"] = undefined;
  var2["month_string"] = undefined;
  var2["days"] = undefined;
  var3 = int(istrue(var1));

  if(var0 <= 31) {
    var2 = 1;
    var2 = "January";
    var2 = var0;
    return var2;
  }

  if(var0 <= 59 + var3) {
    var2 = 2;
    var2 = "February";
    var2 = var0 - 31;
    return var2;
  }

  if(var0 <= 90 + var3) {
    var2 = 3;
    var2 = "March";
    var2 = var0 - 59 + var3;
    return var2;
  }

  if(var0 <= 120 + var3) {
    var2 = 4;
    var2 = "April";
    var2 = var0 - 90 + var3;
    return var2;
  }

  if(var0 <= 151 + var3) {
    var2 = 5;
    var2 = "May";
    var2 = var0 - 120 + var3;
    return var2;
  }

  if(var0 <= 182 + var3) {
    var2 = 6;
    var2 = "June";
    var2 = var0 - 151 + var3;
    return var2;
  }

  if(var0 <= 212 + var3) {
    var2 = 7;
    var2 = "July";
    var2 = var0 - 182 + var3;
    return var2;
  }

  if(var0 <= 243 + var3) {
    var2 = 8;
    var2 = "August";
    var2 = var0 - 212 + var3;
    return var2;
  }

  if(var0 <= 273 + var3) {
    var2 = 9;
    var2 = "September";
    var2 = var0 - 243 + var3;
    return var2;
  }

  if(var0 <= 304 + var3) {
    var2 = 10;
    var2 = "Octobor";
    var2 = var0 - 273 + var3;
    return var2;
  }

  if(var0 <= 335 + var3) {
    var2 = 11;
    var2 = "November";
    var2 = var0 - 304 + var3;
    return var2;
  }

  var2 = 12;
  var2 = "December";
  var2 = var0 - 335 + var3;
  return var2;
}

function set_friendlyfire_warnings(var0) {
  if(var0) {
    self.friendlyfire_warnings_disable = undefined;
    return;
  }

  self.friendlyfire_warnings_disable = 1;
}

function battlechatter_on(var0) {
  thread battlechatter_on_thread(var0);
}

function battlechatter_on_thread(var0) {
  level endon("battlechatter_off_thread");
  scripts\cp\cp_battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized)) {
    waitframe();
  }

  anim.bcs_enabled = 1;
  wait 1.5;
  jumpiffalse(isDefined(var0)) LOC_00000042;
  scripts\cp\cp_battlechatter::set_battlechatter_variable(var0, 1);
  var1 = getaiarray(var0);
  goto LOC_00000077;
}

function set_battlechatter(var0) {
  if(!isDefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }

  if(istrue(self.battlechatter_removed)) {
    return;
  }

  if(var0) {
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

function player_looking_at(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 0.8;
  }

  var4 = get_player_from_self();
  var5 = var4 getEye();
  var6 = vectortoangles(var0 - var5);
  var7 = anglesToForward(var6);
  var8 = var4 getplayerangles();
  var9 = anglesToForward(var8);
  var10 = vectordot(var7, var9);

  if(var10 < var1) {
    return 0;
  }

  if(isDefined(var2)) {
    return 1;
  }

  return scripts\engine\trace::ray_trace_detail_passed(var0, var5, var3, scripts\engine\trace::create_default_contents(1));
}

function is_divisible_by(var0, var1) {
  if(floor(var0 / var1) > var0 / var1) {
    return 1;
  }

  return 0;
}

function array_merge(var0, var1) {
  if(var0.size == 0) {
    return var1;
  }

  if(var1.size == 0) {
    return var0;
  }

  var2 = var0;

  foreach(var4 in var1) {
    var5 = 0;

    foreach(var7 in var0) {
      if(var7 == var4) {
        var5 = 1;
        break;
      }
    }

    if(var5) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function create_sunflare_setting(var0) {
  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }

  var1 = spawnStruct();
  var1.name = var0;
  level.sunflare_settings[var0] = var1;
  return var1;
}

function vectortoanglessafe(var0, var1) {
  var2 = vectorcross(var0, var1);
  var1 = vectorcross(var2, var0);
  var3 = axistoangles(var0, var2, var1);
  return var3;
}

function createuseent(var0) {
  var1 = spawn("script_origin", var0);
  var1.curprogress = 0;
  var1.usetime = 0;
  var1.userate = 8000;
  var1.inuse = 0;
  return var1;
}

function getinteractionbynoteworthy(var0) {
  foreach(var2 in level.current_interaction_structs) {
    if(var2.script_noteworthy == var0) {
      return var2;
    }
  }

  return undefined;
}

function quicksort(var0, var1) {
  return quicksortmid(var0, 0, var0.size - 1, var1);
}

function quicksortmid(var0, var1, var2, var3) {
  var4 = var1;
  var5 = var2;

  if(!isDefined(var3)) {
    var3 = &quicksort_compare;
  }

  if(var2 - var1 >= 1) {
    var6 = var0[var1];

    while(var5 > var4) {
      while([[var3]](var0[var4].patrolscore, var6.patrolscore) && var4 <= var2 && var5 > var4) {
        var4++;
      }

      while(![[var3]](var0[var5].patrolscore, var6.patrolscore) && var5 >= var1 && var5 >= var4) {
        var5--;
      }

      if(var5 > var4) {
        var0 = swap(var0, var4, var5);
      }
    }

    var0 = swap(var0, var1, var5);
    var0 = quicksortmid(var0, var1, var5 - 1, var3);
    var0 = quicksortmid(var0, var5 + 1, var2, var3);
  } else {
    return var1;
  }

  return var0;
}

function quicksort_compare(var0, var1) {
  return var0 <= var1;
}

function swap(var0, var1, var2) {
  var3 = var0[var1];
  var0 = var0[var2];
  var0 = var3;
  return var0;
}

function hideminimap(var0) {
  if(!isDefined(self.minimapstatetracker)) {
    self.minimapstatetracker = 0;
  }

  var1 = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0) {
    self.minimapstatetracker = 0;
  }

  if(istrue(var0) || self.minimapstatetracker == 0 && var1 > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var0)) {
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

  var0 = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && var0 < self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 0);
    return;
  }
}

function getplayerdataloadoutgroup() {
  if(getdvarint("LPSPMQSNPQ")) {
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

function allow_change_stance(var0) {
  var1 = self getstance();

  switch (var1) {
    case "stand":
      scripts\common\utility::allow_crouch(var0);
      scripts\common\utility::allow_prone(var0);
      break;
    case "crouch":
      scripts\common\utility::allow_stand(var0);
      scripts\common\utility::allow_prone(var0);
      break;
    case "prone":
      scripts\common\utility::allow_stand(var0);
      scripts\common\utility::allow_crouch(var0);
      break;
  }
}

function getplayersinteam(var0) {
  if(!isDefined(var0)) {
    var0 = "allies";
  }

  var1 = [];

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      var1 = var3;
    }
  }

  return var1;
}

function teleportallplayersinteamtostructs(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var1, "targetname");

  if(!isDefined(var3) || var3.size < 4) {
    return;
  }

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var4 = 0;

  foreach(var6 in getplayersinteam(var0)) {
    var3[var4].angles = scripts\engine\utility::ter_op(isDefined(var3[var4].angles), var3[var4].angles, (0, 0, 0));
    var6 setOrigin(var3[var4].origin);
    var6 setplayerangles(var3[var4].angles);
    var6 dontinterpolate();
    var4++;
  }

  if(!istrue(var2)) {
    return;
  }

  thread thread_teleportplayertoteamstructs_latejoin(level, var0);
}

function thread_teleportplayertoteamstructs_latejoin(var0, var1) {
  level endon("game_ended");
  level notify("waiting_for_team_teleports_" + var0);
  level endon("waiting_for_team_teleports_" + var0);

  for(;;) {
    level waittill("connected", var2);
    thread teleportplayertoteamstructs_latejoin(level, var2);
  }
}

function teleportplayertoteamstructs_latejoin(var0, var1) {
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  waitframe();
  teleportplayertoteamstructs(var0, var1);
}

function teleportplayertoteamstructs(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var1, "targetname");

  if(!isDefined(var2) || var2.size < 4) {
    return;
  }

  var3 = randomintrange(0, var2.size);
  var2[var3].angles = scripts\engine\utility::ter_op(isDefined(var2[var3].angles), var2[var3].angles, (0, 0, 0));
  var0 setOrigin(var2[var3].origin);
  var0 setplayerangles(var2[var3].angles);
  var0 dontinterpolate();
}

function string_is_single_digit_integer(var0) {
  if(var0.size > 1) {
    return false;
  }

  var1 = [];
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

function printgameaction(var0, var1) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }

  var2 = "";

  if(isDefined(var1)) {
    var2 = "[" + var1 getentitynumber() + ":" + var1.name + "] ";
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

function get_center_point_of_array(var0) {
  var1 = (0, 0, 0);

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = (var1[0] + var0[var2].origin[0], var1[1] + var0[var2].origin[1], var1[2] + var0[var2].origin[2]);
  }

  return (var1[0] / var0.size, var1[1] / var0.size, var1[2] / var0.size);
}

function sethintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  self makeusable();

  if(isDefined(var0)) {
    self sethinttag(var0);
  }

  if(isDefined(var1)) {
    self setCursorHint(var1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  if(isDefined(var2)) {
    self sethinticon(var2);
  }

  if(isDefined(var3)) {
    self setHintString(var3);
  }

  if(isDefined(var4)) {
    var4 = int(clamp(var4, -10, 1));
    self setusepriority(var4);
  } else {
    self setusepriority(-10);
  }

  if(isDefined(var5)) {
    self setuseholdduration(var5);

    if(var5 == "duration_medium" || var5 == "duration_long") {
      self sethintrequiresholding(1);
    }
  } else {
    self setuseholdduration("duration_short");
  }

  if(isDefined(var6)) {
    self sethintonobstruction(var6);
  } else {
    self sethintonobstruction("hide");
  }

  if(isDefined(var7)) {
    self sethintdisplayrange(var7);
  } else {
    self sethintdisplayrange(200);
  }

  if(isDefined(var8)) {
    self sethintdisplayfov(var8);
  } else {
    self sethintdisplayfov(160);
  }

  if(isDefined(var9)) {
    self setuserange(var9);
  } else {
    self setuserange(50);
  }

  if(isDefined(var10)) {
    self setusefov(var10);
    return;
  }

  self setusefov(120);
}

function is_indoors(var0) {
  var1 = 0;
  var2 = (0, 0, 0);

  if(isent(var0)) {
    var2 = var0.origin;
  } else if(isvector(var0)) {
    var2 = var0;
  } else if(isstruct(var0)) {
    var2 = var0.origin;
  }

  var3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var2, var2 + (0, 0, 10000), undefined, var3)) {
    var1 = 1;
  }

  return var1;
}

function is_indoors_vehicleignored(var0) {
  var1 = 0;
  var2 = (0, 0, 0);

  if(isent(var0)) {
    var2 = var0.origin;
  } else if(isvector(var0)) {
    var2 = var0;
  } else if(isstruct(var0)) {
    var2 = var0.origin;
  }

  var3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var2, var2 + (0, 0, 10000), undefined, var3)) {
    var1 = 1;
  }

  return var1;
}

function isgesture(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(issubstr(var1, "ges_plyr")) {
    return 1;
  }

  if(issubstr(var1, "devilhorns_mp")) {
    return 1;
  }

  return 0;
}

function actionslotoverride(var0, var1, var2, var3) {
  self setweaponhudiconoverride("actionslot" + var0, var1);

  if(isDefined(var2)) {
    setactionslotoverrideammo(var0, var2);
  }

  if(isDefined(var3)) {
    thread actionslotoverridecallback(var0, var3);
    return;
  }
}

function actionslotoverridecallback(var0, var1) {
  self endon("death");
  self endon("removeActionslot" + var0);
  self notifyonplayercommand("actionslot" + var0, "+actionslot " + var0);

  for(;;) {
    self waittill("actionslot" + var0);
    self thread[[var1]]();
  }
}

function actionslotoverrideremove(var0) {
  self notify("removeActionslot" + var0);
  self setweaponhudiconoverrideammo("actionslot" + var0, -1);
  self setweaponhudiconoverride("actionslot" + var0, "none");
}

function setactionslotoverrideammo(var0, var1) {
  self setweaponhudiconoverrideammo("actionslot" + var0, var1);
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
  var0 = ["up", "up_release", "down", "down_release", "use", "use_release", "stance", "stance_release", "A", "A_release", "right", "ads", "ads_release", "attack", "attack_release", "touchpad", "touchpad_release", "swap_weapon", "swap_weapon_release"];
  var1 = [];
  var2 = 2;

  for(var3 = undefined;; var3 = undefined) {
    var4 = level.demo_button_combos;
    var5 = scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var0);

    if(getdvarint("scr_demo_debug", 0)) {
      var6 = gettime();

      if(!isDefined(var3)) {
        var3 = var6 + var2 * 1000;
      }

      var1 = var5;

      if(var6 >= var3) {
        var3 = undefined;
        var1 = [];
        continue;
      }

      var3 = var6 + var2 * 1000;
      var1 = validate_button_combo(var1);

      if(var1.size < 1) {}
    }
  }
}

function setup_debug_button_combos_for_player() {}

function add_demo_button_combo(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.button_combo = var0;
  var4.func = var1;
  var4.message = var2;
  var4.timeout = var3;
  level.demo_button_combos[level.demo_button_combos.size] = var4;
}

function validate_button_combo(var0) {
  var1 = [];

  for(var2 = 0; var2 < level.demo_button_combos.size; var2++) {
    var3 = level.demo_button_combos[var2];
    var4 = level.demo_button_combos[var2].button_combo;

    if(var0.size <= var4.size) {
      if(var0[var0.size - 1] == var4[var0.size - 1]) {
        if(var0.size == var4.size) {
          if(isDefined(var3.message)) {
            announcement(var3.message);
          }

          var0 = [];
          self thread[[var3.func]]();
        }

        var1 = var0;
        break;
      }
    }
  }

  return var1;
}

function getenemyteams(var0) {
  var1 = level.teamnamelist;
  var1 = scripts\engine\utility::array_remove(var1, var0);
  return var1;
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function getgametype() {
  return level.gametype;
}

function register_create_script(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var0;
  }

  if(isDefined(var1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var1;
  }

  if(isDefined(var2)) {
    level.create_script_file_ids[var0] = "cs" + var2;
  }

  if(isDefined(var3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var3;
    return;
  }
}

function array_notify(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 notify(var1, var2);
  }
}

function addtoactivekillstreaklist(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var4)) {
    var7 = 0;

    if(isusingremote(var2)) {
      var7 = 1;
    }

    var8 = undefined;

    if(level.teambased) {
      var8 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var5, 1, 10000, undefined, undefined, 1, var7);
    } else {
      var8 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var2, "hud_icon_head_equipment_friendly", var5, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(var8, var6);
    return;
  }
}

function removeteamheadicononnotify(var0, var1) {
  var2 = ["death"];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var2.size, var1);
  }

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0);
}

function killstreak_make_vehicle(var0, var1, var2, var3, var4) {
  self.vehiclename = var0;
  self.scorepopup = var1;
  self.vodestroyed = var2;
  self.votimeout = var3;
  self.destroyedsplash = var4;
  self enableplayermarks("killstreak");
  self filteroutplayermarks(self.team);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);

  if(isDefined(self.owner)) {
    self.owner notify("killstreak_vehicle_made", self);
    return;
  }
}

function killstreak_set_pre_mod_damage_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback(var0, level.kspremoddamagecallback);
  self.kspremoddamagecallback = var1;
}

function killstreak_set_post_mod_damage_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback(var0, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = var1;
}

function killstreak_set_death_callback(var0, var1) {
  killstreak_vehicle_callback_init();
  scripts\cp\vehicles\damage_cp::set_death_callback(var0, level.ksdeathcallback);
  self.ksdeathcallback = var1;
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

function killstreak_pre_mod_damage_callback(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(var2) && isDefined(self.owner) && var2 == self.owner) {
      var1 = int(ceil(var1 * 0.5));
    }

    var0.damage = var1;
  }

  var3 = 1;
  var4 = self.kspremoddamagecallback;

  if(isDefined(var4)) {
    var3 = self[[var4]](var0);
  }

  return var3;
}

function killstreak_post_mod_damage_callback(var0) {
  killstreakhit(var0.attacker, var0.objweapon, self, var0.meansofdeath, var0.damage);
  var1 = 1;
  var2 = self.kspostmoddamagecallback;

  if(isDefined(var2)) {
    var1 = self[[var2]](var0);
  }

  return var1;
}

function killstreak_death_callback(var0) {
  onkillstreakkilled(self.streakname, var0.attacker, var0.objweapon, var0.meansofdeath, var0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  var1 = 1;
  var2 = self.ksdeathcallback;

  if(isDefined(var2)) {
    var1 = self[[var2]](var0);
  }

  return var1;
}

function killstreakhit(var0, var1, var2, var3, var4) {
  if(isDefined(var1) && isPlayer(var0) && isDefined(var2.owner) && isDefined(var2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var0, var2.owner)) {
      if(iskillstreakweapon(var1.basename)) {
        return;
      }

      var5 = createheadicon(var1);

      if(!isDefined(var0.lasthittime[var5])) {
        var0.lasthittime[var5] = 0;
      }

      if(var0.lasthittime[var5] == gettime()) {
        return;
      }

      var0.lasthittime[var5] = gettime();

      if(onlinestatsenabled()) {}

      if(isDefined(var3) && scripts\engine\utility::isbulletdamage(var3) || isprojectiledamage(var3)) {
        var0.lastdamagetime = gettime();
        var6 = scripts\cp\cp_weapon::getweapongroup(var1.basename);

        if(var6 == "weapon_lmg") {
          if(!isDefined(var0.shotslandedlmg)) {
            var0.shotslandedlmg = 1;
            return;
          }

          var0.shotslandedlmg++;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function isprojectiledamage(var0) {
  var1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var1, var0)) {
    return true;
  }

  return false;
}

function onkillstreakkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = 0;
  var10 = undefined;

  if(isDefined(var1) && isDefined(self.owner)) {
    if(isDefined(var1.owner) && isPlayer(var1.owner)) {
      var1 = var1.owner;
    }
  } else if(isDefined(var1) && isDefined(self.team) && isDefined(var1.team)) {
    if(isenemy(var1) && isPlayer(var1)) {
      var10 = var1;
    }
  }

  if(isDefined(var10)) {
    if(isDefined(var7)) {
      var10 scripts\cp\cp_player_battlechatter::killstreakdestroyed(var0);
    }

    thread scripts\mp\mp_agent_damage::killedkillstreak(var0, var10, var2);

    if(!tryingtoleave()) {
      thread scripts\mp\ammorestock::killstreakkilled(var0, self.owner, self, var10, var4, var3, var2, var5);
    }

    scripts\cp_mp\gestures::processcalloutdeath(self, var10);
    var9 = 1;
  }

  if(isDefined(self.owner) && isDefined(var6)) {}

  if(!istrue(var8)) {
    self notify("death");
  }

  return var9;
}

function skydivestreamhintdvars(var0) {
  skydiveontacinsertplacement();
  skydivehintnotify(var0 + "_heli_entrance", var0 + "_heli_goal");
}

function skydivehintnotify(var0, var1) {
  if(!isDefined(level.heli_structs_entrances)) {
    level.heli_structs_entrances = [];
  }

  if(!isDefined(level.heli_structs_goals)) {
    level.heli_structs_goals = [];
  }

  var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy");
  var3 = scripts\engine\utility::getStruct(var1, "script_noteworthy");
  level.heli_structs_entrances[level.heli_structs_entrances.size] = var2;
  level.heli_structs_goals[level.heli_structs_goals.size] = var3;
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
  var0 = getDvar("NSQLTTMRMP");

  if(var0 == "cp_raid_complex" || var0 == "cp_dntsk_raid") {
    return true;
  }

  return false;
}

function issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled)) {
    level.simultaneouskillenabled = getdvarint("MRSNQSMSPL", 0) == 0;
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
  return level.onlinegame && getdvarint("LSTLQTSSRM");
}

function getenemycount(var0, var1) {
  var2 = 0;
  var3 = getenemyteams(var0);

  foreach(var5 in var3) {
    var2 += getteamcount(var5, istrue(var1));
  }

  return var2;
}

function getteamcount(var0, var1) {
  if(istrue(var1)) {
    return level.teamdata[var0]["alivePlayers"].size;
  }

  return level.teamdata[var0]["players"].size;
}

function getenemyplayers(var0, var1) {
  var2 = [];
  var3 = getenemyteams(var0);

  foreach(var5 in var3) {
    if(istrue(var1)) {
      foreach(var7 in level.teamdata[var5]["alivePlayers"]) {
        if(isDefined(var7) && isalive(var7) && !isDefined(var7.fauxdead)) {
          var2 = var7;
        }
      }

      continue;
    }

    foreach(var7 in level.teamdata[var5]["players"]) {
      var2 = var7;
    }
  }

  return var2;
}

function ref_123fe(var0, var1) {
  var2 = level.players;

  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var2 = [var1];
    } else {
      var2 = var1;
    }
  }

  foreach(var4 in var2) {
    var4 setplayermusicstate(var0);
  }
}

function ref_14441(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  var1 = self;
  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, 64);
  var2 = 1.5;
  var3 = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    var4 = [];
    var5 = getentitylessscriptablearrayinradius(undefined, undefined, var1.origin, var0);

    for(var6 = 0; var6 < var5.size; var6++) {
      if(var5[var6] scriptableisdoor()) {
        var4 = var5[var6];
      }
    }

    for(var7 = 0; var7 < var4.size; var7++) {
      var4[var7] setscriptablepartstate("door", "left_30", 0);
    }

    wait var2;
  }
}

function questtimeradd() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(is_valid_player(var2)) {
      var0++;
    }
  }

  return var0;
}

function ref_13c3e(var0, var1) {
  self endon("death");
  self notify("track_last_good_position");
  self endon("track_last_good_position");

  if(!isDefined(var1)) {
    var1 = 0.1;
  }

  for(;;) {
    wait var1;

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
      foreach(var3 in level.outofboundstriggers) {
        if(self istouching(var3)) {}
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

    if(istrue(var0) && !ispointonnavmesh(self.origin)) {
      continue;
    }

    self.last_good_pos = self.origin;
  }
}
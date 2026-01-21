#include scripts\utility;

main() {
  // disable hud while in remote killstreak
  replacefunc(maps\mp\_utility::setusingremote, ::setusingremote_stub);
  replacefunc(maps\mp\_utility::playerremotekillstreakshowhud, ::playerremotekillstreakshowhud_stub);

  // scavenger notify
  replacefunc(maps\mp\_utility::_setperk, ::_setperk_stub);
  replacefunc(maps\mp\_utility::_unsetperk, ::_unsetperk_stub);
  replacefunc(maps\mp\_utility::_clearperks, ::_clearperks_stub);

  // use h2 killstreak util functions
  replacefunc(maps\mp\_utility::iskillstreakweapon, ::iskillstreakweapon_stub);

  // use h2 prefix
  replacefunc(maps\mp\_utility::getbaseweaponname, ::getbaseweaponname_stub);
  replacefunc(maps\mp\_utility::isattachmentsniperscopedefaulttokenized, ::isattachmentsniperscopedefaulttokenized_stub);

  // extra checks for emped
  replacefunc(maps\mp\_utility::isemped, ::isemped_stub);

  // use splash table to get killstreak names
  replacefunc(maps\mp\_utility::getkillstreakname, ::getkillstreakname_stub);

  // vision set stuff to support H2 maps
  replacefunc(maps\mp\_utility::get_players_watching, ::get_players_watching_stub);
  replacefunc(maps\mp\_utility::set_visionset_for_watching_players, ::set_visionset_for_watching_players_stub);
  replacefunc(maps\mp\_utility::reset_visionset_on_spawn, ::reset_visionset_on_spawn_stub);
  replacefunc(maps\mp\_utility::reset_visionset_on_team_change, ::reset_visionset_on_team_change_stub);
  replacefunc(maps\mp\_utility::reset_visionset_on_disconnect, ::reset_visionset_on_disconnect_stub);
  replacefunc(maps\mp\_utility::revertvisionsetforplayer, ::revertvisionsetforplayer_stub);

  replacefunc(maps\mp\_utility::leaderdialogonplayer_internal, ::leaderdialogonplayer_internal_stub);

  replacefunc(maps\mp\_utility::incplayerstat, ::incplayerstat_stub);
  replacefunc(maps\mp\_utility::setplayerstat, ::setplayerstat_stub);
}

playerremotekillstreakshowhud_stub() {
  if(!self isemped_stub())
    self setclientomnvar("ui_killstreak_remote", 0);
}

setusingremote_stub(var_0) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_0;
  common_scripts\utility::_disableoffhandweapons();
  maps\mp\_utility::playerremotekillstreakhidehud();
  self notify("using_remote");
}

_setperk_stub(perk_name, var_1, var_2) {
  if(!isDefined(perk_name)) {
    return;
  }
  if(perk_name == "specialty_scavenger") {
    level notify("scavenger_update");
  }

  self thread maps\mp\gametypes\_hud_message::deathstreaksplashnotify(perk_name);

  self.perks[perk_name] = 1;
  self.perksperkname[perk_name] = perk_name;
  self.perksuseslot[perk_name] = var_1;

  if(isDefined(level.perksetfuncs[perk_name]))
    self thread[[level.perksetfuncs[perk_name]]]();

  var_3 = maps\mp\_utility::strip_suffix(perk_name, "_lefthand");

  if(perk_name == "none" || perk_name == "specialty_null") {
    return;
  }

  if(isDefined(var_2))
    self setperk(perk_name, !isDefined(level.scriptperks[var_3]), var_1, var_2);
  else
    self setperk(perk_name, !isDefined(level.scriptperks[var_3]), var_1);
}

_unsetperk_stub(perk_name) {
  if(perk_name == "specialty_scavenger") {
    level notify("scavenger_update");
  }

  self.perks[perk_name] = undefined;
  self.perksperkname[perk_name] = undefined;
  self.perksuseslot[perk_name] = undefined;
  self.perksperkpower[perk_name] = undefined;

  if(isDefined(level.perkunsetfuncs[perk_name]))
    self thread[[level.perkunsetfuncs[perk_name]]]();

  var_1 = maps\mp\_utility::strip_suffix(perk_name, "_lefthand");
  self unsetperk(perk_name, !isDefined(level.scriptperks[var_1]));
}

_clearperks_stub() {
  level notify("scavenger_update");

  foreach(var_2, var_1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_2]))
      self[[level.perkunsetfuncs[var_2]]]();
  }

  self.perks = [];
  self.perksperkname = [];
  self.perksuseslot = [];
  self.perksperkpower = [];
  self.perkscustom = [];
  self clearperks();
}

iskillstreakweapon_stub(var_0) {
  if(isDefined(var_0) && var_0 != "none" && (maps\mp\gametypes\_hardpoints::h2_iskillstreakactivator(var_0) || isDefined(level.killstreakspecialcaseweapons[var_0]))) {
    return 1;
  }

  return 0;
}

getbaseweaponname_stub(var_0) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "")
    return var_0;

  weapon_name_token = maps\mp\_utility::getweaponnametokens(var_0);
  var_2 = "";

  // patching to add other game prefixes
  weap_game_prefixes = strtok("iw5,iw6,iw9,s1,h1,h2", ",");
  foreach(token in weap_game_prefixes) {
    if(weapon_name_token[0] == token) {
      return weapon_name_token[0] + "_" + weapon_name_token[1];
    }
  }

  if(weapon_name_token[0] == "alt")
    var_2 = weapon_name_token[1] + "_" + weapon_name_token[2];
  else if(weapon_name_token.size > 1 && (weapon_name_token[1] == "grenade" || weapon_name_token[1] == "marker"))
    var_2 = weapon_name_token[0] + "_" + weapon_name_token[1];
  else
    var_2 = weapon_name_token[0];

  return var_2;
}

isattachmentsniperscopedefaulttokenized_stub(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "alt")
      var_3 = 1;

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "iw5" || var_0[var_3] == "iw6" || var_0[var_3] == "h1" || var_0[var_3] == "h2")) {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper")
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
    }
  }

  return var_2;
}

isemped_stub() {
  if(self.team == "spectator" || maps\mp\_utility::invirtuallobby()) {
    return 0;
  }

  if(level.teambased) {
    return level.teamemped[self.team];
  }

  return (isDefined(level.empplayer) && level.empplayer != self);
}

getkillstreakname_stub(var_0) {
  return tablelookupistring("mp/splashTable.csv", 0, var_0, 1);
}

get_players_watching_stub() {
  var_0 = 0;
  var_1 = 0;
  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(!isDefined(var_5) || var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(isDefined(var_5.team) && var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self)
          var_6 = 1;
      }

      if(var_5.forcespectatorclient == var_2)
        var_6 = 1;
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2)
        var_6 = 1;
    }

    if(var_6)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

set_visionset_for_watching_players_stub(var_0, var_1) {
  foreach(player in get_players_watching_stub()) {
    player notify("changing_watching_visionset");
    player thread _visionsetnakedforplayer(var_0, var_1);
  }
}

reset_visionset_on_spawn_stub() {
  self endon("disconnect");
  self waittill("spawned");
  self _visionsetnakedforplayer("", 0.0);
  self visionsetpostapplyforplayer("", 0.0);
}

reset_visionset_on_team_change_stub(var_0, var_1, var_2) {
  self endon("changing_watching_visionset");
  var_0 endon("disconnect");
  var_3 = gettime();
  var_4 = self.team;

  while(gettime() - var_3 < var_1 * 1000) {
    if(self.team != var_4 || !common_scripts\utility::array_contains(var_0 maps\mp\_utility::get_players_watching(), self)) {
      if(isDefined(var_2) && var_2)
        self visionsetpostapplyforplayer("", 0.0);
      else
        self _visionsetnakedforplayer("", 0.0);

      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

reset_visionset_on_disconnect_stub(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");

  if(isDefined(var_1) && var_1)
    self visionsetpostapplyforplayer("", 0.0);
  else
    self _visionsetnakedforplayer("", 0.0);
}

revertvisionsetforplayer_stub(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(isDefined(level.nukedetonated) && isDefined(level.nukevisionset)) {
    self setclienttriggervisionset(level.nukevisionset, var_0);
    self _visionsetnakedforplayer(level.nukevisionset, var_0);
    maps\mp\_utility::set_visionset_for_watching_players(level.nukevisionset, var_0);
  } else if(isDefined(self.usingremote) && isDefined(self.ridevisionset)) {
    self setclienttriggervisionset(self.ridevisionset, var_0);
    self _visionsetnakedforplayer(self.ridevisionset, var_0);
    maps\mp\_utility::set_visionset_for_watching_players(self.ridevisionset, var_0);
  } else {
    self setclienttriggervisionset("", var_0);
    self _visionsetnakedforplayer("", var_0);
    maps\mp\_utility::set_visionset_for_watching_players("", var_0);
  }
}

leaderdialogonplayer_internal_stub(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("playLeaderDialogOnPlayer");
  self endon("playLeaderDialogOnPlayer");

  if(isDefined(self.leaderdialoggroups[var_0])) {
    var_3 = var_0;
    var_0 = self.leaderdialoggroups[var_3];
    self.leaderdialoggroups[var_3] = undefined;
    self.leaderdialoggroup = var_3;
  }

  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"]))
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_2);

  if(issubstr(game["dialog"][var_0], "null")) {
    return;
  }
  if(isDefined(level.ishorde) && level.ishorde) {
    if(issubstr(var_0, "coop_gdn"))
      var_4 = var_0;
    else
      var_4 = "AT_anr0_" + game["dialog"][var_0];
  } else
    var_4 = game["voice"][var_1] + game["dialog"][var_0];

  var_5 = var_4;

  if(soundexists(var_4)) {
    if(maps\mp\_utility::leaderdialog_islockedout(game["dialog"][var_0], self)) {
      return;
    }
    self.leaderdialogactive = var_4;
    self playlocalannouncersound(var_4);
    maps\mp\_utility::leaderdialog_trylockout(game["dialog"][var_0], self);
  }

  wait 2.0;
  self.leaderdialoglocalsound = "";
  self.leaderdialogactive = "";
  self.leaderdialoggroup = "";

  if(self.leaderdialogqueue.size > 0) {
    var_6 = self.leaderdialogqueue[0];
    var_7 = self.leaderdialoglocqueue[0];

    for(var_8 = 1; var_8 < self.leaderdialogqueue.size; var_8++)
      self.leaderdialogqueue[var_8 - 1] = self.leaderdialogqueue[var_8];

    for(var_8 = 1; var_8 < self.leaderdialoglocqueue.size; var_8++)
      self.leaderdialoglocqueue[var_8 - 1] = self.leaderdialoglocqueue[var_8];

    self.leaderdialogqueue[var_8 - 1] = undefined;
    self.leaderdialoglocqueue[var_8 - 1] = undefined;
    thread maps\mp\_utility::leaderdialogonplayer_internal(var_6, var_1, var_7);
  }
}

incplayerstat_stub(var_0, var_1) {
  if(isagent(self)) {
    return;
  }
  key = "stats_" + var_0;
  if(isDefined(self.stats[key])) {
    var_2 = self.stats[key];
    var_2.value += var_1;
  }
}

setplayerstat_stub(var_0, var_1) {
  key = "stats_" + var_0;
  if(isDefined(self.stats[key])) {
    var_2 = self.stats[key];
    var_2.value = var_1;
    var_2.time = gettime();
  }
}
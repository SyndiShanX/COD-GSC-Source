/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_laststand.gsc
**************************************************/

callback_playerlaststandzombies(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self notify("enter_last_stand");
  registerlaststandparameter(var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(gameshouldend(self, var_3, 1) && !isattackerhostzombie(var_1) && !isattackerbossozstage2(var_1) && !cananyplayertokenrevive()) {
    self.uselaststandparams = 1;
    self.numberofbleedouts++;
    maps\mp\_utility::_suicide();
    zombieendgame(undefined, var_3);
  } else if(!maydolaststandzombies(self)) {
    var_9 = "ui_zm_character_" + self.characterindex + "_alive";
    setomnvar(var_9, 0);
    self.uselaststandparams = 0;
    self.numberofbleedouts++;
    maps\mp\_utility::_suicide();

    if(level.players.size < 2) {
      zombieendgame(undefined, var_3);
    }
  } else {
    if(isattackerhostzombie(var_1)) {
      thread hostzombielaststand();
      return;
    }

    if(isattackerbossozstage2(var_1)) {
      thread hostzombielaststand(1);
      return;
    }

    if(maps\mp\zombies\_util::iszombieshardmode()) {
      maps\mp\_utility::_suicide();
      return;
    }

    self notify("begin_last_stand");
    self.inlaststand = 1;
    self.laststand = 1;
    maps\mp\zombies\_util::setallignoreme(1);
    self.health = 1;
    self.numberofdowns++;
    var_10 = zombieslaststandweapon();
    savelaststandweapons(var_10);

    if(!haslaststandweapon(var_10)) {
      giveplayerweapon(var_10, 1);
    } else {
      self switchtoweaponimmediate(var_10);
    }

    thread maps\mp\zombies\_util::zombieallowallboost(0, "laststand");
    thread zombieperkbleed();
    thread zombietokenrevive();
    common_scripts\utility::_disableusability();
    common_scripts\utility::_disableweaponswitch();
    self disableoffhandweapons();

    if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
      self deathdropgrenade();
    }

    thread laststandrevivezombie(var_0, var_1, var_4, var_7, var_3);

    if(isDefined(level.laststandinwaterfunc)) {
      self thread[[level.laststandinwaterfunc]]();
    }

    if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0) {
      thread tryendgameafteragentsdie(var_3);
    }
  }
}

tryendgameafteragentsdie(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  while(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0) {
    wait 0.05;
  }

  if(!areanyotherplayersalive(self) && !maps\mp\zombies\_util::is_true(self.selfreviveactive)) {
    thread killplayerandendgameafteragentsdead(var_0);
  }
}

killplayerandendgameafteragentsdead(var_0) {
  level endon("game_ended");
  self.uselaststandparams = 1;
  self.numberofbleedouts++;
  maps\mp\_utility::_suicide();
  zombieendgame(undefined, var_0);
}

zombietokenrevive() {
  zombietokenrevivewait();

  if(isDefined(self)) {
    maps\mp\zombies\_util::cleartokenuseomnvars();
  }
}

zombietokenrevivewait() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    if(isDefined(self.tokenbuttonpressed) && self.tokenbuttonpressed && !isDefined(self playergetuseent(1)) && maps\mp\gametypes\zombies::hastoken(10)) {
      if(!isDefined(var_0)) {
        var_0 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
        maps\mp\zombies\_util::settokenuseomvars();
      }

      if(gettime() >= var_0) {
        maps\mp\gametypes\zombies::spendtoken(10);
        self notify("revive_trigger", 0);
        return;
      }
    } else if(isDefined(var_0)) {
      var_0 = undefined;
      maps\mp\zombies\_util::cleartokenuseomnvars();
    }

    waitframe();
  }
}

savelaststandweapons(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = self getweaponslistprimaries();
  self.primaryweapons = [];

  foreach(var_4 in var_2) {
    if(!issubstr(var_4, "combatknife")) {
      self.primaryweapons[self.primaryweapons.size] = var_4;
    }
  }

  self.lastequippedweapon = self getcurrentprimaryweapon();

  if(self.lastequippedweapon == "search_dstry_bomb_defuse_mp" && isDefined(self.lastnonuseweapon) && isDefined(common_scripts\utility::array_find(self.primaryweapons, self.lastnonuseweapon))) {
    self.lastequippedweapon = self.lastnonuseweapon;
  }

  if(issubstr(self.lastequippedweapon, "killstreak")) {
    self.lastequippedweapon = self.primaryweapons[0];
  }

  if(self.lastequippedweapon == "airdrop_sentry_marker_mp") {
    self.lastequippedweapon = self.primaryweapons[0];
  }

  if(self.lastequippedweapon == "none") {
    self.lastequippedweapon = self.primaryweapons[0];
  }

  if(issubstr(self.lastequippedweapon, "exo_suit_")) {
    self.lastequippedweapon = self.primaryweapons[0];
  }

  foreach(var_4 in self.primaryweapons) {
    self.primaryweaponsammo[var_4]["ammoclip"] = self getweaponammoclip(var_4);

    if(common_scripts\utility::string_find(var_4, "akimbo")) {
      self.primaryweaponsammo[var_4]["ammoclipleft"] = self getweaponammoclip(var_4, "left");
    }

    self.primaryweaponsammo[var_4]["ammostock"] = self getweaponammostock(var_4);
  }

  self.tombstoneweapon = self.lastequippedweapon;
  self.tombstoneweaponlevel = maps\mp\zombies\_util::getzombieweaponlevel(self, self.tombstoneweapon);

  if(issubstr(self.tombstoneweapon, "titan")) {
    self.tombstoneweaponlevel = 0;
  }

  foreach(var_9 in self.primaryweapons) {
    if(!issubstr(var_9, "titan")) {
      if(var_1) {
        self takeweapon(var_9);
      }

      var_10 = maps\mp\zombies\_util::getzombieweaponlevel(self, var_9);

      if(var_10 > self.tombstoneweaponlevel) {
        self.tombstoneweapon = var_9;
        self.tombstoneweaponlevel = var_10;
      }
    }
  }

  if(isDefined(self.scriptedtombstoneweapon) && isDefined(self.scriptedtombstoneweaponlevel)) {
    self.tombstoneweapon = self.scriptedtombstoneweapon;
    self.tombstoneweaponlevel = self.scriptedtombstoneweaponlevel;
  }
}

refillstoredweaponammo() {
  foreach(var_1 in self.primaryweapons) {
    self.primaryweaponsammo[var_1]["fillMax"] = 1;
  }
}

zombieslaststandweapon() {
  var_0 = [];

  if(maps\mp\zombies\_util::getzombieslevelnum() >= 3) {
    var_0 = ["iw5_fusionzm_mp", "iw5_dlcgun3zm_mp", "iw5_rw1zm_mp", "iw5_vbrzm_mp", "iw5_titan45zm_mp"];
  } else {
    var_0 = ["iw5_fusionzm_mp", "iw5_rw1zm_mp", "iw5_vbrzm_mp", "iw5_titan45zm_mp"];
  }

  var_1 = var_0[var_0.size - 1];
  var_2 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self, var_1);
  var_3 = -1;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self, var_0[var_4]);

    if(self hasweapon(var_5)) {
      var_6 = maps\mp\zombies\_util::getzombieweaponlevel(self, var_0[var_4]);

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

haslaststandweapon(var_0) {
  if(!isDefined(var_0)) {
    var_0 = zombieslaststandweapon();
  }

  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      self.hadlaststandweapon = 1;
      return 1;
    }
  }

  self.hadlaststandweapon = 0;
  return 0;
}

gameshouldend(var_0, var_1, var_2) {
  if(level.players.size <= 1) {
    if(isDefined(var_1) && var_1 == "MOD_SUICIDE") {
      return 1;
    }

    if(var_0 hasexostim() && maydolaststandzombies(var_0)) {
      return 0;
    }
  }

  if(areanyotherplayersalive(var_0)) {
    return 0;
  } else if(isDefined(var_2) && var_2 && areanyalliedagentsalive(var_0)) {
    return 0;
  }

  return 1;
}

areanyalliedagentsalive(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_3 in var_1) {
    if(!isalliedsentient(var_3, var_0)) {
      continue;
    }
    if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
      continue;
    }
    if(maps\mp\zombies\_util::is_true(var_3.fakeplayer)) {
      continue;
    }
    return 1;
  }

  return 0;
}

areanyotherplayersalive(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_0 == var_3) {
      continue;
    }
    if(!maps\mp\zombies\_util::isonhumanteam(var_3)) {
      continue;
    }
    if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
      if(maps\mp\agents\_agent_utility::getnumownedactiveagents(var_3) == 0) {
        continue;
      }
    }

    if(!isDefined(var_3.sessionstate) || var_3.sessionstate != "playing") {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

cananyplayertokenrevive() {
  if(!level.tokensenabled) {
    return 0;
  }

  foreach(var_1 in level.players) {
    if(var_1 playercantokenrevive()) {
      return 1;
    }
  }

  return 0;
}

playercantokenrevive() {
  if(!level.tokensenabled) {
    return 0;
  }

  if(self.sessionstate != "playing") {
    return 0;
  }

  if(!maps\mp\gametypes\zombies::hastoken(10)) {
    return 0;
  }

  return 1;
}

zombieendgame(var_0, var_1) {
  if(!gameshouldend(self, var_1)) {
    return 0;
  }

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  maps\mp\zombies\_util::writezombiestats();
  level.finalkillcam_winner = level.enemyteam;

  if(!isDefined(var_0)) {
    level thread maps\mp\gametypes\_gamelogic::endgame(level.enemyteam, game["end_reason"]["survivors_eliminated"]);
  }

  waitframe();
  maps\mp\zombies\_zombies_music::changezombiemusic("game_over");
}

maydolaststandzombies(var_0) {
  if(var_0 maps\mp\_utility::touchingbadtrigger()) {
    return 0;
  }

  if(maps\mp\zombies\_util::is_true(var_0.outofbounds)) {
    return 0;
  }

  if(maps\mp\zombies\_util::isplayerinfected(var_0)) {
    return 0;
  }

  return 1;
}

registerlaststandparameter(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.einflictor = var_0;
  var_7.attacker = var_1;
  var_7.idamage = var_2;
  var_7.attackerposition = var_1.origin;
  var_7.smeansofdeath = var_3;
  var_7.sweapon = var_4;
  var_7.vdir = var_5;
  var_7.shitloc = var_6;
  var_7.laststandstarttime = gettime();

  if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_7.sprimaryweapon = var_1 getcurrentprimaryweapon();
  } else {
    var_7.sprimaryweapon = undefined;
  }

  self.laststandparams = var_7;
}

hasexostim() {
  return isDefined(self.isexostimactive) && self.isexostimactive;
}

useexostim() {
  self notify("take_exo_revive");
  thread laststandselfrevive();
  level thread selfrevivethinkloop(self);
}

zombieperkbleed() {
  zombieperkbleedwait();
  zombieperkbleedflashingstop();
}

zombieperkbleedwait() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 = [];

  for(var_1 = self.zm_perks.size - 1; var_1 >= 0; var_1--) {
    var_2 = self.zm_perks[var_1];

    if(var_2 != "exo_suit" && (var_2 != "exo_revive" || level.players.size > 1)) {
      var_0[var_0.size] = var_2;
    }
  }

  if(!var_0.size) {
    return;
  }
  var_3 = 8;

  foreach(var_2 in var_0) {
    zombieperkbleedflashing(var_2);
    wait(var_3);

    while(isDefined(self.beingrevived) && self.beingrevived) {
      waitframe();
    }

    self notify("take_" + var_2);
  }
}

zombieperkbleedflashing(var_0) {
  var_1 = maps\mp\zombies\_terminals::getitemomnvar(var_0);
  self.perkomnvarflash = var_1;
  self setclientomnvar(var_1, 2);
}

zombieperkbleedflashingstop() {
  if(isDefined(self) && isDefined(self.perkomnvarflash)) {
    self setclientomnvar(self.perkomnvarflash, 1);
    self.perkomnvarflash = undefined;
  }
}

laststandrevivezombie(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("force_cancel_placement");
  thread maps\mp\zombies\_zombies_audio::playerlaststandvo();
  thread laststandwaittilldeathzombies();
  thread laststandammomonitor();
  thread laststandkeepoverlayzombies();
  thread laststandmonitorabandonment();
  var_5 = spawn("script_model", self.origin);
  var_5 setModel("tag_origin");
  var_5 setcursorhint("HINT_NOICON");
  var_5 sethintstring(&"PLATFORM_REVIVE");
  var_5 makeusable();
  var_5.inuse = 0;
  var_5.curprogress = 0;
  var_5.usetime = level.laststandusetime;
  var_5.userate = 1;
  var_5.id = "last_stand";
  var_5.targetname = "revive_trigger";
  var_5.owner = self;
  var_5 linkto(self, "tag_origin", (0, 0, 20), (0, 0, 0));
  var_5 thread deleteonreviveordeathordisconnect();
  self.reviveicon = createreviveicon("hint_health_zm", 8, 8, (0.5, 1, 0.99));
  thread laststandupdatereviveiconcolorzombies(var_5, 30);
  thread laststandupdatereviveiconzombies(var_5);
  var_5 thread reviveentmonitor();
  var_5 thread laststandwaittilllifereceived();

  if(level.players.size <= 1 && hasexostim()) {
    useexostim();
  } else {
    var_5 thread revivetriggerthinkzombies();
    applylaststandmoneypenalty(self);
    thread laststandtimerzombies(30, var_5);
  }

  var_5 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);

  while(isDefined(var_5.inuse) && var_5.inuse) {
    waitframe();
  }

  self hudoutlinedisable();
  self disableweapons();
  self.movespeedscaler = 0.05;
  thread bleedout();
}

deleteonreviveordeathordisconnect() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self.owner common_scripts\utility::waittill_any("death", "disconnect");

  if(isDefined(self)) {
    self delete();
  }
}

createreviveicon(var_0, var_1, var_2, var_3) {
  if(isDefined(self.reviveicon)) {
    self.reviveicon destroy();
  }

  var_4 = newteamhudelem(self.team);
  var_4 setshader(var_0, var_1, var_2);
  var_4 setwaypoint(1, 1);
  var_4 settargetent(self);
  var_4.color = var_3;
  return var_4;
}

applylaststandmoneypenalty(var_0) {
  var_1 = maps\mp\gametypes\zombies::getcurrentmoney(var_0);
  var_2 = int(var_1 * 0.1);
  var_3 = common_scripts\utility::mod(var_2, 10);
  var_2 = var_2 - var_3;
  var_0 maps\mp\gametypes\zombies::spendmoney(var_2);
  var_0.revivemoneyaward = var_2;
}

bleedout() {
  self notify("bleedout");
  level notify("bleedout");

  if(isDefined(self.reviveicon)) {
    self.reviveicon destroy();
  }

  var_0 = "ui_zm_character_" + self.characterindex + "_alive";
  setomnvar(var_0, 0);

  if(maps\mp\zombies\_util::playerhasem1ammoinfo()) {
    maps\mp\zombies\_util::playerclearem1ammoinfo();
  }

  self.numberofbleedouts++;
  self suicide();

  if(!areanyotherplayersalive(self)) {
    zombieendgame();
  } else {
    maps\mp\zombies\_zombies_music::changezombiemusic("player_died", self);
  }
}

laststandselfrevive() {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 3);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  self.curprogress = 0;
  self.userate = 1;
  self.usetime = 8000;
  self.selfreviveactive = 1;
  var_0 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(self.laststand) && !level.gameended) {
    if(var_0 != self.userate) {
      if(self.curprogress > self.usetime) {
        self.curprogress = self.usetime;
      }

      if(self.userate > 0) {
        var_1 = gettime();
        var_2 = self.curprogress / self.usetime;
        var_3 = var_1 + (1 - var_2) * (self.usetime / self.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_3));
      }

      var_0 = self.userate;
    }

    wait 0.05;
  }

  self.selfreviveactive = 0;
  self setclientomnvar("ui_use_bar_end_time", 0);
}

selfrevivethinkloop(var_0) {
  while(!level.gameended && maps\mp\_utility::isreallyalive(var_0) && var_0.curprogress < var_0.usetime) {
    var_0.curprogress = var_0.curprogress + 50 * var_0.userate;

    if(var_0.curprogress >= var_0.usetime) {
      var_0 notify("revive_trigger");
    }

    wait 0.05;
  }
}

revivetriggerthinkzombies() {
  self endon("death");
  level endon("game_ended");
  var_0 = 2000;
  var_1 = 0.5;

  for(;;) {
    self makeusable();
    self waittill("trigger", var_2);
    self makeunusable();
    self.curprogress = 0;
    self.inuse = 1;
    self.owner.beingrevived = 1;
    var_2 freezecontrols(1);
    var_2 common_scripts\utility::_disableweaponswitch();
    var_2 maps\mp\zombies\_util::playerallowfire(0, "laststand");
    var_2.isreviving = 1;
    var_3 = var_0;

    if(var_2 hasexostim()) {
      var_3 = var_3 * var_1;
    }

    thread revivetriggerthinkzombies_cleanup(var_2);
    var_4 = maps\mp\gametypes\_damage::reviveholdthink(var_2, var_3, 0);
    self.inuse = 0;

    if(isDefined(self.owner)) {
      self.owner.beingrevived = 0;
    }

    if(isDefined(var_2) && maps\mp\_utility::isreallyalive(var_2)) {
      self notify("reviveTriggerThinkZombies_cleanup");

      if(!isDefined(var_4)) {
        var_2 maps\mp\gametypes\_gameobjects::updateuiprogress(self, 0);
      }
    }

    if(isDefined(var_4) && var_4) {
      self.owner notify("revive_trigger", var_2);
      var_5 = var_2;

      if(!isPlayer(var_5) && isPlayer(var_5.owner)) {
        var_5 = var_5.owner;
      }

      var_5 maps\mp\gametypes\zombies::givemoney(self.owner.revivemoneyaward);
      break;
    }
  }
}

revivetriggerthinkzombies_cleanup(var_0) {
  common_scripts\utility::waittill_any_ents(self, "death", self, "reviveTriggerThinkZombies_cleanup");
  var_0 freezecontrols(0);
  var_0 maps\mp\zombies\_util::playerallowfire(1, "laststand");
  var_0 common_scripts\utility::_enableweaponswitch();
  var_0.isreviving = 0;
}

waittill_any_in_array_return_no_endon_death_duplicate(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    childthread common_scripts\utility::waittill_string_no_endon_death(var_3, var_1);
  }

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

laststandcleanupomnvar(var_0) {
  level endon("game_ended");
  self endon("revive_trigger");
  var_1 = self.characterindex;
  waittill_any_in_array_return_no_endon_death_duplicate(var_0);
  var_2 = "ui_zm_character_" + var_1 + "_bleedout_endtime";
  setomnvar(var_2, 0);
  level notify(var_2 + "_cancel");
}

laststandwaittilllifereceived() {
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("becameSpectator");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 thread laststandcleanupomnvar(["becameSpectator", "death", "disconnect"]);
  var_0 waittill("revive_trigger", var_1);

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_0 thread maps\mp\zombies\_zombies_audio::playerrevivevo(var_1);
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1 != var_0) {
    var_0 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived", var_1);
    var_1 maps\mp\_utility::incplayerstat("assists", 1);
    var_1 maps\mp\_utility::incpersstat("assists", 1);
    var_1.assists = var_1 maps\mp\_utility::getpersstat("assists");
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "assists", var_1.assists);
  }

  var_2 = "ui_zm_character_" + var_0.characterindex + "_bleedout_endtime";
  setomnvar(var_2, 0);
  level notify(var_2 + "_cancel");

  if(var_0 isreloading()) {
    while(var_0 isreloading()) {
      waitframe();
    }

    waitframe();
  }

  var_0 respawnplayerzombies(1);
}

reviveentwaittillconditions() {
  self endon("death");
  self.owner common_scripts\utility::waittill_any("revive_trigger", "disconnect", "becameSpectator");
}

reviveentmonitor() {
  if(isDefined(self.owner.reviveicon)) {
    var_0 = self.owner.reviveicon;
  } else {
    var_0 = undefined;
  }

  reviveentwaittillconditions();

  if(isDefined(self) && isDefined(self.owner) && isDefined(self.owner.reviveicon)) {
    self.owner.reviveicon destroy();
  } else if(isDefined(var_0)) {
    var_0 destroy();
  }

  if(isDefined(self)) {
    self delete();
  }
}

givebackweaponsfromlaststand() {
  if(!self.hadlaststandweapon) {
    var_0 = zombieslaststandweapon();
    self takeweapon(var_0);
    self loadweapons(var_0);
  }

  var_1 = undefined;

  if(issubstr(self.lastequippedweapon, "turrethead")) {
    var_2 = -1;

    for(var_3 = 0; var_3 < self.primaryweapons.size; var_3++) {
      var_4 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self, self.primaryweapons[var_3]);
      var_5 = maps\mp\zombies\_util::getzombieweaponlevel(self, self.primaryweapons[var_3]);

      if(var_5 > var_2) {
        var_1 = var_4;
        var_2 = var_5;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = self.lastequippedweapon;
  }

  foreach(var_7 in self.primaryweapons) {
    givestoredweapon(var_7, var_7 == var_1);
  }
}

respawnplayerzombies(var_0) {
  self notify("revive");
  self.laststand = undefined;
  self.inlaststand = 0;
  self.headicon = "";
  self.health = self.maxhealth;
  self.ignoreme = 0;
  self.ignoremecount = undefined;
  self.zombiesignoreme = 0;
  self.zombiesignoremecount = undefined;
  self.beingrevived = 0;
  self.lastrevivetime = gettime();

  if(maps\mp\_utility::_hasperk("specialty_lightweight")) {
    self.movespeedscaler = maps\mp\_utility::lightweightscalar();
  }

  self hudoutlinedisable();
  self laststandrevive();
  self setstance("crouch");

  if(var_0) {
    givebackweaponsfromlaststand();
  }

  if(var_0) {
    common_scripts\utility::_enableweaponswitch();
  } else {
    self enableweaponswitch();
  }

  thread maps\mp\zombies\_util::zombieallowallboost(1, "laststand");
  self enableweapons();
  common_scripts\utility::_enableusability();
  self enableoffhandweapons();
  maps\mp\gametypes\_weapons::updatemovespeedscale();
  maps\mp\_utility::clearlowermessage("last_stand");
  maps\mp\_utility::giveperk("specialty_pistoldeath", 0);
  self allowsprint(1);

  if(!canspawn(self.origin)) {
    maps\mp\_movers::unresolved_collision_nearest_node(self, 0);
  }
}

revivefromspectatemode() {
  self endon("disconnect");
  wait 1.0;
  maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  self.pers["lives"] = 1;
  thread maps\mp\gametypes\_playerlogic::spawnclient();
  thread maps\mp\zombies\_util::setcustomcharacter(self.characterindex, 0);
  wait 0.1;
  respawnplayerzombies(0);
}

givestoredweapon(var_0, var_1) {
  giveplayerweapon(var_0, var_1);

  if(isDefined(self.primaryweaponsammo[var_0]["fillMax"])) {
    self givemaxammo(var_0);
    self.primaryweaponsammo[var_0]["fillMax"] = undefined;
  } else {
    self setweaponammoclip(var_0, self.primaryweaponsammo[var_0]["ammoclip"]);

    if(common_scripts\utility::string_find(var_0, "akimbo") && isDefined(self.primaryweaponsammo[var_0]["ammoclipleft"])) {
      self setweaponammoclip(var_0, self.primaryweaponsammo[var_0]["ammoclipleft"], "left");
    }

    self setweaponammostock(var_0, self.primaryweaponsammo[var_0]["ammostock"]);
  }
}

giveplayerweapon(var_0, var_1) {
  while(!self loadweapons([var_0])) {
    waitframe();
  }

  maps\mp\_utility::_giveweapon(var_0);

  if(var_1) {
    self switchtoweaponimmediate(var_0);
  }
}

laststandwaittilldeathzombies() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  self.laststand = undefined;
  self.inlaststand = 0;
  self.ignoreme = 0;
  self.ignoremecount = undefined;
  self.zombiesignoreme = 0;
  self.zombiesignoremecount = undefined;
}

laststandkeepoverlayzombies() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  for(;;) {
    self.health = 2;
    waitframe();
    self.health = 1;
    waitframe();
  }
}

laststandmonitorabandonment() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive_trigger");
  self endon("horde_end_spectate");

  for(;;) {
    level waittill("player_disconnected");

    if(gameshouldend(self)) {
      self.uselaststandparams = 1;
      self.numberofbleedouts++;
      maps\mp\_utility::_suicide();
      zombieendgame();
      return;
    }

    waitframe();
  }
}

laststandupdatereviveiconzombies(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = (1, 1, 1);

  for(;;) {
    while(!var_0.inuse) {
      waitframe();
    }

    var_2 = self.reviveicon.color;
    self.reviveicon = createreviveicon("hint_health_zm", 8, 8, var_1);

    while(var_0.inuse) {
      waitframe();
    }

    if(self.reviveicon.color != var_1) {
      var_2 = self.reviveicon.color;
    }

    self.reviveicon = createreviveicon("hint_health_zm", 8, 8, var_2);
  }
}

laststandupdatereviveiconcolorzombies(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\_utility::playdeathsound();
  wait(var_1 / 3);

  while(var_0.inuse) {
    wait 0.05;
  }

  self.reviveicon.color = (1, 0.5, 0);
  maps\mp\_utility::playdeathsound();
  wait(var_1 / 3);

  while(var_0.inuse) {
    wait 0.05;
  }

  self.reviveicon.color = (0.99, 0.19, 0.22);
  maps\mp\_utility::playdeathsound();
}

laststandtimerzombies(var_0, var_1) {
  var_2 = gettime() + var_0 * 1000;
  var_3 = "ui_zm_character_" + self.characterindex + "_bleedout_endtime";
  level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration(var_3, var_2);
}

laststandammomonitor() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 = 1.0;

  for(;;) {
    wait(var_0);
    var_1 = self getcurrentweapon();
    var_2 = self getammocount(var_1);

    if(var_2 == 0) {
      var_3 = weaponclipsize(var_1);
      self setweaponammostock(var_1, var_3);
    }
  }
}

isattackerhostzombie(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.agent_type)) {
    return 0;
  }

  return var_0.agent_type == "zombie_host";
}

isattackerbossozstage2(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.agent_type)) {
    return 0;
  }

  return var_0.agent_type == "zombie_boss_oz_stage2";
}

hostzombielaststand(var_0) {
  self endon("disconnect");
  self endon("cured");
  level notify("player_infected", self);
  self notify("player_infected");
  var_1 = zombieslaststandweapon();
  savelaststandweapons(var_1, 0);
  var_2 = 60;

  if(isDefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive) {
    var_2 = var_2 + 15;
  }

  maps\mp\zombies\_zombies_audio::player_infected();
  self laststandrevive();
  self.health = 100;
  self.infected = 1;
  self.infectedendtime = gettime() + var_2 * 1000;
  thread hostzombieupdateoutline();
  thread hostzombiehud(var_2);

  if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {} else {
    thread hostzombieheartbeat(var_2);
  }

  thread hostzombiewaitcured();
  thread hostzombietokencured();
  thread hostzombiewaitbleedout();
  thread hostzombieupdateendtime();
  thread hostzombiecuredsound();

  while(self.infectedendtime > gettime()) {
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    waitframe();
  }

  self notify("stop_useHoldThinkLoop");
  self.isdefusing = 0;
  self.isplanting = 0;

  if(level.players.size <= 1 && hasexostim()) {
    thread hostzombiesoloexostim();
  } else {
    level thread spawnplayerhostzombie(self);
    self.hideondeath = 1;
    bleedout();
  }
}

hostzombiesoloexostim() {
  self notify("cured", 0);
  waitframe();
  self dodamage(self.health, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
}

hostzombieupdateoutline() {
  var_0 = 0;
  var_1 = 1;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(maps\mp\zombies\_util::isplayerinfected(var_5)) {
      var_5 hudoutlineenable(var_1, 0);
      var_2[var_2.size] = var_5;
      continue;
    }

    var_5 hudoutlinedisable();
    var_3[var_3.size] = var_5;
  }

  waitframe();
  var_2 = common_scripts\utility::array_removeundefined(var_2);
  var_3 = common_scripts\utility::array_removeundefined(var_3);

  foreach(var_8 in level.hostcuremodels) {
    if(maps\mp\zombies\_util::is_true(var_8.terminal.terminaldeactivated)) {
      continue;
    }
    if(var_2.size) {
      if(maps\mp\zombies\_terminals::perkterminalhostcureincooldown(var_8.terminal) || maps\mp\zombies\_util::is_true(var_8.terminal.terminaldisabled)) {
        var_8 hudoutlineenableforclients(var_2, var_0, 1);
      } else {
        var_8 hudoutlineenableforclients(var_2, var_1, 1);
      }
    }

    if(var_3.size) {
      var_8 hudoutlinedisableforclients(var_3);
    }

    if(var_2.size) {
      var_8 maps\mp\zombies\_terminals::perkterminalcuremodellighton();
      continue;
    }

    var_8 maps\mp\zombies\_terminals::perkterminalcuremodellightoff();
  }
}

hostzombieupdateendtime() {
  self endon("disconnect");
  self endon("bleedout");
  self endon("cured");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.health = 100;

    if(isscriptedagent(var_1)) {
      if(var_0 > 50) {
        var_5 = 5000;
      } else {
        var_5 = 3000;
      }
    } else {
      var_5 = var_0 * 100;
    }

    self.infectedendtime = self.infectedendtime - var_5;
    self notify("infectedEntTimeUpdate", var_5);
  }
}

hostzombietokencured() {
  hostzombietokencuredwait();

  if(isDefined(self)) {
    maps\mp\zombies\_util::cleartokenuseomnvars();
  }
}

hostzombietokencuredwait() {
  self endon("hostZombieEnd");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 = 90000;
  var_1 = undefined;

  for(;;) {
    if(isDefined(self.tokenbuttonpressed) && self.tokenbuttonpressed && !isDefined(self playergetuseent(1)) && maps\mp\gametypes\zombies::hastoken(10)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
        maps\mp\zombies\_util::settokenuseomvars();
      }

      if(gettime() >= var_1) {
        maps\mp\gametypes\zombies::spendtoken(10);
        self setwatersheeting(1, 0.5);
        var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

        foreach(var_4 in var_2) {
          if(isDefined(var_4.agent_type) && var_4.agent_type == "zombie_host" && distance2dsquared(var_4.origin, self.origin) < var_0) {
            var_4 suicide();
          }
        }

        self notify("cured", 1);
        return;
      }
    } else if(isDefined(var_1)) {
      var_1 = undefined;
      maps\mp\zombies\_util::cleartokenuseomnvars();
    }

    waitframe();
  }
}

hostzombiewaitcured() {
  self endon("hostZombieEnd");
  self endon("disconnect");
  self waittill("cured", var_0);
  thread hostzombieend(var_0);
}

hostzombiewaitbleedout() {
  self endon("hostZombieEnd");
  self endon("disconnect");
  self waittill("bleedout");
  thread hostzombieend(0);
}

hostzombieend(var_0) {
  self notify("hostZombieEnd");
  self.infected = 0;

  if(var_0) {
    thread playercureignore();
  }

  level notify("player_cured", self);
  self stopshellshock();
  hostzombieupdateoutline();
}

playercureignore() {
  self notify("playerCureIgnore");
  self endon("playerCureIgnore");
  self endon("disconnect");
  var_0 = 5;

  if(level.players.size == 1) {
    var_0 = 8;
  }

  thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(var_0);
}

spawnplayerhostzombie(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  playFX(common_scripts\utility::getfx("gib_full_body"), var_1.origin, (1, 0, 0));
  waitframe();
  var_2 = undefined;
  var_3 = undefined;

  switch (var_0.characterindex) {
    case 0:
      var_2 = "security_host";
      var_3 = "zombie_eye_host_security";
      break;
    case 1:
      var_2 = "exec_host";
      var_3 = "zombie_eye_host_exec";
      break;
    case 2:
      var_2 = "it_host";
      var_3 = "zombie_eye_host_it";
      break;
    case 3:
    default:
      if(maps\mp\zombies\_util::getzombieslevelnum() < 3) {
        var_2 = "janitor_host";
        var_3 = "zombie_eye_host_janitor";
      } else {
        var_2 = "pilot_host";
        var_3 = "zombie_eye_host_pilot";
      }

      break;
  }

  var_4 = maps\mp\zombies\_zombies::spawnzombie("zombie_host", var_1, var_3);
  var_4.hastraversed = 1;
  var_4 thread maps\mp\zombies\_util::setcharactermodel(var_2, 1);
  var_5 = 4;
  var_4.maxhealth = var_4.maxhealth * var_5;
  var_4.health = var_4.health * var_5;
  maps\mp\zombies\_zombies_audio_announcer::announcerhostturndialog();
}

hostzombieheartbeat(var_0) {
  var_1 = [];
  var_1[var_1.size] = "zmb_infected_low";
  var_1[var_1.size] = "zmb_infected_med";
  var_1[var_1.size] = "zmb_infected_high";

  if(!var_1.size) {
    return;
  }
  var_2 = 0;

  while(isDefined(var_2) && var_2 < var_1.size) {
    var_3 = hostzobieheartbeatgetent();
    var_3 playsoundonmovingent(var_1[var_2]);
    var_3 scalevolume(1);
    var_3.inuse = 1;
    var_2 = hostzombieheartbeatnextstage(var_2, var_1.size, var_0);
    var_4 = 0.5;

    if(!isDefined(var_2)) {
      var_4 = 0;
    }

    var_3 thread hostzombieheartbeatstop(var_4);
  }
}

hostzobieheartbeatgetent() {
  var_0 = undefined;
  var_1 = getEntArray("infected_heart_beat", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.inuse) || !var_3.inuse) {
      var_0 = var_3;

      if(!isDefined(var_3.owner) || var_3.owner == self) {
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0.targetname = "infected_heart_beat";
  }

  var_0.owner = self;
  var_0 hide();
  var_0 showtoplayer(self);
  return var_0;
}

hostzombieheartbeatnextstage(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("bleedout");
  self endon("cured");

  for(;;) {
    var_3 = (self.infectedendtime - gettime()) / 1000;
    var_4 = int((1.0 - var_3 / var_2) * var_1);

    if(var_4 != var_0) {
      return var_4;
    }

    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    waitframe();
  }
}

hostzombieheartbeatstop(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    self scalevolume(0, 0.5);
    wait(var_0);
  }

  self stopsounds();
  self.inuse = 0;
}

hostzombiecuredsound() {
  self endon("death");
  self endon("bleedout");
  self endon("disconnect");
  self waittill("cured");
  self playlocalsound("zmb_infected_cured");
}

hostzombiehud(var_0) {
  thread hostzombiehudvisionset(var_0);
  self shellshock("zm_infected_start", 2);
  thread hostzombiehudfadetoblack(var_0);
  thread hostzombiehudcountdown(var_0);
  thread hostzombiehudcountdownhostmigration();
}

hostzombiehudvisionset(var_0) {
  self endon("disconnect");

  if(maps\mp\zombies\_util::iszombieshardmode() && isDefined(level.zombiehardmodeinfectedvisionset)) {
    self.hostvisionset = level.zombiehardmodeinfectedvisionset;
    self visionsetpostapplyforplayer(level.zombiehardmodeinfectedvisionset, 0.5);
  } else if(isDefined(level.zombieinfectedvisionset)) {
    self.hostvisionset = level.zombieinfectedvisionset;
    self visionsetpostapplyforplayer(level.zombieinfectedvisionset, 0.5);
    thread hostzombievisionset2(var_0 / 2.0);
  }

  if(isDefined(level.zombieinfectedlightset)) {
    self lightsetoverrideenableforplayer(level.zombieinfectedlightset);
  }

  self clientaddsoundsubmix("infected");
  hostzombiehudvisionsetwait(var_0);
  self clientclearsoundsubmix("infected");
  var_1 = "";
  var_2 = 0;

  if(maps\mp\zombies\_util::iszombieshardmode() && isDefined(level.zombiehardmodevisionset)) {
    var_1 = level.zombiehardmodevisionset;
    var_2 = 0.5;
  }

  if(isDefined(level.zombieinfectedvisionset)) {
    self visionsetpostapplyforplayer(var_1, var_2);
  }

  if(isDefined(level.zombieinfectedlightset)) {
    self lightsetoverrideenableforplayer();
  }
}

hostzombiehudvisionsetwait(var_0) {
  self endon("death");
  self endon("bleedout");
  self endon("cured");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

hostzombievisionset2(var_0) {
  self endon("death");
  self endon("bleedout");
  self endon("cured");
  self endon("disconnect");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(isDefined(level.zombieinfectedvisionset2)) {
    self.hostvisionset = level.zombieinfectedvisionset2;
    self visionsetpostapplyforplayer(level.zombieinfectedvisionset2, 0.5);
  }
}

hostzombiehudfadetoblack(var_0) {
  self endon("disconnect");
  self endon("bleedout");
  self endon("cured");

  if(isDefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive) {
    var_1 = (self.infectedendtime - gettime()) * 0.001 - 60;
    wait(var_1);
  }

  var_2 = 0.0;
  var_3 = 0.85;
  var_4 = hostzombiehudfullscreen("black");
  var_4.sort = 1;
  var_4 thread hostzombiehudcleanup(self);

  for(;;) {
    var_5 = (self.infectedendtime - gettime()) / 1000;

    if(var_5 <= 0) {
      return;
    }
    var_6 = 1.0 - var_5 / var_0;
    var_6 = clamp(var_6, 0.0, 1.0);
    var_4.alpha = var_2 + (var_3 - var_2) * var_6;
    var_4 fadeovertime(var_5);
    var_4.alpha = var_3;
    self waittill("infectedEntTimeUpdate");
  }
}

hostzombiehudcountdown(var_0) {
  self endon("disconnect");
  self endon("bleedout");
  self endon("cured");
  var_1 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
  setomnvar(var_1, self.infectedendtime);
  thread hostzombieomnvarcleanup();

  for(;;) {
    var_2 = (self.infectedendtime - gettime()) / 1000;
    var_2 = max(var_2, 0.1);
    self waittill("infectedEntTimeUpdate", var_3);
    setomnvar(var_1, self.infectedendtime);
  }
}

hostzombiehudcountdownhostmigration() {
  self endon("disconnect");
  self endon("bleedout");
  self endon("cured");

  for(;;) {
    level waittill("host_migration_begin");
    var_0 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
    setomnvar(var_0, 0);
    var_1 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    self clientaddsoundsubmix("infected");

    if(isDefined(self.hostvisionset)) {
      self visionsetpostapplyforplayer(self.hostvisionset, 0);
    }

    if(isDefined(level.zombieinfectedlightset)) {
      self lightsetoverrideenableforplayer(level.zombieinfectedlightset);
    }

    self.infectedendtime = self.infectedendtime + var_1;
    self notify("infectedEntTimeUpdate", var_1);
  }
}

hostzombieomnvarcleanup() {
  self endon("disconnect");
  var_0 = common_scripts\utility::waittill_any_return("cured", "death", "becameSpectator");
  var_1 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
  setomnvar(var_1, 0);

  if(isDefined(var_0) && var_0 != "cured") {
    var_1 = "ui_zm_character_" + self.characterindex + "_alive";
    setomnvar(var_1, 0);
  }
}

hostzombiehudcleanup(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 common_scripts\utility::waittill_any("cured", "death", "becameSpectator");
  self destroy();
}

hostzombiehudfullscreen(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader(var_0, 640, 480);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  return var_1;
}
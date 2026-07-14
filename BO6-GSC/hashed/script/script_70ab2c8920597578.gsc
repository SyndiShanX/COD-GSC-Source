/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_70ab2c8920597578.gsc
*****************************************************/

#using script_232f31def1450dbb;
#using script_3798db193e76a866;
#using scripts\anim\notetracks_sp;
#using scripts\asm\asm_sp;
#using scripts\common\concussion_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\damagefeedback;
#using scripts\sp\hud_util;
#using scripts\sp\missilelauncher;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\vehicle;
#namespace namespace_b45fb163fb1def48;

function init() {
  level.var_7c5adddee8ed81c3 = &utility::issharedfuncdefined;
  level.var_ed8336091f09eea4 = &utility::getsharedfunc;
  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  perk_init();
  player_init();
  vehicle_init();
  game_init();
  spawn_init();
  emp_init();
  execution_init();
  entity_init();
  weapons_init();
  damage_init();
  sound_init();
  flares_init();
  shellshock_init();
  fx_init();
  ai_init();
  bots_init();
  agents_init();
  outline_init();
  game_utility_init();
  rank_init();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  challenges_init();
  function_6565c0a533bcf33b();
  stealth_init();
  gameskill_init();
  poi_init();
  aggregator_init();
  level thread activities_init();
  function_da61af19396a02ed();
  cameras_init();
  function_9b2fc394968feb51();
  battlechatter_init();
  host_migration_init();
  function_d83887c1b49a5f();
  utility::flag_set("\x9b\x86\vN\xca#\xaf\xcc\xae\x9b\x1b\x1d\xb4\xde\x9bs\xbe\xd2\xe6-\xd1KX\xb1-=\xb2F");
}

function gameskill_init() {}

function poi_init() {}

function stealth_init() {}

function anim_init() {
  utility::registersharedfunc(#"anim", #"scriptmodelplayanimdeltamotion", &scriptmodelplayanimdeltamotion_sp);
  utility::registersharedfunc(#"anim", #"asm_playfacialanim", &asm_sp::asm_playfacialanim_sp);
  utility::registersharedfunc(#"anim", #"handlenotetrack", &notetracks_sp::handlenotetrack);
}

function hud_init() {}

function killstreak_init() {
  utility::registersharedfunc(#"killstreak", #"createstreakinfo", &killstreaks::createstreakinfo);
  utility::registersharedfunc(#"killstreak", #"streakdeploy_doweapontabletdeploy", &killstreaks::function_1b81d98bbcabbe2);
  utility::registersharedfunc(#"killstreak", #"getkillstreakairstrikeheightent", &killstreaks::getkillstreakairstrikeheightent);
  utility::registersharedfunc(#"killstreak", #"killstreak_setMainVision", &killstreaks::killstreak_setmainvision);
  utility::registersharedfunc(#"killstreak", #"killstreak_setSubVision", &killstreaks::killstreak_setsubvision);
  utility::registersharedfunc(#"killstreak", #"restorekillstreakplayerangles", &killstreaks::restorekillstreakplayerangles);
  utility::registersharedfunc(#"killstreak", #"killstreak_setupVehicleDamageFunctionality", &killstreaks::killstreak_setupvehicledamagefunctionality);
  utility::registersharedfunc(#"killstreak", #"streakdeploy_doweaponfireddeploy", &killstreaks::function_65f8dabf1a67c54d);
  utility::registersharedfunc(#"killstreak", #"streakdeploy_doweaponswitchdeploy", &killstreaks::function_4e6d4115da4697a1);
  utility::registersharedfunc(#"killstreak", #"registerKillstreakDamageDealingWeapon", &killstreaks::registerkillstreakdamagedealingweapon);
  utility::registersharedfunc(#"killstreak", #"killstreak_switchBackLastWeapon", &killstreaks::killstreak_switchbacklastweapon);
  utility::registersharedfunc(#"killstreak", #"getridofkillstreakdeployweapon", &killstreaks::getridofkillstreakdeployweapon);
  utility::registersharedfunc(#"killstreak", #"killstreakmakevehicle", &killstreaks::function_e6afb7791ed8cc3b);
  utility::registersharedfunc(#"killstreak", #"registervisibilityomnvarforkillstreak", &killstreaks::registervisibilityomnvarforkillstreak);
  utility::registersharedfunc(#"killstreak", #"setVisibiilityOmnvarForKillstreak", &killstreaks::setvisibiilityomnvarforkillstreak);
  utility::registersharedfunc(#"killstreak", #"killstreak_explosionnearai", &killstreaks::killstreak_explosionnearai);
  utility::registersharedfunc(#"killstreak", #"playerkillstreakgetownerlookatignoreents", &killstreaks::playerkillstreakgetownerlookatignoreents);
  utility::registersharedfunc(#"chopper_gunner", #"assigntargetmarkers", &killstreaks::killstreak_assigntargetmarkers);
  utility::registersharedfunc(#"gunship", #"assigntargetmarkers", &killstreaks::killstreak_assigntargetmarkers);
  utility::registersharedfunc(#"cruise_predator", #"assigntargetmarkers", &killstreaks::killstreak_assigntargetmarkers);
  utility::registersharedfunc(#"killstreak_shared", #"assigntargetmarkers", &killstreaks::killstreak_assigntargetmarkers);
}

function equipment_init() {
  utility::registersharedfunc(#"shellshock", #"concussioninterruptdelayfunc", &concussion_utility::calculateinterruptdelay);
  utility::registersharedfunc(#"equipment", #"getMineIgnoreList", &function_93723523658d8998);
  utility::registersharedfunc(#"equipment", #"watchFlightCollision", &watchflightcollision);
}

function entity_init() {}

function perk_init() {}

function player_init() {
  utility::registersharedfunc(#"player", #"_isalive", &playerisalive);
  utility::registersharedfunc(#"player", #"fadetoblackforplayer", &fadetoblackforplayer);
  utility::registersharedfunc(#"player", #"freezecontrols", &function_af729f77060047bf);
  utility::registersharedfunc(#"player", #"getSuperFaction", &getsuperfactionsp);
  utility::registersharedfunc(#"player", #"getplayersinradius", &player_sp::script_getplayersinradius);
  utility::registersharedfunc(#"player", #"get_rumble_ent", &utility_sp::get_rumble_ent);
  utility::registersharedfunc(#"player", #"rumble_ramp_to", &utility_sp::rumble_ramp_to);
  utility::registersharedfunc(#"player", #"playerhide", &playerhide);
  utility::registersharedfunc(#"player", #"playershow", &playershow);
  utility::registersharedfunc(#"player", #"playersareenemies", &playersareenemies);
  utility::registersharedfunc(#"player", #"ishost", &utility::always_true);
  utility::registersharedfunc(#"player", #"getPlayerGuid", &player_sp::getplayerguid);
  utility::registersharedfunc(#"player", #"controlturreton", &function_36aaaac6dc94a71f);
  utility::registersharedfunc(#"player", #"controlturretoff", &function_5cfa65682417323);
  utility::registersharedfunc(#"player", #"enableplayeruse", &enableplayerusesp);
  utility::registersharedfunc(#"player", #"disableplayeruse", &disableplayerusesp);
  utility::registersharedfunc(#"player", #"hash_da573849b1275dfb", &utility_sp::player_gesture_combat);
  val::register("p6\v\xe5\xb2r_\x99o9\xaf\xdc\xe0,\xee7}l{;\xd26", 1, 0, "\x127\xca\x8d3", &utility::empty_init_func, "~\xa9\xccdcE");
  level.enableexecutionattackfunc = &utility::empty_init_func;
  level.disableexecutionattackfunc = &utility::empty_init_func;
}

function playersareenemies(firstplayer, secondplayer, var_7fda5c8b4c4dcefc) {
  return firstplayer != secondplayer;
}

function host_migration_init() {
  utility::registersharedfunc(#"hostmigration", #"waitLongDurationWithPause", &function_b9b2e429edc101de);
}

function vehicle_init() {
  utility::registersharedfunc(#"vehicle", #"vehicle_drivershowviewmodel", &vehicle::function_626a1e107fcccc44);
  utility::registersharedfunc(#"vehicle", #"vehicleMinesGetLevelDataForMine", &vehicle::function_d99afe8cca2ec06e);
  utility::registersharedfunc(#"vehicle", #"vehicleFindSafeExitPos", &vehicle::function_daf07ebacb30997d);
  utility::registersharedfunc(#"vehicle", #"vehicleminesisfriendlytomine", &vehicle::vehicle_isfriendlytomine);
  utility::registersharedfunc(#"vehicle", #"vehicleminesshouldvehicletriggermine", &vehicle::vehicle_shouldvehicletriggermine);
  utility::registersharedfunc(#"vehicle", #"vehicleminesminetrigger", &vehicle::vehicle_minetrigger);
  utility::registersharedfunc(#"vehicle", #"spawn_vehicle_sp_only", &vehicle::spawn_vehicle);
  utility::registersharedfunc(#"vehicle", #"spawn_vehicle_and_gopath_sp_only", &vehicle::spawn_vehicle_and_gopath);
}

function game_init() {
  utility::registersharedfunc(#"game", #"getplayerprogression", &getplayerprogression);
  utility::registersharedfunc(#"game", #"setplayerprogression", &setplayerprogression);
  utility::registersharedfunc(#"game", #"getplayerprofiledata", &getlocalplayerprofiledata);
  utility::registersharedfunc(#"game", #"gettracecontents", &gettracecontents);
  utility::registersharedfunc(#"game", #"IsMagellanMode", &utility::always_false);
}

function spawn_init() {}

function emp_init() {}

function execution_init() {
  utility::registersharedfunc(#"executions", #"is_in_takedown", &utility::function_2e65191ae41e3eed);
}

function weapons_init() {
  utility::registersharedfunc(#"weapons", #"switchtoweapon", &switchtoweapon);
  utility::registersharedfunc(#"weapons", #"switchtoweaponimmediate", &switchtoweaponimmediate);
  utility::registersharedfunc(#"weapons", #"minedamagemonitor", &grenadedamagemonitor);
  utility::registersharedfunc(#"weapons", #"_launchgrenade", &launchgrenade_sp);
  utility::registersharedfunc(#"weapons", #"getridofweapon", &namespace_ce85794d215160e3::getridofweapon);
  utility::registersharedfunc(#"weapons", #"forcevalidweapon", &namespace_ce85794d215160e3::forcevalidweapon);
  utility::registersharedfunc(#"weapons", #"domonitoredweaponswitch", &namespace_ce85794d215160e3::domonitoredweaponswitch);
  utility::registersharedfunc(#"weapons", #"isswitchingtoweaponwithmonitoring", &namespace_ce85794d215160e3::isswitchingtoweaponwithmonitoring);
  utility::registersharedfunc(#"weapons", #"abortmonitoredweaponswitch", &namespace_ce85794d215160e3::abortmonitoredweaponswitch);
  utility::registersharedfunc(#"weapons", #"giveweapon", &namespace_ce85794d215160e3::_giveweapon);
  utility::registersharedfunc(#"weapons", #"takeweapon", &namespace_ce85794d215160e3::_takeweapon);
  utility::registersharedfunc(#"weapons", #"iscurrentweapon", &namespace_ce85794d215160e3::iscurrentweapon);
  utility::registersharedfunc(#"weapons", #"isSharpMeleeWeapon", &utility::always_false);
  utility::registersharedfunc(#"weapons", #"magicbullet", &magicbullet_sp);
  utility::registersharedfunc(#"weapons", #"lockOnLauncherGetTargetArray", &missilelauncher::lockonlaunchergettargetarray);
  utility::registersharedfunc(#"weapons", #"isMissileLauncherLockOnAllowed", &missilelauncher::ismissilelauncherlockonallowed);
}

function damage_init() {
  utility::registersharedfunc(#"damage", #"isheadshot", &damagefeedback::isheadshot);
}

function sound_init() {
  utility::registersharedfunc(#"sound", #"playsoundtoplayer", &playsoundtoplayer_sp);
}

function flares_init() {}

function shellshock_init() {}

function fx_init() {
  utility::registersharedfunc(#"fx", #"spawnfxforclient", &spawnfxforclient_sp);
}

function ai_init() {
  utility::registersharedfunc(#"ai", #"giveAIWeapon", &giveaiweapon_sp);
  utility::registersharedfunc(#"ai", #"getfreeaicount", &getfreeaicount_sp);
  utility::registersharedfunc(#"ai", #"spawnnewaitype_sharedfunc", &spawnnewaitype_sp);
  utility::registersharedfunc(#"ai", #"get_aitype_by_subclass_sharedfunc", &function_86158d9597552918);
  utility::registersharedfunc(#"ai", #"getcorpseentity", &function_d58b3b116fe2090c);
}

function bots_init() {}

function agents_init() {}

function outline_init() {}

function game_utility_init() {}

function rank_init() {}

function supers_init() {}

function gamescore_init() {}

function pers_init() {}

function dlog_init() {}

function challenges_init() {}

function function_6565c0a533bcf33b() {}

function aggregator_init() {}

function cameras_init() {}

function function_9b2fc394968feb51() {}

function battlechatter_init() {}

function function_da61af19396a02ed() {
  utility::registersharedfunc(#"cursor_hint", #"create", &cursor_hint::create_cursor_hint);
  utility::registersharedfunc(#"cursor_hint", #"remove", &cursor_hint::remove_cursor_hint);
}

function function_d83887c1b49a5f() {
  utility::create_func_ref("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", &setsaveddvar);
}

function activities_init() {
  while(!isDefined(level.script)) {
    waitframe();
  }

  activityname = level.script;
  mapbundle = function_cbe75068ad1ba418();

  if(isstring(mapbundle.activityname)) {
    activityname = mapbundle.activityname;
  }

  if(isstring(activityname)) {
    startactivity(activityname);
  }
}

function private function_b9b2e429edc101de(delay = 0) {
  if(delay > 0) {
    wait delay;
  }
}

function private playsoundtoplayer_sp(aliasname, player, srcentity) {
  if(soundexists(aliasname)) {
    self playSound(aliasname);
  }
}

function private spawnfxforclient_sp(fxid, position, player, forward, up) {
  assert(isDefined(level.player) && player == level.player);
  return spawnfx(fxid, position, forward, up);
}

function private giveaiweapon_sp(weapname) {
  self.weapon = weapname;
}

function private getfreeaicount_sp() {
  return getfreeaicount();
}

function private spawnnewaitype_sp(aitype, position, angles, team, characterlistname, gender) {
  newai = dospawnaitype(aitype, position, angles, 1, undefined, undefined, undefined, undefined, characterlistname);

  if(isDefined(newai)) {
    newai thread spawner::spawn_think();
  }

  return newai;
}

function private function_86158d9597552918(subclass) {
  if(isDefined(level.var_e5429a7e5d5b1ed1) && isDefined(level.var_e5429a7e5d5b1ed1[subclass])) {
    return utility::array_randomize(level.var_e5429a7e5d5b1ed1[subclass]);
  }

  return [];
}

#using_animtree("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");

function private scriptmodelplayanimdeltamotion_sp(animname, notifystring, animstarttimeseconds, blendtype) {
  animation = function_299a4852289c6102(animname, #animtree);

  if(isDefined(animation)) {
    if(!isDefined(notifystring)) {
      notifystring = "\x0e\x87\x8a^\xcbw\x98\b\xe7\xf2\xa2Ri";
    }

    self useanimtree(#animtree);
    self animScripted(notifystring, self.origin, self.angles, animation);

    if(isDefined(animstarttimeseconds)) {
      coef = animstarttimeseconds / getanimlength(animation);
      self setanimtime(animname, coef);
    }
  }
}

function fadetoblackforplayer(player, fadetoblack, fadetime = 0) {
  if(istrue(fadetoblack)) {
    hud_util::fade_out(fadetime, "\x8a-\v\xa1\xbd");
    return;
  }

  hud_util::fade_in(fadetime, "\x8a-\v\xa1\xbd");
}

function function_af729f77060047bf(frozen, force, debug) {
  if(frozen) {
    val::set("mi\xf9\xb6\x047\x03\x19\xa5y", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", frozen);
    return;
  }

  val::reset("mi\xf9\xb6\x047\x03\x19\xa5y", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[");
}

function getsuperfactionsp(player) {
  return false;
}

function playerisalive() {
  return isalive(self);
}

function gettracecontents(contentsfor = "\x91\xca\xcc\v\xab\xd8:") {
  switch (contentsfor) {
    case #"hash_7038dec66d8275be":
    default:
      return ["\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "f$\xa6\xed\x03\xf1\xd9p*\x10\xc0\xae!\xd6\xdep?\x81\x9f\xcc\xa9\t`\x87", "\x998b\x97\xb6Y\xbb\x05\x82\x19\xfb7\xb3\xfb\x9b\\\xdbx3\x14\xc6zp\a\xe4\xfe9", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae.", "H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4"];
  }
}

function enableplayerusesp(player) {
  self makeusable();
}

function disableplayerusesp(player) {
  self makeunusable();
}

function grenadedamagemonitor(hitsmax) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self setCanDamage(1);
  self.health = 100000;
  self.maxhealth = 100000;
  hits = hitsmax ?? 1;

  while(true) {
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker) && !isactor(attacker)) {
      if(isDefined(attacker.owner) && (isPlayer(attacker.owner) || isactor(attacker.owner))) {
        attacker = attacker.owner;
      }
    }

    if(!isPlayer(attacker) && !isactor(attacker)) {
      continue;
    }

    if(isPlayer(attacker)) {
      damagefeedback::damagefeedback_took_damage(1, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
    }

    hits -= 1;

    if(hits <= 0) {
      break;
    }
  }

  self notify("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self notify("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej", attacker);
}

function launchgrenade_sp(weaponname, origin, velocity, var_b966691b2aaee324, notthrown, var_c06e1b0df088b79d, tickpercentoverride) {
  return magicgrenademanual(weaponname, origin, velocity, var_b966691b2aaee324);
}

function function_93723523658d8998() {
  ignorelist = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders) {
      ignorelist[ignorelist.size] = struct.ents[0];
    }
  }

  linkedents = self getlinkedchildren(1);

  if(!isDefined(linkedents)) {
    linkedents = [];
  }

  linkedents[linkedents.size] = self getlinkedparent();

  foreach(linkedent in linkedents) {
    if(isDefined(linkedent) && linkedent.classname == ",\xe1\x93So\x98\r") {
      ignorelist[ignorelist.size] = linkedent;
    }
  }

  return ignorelist;
}

function magicbullet_sp(objweapon, start, end, owner, event_ent) {
  assert(!isstring(objweapon), "<dev string:x24>");
  missile = magicbullet(objweapon, start, end, owner, event_ent);

  if(isDefined(missile) && isDefined(owner)) {
    missile setotherent(owner);
  }

  return missile;
}

function watchflightcollision() {
  original_pos = self.origin;

  while(true) {
    self waittill("\x95\xad\xa7\xf3\xcf^l\xb9)\xad\xbb\xba\xb0\xf4b\x87(", platform);

    if(isDefined(platform) && self istouching(platform) && self.origin[2] - original_pos[2] > 12) {
      self notify("\xcc4H\x84pw\x9d\x81\f__\xb8X\xf5\xcd\x9d\x97\x99m\xab:A\xb7");
      return;
    }
  }
}

function function_36aaaac6dc94a71f() {
  assertmsg("<dev string:x69>");
}

function function_5cfa65682417323() {
  assertmsg("<dev string:x69>");
}

function function_d58b3b116fe2090c() {
  assertmsg("<dev string:x69>");
}
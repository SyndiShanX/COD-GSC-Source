/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\init.gsc
**************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\combat_utility;
#using scripts\anim\cqb;
#using scripts\anim\face;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\squadmanager;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\load;
#using scripts\sp\names;
#using scripts\sp\player\playerchatter;
#using scripts\sp\utility;
#namespace init;

function main() {
  if(!utility::flag_exist("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca")) {
    utility::flag_init("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");
  }

  if(!isDefined(self.export)) {
    self.export = -1;
  }

  setupuniqueanims();

  if(self.type != "\x9b\x11\"\xd6\xfb;") {
    utility::setupsoldierdefaults();
    thread shared::setupweapons();
  }

  thread offhands::offhandfiremanager();

  if(!isDefined(level.disablemonitorflash)) {
    thread combat_utility::monitorflash();
  }

  thread ondeath();

  if(!getdvarint(@ "hash_e6afce2cf5cf7515")) {
    self pushplayer(0);
  }

  if(self.type != "\x9b\x11\"\xd6\xfb;") {
    thread setnameandrank_andaddtosquad();
  }

  if(isDefined(level.aitypeinitfuncs) && isDefined(level.aitypeinitfuncs[self.classname])) {
    self[[level.aitypeinitfuncs[self.classname]]]();
  }

  self.fnachievements = &achievement_death_tracker;
}

function shouldforceupdatebt() {
  return isDefined(self.bt.forceupdate) && self.bt.forceupdate;
}

function weapons_with_ir(weapon) {
  weapons[0] = "\x03\xf8>\xf3t\n\x16\f\x8c\xd6\r\xc4";
  weapons[1] = "\xa1M\xcf\xac\xaa\xf7\x9e-";
  weapons[2] = "=\x1cU2E\r\xe0cn\xe2\x93";
  weapons[3] = "%\xe4\xe44\x89\xb9";

  if(!isDefined(weapon)) {
    return false;
  }

  for(i = 0; i < weapons.size; i++) {
    if(issubstr(weapon, weapons[i])) {
      return true;
    }
  }

  return false;
}

function setnameandrank_andaddtosquad() {
  self endon("\x1e\xfd\xd1\xa2\a");
  names::get_name();
  thread squadmanager::addtosquad();
}

function pollallowedstancesthread() {
  for(;;) {
    if(self isstanceallowed("<dev string:x24>")) {
      line[0] = "<dev string:x2d>";
      color[0] = (0, 1, 0);
    } else {
      line[0] = "<dev string:x3e>";
      color[0] = (1, 0, 0);
    }

    if(self isstanceallowed("<dev string:x53>")) {
      line[1] = "<dev string:x5d>";
      color[1] = (0, 1, 0);
    } else {
      line[1] = "<dev string:x6f>";
      color[1] = (1, 0, 0);
    }

    if(self isstanceallowed("<dev string:x85>")) {
      line[2] = "<dev string:x8e>";
      color[2] = (0, 1, 0);
    } else {
      line[2] = "<dev string:x9f>";
      color[2] = (1, 0, 0);
    }

    abovehead = self getshootatpos() + (0, 0, 30);
    offset = (0, 0, -10);

    for(i = 0; i < line.size; i++) {
      textpos = (abovehead[0] + offset[0] * i, abovehead[1] + offset[1] * i, abovehead[2] + offset[2] * i);
      print3d(textpos, line[i], color[i], 1, 0.75);
    }

    wait 0.05;
  }
}

function setupuniqueanims() {
  if(!(isDefined(self.animplaybackrate) && isDefined(self.moveplaybackrate))) {
    set_anim_playback_rate();
  }
}

function set_anim_playback_rate() {
  self.animplaybackrate = 0.97 + randomfloat(0.13);
  self.movetransitionrate = 0.97 + randomfloat(0.13);
  self.moveplaybackrate = self.movetransitionrate;
  self.sidesteprate = 1.35;
}

function infiniteloop(one, two, three, whatever) {
  anim waittill("\x83[x\xee\xe8AR\xcd\xb5\x0e\xe8\x0e6\x11");
}

function empty(one, two, three, whatever) {}

function initdeveloperdvars() {
  if(getDvar(@ "hash_993202a1929383dc") == "<dev string:xb4>") {
    setDvar(@ "hash_993202a1929383dc", "<dev string:xb8>");
  } else if(getDvar(@ "hash_993202a1929383dc") == "<dev string:xbf>") {
    anim.defaultexception = &infiniteloop;
  }

  if(getDvar(@ "hash_27494f1d75fc0809") == "<dev string:xb4>") {
    setDvar(@ "hash_27494f1d75fc0809", "<dev string:xb8>");
  }

  if(getDvar(@ "hash_c407a6f2012f4956") == "<dev string:xb4>") {
    setDvar(@ "hash_c407a6f2012f4956", "<dev string:xc5>");
  }

  if(getDvar(@ "anim_debug") == "<dev string:xb4>") {
    setDvar(@ "anim_debug", "<dev string:xb4>");
  }

  if(getDvar(@ "debug_misstime") == "<dev string:xb4>") {
    setDvar(@ "debug_misstime", "<dev string:xb4>");
  }
}

function initbattlechatter() {
  if(!isDefined(anim.player.team)) {
    anim.player.team = "O\x15\x1b\xad\x9ff";
  }

  shared::init_squadmanager();
  battlechatter::init_battlechatter();
  anim.player thread playerchatter::playeranimnameswitch();
  anim.player thread squadmanager::addtosquad();
}

function initgrenades() {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    aisetgrenadetimer(player, "\xe8\xb1\xb2h\x04@", randomintrange(1000, 20000));
    aisetgrenadetimer(player, "\xc5R\xc9n\xc2\xed\xccL", randomintrange(1000, 20000));
    player thread setnextplayergrenadetime();
  }

  aisetgrenadetimer(undefined, "\xe8\xb1\xb2h\x04@", randomintrange(0, 20000));
  aisetgrenadetimer(undefined, "\xc5R\xc9n\xc2\xed\xccL", randomintrange(0, 20000));
}

function setnextplayergrenadetime() {
  assert(isPlayer(self));
  waittillframeend();

  if(isDefined(self.gs.playergrenaderangetime)) {
    maxtime = int(self.gs.playergrenaderangetime * 0.7);

    if(maxtime < 1) {
      maxtime = 1;
    }

    aisetgrenadetimer(self, "\xe8\xb1\xb2h\x04@", randomintrange(0, maxtime));
  }

  if(isDefined(self.gs.playerdoublegrenadetime)) {
    maxtime = int(self.gs.playerdoublegrenadetime);
    mintime = int(maxtime / 2);

    if(maxtime <= mintime) {
      maxtime = mintime + 1;
    }

    function_9d36d2d620e7536(self, randomintrange(mintime, maxtime));
  }
}

function ondeath() {
  if(isDefined(level.disablestrangeondeath)) {
    return;
  }

  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self)) {
    if(isDefined(self.a.usingturret)) {
      self.a.usingturret delete();
    }
  }
}

function firstinit() {
  setdvarifuninitialized(@ "hash_f53ba58df3983a20", "<dev string:xbf>");
  setdvarifuninitialized(@ "hash_a19781010239d2e6", "<dev string:xb4>");
  setdvarifuninitialized(@ "hash_5fa8fd0b6bdb960", "<dev string:xb4>");
  setdvarifuninitialized(@ "hash_326268c4fc6f45f9", 0);

  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  load::anim_earlyinit();
  level.nextgrenadedrop = randomint(3);
  anim.defaultexception = &empty;

  if(!isDefined(level.g_effect)) {
    level.g_effect = [];
  }

  initdeveloperdvars();
  names::setup_names();
  shared::initanimvars();
  asm_sp::function_ed85ed7dad46d8b();
  ai::function_b3d799e0f9e68a3f();
  initgrenades();
  shared::initmeleecharges();
  level.fngetcorpsearrayfunc = &getcorpsearraysp;

  if(!isDefined(anim.optionalstepeffectfunction)) {
    anim.fnfootstepeffectsmall = &notetracks_sp::playfootstepeffectsmall;
    anim.fnfootstepeffect = &notetracks_sp::playfootstepeffect;
  }

  if(!isDefined(anim.fnfootprinteffect)) {
    anim.fnfootprinteffect = &notetracks_sp::playfootprinteffect;
  }

  if(getdvarint(@ "hash_5e3944acaebdd5a0", 0) == 1) {}

  notetracks_sp::registernotetracksifnot();
  utility_sp::setupglobalcallbackfunctions_sp();

  setdvarifuninitialized(@ "debug_delta", "<dev string:xb8>");

  level.painai = undefined;
  face::initlevelface();

  if(!isDefined(anim.chatinitialized)) {
    if(utility::player_is_in_jackal()) {
      anim.player = level.player_jackal;
    } else {
      anim.player = getEntArray("K_p\x84a\x01", #classname)[0];
    }

    initbattlechatter();
  }

  cqb::setupcqbpointsofinterest();
  utility::init_smartobjects();
  shared::setuprandomtable();
  level.player thread combat_utility::watchreloading();
}

function getcorpsearraysp() {
  result = getcorpsearray();
  return result;
}

function achievement_death_tracker() {
  if(!isDefined(self.attacker) || !isPlayer(self.attacker)) {
    return;
  }

  if(!isDefined(self.team) || self.team != "?\xb1\xc0\x9a" && self.team != "\x8c\x1b\xab)\xd1") {
    return;
  }

  if(isDefined(self.damageweapon) && isDefined(self.damagemod) && isDefined(self.damageweapon.basename)) {
    if(self.damagemod == "M\x81\xaf\xee\xc9\xcfD\xef\x91J" && isstartstr(self.damageweapon.basename, "\x89\x18p\xdc9")) {
      level thread utility_sp::giveachievement_wrapper("n[\xbd[Vdir\x95l\xd1");
    }
  }
}
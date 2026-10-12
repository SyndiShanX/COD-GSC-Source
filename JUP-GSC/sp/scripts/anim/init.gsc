/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\init.gsc
***********************************************/



#using scripts\anim\battlechatter;
#using scripts\anim\combat_utility;
#using scripts\anim\cqb;
#using scripts\anim\face;
#using scripts\anim\init;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\squadmanager;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
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
  if(!flag_exist("load_finished")) {
    flag_init("load_finished");
  }

  if(!isDefined(self.export)) {
    self.export = -1;
  }

  setupuniqueanims();

  if(self.type != "zombie") {
    scripts\asm\shared\utility::setupsoldierdefaults();
    thread setupweapons();
  }

  thread scripts\sp\equipment\offhands::offhandfiremanager();

  if(!isDefined(level.disablemonitorflash)) {
    thread monitorflash();
  }

  thread ondeath();

  if(!getdvarint(@ "hash_e6afce2cf5cf7515")) {
    self pushplayer(0);
  }

  if(self.type != "zombie") {
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
  weapons[0] = "m4_grenadier";
  weapons[1] = "m4_grunt";
  weapons[2] = "m4_silencer";
  weapons[3] = "m4m203";

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
  self endon("death");
  scripts\sp\names::get_name();
  thread scripts\anim\squadmanager::addtosquad();
}

function pollallowedstancesthread() {
  for(;;) {
    if(self isstanceallowed("<dev string:x1c>")) {
      line[0] = "<dev string:x22>";
      color[0] = (0, 1, 0);
    } else {
      line[0] = "<dev string:x30>";
      color[0] = (1, 0, 0);
    }

    if(self isstanceallowed("<dev string:x42>")) {
      line[1] = "<dev string:x49>";
      color[1] = (0, 1, 0);
    } else {
      line[1] = "<dev string:x58>";
      color[1] = (1, 0, 0);
    }

    if(self isstanceallowed("<dev string:x6b>")) {
      line[2] = "<dev string:x71>";
      color[2] = (0, 1, 0);
    } else {
      line[2] = "<dev string:x7f>";
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
  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate)) {
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
  anim waittill("new exceptions");
}

function empty(one, two, three, whatever) {}

function initdeveloperdvars() {
  if(getDvar(@ "hash_993202a1929383dc") == "<dev string:x91>") {
    setDvar(@ "hash_993202a1929383dc", "<dev string:x92>");
  } else if(getDvar(@ "hash_993202a1929383dc") == "<dev string:x96>") {
    anim.defaultexception = &scripts\anim\init::infiniteloop;
  }

  if(getDvar(@ "hash_27494f1d75fc0809") == "<dev string:x91>") {
    setDvar(@ "hash_27494f1d75fc0809", "<dev string:x92>");
  }

  if(getDvar(@ "hash_c407a6f2012f4956") == "<dev string:x91>") {
    setDvar(@ "hash_c407a6f2012f4956", "<dev string:x99>");
  }

  if(getDvar(@ "anim_debug") == "<dev string:x91>") {
    setDvar(@ "anim_debug", "<dev string:x91>");
  }

  if(getDvar(@ "debug_misstime") == "<dev string:x91>") {
    setDvar(@ "debug_misstime", "<dev string:x91>");
  }
}

function initbattlechatter() {
  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  init_squadmanager();
  scripts\anim\battlechatter::init_battlechatter();
  anim.player thread scripts\sp\player\playerchatter::playeranimnameswitch();
  anim.player thread scripts\anim\squadmanager::addtosquad();
}

function initgrenades() {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    aisetgrenadetimer(player, "lethal", randomintrange(1000, 20000));
    aisetgrenadetimer(player, "tactical", randomintrange(1000, 20000));
    player thread setnextplayergrenadetime();
  }

  aisetgrenadetimer(undefined, "lethal", randomintrange(0, 20000));
  aisetgrenadetimer(undefined, "tactical", randomintrange(0, 20000));
}

function setnextplayergrenadetime() {
  assert(isPlayer(self));
  waittillframeend();

  if(isDefined(self.gs.playergrenaderangetime)) {
    maxtime = int(self.gs.playergrenaderangetime * 0.7);

    if(maxtime < 1) {
      maxtime = 1;
    }

    aisetgrenadetimer(self, "lethal", randomintrange(0, maxtime));
  }

  if(isDefined(self.gs.playerdoublegrenadetime)) {
    maxtime = int(self.gs.playerdoublegrenadetime);
    mintime = int(maxtime / 2);

    if(maxtime <= mintime) {
      maxtime = mintime + 1;
    }

    function_e4da167dc330b3d3(self, randomintrange(mintime, maxtime));
  }
}

function ondeath() {
  if(isDefined(level.disablestrangeondeath)) {
    return;
  }

  self waittill("death");

  if(!isDefined(self)) {
    if(isDefined(self.a.usingturret)) {
      self.a.usingturret delete();
    }
  }
}

function firstinit() {
  setdvarifuninitialized(@ "hash_f53ba58df3983a20", "<dev string:x96>");
  setdvarifuninitialized(@ "hash_a19781010239d2e6", "<dev string:x91>");
  setdvarifuninitialized(@ "hash_5fa8fd0b6bdb960", "<dev string:x91>");
  setdvarifuninitialized(@ "hash_326268c4fc6f45f9", 0);

  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  scripts\sp\load::anim_earlyinit();
  level.nextgrenadedrop = randomint(3);
  level.lastplayersighted = 100;
  anim.defaultexception = &scripts\anim\init::empty;

  if(!isDefined(level.g_effect)) {
    level.g_effect = [];
  }

  initdeveloperdvars();
  scripts\sp\names::setup_names();
  initanimvars();
  function_a2b8f8b0891ee7fe();
  scripts\common\ai::function_67ec1df786cad61a();
  initgrenades();
  initmeleecharges();
  level.fngetcorpsearrayfunc = &getcorpsearraysp;
  level.fnsetcorpseremovetimerfunc = &setcorpseremovetimersp;

  if(!isDefined(anim.optionalstepeffectfunction)) {
    anim.fnfootstepeffectsmall = &scripts\anim\notetracks_sp::playfootstepeffectsmall;
    anim.fnfootstepeffect = &scripts\anim\notetracks_sp::playfootstepeffect;
  }

  if(!isDefined(anim.fnfootprinteffect)) {
    anim.fnfootprinteffect = &scripts\anim\notetracks_sp::playfootprinteffect;
  }

  if(getdvarint(@ "hash_5e3944acaebdd5a0", 0) == 1) {}

  scripts\anim\notetracks_sp::registernotetracksifnot();
  scripts\engine\sp\utility::setupglobalcallbackfunctions_sp();

  setdvarifuninitialized(@ "debug_delta", "<dev string:x92>");

  level.painai = undefined;
  scripts\anim\face::initlevelface();

  if(!isDefined(anim.chatinitialized)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level.player_jackal;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    initbattlechatter();
  }

  initwindowtraverse();
  scripts\anim\cqb::setupcqbpointsofinterest();
  scripts\smartobjects\utility::init_smartobjects();
  setuprandomtable();
  level.player thread watchreloading();
}

function getcorpsearraysp() {
  result = getcorpsearray();
  return result;
}

function setcorpseremovetimersp(time) {
  return self setcorpseremovetimer(time);
}

function achievement_death_tracker() {
  if(!isDefined(self.attacker) || !isPlayer(self.attacker)) {
    return;
  }

  if(!isDefined(self.team) || self.team != "axis" && self.team != "team3") {
    return;
  }

  if(isDefined(self.damagemod) && isDefined(self.damageweapon) && isDefined(self.damageweapon.basename)) {
    if(self.damagemod == "MOD_IMPACT" && isstartstr(self.damageweapon.basename, "smoke")) {
      level thread scripts\sp\utility::giveachievement_wrapper("smokedirect");
    }
  }

  if(level.player isonladder()) {
    var_32963b8862f62085 = level.player getplayerprogression("achievementHangtime");

    if(var_32963b8862f62085 < 3) {
      if(isDefined(self.damagemod) && (self.damagemod == "MOD_PISTOL_BULLET" || self.damagemod == "MOD_RIFLE_BULLET" || self.damagemod == "MOD_EXPLOSIVE_BULLET")) {
        if(var_32963b8862f62085 == 2) {
          level thread scripts\sp\utility::giveachievement_wrapper("hangtime");
        }

        level.player setplayerprogression("achievementHangtime", var_32963b8862f62085 + 1);
      }
    }
  }
}
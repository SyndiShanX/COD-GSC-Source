/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\init.gsc
***********************************************/

function setglobalaimsettings() {
  anim.covercrouchleanpitch = 55;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  anim.painyawdifffartolerance = 25;
  anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
  anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
  anim.painpitchdifftolerance = 30;
  anim.maxanglecheckyawdelta = 65;
  anim.maxanglecheckpitchdelta = 65;
}

function main() {
  firstinit();

  if(!scripts\engine\utility::flag_exist("load_finished")) {
    scripts\engine\utility::flag_init("load_finished");
  }

  self.a = spawnStruct();

  if(!isDefined(self.export)) {
    self.export = -1;
  }

  setupuniqueanims();
  scripts\asm\shared\utility::setupsoldierdefaults();
  thread scripts\anim\shared::setupweapons();
  self.exception = [];
  self.exception["corner"] = 1;
  self.exception["cover_crouch"] = 1;
  self.exception["stop"] = 1;
  self.exception["stop_immediate"] = 1;
  self.exception["move"] = 1;
  self.exception["exposed"] = 1;
  self.exception["corner_normal"] = 1;
  var_0 = getarraykeys(self.exception);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    scripts\engine\utility::clear_exception(var_0[var_1]);
  }

  thread scripts\sp\equipment\offhands::offhandfiremanager();

  if(!isDefined(level.disablemonitorflash)) {
    thread scripts\anim\combat_utility::monitorflash();
  }

  thread ondeath();

  if(!getdvarint("LLQQOPKTKM")) {
    self pushplayer(0);
    scripts\asm\asm::asm_init_blackboard();
    scripts\aitypes\bt_util::bt_init();
    scripts\asm\asm_sp::asm_init(self.asmasset, self.animationarchetype);
    thread ai_update();
    self.asmasset = undefined;
    self.animationarchetype = undefined;
  }

  thread setnameandrank_andaddtosquad();

  if(isDefined(level.aitypeinitfuncs) && isDefined(level.aitypeinitfuncs[self.classname])) {
    self[[level.aitypeinitfuncs[self.classname]]]();
  }

  self.fnachievements = &achievement_death_tracker;
}

function shouldforceupdatebt() {
  return isDefined(self.bt.forceupdate) && self.bt.forceupdate;
}

function ai_update() {
  self endon("terminate_ai_threads");
  self endon("entitydeleted");
  thread scripts\asm\asm_sp::deletehandler();
}

function weapons_with_ir(var_0) {
  GscBinSkip1(0x45, 0, "m4_grenadier");
}

function setnameandrank_andaddtosquad() {
  self endon("death");
  scripts\sp\names::get_name();
  thread scripts\anim\squadmanager::addtosquad();
}

function pollallowedstancesthread() {
  for(;;) {
    if(self isstanceallowed("stand")) {
      var_0 = "stand allowed";
      var_1 = (0, 1, 0);
    } else {
      var_0 = "stand not allowed";
      var_1 = (1, 0, 0);
    }

    if(self isstanceallowed("crouch")) {
      var_0 = "crouch allowed";
      var_1 = (0, 1, 0);
    } else {
      var_0 = "crouch not allowed";
      var_1 = (1, 0, 0);
    }

    if(self isstanceallowed("prone")) {
      var_0 = "prone allowed";
      var_1 = (0, 1, 0);
    } else {
      var_0 = "prone not allowed";
      var_1 = (1, 0, 0);
    }

    var_2 = self getshootatpos() + (0, 0, 30);
    var_3 = (0, 0, -10);

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_5 = (var_2[0] + var_3[0] * var_4, var_2[1] + var_3[1] * var_4, var_2[2] + var_3[2] * var_4);
    }

    wait 0.05;
  }
}

function setupuniqueanims() {
  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate)) {
    set_anim_playback_rate();
    return;
  }
}

function set_anim_playback_rate() {
  self.animplaybackrate = 0.97 + randomfloat(0.13);
  self.movetransitionrate = 0.97 + randomfloat(0.13);
  self.moveplaybackrate = self.movetransitionrate;
  self.sidesteprate = 1.35;
}

function infiniteloop(var_0, var_1, var_2, var_3) {
  anim waittill("new exceptions");
}

function empty(var_0, var_1, var_2, var_3) {}

function initdeveloperdvars() {}

function initbattlechatter() {
  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  level._battlechatter = spawnStruct();
  level._battlechatter.fnevaluatemoveevent = &scripts\anim\battlechatter_ai::evaluatemoveevent;
  level._battlechatter.fnevaluatereloadevent = &scripts\anim\battlechatter_ai::evaluatereloadevent;
  level._battlechatter.fnaddthreatevent = &scripts\anim\battlechatter_ai::addthreatevent;
  level._battlechatter.fnevaluateattackevent = &scripts\anim\battlechatter_ai::evaluateattackevent;
  level._battlechatter.fnplaybattlechatter = &scripts\anim\battlechatter::playbattlechatter;
  scripts\anim\shared::init_squadmanager();
  anim.player thread scripts\anim\squadmanager::addplayertosquad();
  anim.player thread scripts\anim\squadmanager::playeranimnameswitch();
  scripts\anim\battlechatter::init_battlechatter();
  anim.player thread scripts\anim\battlechatter_ai::addtosystem();
  scripts\sp\player\playerchatter::init_playerchatter();
  anim thread scripts\anim\battlechatter::bcsdebugwaiter();
  scripts\engine\sp\utility::battlechatter_on("axis");
}

function initgrenades() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.grenadetimers["fraggrenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag_main"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag_vr"] = randomintrange(1000, 20000);
    var_1.grenadetimers["flash_grenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["flash"] = randomintrange(1000, 20000);
    var_1.grenadetimers["emp"] = randomintrange(1000, 20000);
    var_1.grenadetimers["antigrav"] = randomintrange(1000, 20000);
    var_1.grenadetimers["seeker"] = randomintrange(1000, 20000);
    var_1.grenadetimers["c8_grenade"] = randomintrange(1000, 10000);
    var_1.grenadetimers["double_grenade"] = randomintrange(1000, 60000);
    var_1.grenadetimers["frag_tincan"] = randomintrange(1000, 5000);
    var_1.grenadetimers["flash"] = randomintrange(1000, 20000);
    var_1.grenadetimers["molotov"] = randomintrange(1000, 60000);
    var_1.grenadetimers["semtex"] = randomintrange(1000, 20000);
    var_1.numgrenadesinprogresstowardsplayer = 0;
    var_1.lastgrenadelandednearplayertime = -1000000;
    var_1.lastfraggrenadetoplayerstart = -1000000;
    thread setnextplayergrenadetime();
  }

  anim.grenadetimers["AI_fraggrenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_semtex"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_seeker"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag_main"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag_vr"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_emp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_antigrav"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_c8_grenade"] = randomintrange(0, 10000);
  anim.grenadetimers["AI_frag_tincan"] = randomintrange(1000, 5000);
  anim.grenadetimers["AI_molotov"] = randomintrange(0, 500);
  anim.grenadetimers["AI_molotov"] = randomintrange(0, 20000);
  scripts\anim\combat_utility::initgrenadethrowanims();
}

function aiturnnotifies() {
  var_0 = 0;
  var_1 = 3;

  for(;;) {
    var_2 = getaiarray();

    if(var_2.size == 0) {
      wait 0.05;
      var_0 = 0;
      continue;
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(var_2[var_3])) {
        continue;
      }

      var_2[var_3] notify("do_slow_things");
      var_0++;

      if(var_0 == var_1) {
        wait 0.05;
        var_0 = 0;
      }
    }
  }
}

function setnextplayergrenadetime() {
  waittillframeend();

  if(isDefined(self.gs.playergrenaderangetime)) {
    var_0 = int(self.gs.playergrenaderangetime * 0.7);

    if(var_0 < 1) {
      var_0 = 1;
    }

    self.grenadetimers["frag"] = randomintrange(0, var_0);
    self.grenadetimers["flash_grenade"] = randomintrange(0, var_0);
    self.grenadetimers["seeker"] = randomintrange(0, var_0);
  }

  if(isDefined(self.gs.playerdoublegrenadetime)) {
    var_0 = int(self.gs.playerdoublegrenadetime);
    var_1 = int(var_0 / 2);

    if(var_0 <= var_1) {
      var_0 = var_1 + 1;
    }

    self.grenadetimers["double_grenade"] = randomintrange(var_1, var_0);
    return;
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
      return;
    }

    return;
  }
}

function firstinit() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  scripts\sp\load::anim_earlyinit();
  level.nextgrenadedrop = randomint(3);
  level.lastplayersighted = 100;
  anim.defaultexception = &empty;

  if(!isDefined(level.g_effect)) {
    level.g_effect = [];
  }

  initdeveloperdvars();
  scripts\sp\names::setup_names();
  scripts\anim\shared::initanimvars();
  initgrenades();
  scripts\anim\shared::initadvancetoenemy();
  scripts\anim\shared::initmeleecharges();
  level.fngetcorpsearrayfunc = &getcorpsearraysp;
  level.fnsetcorpseremovetimerfunc = &setcorpseremovetimersp;

  if(!isDefined(anim.optionalstepeffectfunction)) {
    anim.fnfootstepeffectsmall = &scripts\anim\notetracks_sp::playfootstepeffectsmall;
    anim.fnfootstepeffect = &scripts\anim\notetracks_sp::playfootstepeffect;
  }

  if(!isDefined(anim.fnfootprinteffect)) {
    anim.fnfootprinteffect = &scripts\anim\notetracks_sp::playfootprinteffect;
  }

  scripts\anim\notetracks_sp::registernotetracks();
  scripts\engine\sp\utility::setupglobalcallbackfunctions_sp();
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

  scripts\anim\shared::initwindowtraverse();
  scripts\anim\cqb::setupcqbpointsofinterest();
  scripts\anim\shared::initdeaths();
  scripts\anim\shared::setuprandomtable();
  level.player thread scripts\anim\combat_utility::watchreloading();
}

function getcorpsearraysp() {
  var_0 = getcorpsearray();

  if(isDefined(level.stealth.additional_corpse)) {
    foreach(var_2 in level.stealth.additional_corpse) {
      if(isDefined(var_2)) {
        var_0 = var_2;
      }
    }
  }

  return var_0;
}

function setcorpseremovetimersp(var_0) {
  return self setcorpseremovetimer(var_0);
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
    var_0 = level.player getplayerprogression("achievementHangtime");

    if(var_0 < 3) {
      if(isDefined(self.damagemod) && (self.damagemod == "MOD_PISTOL_BULLET" || self.damagemod == "MOD_RIFLE_BULLET" || self.damagemod == "MOD_EXPLOSIVE_BULLET")) {
        if(var_0 == 2) {
          level thread scripts\sp\utility::giveachievement_wrapper("hangtime");
        }

        level.player setplayerprogression("achievementHangtime", var_0 + 1);
        return;
      }

      return;
    }

    return;
  }
}
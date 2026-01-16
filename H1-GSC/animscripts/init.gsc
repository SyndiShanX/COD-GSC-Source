/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\init.gsc
********************************/

initweapon(var_0) {
  self.weaponinfo[var_0] = spawnstruct();
  self.weaponinfo[var_0].position = "none";
  self.weaponinfo[var_0].hasclip = 1;

  if(getweaponclipmodel(var_0) != "")
    self.weaponinfo[var_0].useclip = 1;
  else
    self.weaponinfo[var_0].useclip = 0;
}

isweaponinitialized(var_0) {
  return isdefined(self.weaponinfo[var_0]);
}

setglobalaimsettings() {
  anim.covercrouchleanpitch = 55;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  anim.aimpitchdiffclosedistsq = 6400;
  anim.aimpitchdiffclosetolerance = 30;
  anim.painyawdifffartolerance = 25;
  anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
  anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
  anim.painpitchdifftolerance = 30;
  anim.maxanglecheckyawdelta = 65;
  anim.maxanglecheckpitchdelta = 65;
}

everusessecondaryweapon() {
  if(animscripts\utility::isshotgun(self.secondaryweapon))
    return 1;

  if(weaponclass(self.primaryweapon) == "rocketlauncher")
    return 1;

  return 0;
}

#using_animtree("generic_human");

main() {
  self.a = spawnstruct();
  self.a.laseron = 0;
  self.primaryweapon = self.weapon;
  firstinit();

  if(!isdefined(self.primaryweapon) || self.primaryweapon == "")
    self.primaryweapon = "none";

  if(self.secondaryweapon == "")
    self.secondaryweapon = "none";

  if(self.sidearm == "")
    self.sidearm = "none";

  initweapon(self.primaryweapon);
  initweapon(self.secondaryweapon);
  initweapon(self.sidearm);
  self setdefaultaimlimits();
  self.a.weaponpos["left"] = "none";
  self.a.weaponpos["right"] = "none";
  self.a.weaponpos["chest"] = "none";
  self.a.weaponpos["back"] = "none";
  self.a.weaponposdropping["left"] = "none";
  self.a.weaponposdropping["right"] = "none";
  self.a.weaponposdropping["chest"] = "none";
  self.a.weaponposdropping["back"] = "none";
  self.lastweapon = self.weapon;
  self.root_anim = % animscript_root;
  thread begingrenadetracking();
  var_0 = animscripts\utility::usingrocketlauncher();
  self.a.neverlean = var_0;

  if(var_0)
    thread animscripts\shared::rpgplayerrepulsor();

  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  self.a.pose = "stand";
  self.a.grenadethrowpose = "stand";
  self.a.movement = "stop";
  self.a.state = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  self.a.prevputguninhandtime = -1;
  self.dropweapon = 1;
  self.minexposedgrenadedist = 850;
  animscripts\shared::placeweaponon(self.primaryweapon, "right");

  if(animscripts\utility::isshotgun(self.secondaryweapon))
    animscripts\shared::placeweaponon(self.secondaryweapon, "back");

  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.suppressingenemy = 0;
  self.a.disablelongdeath = !self isbadguy();
  self.a.lookangle = 0;
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = undefined;
  setdvarifuninitialized("ai_reactToBulletChance", 0.8);
  setdvarifuninitialized("ai_reactToBulletCooldown", 5000);

  if(self.team == "allies" && !issubstr(self.classname, "russian") && allies_with_ir())
    self.has_ir = 1;

  self.a.postscriptfunc = undefined;
  self.a.stance = "stand";
  self.chooseposefunc = animscripts\utility::choosepose;
  self._animactive = 0;
  self._lastanimtime = 0;
  thread enemynotify();
  self.baseaccuracy = 1;
  self.a.misstime = 0;
  self.a.nodeath = 0;
  self.a.misstime = 0;
  self.a.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.accuracystationarymod = 1;
  self.chatinitialized = 0;
  self.sightpostime = 0;
  self.sightposleft = 1;
  self.needrecalculategoodshootpos = 1;
  self.defaultturnthreshold = 55;
  self.a.nextstandinghitdying = 0;

  if(!isdefined(self.script_forcegrenade))
    self.script_forcegrenade = 0;

  setupuniqueanims();
  animscripts\weaponlist::refillclip();
  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;

  if(self.team == "allies")
    self.suppressionthreshold = 0.75;
  else
    self.suppressionthreshold = 0.5;

  if(self.team == "allies")
    self.randomgrenaderange = 0;
  else
    self.randomgrenaderange = 128;

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  animscripts\animset::setup_run_n_gun();
  self.exception = [];
  self.exception["corner"] = 1;
  self.exception["cover_crouch"] = 1;
  self.exception["stop"] = 1;
  self.exception["stop_immediate"] = 1;
  self.exception["move"] = 1;
  self.exception["exposed"] = 1;
  self.exception["corner_normal"] = 1;
  var_1 = getarraykeys(self.exception);

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    common_scripts\utility::clear_exception(var_1[var_2]);

  self.reacquire_state = 0;
  thread setnameandrank_andaddtosquad();
  self.shouldconserveammotime = 0;

  if(isdefined(level.h1_bullet_whizby_enabled) && level.h1_bullet_whizby_enabled) {
    self.disablebulletwhizbyreaction = undefined;
    self.disable_dive_whizby_react = 1;
  } else
    self.disablebulletwhizbyreaction = 1;

  self.noruntwitch = 1;

  if(isdefined(level.h1_team_run_twitch_enabled)) {
    if(isdefined(level.h1_team_run_twitch_enabled[self.team]))
      self.noruntwitch = !level.h1_team_run_twitch_enabled[self.team];
  }

  self.proneaimlimits = spawnstruct();
  self.proneaimlimits.rightaimlimit = 45;
  self.proneaimlimits.leftaimlimit = -45;
  self.proneaimlimits.upaimlimit = 35;
  self.proneaimlimits.downaimlimit = -35;
  self.animaimlimit = spawnstruct();
  self.animaimlimit.rightaimlimit = 45;
  self.animaimlimit.leftaimlimit = -45;
  self.doaimidlethread = 1;

  if(!isdefined(level.disablemonitorflash))
    thread animscripts\combat_utility::monitorflash();

  thread ondeath();
  thread handleikevent();
}

handleikevent() {
  self endon("death");
  var_0 = -30;
  self setanimlimited( % actor_ik_move_root, 0);
  self setanimlimited( % stand_exposed_ik_add, 1);
  var_1 = 0;

  for (;;) {
    self waittill("actorik", var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(var_2 <= 0.01) {
      if(var_1 == 0) {
        self setanimlimited( % actor_ik_move_root, 0);
        var_1 = 1;
      }

      continue;
    }

    var_5 = var_5 * -1;
    var_9 = var_0;

    if(length2dsquared(self.velocity) > 0.01)
      var_9 = -10;

    var_10 = 0;
    var_11 = 8;
    var_12 = 8;

    if(var_3)
      var_12 = 5;

    if(var_4)
      var_11 = 5;

    var_13[0] = var_8;
    var_13[1] = var_8 + var_7 * var_11;
    var_13[2] = var_6;
    var_13[3] = var_6 + var_5 * var_12;
    var_14[0] = 1;
    var_14[1] = 1;
    var_14[2] = 1;
    var_14[3] = 1;
    var_15[0] = min(var_13[0][2], var_13[1][2]);
    var_15[1] = min(var_13[2][2], var_13[3][2]);
    var_16[0] = 0;
    var_16[1] = 0;

    if(abs(var_15[0] - var_15[1]) < 1) {
      var_16[0] = 1;
      var_16[1] = 1;
    } else if(var_15[0] < var_15[1])
      var_16[0] = 1;
    else
      var_16[1] = 1;

    var_17[0] = 0;
    var_17[1] = 0;
    var_17[2] = 0;
    var_17[3] = 0;

    for (var_18 = 0; var_18 < 4; var_18++) {
      var_19 = var_13[var_18] + (0, 0, 30);
      var_20 = var_13[var_18] - (0, 0, 30);
      var_21 = self aiphysicstrace(var_19, var_20, 1.5, 3, 1, 1, 0, 1, 1, 1);
      var_22 = var_19 + 2 * var_21["fraction"] * (0, 0, -30);
      var_17[var_18] = var_22[2] - self.origin[2];

      if(var_21["fraction"] == 1)
        var_14[var_18] = 0;
    }

    if(var_14[0] || var_14[1])
      var_23 = max(var_17[0], var_17[1]);
    else
      var_23 = 0;

    if(var_14[2] || var_14[3])
      var_24 = max(var_17[2], var_17[3]);
    else
      var_24 = 0;

    if(var_16[0] == 1 && var_16[1] == 1)
      var_10 = min(var_23, var_24);
    else if(var_16[0] == 1)
      var_10 = var_23;
    else
      var_10 = var_24;

    var_10 = clamp(var_10, var_9, 0);

    if(var_10 < 0) {
      var_25 = var_10 / var_0;
      self setanimlimited( % actor_ik_move_root, var_25 * var_2);
      var_1 = 0;
    } else if(var_1 == 0) {
      self setanimlimited( % actor_ik_move_root, 0);
      var_1 = 1;
    }
  }
}

allies_with_ir() {
  if(!isdefined(self.script_friendname))
    return 1;

  var_0[0] = "Griggs";
  var_0[1] = "Nikolai";

  foreach(var_2 in var_0) {
    if(issubstr(self.script_friendname, var_2))
      return 0;
  }

  return 1;
}

weapons_with_ir(var_0) {
  var_1[0] = "m4_grenadier";
  var_1[1] = "m4_grunt";
  var_1[2] = "m4_silencer";
  var_1[3] = "m4m203";

  if(!isdefined(var_0))
    return 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(issubstr(var_0, var_1[var_2]))
      return 1;
  }

  return 0;
}

setnameandrank_andaddtosquad() {
  self endon("death");

  if(!isdefined(level.loadoutcomplete))
    level waittill("loadout complete");

  maps\_names::get_name();
  thread animscripts\squadmanager::addtosquad();
}

pollallowedstancesthread() {
  for (;;) {
    if(self isstanceallowed("stand")) {
      var_0[0] = "stand allowed";
      var_1[0] = (0, 1, 0);
    } else {
      var_0[0] = "stand not allowed";
      var_1[0] = (1, 0, 0);
    }

    if(self isstanceallowed("crouch")) {
      var_0[1] = "crouch allowed";
      var_1[1] = (0, 1, 0);
    } else {
      var_0[1] = "crouch not allowed";
      var_1[1] = (1, 0, 0);
    }

    if(self isstanceallowed("prone")) {
      var_0[2] = "prone allowed";
      var_1[2] = (0, 1, 0);
    } else {
      var_0[2] = "prone not allowed";
      var_1[2] = (1, 0, 0);
    }

    var_2 = self getshootatpos() + (0, 0, 30);
    var_3 = (0, 0, -10);

    for (var_4 = 0; var_4 < var_0.size; var_4++)
      var_5 = (var_2[0] + var_3[0] * var_4, var_2[1] + var_3[1] * var_4, var_2[2] + var_3[2] * var_4);

    wait 0.05;
  }
}

setupuniqueanims() {
  if(!isdefined(self.animplaybackrate) || !isdefined(self.moveplaybackrate))
    set_anim_playback_rate();
}

set_anim_playback_rate() {
  self.animplaybackrate = 0.9 + randomfloat(0.2);
  self.movetransitionrate = 0.9 + randomfloat(0.2);
  self.moveplaybackrate = 1;
  self.sidesteprate = 1.35;
}

infiniteloop(var_0, var_1, var_2, var_3) {
  anim waittill("new exceptions");
}

empty(var_0, var_1, var_2, var_3) {}

enemynotify() {
  self endon("death");

  if(1) {
    return;
  }
  for (;;) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    while (isplayer(self.enemy)) {
      if(animscripts\utility::hasenemysightpos())
        level.lastplayersighted = gettime();

      wait 2;
    }
  }
}

initwindowtraverse() {
  level.window_down_height[0] = -36.8552;
  level.window_down_height[1] = -27.0095;
  level.window_down_height[2] = -15.5981;
  level.window_down_height[3] = -4.37769;
  level.window_down_height[4] = 17.7776;
  level.window_down_height[5] = 59.8499;
  level.window_down_height[6] = 104.808;
  level.window_down_height[7] = 152.325;
  level.window_down_height[8] = 201.052;
  level.window_down_height[9] = 250.244;
  level.window_down_height[10] = 298.971;
  level.window_down_height[11] = 330.681;
}

firstinit() {
  if(isdefined(anim.notfirsttime)) {
    return;
  }
  anim.notfirsttime = 1;
  animscripts\animset::init_anim_sets();
  anim.usefacialanims = 0;
  maps\_load::init_level_players();
  level.player.invul = 0;
  level.nextgrenadedrop = randomint(3);
  level.lastplayersighted = 100;
  anim.defaultexception = ::empty;
  initdeveloperdvars();
  setdvar("scr_expDeathMayMoveCheck", "on");
  maps\_names::setup_names();
  anim.animflagnameindex = 0;
  animscripts\init_move_transitions::initmovestartstoptransitions();
  anim.combatmemorytimeconst = 10000;
  anim.combatmemorytimerand = 6000;
  initgrenades();
  initadvancetoenemy();

  if(!isdefined(anim.optionalstepeffectfunction)) {
    anim.optionalstepeffectsmallfunction = animscripts\notetracks::playfootstepeffectsmall;
    anim.optionalstepeffectfunction = animscripts\notetracks::playfootstepeffect;
  }

  if(!isdefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  if(!isdefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  if(!isdefined(anim.shootenemywrapper_func))
    anim.shootenemywrapper_func = animscripts\utility::shootenemywrapper_shootnotify;

  if(!isdefined(anim.shootposwrapper_func))
    anim.shootposwrapper_func = animscripts\utility::shootposwrapper;

  anim.fire_notetrack_functions["scripted"] = animscripts\notetracks::fire_straight;
  anim.fire_notetrack_functions["cover_right"] = animscripts\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_left"] = animscripts\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_crouch"] = animscripts\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_stand"] = animscripts\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["move"] = animscripts\notetracks::shootnotetrack;
  animscripts\notetracks::registernotetracks();

  if(!isdefined(level.flag))
    common_scripts\utility::init_flags();

  maps\_gameskill::setskill();
  level.painai = undefined;
  animscripts\setposemovement::initposemovementfunctions();
  animscripts\face::initlevelface();
  anim.burstfirenumshots = animscripts\utility::array(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.fastburstfirenumshots = animscripts\utility::array(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.semifirenumshots = animscripts\utility::array(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim.badplaces = [];
  anim.badplaceint = 0;
  anim.player = getentarray("player", "classname")[0];
  initbattlechatter();
  initwindowtraverse();
  animscripts\cqb::setupcqbpointsofinterest();
  initdeaths();
  setglobalaimsettings();
  anim.lastcarexplosiontime = -100000;
  setuprandomtable();
  level.player thread animscripts\combat_utility::watchreloading();
  thread aiturnnotifies();
}

initdeveloperdvars() {}

initbattlechatter() {
  animscripts\squadmanager::init_squadmanager();
  anim.player thread animscripts\squadmanager::addplayertosquad();
  animscripts\battlechatter::init_battlechatter();
  anim.player thread animscripts\battlechatter_ai::addtosystem();
  anim thread animscripts\battlechatter::bcsdebugwaiter();
}

initdeaths() {
  anim.numdeathsuntilcrawlingpain = randomintrange(0, 15);
  anim.numdeathsuntilcornergrenadedeath = randomintrange(0, 10);
  anim.nextcrawlingpaintime = gettime() + randomintrange(0, 20000);
  anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(0, 10000);
  anim.nextcornergrenadedeathtime = gettime() + randomintrange(0, 15000);
}

initgrenades() {
  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.grenadetimers["fraggrenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["flash_grenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["double_grenade"] = randomintrange(1000, 60000);
    var_1.grenadetimers["microwave_grenade"] = randomintrange(1000, 20000);
    var_1.numgrenadesinprogresstowardsplayer = 0;
    var_1.lastgrenadelandednearplayertime = -1000000;
    var_1.lastfraggrenadetoplayerstart = -1000000;
    var_1 thread setnextplayergrenadetime();
  }

  anim.grenadetimers["AI_fraggrenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_microwave_grenade"] = randomintrange(0, 20000);
  animscripts\combat_utility::initgrenadethrowanims();
}

initadvancetoenemy() {
  level.lastadvancetoenemytime = [];
  level.lastadvancetoenemytime["axis"] = 0;
  level.lastadvancetoenemytime["allies"] = 0;
  level.lastadvancetoenemytime["team3"] = 0;
  level.lastadvancetoenemytime["neutral"] = 0;
  level.lastadvancetoenemydest = [];
  level.lastadvancetoenemydest["axis"] = (0, 0, 0);
  level.lastadvancetoenemydest["allies"] = (0, 0, 0);
  level.lastadvancetoenemydest["team3"] = (0, 0, 0);
  level.lastadvancetoenemydest["neutral"] = (0, 0, 0);
  level.lastadvancetoenemysrc = [];
  level.lastadvancetoenemysrc["axis"] = (0, 0, 0);
  level.lastadvancetoenemysrc["allies"] = (0, 0, 0);
  level.lastadvancetoenemysrc["team3"] = (0, 0, 0);
  level.lastadvancetoenemysrc["neutral"] = (0, 0, 0);
  level.lastadvancetoenemyattacker = [];
  level.advancetoenemygroup = [];
  level.advancetoenemygroup["axis"] = 0;
  level.advancetoenemygroup["allies"] = 0;
  level.advancetoenemygroup["team3"] = 0;
  level.advancetoenemygroup["neutral"] = 0;
  level.advancetoenemyinterval = 30000;
  level.advancetoenemygroupmax = 3;
}

aiturnnotifies() {
  var_0 = 0;
  var_1 = 3;

  for (;;) {
    var_2 = getaiarray();

    if(var_2.size == 0) {
      wait 0.05;
      var_0 = 0;
      continue;
    }

    for (var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isdefined(var_2[var_3])) {
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

setnextplayergrenadetime() {
  waittillframeend;

  if(isdefined(self.gs.playergrenaderangetime)) {
    var_0 = int(self.gs.playergrenaderangetime * 0.7);

    if(var_0 < 1)
      var_0 = 1;

    self.grenadetimers["fraggrenade"] = randomintrange(0, var_0);
    self.grenadetimers["flash_grenade"] = randomintrange(0, var_0);
    self.grenadetimers["microwave_grenade"] = randomintrange(0, var_0);
  }

  if(isdefined(self.gs.playerdoublegrenadetime)) {
    var_0 = int(self.gs.playerdoublegrenadetime);
    var_1 = int(var_0 / 2);

    if(var_0 <= var_1)
      var_0 = var_1 + 1;

    self.grenadetimers["double_grenade"] = randomintrange(var_1, var_0);
  }
}

begingrenadetracking() {
  if(isdefined(level.disablegrenadetracking)) {
    return;
  }
  self endon("death");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0 thread maps\_utility::grenade_earthquake();
  }
}

setuprandomtable() {
  anim.randominttablesize = 60;
  anim.randominttable = [];

  for (var_0 = 0; var_0 < anim.randominttablesize; var_0++)
    anim.randominttable[var_0] = var_0;

  for (var_0 = 0; var_0 < anim.randominttablesize; var_0++) {
    var_1 = randomint(anim.randominttablesize);
    var_2 = anim.randominttable[var_0];
    anim.randominttable[var_0] = anim.randominttable[var_1];
    anim.randominttable[var_1] = var_2;
  }
}

ondeath() {
  if(isdefined(level.disablestrangeondeath)) {
    return;
  }
  self waittill("death");

  if(!isdefined(self)) {
    if(isdefined(self.a.usingturret))
      self.a.usingturret delete();
  }
}
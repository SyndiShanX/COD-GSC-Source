/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\init.gsc
**************************************/

#include animscripts\utility;
#include maps\_utility;
#include animscripts\combat_utility;
#include common_scripts\utility;
#include animscripts\debug;
#include animscripts\anims;
#include animscripts\assign_weapon;
#include animscripts\shared;
#include maps\_gameskill;
#include animscripts\run;
#include animscripts\weaponlist;
#include maps\_names;
#include animscripts\cover_arrival;
#include animscripts\init;
#include animscripts\setposemovement;
#include animscripts\cqb;
#include animscripts\react;
#include animscripts\combat;
#include animscripts\move;
#include animscripts\cover_behavior;
#include animscripts\pain;
#include animscripts\death;
#include animscripts\balcony;

initweapon(weapon) {
  self.weaponinfo[weapon] = spawnstruct();
  self.weaponinfo[weapon].position = "none";
  self.weaponinfo[weapon].hasclip = 1;

  if(getweaponclipmodel(weapon) != "")
    self.weaponinfo[weapon].useclip = 1;
  else
    self.weaponinfo[weapon].useclip = 0;
}

isweaponinitialized(weapon) {
  return isDefined(self.weaponinfo[weapon]);
}

#using_animtree("generic_human");

main() {
  self.a = spawnstruct();
  self.a.laseron = 0;

  if(self.weapon == "")
    self setcurrentweapon("none");

  self setprimaryweapon(self.weapon);

  if(self.secondaryweapon == "")
    self setsecondaryweapon("none");

  self setprimaryweapon(animscripts\assign_weapon::assign_random_weapon());
  self thread animscripts\assign_weapon::set_random_camo_drop();
  self setsecondaryweapon(self.secondaryweapon);
  self setcurrentweapon(self.primaryweapon);
  self.looking_at_entity = 0;
  self.initial_primaryweapon = self.primaryweapon;
  self.initial_secondaryweapon = self.secondaryweapon;
  self initweapon(self.primaryweapon);
  self initweapon(self.secondaryweapon);
  self initweapon(self.sidearm);
  self.weapon_positions = [];
  self.weapon_positions[self.weapon_positions.size] = "left";
  self.weapon_positions[self.weapon_positions.size] = "right";
  self.weapon_positions[self.weapon_positions.size] = "chest";
  self.weapon_positions[self.weapon_positions.size] = "back";

  for(i = 0; i < self.weapon_positions.size; i++)
    self.a.weaponpos[self.weapon_positions[i]] = "none";

  self.lastweapon = self.weapon;
  self.root_anim = % root;
  self thread begingrenadetracking();
  firstinit();
  hasrocketlauncher = usingrocketlauncher();
  self.a.neverlean = hasrocketlauncher;
  self.animtype = setanimtype();
  self.lastanimtype = self.animtype;
  self animscripts\anims::clearanimcache();

  if(isDefined(level.setup_anim_array_callback))
    [[level.setup_anim_array_callback]](self.animtype);

  self.heat = 0;
  self.issniper = issniperrifle(self.primaryweapon);
  self.bulletsinclip = 0;
  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  self.a.weapon_switch_asap = 0;
  self.a.weapon_switch_time = gettime();
  self.a.weapon_switch_for_distance_time = -1;
  self.a.nextallowedswitchsidestime = gettime();
  self.a.lastswitchsidestime = gettime();
  self.a.allowevasivemovement = 1;
  self.a.allow_sidearm = 1;
  self.a.allow_shooting = 1;
  self.turntomatchnode = 0;
  setweapondist();
  self.a.pose = "stand";
  self.a.prevpose = self.a.pose;
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  animscripts\shared::placeweaponon(self.primaryweapon, "right");

  if(isDefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol")
    animscripts\shared::placeweaponon(self.secondaryweapon, "back");

  self.a.combatendtime = gettime();
  self.a.script = "init";
  self.a.lastenemytime = gettime();
  self.a.suppressingenemy = 0;
  self.a.desired_script = "none";
  self.a.current_script = "none";
  self.a.disablelongdeath = self.team != "axis" && self.team != "team3";
  self.a.lookangle = 0;
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.isaiming = 0;
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
  self.walk = 0;
  self.sprint = 0;
  self animscripts\shared::setaiminganims( % aim_2, % aim_4, % aim_6, % aim_8);
  self thread animscripts\shared::trackloop();
  self.a.magicreloadwhenreachenemy = 0;
  self.a.flamepaintime = 0;

  if(weaponisgasweapon(self.weapon)) {
    self.a.flamethrowershootdelay_min = 250;
    self.a.flamethrowershootdelay_max = 500;
    self.a.flamethrowershoottime_min = 500;
    self.a.flamethrowershoottime_max = 3000;
    self.a.flamethrowershootswitch = 0;
    self.a.flamethrowershootswitchtimer = 0;
    self.disablearrivals = 1;
    self.disableexits = 1;
  }

  self.a.postscriptfunc = undefined;
  self thread deathnotify();
  self.baseaccuracy = self.accuracy;

  if(!isDefined(self.script_accuracy))
    self.script_accuracy = 1;

  if(self.team == "axis" || self.team == "team3")
    self thread maps\_gameskill::axisaccuracycontrol();
  else if(self.team == "allies")
    self thread maps\_gameskill::alliesaccuracycontrol();

  self.a.misstime = 0;
  self.a.yawtransition = "none";
  self.a.nodeath = 0;
  self.a.misstime = 0;
  self.a.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.a.disablereact = 0;
  self.accuracystationarymod = 1;
  self.chatinitialized = 0;
  self.sightpostime = 0;
  self.sightposleft = 1;
  self.precombatrunenabled = 1;
  self.goodshootposvalid = 0;
  self.needrecalculategoodshootpos = 1;
  self.a.grenadeflee = animscripts\run::getrunanim();
  self.a.crouchpain = 0;
  self.a.nextstandinghitdying = 0;

  if(!isDefined(self.script_forcegrenade))
    self.script_forcegrenade = 0;

  self.a.stopcowering = ::donothing;
  setupuniqueanims();

  thread animscripts\debug::updatedebuginfo();

  self animscripts\weaponlist::refillclip();
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

  self.exception = [];
  self.exception["corner"] = 1;
  self.exception["cover_crouch"] = 1;
  self.exception["stop"] = 1;
  self.exception["stop_immediate"] = 1;
  self.exception["move"] = 1;
  self.exception["exposed"] = 1;
  self.exception["corner_normal"] = 1;
  self.exception["cover_stand"] = 1;
  keys = getarraykeys(self.exception);

  for(i = 0; i < keys.size; i++)
    clear_exception(keys[i]);

  self.old = spawnstruct();
  self.reacquire_state = 0;
  self thread setnameandrank();
  self.shouldconserveammotime = 0;

  self thread printeyeoffsetfromnode();
  self thread showlikelyenemypathdir();

  self thread monitorflashorstun();
  self thread ondeath();
}

printeyeoffsetfromnode() {
  self endon("death");

  while(true) {
    if(getdvarint(#"_id_EF4ABB36") == self getentnum()) {
      if(isDefined(self.covernode)) {
        offset = self geteye() - self.covernode.origin;
        forward = anglestoforward(self.covernode.angles);
        right = anglestoright(self.covernode.angles);
        trueoffset = (vectordot(right, offset), vectordot(forward, offset), offset[2]);
        println(trueoffset);
      }
    } else
      wait 2;

    wait 0.1;
  }

}

showlikelyenemypathdir() {
  self endon("death");

  if(getdvar(#"_id_6CB7B561") == "")
    setdvar("scr_showlikelyenemypathdir", "-1");

  while(true) {
    if(getdvarint(#"_id_6CB7B561") == self getentnum()) {
      yaw = self.angles[1];
      dir = self getanglestolikelyenemypath();

      if(isDefined(dir))
        yaw = dir[1];

      printpos = self.origin + vectorscale((0, 0, 1), 60.0) + anglestoforward((0, yaw, 0)) * 100;
      line(self.origin + vectorscale((0, 0, 1), 60.0), printpos);

      if(isDefined(dir))
        print3d(printpos, "likelyEnemyPathDir: " + yaw, (1, 1, 1), 1, 0.5);
      else
        print3d(printpos, "likelyEnemyPathDir: undefined", (1, 1, 1), 1, 0.5);

      wait 0.05;
    } else
      wait 2;
  }

}

setnameandrank() {
  self endon("death");

  if(!isDefined(level.loadoutcomplete))
    level waittill("loadout complete");

  self maps\_names::get_name();
}

setweapondist() {
  if(self.primaryweapon != "" && self.primaryweapon != "none") {
    primaryweapon_fightdist_min = weaponfightdist(self.primaryweapon);
    primaryweapon_fightdist_max = weaponmaxdist(self.primaryweapon);
    self.primaryweapon_fightdist_minsq = primaryweapon_fightdist_min * primaryweapon_fightdist_min;
    self.primaryweapon_fightdist_maxsq = primaryweapon_fightdist_max * primaryweapon_fightdist_max;
  }

  if(self.secondaryweapon != "" && self.secondaryweapon != "none") {
    secondaryweapon_fightdist_min = weaponfightdist(self.secondaryweapon);
    secondaryweapon_fightdist_max = weaponmaxdist(self.secondaryweapon);
    self.secondaryweapon_fightdist_minsq = secondaryweapon_fightdist_min * secondaryweapon_fightdist_min;
    self.secondaryweapon_fightdist_maxsq = secondaryweapon_fightdist_max * secondaryweapon_fightdist_max;
  }
}

donothing() {
}

setupuniqueanims() {
  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate))
    set_anim_playback_rate();
}

set_anim_playback_rate() {
  self.animplaybackrate = 0.9 + randomfloat(0.2);
  self.moveplaybackrate = 1;
}

infiniteloop(one, two, three, whatever) {
  anim waittill("new exceptions");
}

lastsightupdater() {
  self endon("death");
  self.personalsighttime = -1;
  personalsightpos = self.origin;
  thread trackvelocity();
  thread previewsightpos();
  thread previewaccuracy();
  lastenemy = undefined;
  haslastenemysightpos = 0;

  for(;;) {
    if(!isDefined(self.squad)) {
      wait 0.2;
      continue;
    }

    if(isDefined(lastenemy) && isalive(self.enemy) && lastenemy != self.enemy) {
      personalsightpos = self.origin;
      self.personalsighttime = -1;
    }

    lastenemy = self.enemy;

    if(isDefined(self.lastenemysightpos) && isalive(self.enemy)) {
      if(distancesquared(self.enemy.origin, self.lastenemysightpos) < 10000) {
        personalsightpos = self.lastenemysightpos;
        self.personalsighttime = gettime();
        haslastenemysightpos = 1;
      } else if(isplayer(self.enemy))
        haslastenemysightpos = 0;
    } else
      haslastenemysightpos = 0;

    wait 0.05;
  }
}

clearenemy() {
  self notify("stop waiting for enemy to die");
  self endon("stop waiting for enemy to die");
  self.sightenemy waittill("death");
  self.sightpos = undefined;
  self.sighttime = 0;
  self.sightenemy = undefined;
}

previewsightpos() {
  self endon("death");

  if(getdebugdvar("debug_lastsightpos") != "on") {
    return;
  }
  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }
    print3d(self.lastenemysightpos, "X", (0.2, 0.5, 1.0), 1, 1.0);
  }

}

previewaccuracy() {
  if(getdebugdvar("debug_accuracypreview") != "on") {
    return;
  }
  if(!isDefined(level.offsetnum))
    level.offsetnum = 0;

  level.offsetnum++;

  if(level.offsetnum > 5)
    level.offsetnum = 1;

  self endon("death");

  for(;;) {
    wait 0.05;
    print3d(self.origin + (0, 0, 70 + 25 * 1), self.accuracy, (0.2, 0.5, 1.0), 1, 1.15);
  }

}

trackvelocity() {
  self endon("death");

  for(;;) {
    self.oldorigin = self.origin;
    wait 0.2;
  }
}

deathnotify() {
  self waittill("death", other);
  self notify(anim.scriptchange);
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

initmovestartstoptransitions() {
  transtypes = [];
  transtypes[0] = "left";
  transtypes[1] = "right";
  transtypes[2] = "left_crouch";
  transtypes[3] = "right_crouch";
  transtypes[4] = "crouch";
  transtypes[5] = "stand";
  transtypes[6] = "exposed";
  transtypes[7] = "exposed_crouch";
  transtypes[8] = "pillar";
  transtypes[9] = "pillar_crouch";
  transtypes[10] = "stand_saw";
  transtypes[11] = "prone_saw";
  transtypes[12] = "crouch_saw";
  anim.approach_types = [];
  anim.approach_types["Cover Left"] = [];
  anim.approach_types["Cover Left"][0] = "left";
  anim.approach_types["Cover Left"][1] = "left_crouch";
  anim.approach_types["Cover Right"] = [];
  anim.approach_types["Cover Right"][0] = "right";
  anim.approach_types["Cover Right"][1] = "right_crouch";
  anim.approach_types["Cover Crouch"] = [];
  anim.approach_types["Cover Crouch"][0] = "crouch";
  anim.approach_types["Cover Crouch"][1] = "crouch";
  anim.approach_types["Conceal Crouch"] = anim.approach_types["Cover Crouch"];
  anim.approach_types["Cover Crouch Window"] = anim.approach_types["Cover Crouch"];
  anim.approach_types["Cover Stand"] = [];
  anim.approach_types["Cover Stand"][0] = "stand";
  anim.approach_types["Cover Stand"][1] = "stand";
  anim.approach_types["Conceal Stand"] = anim.approach_types["Cover Stand"];
  anim.approach_types["Cover Prone"] = [];
  anim.approach_types["Cover Prone"][0] = "exposed";
  anim.approach_types["Cover Prone"][1] = "exposed";
  anim.approach_types["Conceal Prone"] = anim.approach_types["Cover Prone"];
  anim.approach_types["Cover Pillar"] = [];
  anim.approach_types["Cover Pillar"][0] = "pillar";
  anim.approach_types["Cover Pillar"][1] = "pillar_crouch";
  anim.approach_types["Path"] = [];
  anim.approach_types["Path"][0] = "exposed";
  anim.approach_types["Path"][1] = "exposed_crouch";
  anim.approach_types["Exposed"] = [];
  anim.approach_types["Exposed"][0] = "exposed";
  anim.approach_types["Exposed"][1] = "exposed_crouch";
  anim.approach_types["Guard"] = anim.approach_types["Path"];
  anim.approach_types["Turret"] = anim.approach_types["Path"];
  anim.iscombatscriptnode["Guard"] = 1;
  anim.iscombatscriptnode["Exposed"] = 1;
  anim.ispathnode["Path"] = 1;
  anim.isambushnode["Ambush"] = 1;

  level thread animscripts\cover_arrival::coverarrivaldebugtool();
}

checkapproachangles(transtypes) {
  idealtransangles[1] = 45;
  idealtransangles[2] = 0;
  idealtransangles[3] = -45;
  idealtransangles[4] = 90;
  idealtransangles[6] = -90;
  idealtransangles[7] = 135;
  idealtransangles[8] = 180;
  idealtransangles[9] = -135;
  wait 0.05;

  for(i = 1; i <= 9; i++) {
    for(j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;

      if(trans == "left" || trans == "left_crouch")
        idealadd = 90;
      else if(trans == "right" || trans == "right_crouch")
        idealadd = -90;

      if(isDefined(anim.covertransangles[trans][i])) {
        correctangle = angleclamp180(idealtransangles[i] + idealadd);
        actualangle = angleclamp180(anim.covertransangles[trans][i]);

        if(absangleclamp180(actualangle - correctangle) > 7)
          println("^1Cover approach animation has bad yaw delta: anim.coverTrans[\"" + trans + "\"][" + i + "]; is ^2" + actualangle + "^1, should be closer to ^2" + correctangle + "^1.");
      }
    }
  }

  for(i = 1; i <= 9; i++) {
    for(j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;

      if(trans == "left" || trans == "left_crouch")
        idealadd = 90;
      else if(trans == "right" || trans == "right_crouch")
        idealadd = -90;

      if(isDefined(anim.coverexitangles[trans][i])) {
        correctangle = angleclamp180(-1 * (idealtransangles[i] + idealadd + 180));
        actualangle = angleclamp180(anim.coverexitangles[trans][i]);

        if(absangleclamp180(actualangle - correctangle) > 7)
          println("^1Cover exit animation has bad yaw delta: anim.coverTrans[\"" + trans + "\"][" + i + "]; is ^2" + actualangle + "^1, should be closer to ^2" + correctangle + "^1.");
      }
    }
  }

}

getexitsplittime(approachtype, dir) {
  return anim.coverexitsplit[approachtype][dir];
}

gettranssplittime(approachtype, dir) {
  return anim.covertranssplit[approachtype][dir];
}

firstinit() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }
  anim.notfirsttime = 1;
  anim.usefacialanims = 0;

  if(!isDefined(anim.dog_health))
    anim.dog_health = 1;

  if(!isDefined(anim.dog_presstime))
    anim.dog_presstime = 1000;

  anim.dog_presstime = 1000;

  println("anim.dog_presstime = " + anim.dog_presstime);

  if(!isDefined(anim.dog_hits_before_kill))
    anim.dog_hits_before_kill = 1;

  if(getdvar(#"_id_273C0FA3") == "on")
    precacheitem("winchester1200");

  level.nextgrenadedrop = randomint(3);
  anim.defaultexception = ::empty;

  if(getdebugdvar("debug_noanimscripts") == "")
    setdvar("debug_noanimscripts", "off");
  else if(getdebugdvar("debug_noanimscripts") == "on")
    anim.defaultexception = animscripts\init::infiniteloop;

  if(getdebugdvar("debug_grenadehand") == "")
    setdvar("debug_grenadehand", "off");

  if(getdebugdvar("anim_dotshow") == "")
    setdvar("anim_dotshow", "-1");

  if(getdebugdvar("anim_debug") == "")
    setdvar("anim_debug", "");

  if(getdebugdvar("debug_misstime") == "")
    setdvar("debug_misstime", "");

  if(getdvar(#"_id_0E3283EA") == "")
    setdvar("modern", "on");

  if(getdvar(#"_id_DA8BDE9E") == "")
    setdvar("scr_ai_auto_fire_rate", "1.0");

  setdvar("scr_expDeathMayMoveCheck", "on");
  maps\_names::setup_names();
  anim.coverstandshots = 0;
  anim.lastsidestepanim = 0;
  anim.meleerange = 64;
  anim.meleerangesq = anim.meleerange * anim.meleerange;
  anim.standrangesq = 262144;
  anim.chargerangesq = 40000;
  anim.chargelongrangesq = 262144;
  anim.aivsaimeleerangesq = 160000;
  anim.animflagnameindex = 0;

  if(isDefined(level.setup_anims_callback))
    [[level.setup_anims_callback]]();

  initmovestartstoptransitions();
  anim.lastupwardsdeathtime = 0;
  anim.backpedalrangesq = 3600;
  anim.pronerangesq = 262144;
  anim.dodgerangesq = 90000;
  anim.blindaccuracymult["allies"] = 0.5;
  anim.blindaccuracymult["axis"] = 0.1;
  anim.blindaccuracymult["team3"] = 0.1;
  anim.runaccuracymult = 0.5;
  anim.combatmemorytimeconst = 10000;
  anim.combatmemorytimerand = 6000;
  anim.scriptchange = "script_change";
  anim.ramboaccuracymult = 1.0;
  anim.ramboswitchangle = 30;
  anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers["player_double_grenade"] = randomintrange(10000, 60000);
  anim.grenadetimers["AI_frag_grenade_sp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade_sp"] = randomintrange(0, 20000);
  anim.numgrenadesinprogresstowardsplayer = 0;
  anim.lastgrenadelandednearplayertime = -1000000;
  anim.lastfraggrenadetoplayerstart = -1000000;
  thread setnextplayergrenadetime();

  thread animscripts\combat_utility::grenadetimerdebug();

  setenv("none");
  anim.fire_notetrack_functions = [];
  anim.fire_notetrack_functions["scripted"] = animscripts\shared::fire_straight;
  anim.fire_notetrack_functions["cover_right"] = animscripts\shared::shootnotetrack;
  anim.fire_notetrack_functions["cover_left"] = animscripts\shared::shootnotetrack;
  anim.fire_notetrack_functions["cover_crouch"] = animscripts\shared::shootnotetrack;
  anim.fire_notetrack_functions["cover_stand"] = animscripts\shared::shootnotetrack;
  anim.fire_notetrack_functions["move"] = animscripts\shared::shootnotetrack;
  anim.shootenemywrapper_func = ::shootenemywrapper_normal;
  anim.shootflamethrowerwrapper_func = ::shootflamethrowerwrapper_normal;
  anim.notetracks = [];
  animscripts\shared::registernotetracks();

  if(!isDefined(level.flag))
    level.flag = [];

  level.painai = undefined;
  animscripts\setposemovement::initposemovementfunctions();
  anim.burstfirenumshots = array(1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 5);
  anim.fastburstfirenumshots = array(2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5);
  anim.semifirenumshots = array(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5);
  anim.badplaces = [];
  anim.badplaceint = 0;
  initwindowtraverse();
  level thread animscripts\cqb::setupcqbpointsofinterest();
  anim.covercrouchleanpitch = -55;
  anim.lastcarexplosiontime = -100000;
  thread aiturnnotifies();
  animscripts\react::reactglobalsinit();
  animscripts\combat::combatglobalsinit();
  animscripts\move::moveglobalsinit();
  animscripts\cover_behavior::coverglobalsinit();
  animscripts\pain::paingloabalsinit();
  animscripts\death::deathglobalsinit();
  animscripts\balcony::balconyglobalsinit();
}

onplayerconnect() {
  player = self;
  firstinit();
  player.invul = 0;

  println("*************************************init::onPlayerConnect");

  player thread animscripts\combat_utility::player_init();
  player thread animscripts\combat_utility::watchreloading();
}

aiturnnotifies() {
  numturnsthisframe = 0;

  while(true) {
    ai = getaiarray();

    if(ai.size == 0) {
      wait 0.05;
      numturnsthisframe = 0;
      continue;
    }

    for(i = 0; i < ai.size; i++) {
      if(!isDefined(ai[i])) {
        continue;
      }
      ai[i] notify("do_slow_things");
      numturnsthisframe++;

      if(numturnsthisframe == 3) {
        wait 0.05;
        numturnsthisframe = 0;
      }
    }
  }
}

setnextplayergrenadetime() {
  waittillframeend;

  if(isDefined(anim.playergrenaderangetime)) {
    maxtime = int(anim.playergrenaderangetime * 0.7);

    if(maxtime < 1)
      maxtime = 1;

    anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(0, maxtime);
    anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(0, maxtime);
  }

  if(isDefined(anim.playerdoublegrenadetime)) {
    maxtime = int(anim.playerdoublegrenadetime);
    mintime = int(maxtime / 2);

    if(maxtime <= mintime)
      maxtime = mintime + 1;

    anim.grenadetimers["player_double_grenade"] = randomintrange(mintime, maxtime);
  }
}

begingrenadetracking() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", grenade, weaponname);
    grenade thread grenade_earthquake();
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthquake() {
  self thread endondeath();
  self endon("end_explode");
  self waittill("explode", position);
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.5, position, 400);
}

ondeath() {
  self waittill("death");

  if(!isDefined(self)) {
    if(isDefined(self.a.usingturret))
      self.a.usingturret delete();
  }
}

setanimtype() {
  animtype = "default";
  classname = tolower(self.classname);
  tokens = strtok(classname, "_");

  foreach(token in tokens) {
    switch (token) {
      case "barnes":
      case "civilian":
      case "digbat":
      case "reznov":
      case "spetsnaz":
      case "vc":
      case "woods":
        animtype = token;
        return animtype;
      case "camo":
        return "spetsnaz";
      case "mpla":
      case "unita":
        return "mpla";
      case "kristina":
        animtype = "female";
        return animtype;
    }
  }

  return animtype;
}
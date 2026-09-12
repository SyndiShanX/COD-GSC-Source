/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58264.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("explosive_bow", &ref_13e28, undefined, &ref_13e0f);
  init_fx();
}

function init_fx() {
  level._effect["vfx_explosive_bow_explosion"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_explosive_bow.vfx");
}

function ref_13e28(var_0) {
  var_1 = self;
  var_2 = ref_13e29(var_1, var_0);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }
  }

  return var_2;
}

function ref_13e0f() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("explosive_bow", self);
  var_0.ref_133ce = 1;
  return ref_13e29(var_0, 1);
}

function get_actor_stance() {
  if(self hasweapon("iw8_sn_t9explosivebow_mp")) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(self ismantling()) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_switch_allowed()) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isusingremote()) {
    return false;
  }

  if(istrue(self.usingascender)) {
    return false;
  }

  return true;
}

function ref_13e29(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(!get_actor_stance()) {
    return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return 0;
    }
  }

  var_2 = laststandrevivedecayscale();

  if(!istrue(var_2)) {
    return var_2;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + var_0.streakname, self);
  }

  return 1;
}

function laststandrevivedecayscale() {
  scripts\common\utility::brjugg_droponplayerdeath(0, "explosive_bow");
  thread move_arena_startspawns();
  var_0 = scripts\mp\utility\weapon::getweaponrootname("iw8_sn_t9explosivebow_mp");
  var_1 = scripts\mp\class::fixcollision(var_0, undefined, undefined, -1, undefined, undefined, 0);
  self.chopper_boss_combat = 1;

  if(self hasweapon(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  }

  self giveweapon(var_1);

  if(isDefined(self.spawnx1stashlootcache) && self.spawnx1stashlootcache) {
    self setweaponammoclip(var_1, 1);
    self setweaponammostock(var_1, self.spawnx1stashlootcache - 1);
    self.spawnx1stashlootcache = undefined;
  } else {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
    self setweaponammostock(var_1, weaponstartammo(var_1, 0));
  }

  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);
  scripts\mp\weapons::fixupplayerweapons(self, var_0);
  self.spawnx1stashlootcache = self getammocount(var_1);
  self notify("explosive_bow_equipped");
  thread ref_144f9(var_1, "weapon_taken");
  thread ref_144f9(var_1, "weapon_dropped");
  thread ref_14495(var_1);
  thread ref_144fb(var_1);
  thread ref_144f2(var_1);
  thread ref_14490(var_1);
  return true;
}

function move_arena_startspawns() {
  self endon("disconnect");
  wait 0.3;

  if(isDefined(self)) {
    scripts\common\utility::brjugg_droponplayerdeath(1, "explosive_bow");
    return;
  }
}

function ref_144f9(var_0, var_1) {
  self endon("disconnect");
  self endon("exit_bow");

  for(;;) {
    self waittill(var_1, var_2);

    if(var_2 == var_0) {
      ref_138fb(var_0);
    }

    waitframe();
  }
}

function ref_14495(var_0) {
  self endon("disconnect");
  self endon("stop_explosive_bow_cancel_watcher");
  self waittill("cancel_all_killstreak_deployments");
  self notify("exit_bow");
  thread handletrex();
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  thread mlgpoint();
}

function ref_144fb(var_0) {
  self endon("disconnect");
  self endon("exit_bow");

  for(;;) {
    self waittill("weapon_change", var_1);

    if(self hasweapon(var_0) && var_1 != var_0) {
      if(var_1.basename == "armor_plate_deploy_mp") {
        self.debug_printcode = self.lastdroppableweaponobj;
        scripts\mp\weapons::ref_1316b(var_0);
      } else if(!self isonladder() && !(var_1.ismelee && self ismeleeing())) {
        ref_138fb(var_0);
      }

      continue;
    }

    if(var_1 == var_0 && isDefined(self.debug_printcode)) {
      scripts\mp\weapons::ref_1316b(self.debug_printcode);
      self.debug_printcode = undefined;
    }
  }
}

function ref_144f2(var_0) {
  self endon("disconnect");
  self endon("exit_bow");

  for(;;) {
    self waittill("weapon_fired");

    if(!self hasweapon(var_0)) {
      self notify("stop_explosive_bow_cancel_watcher");
      thread handletrex();
      return;
    }

    self.spawnx1stashlootcache = self getammocount(var_0);

    if(self.spawnx1stashlootcache == 0) {
      self.spawnx1stashlootcache = undefined;
      thread handletrex();
      thread ref_144ee(var_0);
      self notify("stop_explosive_bow_cancel_watcher");
      self notify("exit_bow");
    }

    waitframe();
  }
}

function ref_144ee(var_0) {
  self endon("disconnect");
  self waittill("weapon_change", var_1);
  self takeweapon(var_0);
}

function ref_14490(var_0) {
  self endon("disconnect");
  self endon("cleanup_explosive_bow");

  for(;;) {
    self waittill("bullet_first_impact", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_5 == var_0) {
      var_10 = vectortoangles(var_3);
      var_11 = anglesToForward(var_10);
      var_12 = anglestoright(var_10);
      var_13 = anglestoup(var_10);
      var_14 = playFX(scripts\engine\utility::getfx("vfx_explosive_bow_explosion"), var_7, var_11, var_13);
      var_14 unmarkkeyframedmover(1);
      playsoundatpos(var_7, "frag_grenade_expl_trans");
      earthquake(0.45, 0.7, var_7, 800);
      playrumbleonposition("grenade_rumble", var_7);
      physicsexplosionsphere(var_7, 800, 0, 1);
    }
  }
}

function handletrex() {
  self endon("disconnect");
  self endon("explosive_bow_equipped");
  self endon("cleanup_explosive_bow");
  self.chopper_boss_combat = 0;
  wait 6;
  self notify("cleanup_explosive_bow");
}

function ref_138fb(var_0) {
  self takeweapon(var_0);

  if(isDefined(self.spawnx1stashlootcache) && self.spawnx1stashlootcache != 0) {
    self notify("stop_explosive_bow_cancel_watcher");
    playerorigin();
  }

  thread handletrex();
  self notify("exit_bow");
}

function mlgpoint() {
  var_0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_1 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_explosive_bow", var_1);
}

function playerorigin() {
  var_0 = level.gametype == "br";

  if(var_0) {
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar("explosive_bow", 1, 0);
    return;
  }

  scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  scripts\mp\killstreaks\killstreaks::awardkillstreak("explosive_bow", "other");
}
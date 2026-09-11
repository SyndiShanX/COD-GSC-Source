/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment_interact.gsc
***********************************************/

function equipmentinteract_init() {
  level.useobjs = [];
  scripts\engine\scriptable::ref_12f5b("hack_usable", &numrequireddestinations);
  thread _updateuseobjs();
}

function numrequireddestinations(var0, var1, var2, var3, var4) {
  numsiegeflags(var0.entity, var3);
}

function numsiegeflags(var0, var1) {
  var2 = var0;
  var2.isbeingused = 1;

  if(isDefined(var1)) {
    var1.iscapturingcrate = 0;
    var1.ishacking = 1;
    thread _deployhacktablet(var1, var2);
    return;
  }
}

function _updateuseobjs() {
  level endon("game_ended");

  for(;;) {
    wait 0.2;

    foreach(var1 in level.useobjs) {
      if(!isDefined(var1)) {
        continue;
      }

      var2 = scripts\common\utility::playersnear(var1.origin, 300);

      foreach(var4 in var2) {
        if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var4, var1.owner)) || istrue(var1.isbeingused) || !var4 scripts\mp\utility\perk::_hasperk("specialty_hack") || var4 scripts\cp_mp\emp_debuff::is_empd() || level.gameended) {
          var1 disablescriptableplayeruse(var4);
          continue;
        }

        var1 enablescriptableplayeruse(var4);
      }
    }
  }
}

function remoteinteractsetup(var0, var1, var2) {
  if(isDefined(var2) || var2) {
    thread _hacksetup(var0);
    return;
  }
}

function _hacksetup(var0) {
  level.useobjs[self getentitynumber()] = self;
  self setscriptablepartstate("hack_usable", "on");

  foreach(var2 in level.players) {
    self disablescriptableplayeruse(var2);
  }
}

function _processusethink(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("mine_triggered");
  self endon("death_or_disconnect");
  self endon("emp_started");
  var1 = (getdvarfloat("perk_hack_equipment_time", 3) - getdvarfloat("perk_hack_equipment_success_time", 0.5)) * 1000;
  var2 = gettime() + var1;

  while(var2 > gettime()) {
    if(!self useButtonPressed()) {
      return false;
    }

    waitframe();
  }

  return true;
}

function _startusethink(var0, var1) {
  var0.isbeingused = 1;
  self.iscapturingcrate = 1;
  self.ishacking = 1;
  var1.interactstate = 0;
  self notify("interact_started");
  var2 = istrue(_processusethink(var0));

  if(var2) {
    var1.interactstate = 2;
  } else {
    self notify("interact_cancelled");
  }

  self notify("interact_finished");

  if(isDefined(var0)) {
    var0.isbeingused = 0;
  }

  if(isDefined(self)) {
    self.iscapturingcrate = 0;
    self.ishacking = undefined;

    if(!istrue(var2)) {
      return;
    }

    if(isDefined(var0)) {
      var0 scripts\mp\equipment::hackequipment(self);
      return;
    }

    return;
  }
}

function _deployhacktablet(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var2 = getcompleteweaponname("ks_remote_hack_mp");
  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", self);
  var3.interactstate = var1;
  thread _updatehackomnvars(var0, var1);
  var4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var2, var3, &_waituntilinteractfinished, &allowednormaldemeanor, undefined, undefined, &_ontabletputaway);

  if(istrue(var4) && isDefined(var0)) {
    thread _startusethink(var0, var3);
    return;
  }

  self notify("interact_cancelled");

  if(isDefined(var0)) {
    var0.isbeingused = 0;
    return;
  }
}

function _updatehackomnvars(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var2 = -1;

  if(isDefined(var0.equipmentref)) {
    var2 = scripts\mp\equipment::getequipmenttableinfo(var0.equipmentref).id;
  } else if(isDefined(var0.streakinfo)) {
    var2 = scripts\mp\utility\killstreak::getkillstreakindex(var0.streakinfo.streakname);
    var2 += 100;
  }

  self setclientomnvar("ui_hack_index", var2);
  self playlocalsound("iw8_eod_tablet_ui");
  _updatehackprogressomnvar(var0);

  if(var1 == 2) {
    self setclientomnvar("ui_hack_progress", 1);
    var3 = getdvarfloat("perk_hack_equipment_success_time", 0.5);
    wait var3;
  } else {
    self stoplocalsound("iw8_eod_tablet_ui");
    self setclientomnvar("ui_hack_progress", 0);
  }

  wait 0.1;
  self setclientomnvar("ui_hack_index", 0);
}

function _updatehackprogressomnvar(var0) {
  self endon("interact_cancelled");
  self waittill("interact_started");
  var1 = 1000;
  var2 = 500;
  var3 = getdvarfloat("perk_hack_equipment_time", 3) * 1000;
  var4 = getdvarfloat("perk_hack_equipment_success_time", 0.5) * 1000;
  var5 = var3 - var1 - var4;
  var6 = gettime() + var3 + var2;
  var7 = gettime() + var1;

  for(;;) {
    var8 = (gettime() - var7) / var5;
    var8 = clamp(var8, 0, 1);
    self setclientomnvar("ui_hack_progress", var8);
    wait 0.05;

    if(gettime() > var6) {
      break;
    }
  }
}

function allowednormaldemeanor(var0, var1) {
  _toggletabletallows(1);
  thread addtolittlebirdmglist();
  thread addspecialistbonus(var0);
  return true;
}

function addspecialistbonus(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var0 endon("deploy_weapon_switch_ended");

  for(;;) {
    if(!self useButtonPressed()) {
      break;
    }

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");
}

function _ontabletputaway(var0) {
  self notify("tabletPutAway");
}

function _waituntilinteractfinished(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(var0.interactstate != 0) {
    return;
  }

  self waittill("interact_finished");

  if(var0.interactstate == 2) {
    var1 = getdvarfloat("perk_hack_equipment_success_time", 0.5);
    wait var1;
    return;
  }
}

function addtolittlebirdmglist() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("death", "tabletPutAway");
  _toggletabletallows(0);
}

function _toggletabletallows(var0) {
  scripts\mp\utility\player::_freezelookcontrols(var0);

  if(isalive(self)) {
    scripts\common\utility::allow_movement(!var0);
    scripts\common\utility::allow_jump(!var0);
    scripts\common\utility::allow_usability(!var0);
    scripts\common\utility::allow_melee(!var0);
    scripts\common\utility::allow_offhand_weapons(!var0);
    return;
  }
}
/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\equipment_interact.gsc
***************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace equipment_interact;

function equipmentinteract_init() {
  level.useobjs = [];
  flag_init("equipment_interact");
  scripts\engine\utility::registersharedfunc("equipment", "deployHackTablet", &deployhacktablet);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("hack_usable", &equipmentscriptableused);
  thread _updateuseobjs();
}

function equipmentscriptableused(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  assert(part == "hack_usable");
  equipmentuse(instance.entity, player);
}

function equipmentuse(instance, player) {
  equipment = instance;

  if(iscp() && istrue(equipment.isbeingused)) {
    return;
  }

  equipment.isbeingused = 1;

  if(isDefined(player)) {
    if(iscp()) {
      equipment disablescriptableplayeruse(player);
    }

    player.iscapturingcrate = 0;
    player.ishacking = 1;
    streakinfo = player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", player);
    streakinfo.interactstate = 0;
    player thread deployhacktablet(function_be0c3a067da1e72d(equipment), equipment, streakinfo);
  }
}

function _updateuseobjs() {
  level endon("game_ended");

  while(true) {
    wait 0.2;

    foreach(useobj in level.useobjs) {
      if(!isDefined(useobj)) {
        continue;
      }

      nearplayers = utility::playersnear(useobj.origin, 300);

      foreach(player in nearplayers) {
        if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, useobj.owner)) || istrue(useobj.isbeingused) || issharedfuncdefined("perk", "hasPerk") && !player[[getsharedfunc("perk", "hasPerk")]]("specialty_hack") || player scripts\cp_mp\emp_debuff::is_empd() || player namespace_53fc9ddbb516e6e1::function_c4d8558fc1592cd6() || level.gameended) {
          useobj disablescriptableplayeruse(player);
          continue;
        }

        useobj enablescriptableplayeruse(player);
      }
    }
  }
}

function remoteinteractsetup(var_3012ab4936b3fdec, allowdefuse, allowhack) {
  if(isDefined(allowhack) || allowhack) {
    thread _hacksetup(var_3012ab4936b3fdec);
  }
}

function _hacksetup(remotedefusecallback) {
  level.useobjs[self getentitynumber()] = self;
  self setscriptablepartstate("hack_usable", "on");

  foreach(player in level.players) {
    self disablescriptableplayeruse(player);
  }
}

function _processusethink(equipment) {
  level endon("game_ended");

  if(isDefined(equipment)) {
    equipment endon("death");
    equipment endon("mine_triggered");
  }

  self endon("death_or_disconnect");
  self endon("emp_started");
  var_25979fcd6ca24291 = getdvarfloat(@ "hash_b22bb1a48299003b", 3);

  if(isDefined(equipment.var_c9f381a81d2b42ed)) {
    var_25979fcd6ca24291 = equipment.var_c9f381a81d2b42ed;
  }

  if(isDefined(equipment.var_bf11ca1f75257311)) {
    var_25979fcd6ca24291 = equipment.var_bf11ca1f75257311;
  }

  var_6daefc1a691b701d = getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5);

  if(isDefined(equipment.var_58dec9951efefbed)) {
    var_6daefc1a691b701d = equipment.var_58dec9951efefbed;
  }

  if(isDefined(equipment.var_f980def4500c0769)) {
    var_6daefc1a691b701d = equipment.var_f980def4500c0769;
  }

  interactduration = (var_25979fcd6ca24291 - var_6daefc1a691b701d) * 1000;
  var_b8cf204dd62d457f = gettime() + interactduration;

  if(isDefined(equipment.var_2c080d51c26d0785)) {
    self thread[[equipment.var_2c080d51c26d0785]]();
  }

  while(var_b8cf204dd62d457f > gettime()) {
    if(!self useButtonPressed()) {
      return false;
    }

    waitframe();
  }

  return true;
}

function _startusethink(equipment, streakinfo) {
  if(isDefined(equipment)) {
    equipment.isbeingused = 1;
  }

  self.iscapturingcrate = 1;
  self.ishacking = 1;
  streakinfo.interactstate = 0;
  self notify("interact_started");
  result = istrue(_processusethink(equipment));

  if(result) {
    streakinfo.interactstate = 2;
  } else {
    self notify("interact_cancelled");
    flag_clear("equipment_interact");
  }

  if(isDefined(equipment.var_3b863b2cb4c0df2e)) {
    self thread[[equipment.var_3b863b2cb4c0df2e]]();
  }

  self notify("interact_finished");
  flag_clear("equipment_interact");

  if(isDefined(equipment)) {
    equipment.isbeingused = 0;
  }

  if(isDefined(self)) {
    self.iscapturingcrate = 0;
    self.ishacking = undefined;

    if(!istrue(result)) {
      if(iscp() && isDefined(equipment)) {
        equipment enablescriptableplayeruse(self);
      }

      return;
    }

    if(isDefined(equipment)) {
      if(issharedfuncdefined("equipment", "hackEquipment")) {
        equipment[[getsharedfunc("equipment", "hackEquipment")]](self);
      }
    }
  }
}

function function_be0c3a067da1e72d(equipment) {
  index = -1;

  if(isDefined(equipment.equipmentref)) {
    if(issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
      index = [[getsharedfunc("equipment", "getEquipmentTableInfo")]](equipment.equipmentref).id;
    }
  }

  if(is_equal(equipment.classname, "misc_turret")) {
    if(issharedfuncdefined("killstreak", "getKillstreakIndex")) {
      index = 100 + [[getsharedfunc("killstreak", "getKillstreakIndex")]]("sentry_gun");
    } else {
      index = 109;
    }
  }

  if(isDefined(equipment.var_1f6c1f17ced6df4b)) {
    index = equipment.var_1f6c1f17ced6df4b;
  }

  assert(index != -1, "Piece of hacked equipment");
  return index;
}

function deployhacktablet(index, equipment, streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  flag_set("equipment_interact");
  weaponobj = makeweapon("ks_remote_hack_mp");

  if(isDefined(equipment.var_ad414715a4dbed05)) {
    weaponobj = equipment.var_ad414715a4dbed05;
  }

  if(isDefined(equipment.var_c9f381a81d2b42ed)) {
    var_c9f381a81d2b42ed = equipment.var_c9f381a81d2b42ed;
  }

  if(isDefined(equipment.var_58dec9951efefbed)) {
    var_58dec9951efefbed = equipment.var_58dec9951efefbed;
  }

  cleanupwaitfunc = &_waituntilinteractfinished;

  if(isDefined(equipment.var_af6b61c84f019e58)) {
    cleanupwaitfunc = equipment.var_af6b61c84f019e58;
  }

  var_28801f64e1d308be = undefined;

  if(isDefined(equipment.var_28801f64e1d308be)) {
    var_28801f64e1d308be = equipment.var_28801f64e1d308be;
  }

  childthread function_60fbd6e6fc195e7b(equipment);
  thread function_c9ada01dc3eac7f3(index, var_c9f381a81d2b42ed, var_58dec9951efefbed, var_28801f64e1d308be);
  self playlocalsound("iw9_ks_tablet_foly_raise_plr");
  switchresult = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, cleanupwaitfunc, &_ontabletgiven, undefined, undefined, &_ontabletputaway);

  if(istrue(switchresult)) {
    thread _startusethink(equipment, streakinfo);
    return;
  }

  self notify("interact_cancelled");
  flag_clear("equipment_interact");

  if(iscp()) {
    self setclientomnvar("ui_hack_index", 0);
    self setclientomnvar("ui_hack_progress", 0);
  }

  if(isDefined(equipment)) {
    equipment.isbeingused = 0;

    if(iscp()) {
      equipment enablescriptableplayeruse(self);
    }
  }
}

function function_60fbd6e6fc195e7b(equipment) {
  self endon("interact_cancelled");
  self endon("interact_finished");
  equipment scripts\engine\utility::waittill_any_2("death", "makeExplosiveUnusable");
  self notify("cancel_all_killstreak_deployments");
}

function function_c9ada01dc3eac7f3(hackindex, var_c9f381a81d2b42ed, var_58dec9951efefbed, var_28801f64e1d308be) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_hack_index", hackindex);
  self playlocalsound("iw9_spotter_perk_tablet_ui");
  _updatehackprogressomnvar(var_c9f381a81d2b42ed, var_58dec9951efefbed);

  if(isDefined(var_28801f64e1d308be)) {
    self[[var_28801f64e1d308be]]();
  }

  self stoplocalsound("iw9_spotter_perk_tablet_ui");
  self setclientomnvar("ui_hack_progress", 0);
  wait 0.1;
  self setclientomnvar("ui_hack_index", 0);
}

function _updatehackprogressomnvar(var_c9f381a81d2b42ed, var_58dec9951efefbed) {
  self endon("interact_cancelled");
  self notify("update_hack_omnvar");
  self endon("update_hack_omnvar");
  self waittill("interact_started");
  var_2646e75e629259a6 = 1000;
  var_137d951e4d233a68 = 500;
  var_84fdeec8cd47b94c = getdvarfloat(@ "hash_b22bb1a48299003b", 3) * 1000;

  if(isDefined(var_c9f381a81d2b42ed)) {
    var_84fdeec8cd47b94c = var_c9f381a81d2b42ed * 1000;
  }

  successduration = getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5) * 1000;

  if(isDefined(var_58dec9951efefbed)) {
    successduration = var_58dec9951efefbed * 1000;
  }

  barduration = var_84fdeec8cd47b94c - var_2646e75e629259a6 - successduration;
  var_b8cf204dd62d457f = gettime() + var_84fdeec8cd47b94c + var_137d951e4d233a68;
  var_b7eb0c292517d42d = gettime() + var_2646e75e629259a6;

  while(true) {
    barprogress = (gettime() - var_b7eb0c292517d42d) / barduration;
    barprogress = clamp(barprogress, 0, 1);
    self setclientomnvar("ui_hack_progress", barprogress);
    wait 0.05;

    if(gettime() > var_b8cf204dd62d457f) {
      break;
    }
  }
}

function _ontabletgiven(streakinfo, switchresult) {
  _toggletabletallows(1);
  thread _cleanuptabletallows();
  return true;
}

function _cancelputawayonuseend(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  streakinfo endon("deploy_weapon_switch_ended");

  while(true) {
    if(!self useButtonPressed()) {
      break;
    }

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");
}

function _ontabletputaway(streakinfo) {
  self notify("tabletPutAway");
  self playlocalsound("iw9_ks_tablet_foly_lower_plr");
}

function _waituntilinteractfinished(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(streakinfo.interactstate != 0) {
    return;
  }

  self waittill("interact_finished");
  flag_clear("equipment_interact");

  if(streakinfo.interactstate == 2) {
    successtime = getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5);
    wait successtime;
  }
}

function _cleanuptabletallows() {
  level endon("game_ended");
  self endon("disconnect");
  waittill_any_3("death", "tabletPutAway", "interact_cancelled");
  _toggletabletallows(0);
}

function _toggletabletallows(var_da3010af8f6be463) {
  if(isalive(self)) {
    if(var_da3010af8f6be463) {
      val::set("tablet", "allow_movement", 0);
      val::set("tablet", "allow_jump", 0);
      val::set("tablet", "usability", 0);
      val::set("tablet", "melee", 0);
      val::set("tablet", "offhand_weapons", 0);
      val::set("tablet", "fire", 0);
      val::set("tablet", "freezecontrols_allowlook", 1);
      return;
    }

    val::reset_all("tablet");
  }
}
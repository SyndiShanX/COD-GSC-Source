/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment_interact.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace equipment_interact;

function equipmentinteract_init() {
  level.useobjs = [];
  scripts\engine\utility::registersharedfunc("equipment", "deployHackTablet", &deployhacktablet);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("hack_usable", &equipmentscriptableused);
  thread _updateuseobjs();
}

function equipmentscriptableused(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  assert(part == "<dev string:x1c>");
  equipmentuse(instance.entity, player);
}

function equipmentuse(instance, player) {
  equipment = instance;
  equipment.isbeingused = 1;

  if(isDefined(player)) {
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

      assertex(useobj isscriptable(), "<dev string:x2b>");
      nearplayers = utility::playersnear(useobj.origin, 300);

      foreach(player in nearplayers) {
        areenemies = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, useobj.owner));

        if(areenemies && player != useobj.owner && !player scripts\mp\utility\perk::_hasperk("specialty_hack")) {
          useobj disablescriptableplayeruse(player);
          continue;
        }

        if(!areenemies || istrue(useobj.isbeingused) || !player scripts\mp\utility\perk::_hasperk("specialty_hack") || player scripts\cp_mp\emp_debuff::is_empd() || player namespace_53fc9ddbb516e6e1::function_c4d8558fc1592cd6() || level.gameended) {
          useobj disablescriptableplayeruse(player);
          continue;
        }

        useobj enablescriptableplayeruse(player);
      }
    }
  }
}

function remoteinteractsetup(var_3012ab4936b3fdec, allowdefuse, allowhack) {
  if(istrue(allowhack)) {
    thread _hacksetup(var_3012ab4936b3fdec);
  }
}

function _hacksetup(remotedefusecallback) {
  level.useobjs[self getentitynumber()] = self;
  assertex(self isscriptable(), "<dev string:x74>");
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
  interactduration = (getdvarfloat(@ "hash_b22bb1a48299003b", 3) - getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5)) * 1000;
  var_b8cf204dd62d457f = gettime() + interactduration;

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
  }

  self notify("interact_finished");

  if(isDefined(equipment)) {
    equipment.isbeingused = 0;
  }

  if(isDefined(self)) {
    self.iscapturingcrate = 0;
    self.ishacking = undefined;

    if(!istrue(result)) {
      return;
    }

    if(isDefined(equipment)) {
      equipment scripts\mp\equipment::hackequipment(self);
    }
  }
}

function function_be0c3a067da1e72d(equipment) {
  index = -1;

  if(isDefined(equipment.equipmentref)) {
    equipmentinfo = scripts\mp\equipment::getequipmenttableinfo(equipment.equipmentref);

    if(isDefined(equipmentinfo)) {
      index = equipmentinfo.id;
    }
  } else if(isDefined(equipment.streakinfo)) {
    index = scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(equipment.streakinfo.streakname);
  }

  assert(index != -1, "<dev string:xba>");
  return index;
}

function deployhacktablet(index, equipment, streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  weaponobj = makeweapon("ks_remote_hack_mp");
  childthread function_60fbd6e6fc195e7b(equipment);
  thread function_c9ada01dc3eac7f3(index);
  self playlocalsound("iw9_ks_tablet_foly_raise_plr");
  switchresult = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, &_waituntilinteractfinished, &_ontabletgiven, undefined, undefined, &_ontabletputaway);

  if(istrue(switchresult)) {
    thread _startusethink(equipment, streakinfo);
    return;
  }

  self notify("interact_cancelled");

  if(isDefined(equipment)) {
    equipment.isbeingused = 0;
  }
}

function function_60fbd6e6fc195e7b(equipment) {
  self endon("interact_cancelled");
  self endon("interact_finished");
  equipment scripts\engine\utility::waittill_any_2("death", "makeExplosiveUnusable");
  self notify("cancel_all_killstreak_deployments");
}

function function_c9ada01dc3eac7f3(hackindex) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_hack_index", hackindex);
  self playlocalsound("iw9_spotter_perk_tablet_ui");
  _updatehackprogressomnvar();
  self stoplocalsound("iw9_spotter_perk_tablet_ui");
  self setclientomnvar("ui_hack_progress", 0);
  wait 0.1;
  self setclientomnvar("ui_hack_index", 0);
}

function _updatehackprogressomnvar() {
  self endon("interact_cancelled");
  self waittill("interact_started");
  var_2646e75e629259a6 = 1000;
  var_137d951e4d233a68 = 500;
  var_84fdeec8cd47b94c = getdvarfloat(@ "hash_b22bb1a48299003b", 3) * 1000;
  successduration = getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5) * 1000;
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
}

function _waituntilinteractfinished(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(streakinfo.interactstate != 0) {
    return;
  }

  self waittill("interact_finished");

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
  force = ter_op(var_da3010af8f6be463, undefined, 1);
  scripts\mp\utility\player::_freezelookcontrols(var_da3010af8f6be463, force);

  if(isalive(self)) {
    if(var_da3010af8f6be463) {
      val::set("tablet", "allow_movement", 0);
      val::set("tablet", "allow_jump", 0);
      val::set("tablet", "usability", 0);
      val::set("tablet", "melee", 0);
      val::set("tablet", "offhand_weapons", 0);
      return;
    }

    val::reset_all("tablet");
  }
}
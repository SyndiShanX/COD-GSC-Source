/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_headgear.gsc
************************************************/

#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#namespace br_headgear;

function autoexec headgear_init() {
  level.headgeardata = spawnStruct();
  level.headgeardata.gear = [];
  utility::registersharedfunc("headgear", "registerHeadGear", &registerheadgear);
  level notify("headgear_init");
}

function registerheadgear(headgeartype, headgeardata) {
  if(isDefined(level.headgeardata.gear[headgeartype])) {
    return;
  }

  level.headgeardata.gear[headgeartype] = headgeardata;
}

function function_27c9f3cd0731b4c0(headgeartype) {
  if(isDefined(headgeartype)) {
    return isDefined(level.headgeardata.gear[headgeartype]);
  }

  return false;
}

function function_a34e6737707000de(headgeartype, player, var_d13c72f4128a8c16, var_fcb952f595aa03ed, var_3ca4e0ab626847bc) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    player[[headgeardata.var_f830d658f5f0af18]](var_d13c72f4128a8c16, var_fcb952f595aa03ed, var_3ca4e0ab626847bc);
  }
}

function function_bfc15242950e692b(player) {
  var_ec1ccc1b4dba40f5 = 0;

  foreach(headgeardata in level.headgeardata.gear) {
    var_ec1ccc1b4dba40f5 = [[headgeardata.var_8965dea27a03f00f]](player);

    if(istrue(var_ec1ccc1b4dba40f5)) {
      break;
    }
  }

  return var_ec1ccc1b4dba40f5;
}

function function_48c7a8ee781fbf56(player) {
  var_40155fb770719328 = 0;

  foreach(headgeardata in level.headgeardata.gear) {
    var_40155fb770719328 = [[headgeardata.hasheadgearfunc]](player);

    if(istrue(var_40155fb770719328)) {
      break;
    }
  }

  return var_40155fb770719328;
}

function hasheadgear(headgeartype, player) {
  if(!isDefined(headgeartype)) {
    return 0;
  }

  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return [[headgeardata.hasheadgearfunc]](player);
  }

  return 0;
}

function function_3e330e6a55dd4b3d(headgeartype, player) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return [[headgeardata.var_8965dea27a03f00f]](player);
  }

  return 0;
}

function function_c210b50cd31a3bc2(headgeartype) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return self[[headgeardata.var_10b068badc49b1ad]]();
  }

  return 0;
}

function function_5ecd6df2572a5899(headgeartype, player) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return [[headgeardata.var_9b9af82c327f6a63]](player);
  }

  return undefined;
}

function function_5109f3947b0c7dfb(headgeartype, player) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return [[headgeardata.var_8928676cf7288c90]](player);
  }

  return 0;
}

function function_d036366985435d3(headgeartype, player, pickup) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    return [[headgeardata.var_d2148115f2c3c399]](player, pickup);
  }

  return 0;
}

function function_b606f6e492722fdb(headgeartype, player) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    player[[headgeardata.var_fe0fd9391666371]]();
  }
}

function function_72935b93ba0bbe17(headgeartype, player) {
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata)) {
    player[[headgeardata.var_bb61027a51ec1e05]]();
  }
}

function function_2bf7865c5a1937b3(player) {
  return istrue(self.var_46fa9025626f3183);
}

function function_3ee77b6233481af9(headgeartype, request) {
  if(!isDefined(self.var_d7a794d94a3269c6)) {
    self.var_d7a794d94a3269c6 = [];
  }

  if(isDefined(self.var_d7a794d94a3269c6[request])) {
    return;
  }

  self.var_d7a794d94a3269c6[request] = 1;
  thread function_1c4dbcfeb264cd9c(headgeartype);
}

function function_9f52e7f6c7bae335(headgeartype, request) {
  if(!isDefined(self.var_d7a794d94a3269c6)) {
    self.var_d7a794d94a3269c6 = [];
  }

  if(!isDefined(self.var_d7a794d94a3269c6[request])) {
    return;
  }

  self.var_d7a794d94a3269c6[request] = undefined;
  thread function_1c4dbcfeb264cd9c(headgeartype);
}

function function_1c4dbcfeb264cd9c(headgeartype) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(istrue(self.var_46fa9025626f3183)) {
    utility::waittill_notify_or_timeout("head_gear_swap_complete", 2);
    waitframe();
  }

  self notify("headGearUpdateOnOff");
  self endon("headGearUpdateOnOff");
  self.var_46fa9025626f3183 = 1;
  waittillframeend();
  headgeardata = level.headgeardata.gear[headgeartype];
  function_f4361ea8ce0fbca4();

  if(istrue(function_c210b50cd31a3bc2(headgeartype))) {
    if(!istrue([[headgeardata.var_8965dea27a03f00f]](self))) {
      self setsoundsubmix("jup_wz_gasmask_nogas");
      thread function_7973b038d9f306f6(headgeartype);
    } else {
      self clearsoundsubmix("jup_wz_gasmask_nogas");
      thread removeheadgear(headgeartype);
    }

    return;
  }

  var_56b89cd79a0d240d = [[headgeardata.var_8965dea27a03f00f]](self);

  if(istrue(var_56b89cd79a0d240d) && (!isDefined(self.var_d7a794d94a3269c6) || !self.var_d7a794d94a3269c6.size)) {
    thread removeheadgear(headgeartype);
    return;
  }

  if(!istrue(var_56b89cd79a0d240d) && isDefined(self.var_d7a794d94a3269c6) && self.var_d7a794d94a3269c6.size) {
    thread function_7973b038d9f306f6(headgeartype);
  }
}

function function_7973b038d9f306f6(headgeartype) {
  self endon("game_ended");
  self endon("death_or_disconnect");
  headgeardata = level.headgeardata.gear[headgeartype];

  if([[headgeardata.var_8928676cf7288c90]](self) == 0) {
    self.var_46fa9025626f3183 = 0;
    return;
  }

  if(isDefined(headgeardata.var_a7d8d38f4018a344)) {
    self[[headgeardata.var_a7d8d38f4018a344]]();
  }

  self notify("head_gear_swap_complete");
  self[[headgeardata.var_4aeed0bec3628793]]();
  self.var_46fa9025626f3183 = 0;
}

function removeheadgear(headgeartype) {
  self endon("game_ended");
  self endon("death_or_disconnect");
  headgeardata = level.headgeardata.gear[headgeartype];

  if(isDefined(headgeardata.preremovefunc)) {
    self[[headgeardata.preremovefunc]]();
  }

  self notify("head_gear_swap_complete");
  self[[headgeardata.onremovefunc]]();
  self.var_46fa9025626f3183 = 0;
}

function function_46a4f41002ccc37d(player, headgeartype, request) {
  headgeardata = level.headgeardata.gear[headgeartype];
  player[[headgeardata.onremovefunc]]();
  player[[headgeardata.var_bb61027a51ec1e05]]();

  if(isDefined(self.var_d7a794d94a3269c6)) {
    self.var_d7a794d94a3269c6[request] = undefined;
  }
}

function breakheadgear(headgeartype, attacker) {
  headgeardata = level.headgeardata.gear[headgeartype];
  self[[headgeardata.breakfunc]](attacker);

  if(![[headgeardata.var_8965dea27a03f00f]](self)) {
    self.var_d7a794d94a3269c6 = undefined;
    self.headgeartype = undefined;
  }
}

function function_f4361ea8ce0fbca4() {
  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(weapobj)) {
    if(self isgestureplaying("iw8_ges_pickup_br")) {
      self stopgestureviewmodel("iw8_ges_pickup_br", 0, 1);
    }

    self takeweapon(weapobj);
    waitframe();
  }
}

function delayedattach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
}

function delayeddetach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

function function_ca27f3fd3dad0c1f() {
  self.var_ca27f3fd3dad0c1f = getdvarint(@ "hash_eb228474021f803", 1);
}

function resetgasmaskremovaldelay() {
  self.var_ca27f3fd3dad0c1f = undefined;
}
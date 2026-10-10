/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\supers\evg.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\engine\utility;
#namespace evg;

function autoexec main() {
  registersharedfunc("super_evg", "init", &function_69aaff334f8191de);
  registersharedfunc("super_evg", "onSuperButtonPressed", &function_cc4ae8e506326196);
  registersharedfunc("super_evg", "given", &function_c13e791e9af862d9);
}

function function_69aaff334f8191de() {
  registersharedfunc("super_evg", "evg_used", &evg_used);
}

function evg_used(grenade) {
  flag_init("equipment_interact");
  self.var_cb424f04bd652fb1 = undefined;
  return true;
}

function function_c13e791e9af862d9(objweapon) {
  function_816b4cfd02dde591();
  thread function_cb9565a90e01f30();
  thread function_5e0605fb98c65415();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_52c31471752bee6f);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_52c31471752bee6f);
  }

  scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_381e4571957a1940);
}

function function_5e0605fb98c65415() {
  self notify("checkSuperButtonHeld");
  self endon("checkSuperButtonHeld");
  level endon("game_ended");
  self endon("evg_take");
  counter = 0;
  self.var_dbf122a3332e5dcc = istrue(self.pers["useNVG"]);

  while(true) {
    while(self superbuttonPressed()) {
      if(!istrue(self.var_c6b5a81ec8caffd1)) {
        function_cc4ae8e506326196();
        self.var_c6b5a81ec8caffd1 = 1;
      }

      wait 1.5;
    }

    self.var_c6b5a81ec8caffd1 = 0;
    wait 0.1;
  }
}

function function_cc4ae8e506326196(objweapon) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("evg_take");
  self notify("evg_end_recharge");
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");

  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride)) {
    visionsetnight(level.nvgvisionsetoverride);
  } else {
    self visionsetnightforplayer(bundle.var_144afe956168e6e5);
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  function_65d533faebb8fd7d();
  waitframe();
}

function function_65d533faebb8fd7d() {
  if(istrue(self.ishaywire) || istrue(self.isemped) || istrue(self.ksempd)) {
    return;
  }

  if(self isonladder() || self ishanging()) {
    return;
  }

  if(isDefined(self.var_69182e585de962fe) && self.var_69182e585de962fe > gettime()) {
    return;
  }

  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  superinfo = self.super;
  outlineplayers = bundle.var_191c4a1763eabb22;

  if(istrue(self.pers["useNVG"])) {
    function_afd32ce1f3abe610(1);
    return;
  }

  percentageremaining = 100;

  if(isDefined(self.var_c6e22d7a9f998295)) {
    batteryduration = bundle.var_94e973b394c254c0;
    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));
  }

  superinfo.usepercent = percentageremaining / 100;

  if(issharedfuncdefined("supers", "updateSuperUIProgress")) {
    self[[getsharedfunc("supers", "updateSuperUIProgress")]]();
  }

  if(issharedfuncdefined("supers", "updateSuperUIState")) {
    self[[getsharedfunc("supers", "updateSuperUIState")]]();
  }

  if(percentageremaining <= 0) {
    return;
  }

  thread function_438ddb00054b12a9();
  thread function_8ef049fddedb272f();
  self nightvisionviewon();
  thread function_53710fd0ad26ee61(1);
  self setscriptablepartstate("evgSfx", "evg_on", 0);

  if(istrue(outlineplayers)) {
    thread function_268e214f18447610(0.6);
  }

  waitframe();
  self.var_69182e585de962fe = gettime() + 1000;
  function_6cbb5644d0b51e2d();

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](1);
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](1);
  }

  self setclientomnvar("ui_block_fu_not_ready_error", 1);
}

function function_6cbb5644d0b51e2d() {
  if(!istrue(self.pers["useNVG"])) {
    self.pers["useNVG"] = 1;
    return;
  }

  if(istrue(self.pers["useNVG"]) && !istrue(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["useNVG"] = 0;
  }
}

function function_8ef049fddedb272f() {
  level endon("game_ended");
  self endon("evg_off");
  self waittill("death_or_disconnect");
  self notify("evg_off_death");
  function_afd32ce1f3abe610(1);

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](0);
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](0);
  }

  self.var_c6e22d7a9f998295 = 0;
}

function function_53710fd0ad26ee61(enabled) {
  if(getdvarint(@ "hash_6c4aa4fa4c54eb2a", 1) == 0) {
    return;
  }

  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(enabled) {
    modeldown = function_248a3eaffa9c3dff();

    if(isDefined(modeldown)) {
      self.nvg3rdpersonmodel = modeldown;
      self attach(self.nvg3rdpersonmodel, "j_head");
    }

    return;
  }

  modelup = function_289ea0fdb50f3084();

  if(isDefined(modelup)) {
    self.nvg3rdpersonmodel = modelup;
    self attach(self.nvg3rdpersonmodel, "j_head");
  }
}

function function_248a3eaffa9c3dff() {
  modeldown = undefined;

  if(isDefined(level.nvgheadoverrides) && isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modeldown = level.nvgheadoverrides[self.operatorcustomization.head]["down"];
  }

  if(!isDefined(modeldown)) {
    modeldown = "offhand_wm_nvgquad_mp_1";
  } else if(modeldown == "nvg_2") {
    modeldown = "offhand_wm_nvgquad_mp_2";
  } else if(modeldown == "nvg_3") {
    modeldown = "offhand_wm_nvgquad_mp_3";
  } else if(modeldown == "nvg_4") {
    modeldown = "offhand_wm_nvgquad_mp_4";
  } else if(modeldown == "none") {
    modeldown = undefined;
  } else {
    assert(0, "Invalid entry value set in level.nvgHeadOverrides for NVG Override Down");
    modeldown = "offhand_wm_nvgquad_mp_1";
  }

  return modeldown;
}

function function_289ea0fdb50f3084() {
  modelup = undefined;

  if(isDefined(level.nvgheadoverrides) && isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modelup = level.nvgheadoverrides[self.operatorcustomization.head]["up"];
  }

  if(!isDefined(modelup)) {
    modelup = "offhand_wm_nvgquad_mp_1_up";
  } else if(modelup == "nvg_2") {
    modelup = "offhand_wm_nvgquad_mp_2_up";
  } else if(modelup == "nvg_3") {
    modelup = "offhand_wm_nvgquad_mp_3_up";
  } else if(modelup == "nvg_4") {
    modelup = "offhand_wm_nvgquad_mp_3_up";
  } else if(modelup == "none") {
    modelup = undefined;
  } else {
    assert(0, "Invalid entry value set in level.nvgHeadOverrides for NVG Override Up");
    modelup = "offhand_wm_nvgquad_mp_1_up";
  }

  return modelup;
}

function function_268e214f18447610(animdelay) {
  self endon("evg_off");
  self endon("evg_off_death");

  if(isDefined(animdelay) && animdelay > 0) {
    wait animdelay;
  }

  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  distancechecks = getdvarint(@ "hash_5716ac078aa9fdd6", 1);
  distancethreshold = getdvarint(@ "hash_3aff4275c846084a", 3000);
  distancethreshold *= distancethreshold;
  var_5b27571147e34abd = getdvarint(@ "hash_20b810a0c1bd5e81", 1);
  outlineasset = undefined;

  while(true) {
    entlist = array_combine(getaiarray(), level.players);

    foreach(player in entlist) {
      outlinefill = undefined;

      if(player == self) {
        continue;
      }

      entnum = player getentitynumber();

      if(!isDefined(self.outlineents)) {
        self.outlineents = [];
      }

      if(isDefined(self.outlineents[entnum])) {
        continue;
      }

      if(player.team == self.team) {
        if(var_5b27571147e34abd) {
          outlineasset = bundle.var_4ebae270af108843;
        }
      } else {
        outlineasset = bundle.var_c31dc1dcf26d73cf;
        outlinefill = "snapshotgrenade";
      }

      if(issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        self.outlineents[entnum] = [[getsharedfunc("outline", "outlineEnableForPlayer")]](player, self, outlineasset, "level_script");
      }
    }

    wait 0.5;
  }
}

function function_ab4442abb750dff6(animdelay) {
  waitframe();

  if(!isDefined(self.outlineents)) {
    return;
  }

  if(isDefined(animdelay) && animdelay > 0) {
    wait animdelay;
  }

  entlist = array_combine(getaiarray(), level.players);

  foreach(player in entlist) {
    if(player == self) {
      continue;
    }

    entnum = player getentitynumber();

    if(!isDefined(self.outlineents[entnum])) {
      continue;
    }

    if(issharedfuncdefined("outline", "outlineDisable")) {
      [[getsharedfunc("outline", "outlineDisable")]](self.outlineents[entnum], player);
    }
  }

  self.outlineents = undefined;
}

function function_bbf3a083d978a6d3(isjammed) {
  self function_9b28bd480aaad85f(isjammed);
}

function function_d8743ede8ca118c6(equipmentref, slot) {
  self notify("evg_take");
  thread function_816b4cfd02dde591();
}

function function_cb9565a90e01f30() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread function_816b4cfd02dde591();
}

function function_816b4cfd02dde591() {
  self.var_d07d8acb673cb5c7 = undefined;
  self.var_7653bd4be7dd5fdb = undefined;
  flag_clear("equipment_interact");
}

function function_438ddb00054b12a9() {
  self notify("evg_init_battery_decay");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("evg_init_battery_decay");
  self.var_cb424f04bd652fb1 = 1;

  if(!isDefined(self.var_c6e22d7a9f998295)) {
    self.var_c6e22d7a9f998295 = 0;
  }

  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  counter = 0;
  superinfo = self.super;
  batteryduration = bundle.var_94e973b394c254c0;
  var_3c41d0b684e437f5 = batteryduration / 100;

  while(istrue(self.var_cb424f04bd652fb1)) {
    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));

    if(percentageremaining < 0) {
      percentageremaining = 0;
    }

    if(counter >= var_3c41d0b684e437f5) {
      self.var_c6e22d7a9f998295 += counter;
      counter = 0;
    }

    if(percentageremaining <= 0) {
      thread function_2ac5b3d09529dd5b();
      break;
    }

    superinfo.usepercent = percentageremaining / 100;

    if(issharedfuncdefined("supers", "updateSuperUIProgress")) {
      self[[getsharedfunc("supers", "updateSuperUIProgress")]]();
    }

    if(issharedfuncdefined("supers", "updateSuperUIState")) {
      self[[getsharedfunc("supers", "updateSuperUIState")]]();
    }

    counter += 0.05;
    wait 0.05;
  }
}

function function_2ac5b3d09529dd5b() {
  function_afd32ce1f3abe610();

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](0);
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](0);
  }

  self setclientomnvar("ui_block_fu_not_ready_error", 0);
}

function function_afd32ce1f3abe610(shouldrefundsuper) {
  self notify("evg_off");
  self nightvisionviewoff();
  thread function_53710fd0ad26ee61(0);
  self setscriptablepartstate("evgSfx", "evg_off", 0);
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  superinfo = self.super;
  outlineplayers = bundle.var_191c4a1763eabb22;

  if(istrue(outlineplayers)) {
    thread function_ab4442abb750dff6(0.5);
  }

  waitframe();
  self.var_69182e585de962fe = gettime() + 1000;
  function_6cbb5644d0b51e2d();
  self.var_cb424f04bd652fb1 = 0;
  batteryduration = bundle.var_94e973b394c254c0;

  if(istrue(shouldrefundsuper) && isDefined(self.var_c6e22d7a9f998295) && self.var_c6e22d7a9f998295 < batteryduration) {
    self.var_c6e22d7a9f998295 -= 0.1;

    if(self.var_c6e22d7a9f998295 <= 0) {
      self.var_c6e22d7a9f998295 = 0;
    }

    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));
    superinfo.usepercent = percentageremaining / 100;
  }

  if(issharedfuncdefined("supers", "updateSuperUIProgress")) {
    self[[getsharedfunc("supers", "updateSuperUIProgress")]]();
  }

  if(issharedfuncdefined("supers", "updateSuperUIState")) {
    self[[getsharedfunc("supers", "updateSuperUIState")]]();
  }

  if(issharedfuncdefined("supers", "superUseFinished")) {
    self[[getsharedfunc("supers", "superUseFinished")]](shouldrefundsuper);
  }
}

function function_52c31471752bee6f() {
  if(istrue(self.pers["useNVG"])) {
    function_afd32ce1f3abe610(1);
  }
}

function function_381e4571957a1940() {
  if(istrue(self.pers["useNVG"])) {
    function_afd32ce1f3abe610(1);
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\supers\evg.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace evg;

function autoexec main() {
  registersharedfunc("super_evg", "init", &function_69aaff334f8191de);
  registersharedfunc("super_evg", "onSuperButtonPressed", &function_cc4ae8e506326196);
  registersharedfunc("super_evg", "given", &function_c13e791e9af862d9);
  registersharedfunc("super_evg", "evg_used", &evg_used);
  registersharedfunc("super_evg", "taken", &function_d8743ede8ca118c6);
  registersharedfunc("super_evg", "evg_handleKillcam", &evg_handlekillcam);
}

function function_69aaff334f8191de() {}

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
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_a2f9ff9de49bc0b6);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_52c31471752bee6f);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_a2f9ff9de49bc0b6);
  }

  scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_381e4571957a1940);
  scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_570ac3b064bbb1a9);
}

function function_5e0605fb98c65415() {
  self notify("evg_checkSuperButtonHeld");
  self endon("evg_checkSuperButtonHeld");
  level endon("game_ended");
  self endon("evg_take");
  self endon("disconnect");
  counter = 0;
  self.var_dbf122a3332e5dcc = istrue(self.pers["useNVG"]);

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    while(self superbuttonPressed()) {
      if(!istrue(self.var_c6b5a81ec8caffd1)) {
        function_cc4ae8e506326196();
        self.var_c6b5a81ec8caffd1 = 1;
      }

      wait 0.5;
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

  if(istrue(self.var_4eee2e8aacb91e8e)) {
    function_dcfd36b8508e118e();
    self.var_c6e22d7a9f998295 = 0;
    self.var_b7f382cdc1975a2a = 0;
    self.var_4eee2e8aacb91e8e = undefined;
    self setclientomnvar("ui_block_fu_not_ready_error", 0);
    self setclientomnvar("ui_super_can_use", 0);
    self setweaponammoclip(self.super.weaponobj, 0);
    function_afd32ce1f3abe610(0, 1);
    return;
  }

  if(self.super.usepercent <= 0 && !self.super.isinuse && !self.super.isactive) {
    result = waittill_any_timeout_1(0.5, "super_use_started");

    if(result == "timeout") {
      return;
    }
  }

  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");

  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride) && !istrue(self.ishaywire)) {
    visionsetnight(level.nvgvisionsetoverride);
  } else if(istrue(self.ishaywire) || istrue(self.isemped) || istrue(self.ksempd) || isDefined(self.var_9d3e90085b3f0da3) || istrue(self.var_85dc59c6a906819f)) {
    self visionsetnightforplayer("killstreak_color_light_damage");
  } else if(!istrue(self.ishaywire)) {
    self visionsetnightforplayer(bundle.var_144afe956168e6e5);
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  function_65d533faebb8fd7d();
  waitframe();
}

function function_65d533faebb8fd7d() {
  if(self isonladder() || self ishanging() || self isthrowinggrenade()) {
    return;
  }

  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  superinfo = self.super;
  outlineplayers = bundle.var_191c4a1763eabb22;

  if(istrue(self.pers["useNVG"])) {
    function_dcfd36b8508e118e();
    self setclientomnvar("ui_super_can_use", 1);

    if(issharedfuncdefined("supers", "handleSuperUIStateChange")) {
      self[[getsharedfunc("supers", "handleSuperUIStateChange")]](2);
      superinfo.state = 2;
    }

    function_afd32ce1f3abe610(0);
    self setweaponammoclip(superinfo.weaponobj, 1);
    return;
  }

  if(isDefined(self.usingremote) || istrue(self.deployingremoteturret)) {
    return;
  }

  percentageremaining = 100;

  if(isDefined(self.var_c6e22d7a9f998295)) {
    batteryduration = getdvarint(@ "hash_cb489895214d11b9", bundle.var_94e973b394c254c0);
    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));
    var_81d507fbe368b535 = batteryduration - self.var_c6e22d7a9f998295;

    if(var_81d507fbe368b535 < 1) {
      self.var_1a65c878d85ac217 = 1;
    }
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

  if(!istrue(self.pausesuperpointsovertime)) {
    self.pausesuperpointsovertime = 1;
  }

  thread function_438ddb00054b12a9();
  thread function_1ce7392d73fb7b4f();
  thread function_8ef049fddedb272f();
  thread function_7dc67e564fe860c0();
  thread function_eac06f5aa18f117();
  self nightvisionviewon(0, 1);
  thread function_53710fd0ad26ee61(1);
  self setscriptablepartstate("evgSfx", "evg_on", 0);

  if(istrue(outlineplayers) && !(istrue(self.ishaywire) || istrue(self.isemped) || istrue(self.ksempd) || isDefined(self.var_9d3e90085b3f0da3) || istrue(self.var_85dc59c6a906819f))) {
    thread function_268e214f18447610(0.6);
  }

  waitframe();
  function_6cbb5644d0b51e2d();

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](1);
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](1);
  }

  if(!istrue(self.var_b7f382cdc1975a2a)) {
    self setclientomnvar("ui_block_fu_not_ready_error", 1);
    self.var_b7f382cdc1975a2a = 1;
  }

  self setweaponammoclip(superinfo.weaponobj, 1);

  while(!self isnightvisionon()) {
    self nightvisionviewon(0, 1);
    wait 0.5;
  }
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
  self nightvisionviewoff(1);
  self setclientomnvar("ui_super_can_use", 1);

  if(issharedfuncdefined("supers", "handleSuperUIStateChange")) {
    self[[getsharedfunc("supers", "handleSuperUIStateChange")]](2);
    self.super.state = 2;
  }

  function_afd32ce1f3abe610(0);
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
    assert(0, "<dev string:x1c>");
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
    assert(0, "<dev string:x67>");
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

  for(newspawns = undefined; true; newspawns = []) {
    entlist = array_combine(getaiarray(), level.players);

    foreach(player in entlist) {
      outlinefill = undefined;

      if(player == self) {
        continue;
      }

      if(!istrue(callsharedfunc("player", "isReallyAlive", player))) {
        continue;
      }

      entnum = player getentitynumber();

      if(!isDefined(self.outlineents)) {
        self.outlineents = [];
      }

      if(isDefined(self.outlineents[entnum])) {
        continue;
      }

      if(isDefined(newspawns)) {
        if(isDefined(newspawns[entnum])) {
          newspawns[entnum] = undefined;
        } else {
          newspawns[entnum] = 1;
          continue;
        }
      }

      if(istrue(level.teambased) && player.team == self.team) {
        if(var_5b27571147e34abd) {
          outlineasset = bundle.var_4ebae270af108843;
        }
      } else {
        outlineasset = bundle.var_c31dc1dcf26d73cf;
        outlinefill = "snapshotgrenade";
      }

      if(issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        self.outlineents[entnum] = [[getsharedfunc("outline", "outlineEnableForPlayer")]](player, self, outlineasset, "level_script");
        player thread function_e97683bcf5f6586e(self);
      }
    }

    wait 0.5;

    if(!isDefined(newspawns)) {}
  }
}

function function_e97683bcf5f6586e(owner) {
  owner endon("remove_evg_outline");
  level endon("game_ended");
  self waittill("death_or_disconnect");

  if(!isDefined(self) || !isDefined(owner)) {
    return;
  }

  entnum = self getentitynumber();

  if(!isDefined(owner.outlineents[entnum])) {
    return;
  }

  if(issharedfuncdefined("outline", "outlineDisable")) {
    [[getsharedfunc("outline", "outlineDisable")]](owner.outlineents[entnum], self);
    owner.outlineents[entnum] = undefined;
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

  if(isDefined(entlist)) {
    foreach(player in entlist) {
      if(player == self) {
        continue;
      }

      entnum = player getentitynumber();

      if(!isDefined(self.outlineents) || !isDefined(self.outlineents[entnum])) {
        continue;
      }

      if(issharedfuncdefined("outline", "outlineDisable")) {
        [[getsharedfunc("outline", "outlineDisable")]](self.outlineents[entnum], player);
      }
    }
  }

  self notify("remove_evg_outline");
  self.outlineents = undefined;
}

function function_bbf3a083d978a6d3(isjammed) {
  self function_9b28bd480aaad85f(isjammed);
}

function function_d8743ede8ca118c6(equipmentref, slot) {
  self notify("evg_take");
  self.pausesuperpointsovertime = 0;
  thread function_816b4cfd02dde591();

  if(self isnightvisionon()) {
    self nightvisionviewoff(1);
    self.pers["useNVG"] = 0;
    self.var_cb424f04bd652fb1 = 0;
  }
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
  batteryduration = getdvarint(@ "hash_cb489895214d11b9", bundle.var_94e973b394c254c0);
  secondselapsed = 0;
  superinfo = self.super;
  var_b40dda23ea7d6b7f = bundle.var_58819f0e1d2d43d1;
  var_5c51c07febe5909f = 0;
  var_3c41d0b684e437f5 = batteryduration / 100;

  while(istrue(self.var_cb424f04bd652fb1)) {
    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));

    if(percentageremaining < 0) {
      percentageremaining = 0;
    }

    if(secondselapsed >= var_3c41d0b684e437f5) {
      self.var_c6e22d7a9f998295 += secondselapsed;
      secondselapsed = 0;
    }

    if(percentageremaining <= 0) {
      thread function_2ac5b3d09529dd5b();
      break;
    }

    superinfo.usepercent = percentageremaining / 100;

    if(!var_5c51c07febe5909f && percentageremaining <= var_b40dda23ea7d6b7f) {
      function_af4d8022b3e0453b();
      var_5c51c07febe5909f = 1;
    }

    if(issharedfuncdefined("supers", "updateSuperUIProgress")) {
      self[[getsharedfunc("supers", "updateSuperUIProgress")]]();
    }

    secondselapsed += 0.05;
    wait 0.05;
  }
}

function function_af4d8022b3e0453b() {
  self playsoundtoplayer("perk_evg_nods_battery_warning", self, self);
}

function function_2ac5b3d09529dd5b() {
  self.pausesuperpointsovertime = 0;
  self.super.usepercent = 0;
  self.var_4eee2e8aacb91e8e = 1;
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  superinfo = self.super;
  outlineplayers = bundle.var_191c4a1763eabb22;
  self visionsetnightforplayer("killstreak_color_light_damage");

  if(istrue(outlineplayers)) {
    thread function_ab4442abb750dff6(0.5);
  }

  if(istrue(self.isjuggernaut)) {
    function_afd32ce1f3abe610(0);
  }
}

function function_dcfd36b8508e118e() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("evg_take");
  offhand = self getheldoffhand();

  if(isDefined(offhand) && isDefined(offhand.basename)) {
    switch (offhand.basename) {
      case #"hash_d9266153a899a37c":
        delayweapon = offhand.basename;
        break;
    }
  }

  if(isDefined(delayweapon)) {
    while(isDefined(self.offhandweapon) && isDefined(self.offhandweapon.basename) && self.offhandweapon.basename == delayweapon) {
      wait 0.1;
    }

    return;
  } else if(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self playerads() > 0) {
    switch (self.currentweapon.basename) {
      case #"hash_5c272c0617caebf0":
        delayweapon = self.currentweapon.basename;
        break;
    }

    if(isDefined(delayweapon)) {
      while(self playerads() > 0) {
        wait 0.1;
      }
    }

    return;
  }

  while(self isinexecutionattack() || self isthrowinggrenade() || self ishanging() || istrue(self.gascoughinprogress)) {
    wait 0.1;

    if(self ishanging()) {
      var_d4feadd35c01e637 = 1;
    }
  }

  if(istrue(self.var_1a65c878d85ac217)) {
    self.var_1a65c878d85ac217 = undefined;
    wait 1;
    return;
  }

  if(istrue(var_d4feadd35c01e637)) {
    wait 0.5;
  }
}

function function_1ce7392d73fb7b4f() {
  level endon("game_ended");
  self endon("evg_off");
  self waittill("using_remote");
  self setclientomnvar("ui_super_can_use", 1);

  if(issharedfuncdefined("supers", "handleSuperUIStateChange")) {
    self[[getsharedfunc("supers", "handleSuperUIStateChange")]](2);
    self.super.state = 2;
  }

  thread function_afd32ce1f3abe610(0);
  thread function_566f0857dabdcf7d();
}

function function_566f0857dabdcf7d() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("evg_take");
  starttime = gettime();
  gracetime = starttime + 5000;

  while(!isDefined(self.usingremote) && gettime() < gracetime) {
    wait 0.5;
  }

  while(true) {
    wait 0.1;

    if(!isDefined(self.usingremote)) {
      wait 1.2;
      thread function_65d533faebb8fd7d();
      return;
    }
  }
}

function function_afd32ce1f3abe610(shouldrefundsuper, var_d0e59be609065b4f) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("evg_take");
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
  function_6cbb5644d0b51e2d();
  self.var_cb424f04bd652fb1 = 0;
  batteryduration = getdvarint(@ "hash_cb489895214d11b9", bundle.var_94e973b394c254c0);

  if(istrue(shouldrefundsuper) && isDefined(self.var_c6e22d7a9f998295) && self.var_c6e22d7a9f998295 < batteryduration) {
    self.var_c6e22d7a9f998295 -= 0.1;

    if(self.var_c6e22d7a9f998295 <= 0) {
      self.var_c6e22d7a9f998295 = 0;
    }

    percentageremaining = int(ceil((batteryduration - self.var_c6e22d7a9f998295) * 100 / batteryduration));
    superinfo.usepercent = percentageremaining / 100;
  }

  self notify("evg_off");

  if(issharedfuncdefined("supers", "updateSuperUIProgress")) {
    self[[getsharedfunc("supers", "updateSuperUIProgress")]]();
  }

  if(istrue(var_d0e59be609065b4f) && issharedfuncdefined("supers", "superUseFinished")) {
    self[[getsharedfunc("supers", "superUseFinished")]](shouldrefundsuper);
  }

  while(self isnightvisionon()) {
    self nightvisionviewoff();
    wait 0.5;
  }
}

function function_52c31471752bee6f(data) {
  self visionsetnightforplayer("killstreak_color_light_damage");
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  outlineplayers = bundle.var_191c4a1763eabb22;

  if(istrue(self.pers["useNVG"]) && istrue(outlineplayers)) {
    thread function_ab4442abb750dff6(0);
  }
}

function function_a2f9ff9de49bc0b6(data) {
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  outlineplayers = bundle.var_191c4a1763eabb22;
  self visionsetnightforplayer(bundle.var_144afe956168e6e5);

  if(istrue(self.pers["useNVG"])) {
    thread function_268e214f18447610(0);
  }
}

function function_381e4571957a1940(data) {
  self visionsetnightforplayer("killstreak_color_light_damage");
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  outlineplayers = bundle.var_191c4a1763eabb22;

  if(istrue(self.pers["useNVG"]) && istrue(outlineplayers)) {
    thread function_ab4442abb750dff6(0);
  }
}

function function_570ac3b064bbb1a9(data) {
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");
  outlineplayers = bundle.var_191c4a1763eabb22;
  self visionsetnightforplayer(bundle.var_144afe956168e6e5);

  if(istrue(self.pers["useNVG"]) && istrue(outlineplayers)) {
    thread function_268e214f18447610(0);
  }
}

function evg_handlekillcam(attacker) {
  self endon("disconnect");
  self endon("final_killcam_starting");

  if(isDefined(attacker.super.staticdata) && isDefined(attacker.super) && isDefined(attacker) && isDefined(attacker.super.staticdata.ref) && attacker.super.staticdata.ref == "super_evg") {
    if(istrue(attacker.pers["useNVG"])) {
      bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_evg");

      if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride)) {
        return;
      } else {
        self visionsetnightforplayer(bundle.var_144afe956168e6e5);
      }
    }
  }

  if(isDefined(self.super.staticdata) && isDefined(self.super) && isDefined(self.super.staticdata.ref) && self.super.staticdata.ref == "super_evg") {
    return;
  }

  thread function_3cb36de1b99ab71();
}

function function_3cb36de1b99ab71() {
  self endon("disconnect");
  self endon("final_killcam_starting");
  self waittill("spawned");

  if(isusingmatchrulesdata()) {
    nvgvisionset = getmatchrulesdata("commonOption", "nvgVisionSet");
    self visionsetnightforplayer(nvgvisionset);
    return;
  }

  self visionsetnightforplayer("iw9_mp_nvg_base_color");
}

function function_7dc67e564fe860c0() {
  level endon("game_ended");
  self endon("evg_off");

  while(true) {
    self waittill("execution_begin", victiment);
    self nightvisionviewoff(1);
    thread function_ab4442abb750dff6(0);
    inexecution = self isinexecutionattack() || self isinexecutionvictim();

    while(inexecution) {
      inexecution = self isinexecutionattack() || self isinexecutionvictim();
      waitframe();
    }

    if(isalive(self)) {
      self nightvisionviewon(1, 1);
      thread function_268e214f18447610(0);
      continue;
    }

    self setclientomnvar("ui_super_can_use", 1);

    if(issharedfuncdefined("supers", "handleSuperUIStateChange")) {
      self[[getsharedfunc("supers", "handleSuperUIStateChange")]](2);
      self.super.state = 2;
    }

    function_afd32ce1f3abe610(0);
  }
}

function function_eac06f5aa18f117() {
  self endon("game_ended");
  self endon("disconnect");
  self endon("evg_take");

  while(true) {
    self waittill("joined_team");
    lastteam = self.pers["last_team"];

    if(isDefined(lastteam) && self.team != lastteam) {
      self.var_c6e22d7a9f998295 = 0;
    }
  }
}
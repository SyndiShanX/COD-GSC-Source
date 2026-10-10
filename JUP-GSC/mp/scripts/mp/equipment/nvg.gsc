/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\nvg.gsc
***********************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\flags;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace nvg;

function runnvg() {
  val::nuke("nvg");

  if(!scripts\mp\flags::gameflag("prematch_done") && isDefined(self.infil)) {
    val::set("runNVG", "nvg", 0);
    thread allownvgsatmatchstart();
  } else {
    val::reset_all("runNVG");
  }

  if(!isDefined(self.pers["useNVG"])) {
    self.pers["useNVG"] = 0;
  }

  if(!isDefined(scripts\mp\utility\stats::getpersstat("killstreak_forcedNVGOff"))) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  thread function_ca7eb80548414e31();
  thread function_389f3670051fb40d();
  thread nvg_monitor();
}

function allownvgsatmatchstart() {
  self notify("allowNVGsAtMatchStart");
  self endon("allowNVGsAtMatchStart");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  val::reset_all("runNVG");
}

function clearnvg(clearmodel) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(clearmodel) {
      self detach(self.nvg3rdpersonmodel, "j_head");
    }

    self.nvg3rdpersonmodel = undefined;
  }
}

function savenvgstate() {
  if(self isnightvisionon()) {
    self.pers["useNVG"] = 1;
    return;
  }

  if(!self isnightvisionon() && !istrue(scripts\mp\utility\stats::getpersstat("killstreak_forcedNVGOff"))) {
    self.pers["useNVG"] = 0;
  }
}

function nvg_monitor() {
  self notify("nvg_monitor");
  self endon("nvg_monitor");
  self endon("disconnect");
  var_941cde8837521cff = gettime();

  while(true) {
    result = waittill_any_return_3("night_vision_on", "night_vision_off", "death");

    if(!isDefined(result)) {
      continue;
    }

    if(result == "death") {
      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "dmz") {
        self nightvisionviewoff(1);
        function_4ca8e54d359cf04a(0);
      }

      break;
    }

    enabled = result == "night_vision_on";
    function_4ca8e54d359cf04a(enabled);
  }
}

function function_4ca8e54d359cf04a(isenabled) {
  savenvgstate();
  nvg_update3rdperson(isenabled);

  if(istrue(isenabled)) {
    level notify("player_enabled_nvgs");
  }

  function_57a8aa1600b3e550(isenabled);
  var_2a3902259f88e70e = gettime();
  duration = var_2a3902259f88e70e - ter_op(isDefined(self.var_b6c830f1879e400f), self.var_941cde8837521cff, 0);
  scripts\mp\analyticslog::logevent_nvgtoggled(gettime(), self.lifeid, self.origin, isenabled, duration, "none");
  self.var_941cde8837521cff = var_2a3902259f88e70e;
}

function function_ca7eb80548414e31() {
  level endon("game_ended");
  self notify("nvg_monitorBlocking");
  self endon("nvg_monitorBlocking");
  thread function_b229e871fddf36d0();
  self endon("disconnect");

  while(true) {
    self waittill("pickup_object");
    childthread function_dffe59707d84c40f();

    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      function_b8159504f369a68d(0);
    }

    waittill_any_5("manual_drop", "force_manual_drop", "manual_drop_cleanup", "bomb_planted", "death");

    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      function_b8159504f369a68d(1);
    }
  }
}

function function_b229e871fddf36d0() {
  self endon("nvg_monitorBlocking");
  self endon("disconnect");
  level waittill("start_game_ended");

  if(isDefined(self)) {
    function_b8159504f369a68d(0);
  }
}

function function_57a8aa1600b3e550(isenabled) {
  togglelight = ter_op(istrue(isenabled), "on", "off");
  self setscriptablepartstate("3PLight", togglelight, 0);
}

function function_389f3670051fb40d() {
  level endon("game_ended");
  self notify("nvg_monitor3PLight");
  self endon("nvg_monitor3PLight");
  self endon("disconnect");
  self endon("death");

  while(true) {
    childthread function_d8e93127577a3812("grenade_pullback");
    childthread function_d8e93127577a3812("weapon_switch");
    childthread function_d8e93127577a3812("offhand_end");
    self waittill("nvg_checkWeapon", newweapon);

    if(!isDefined(newweapon) || !function_add04ed347410264(newweapon)) {
      function_18d34f9bb2010a02(1);
    } else {
      function_18d34f9bb2010a02(0);
    }

    if(istrue(self.pers["useNVG"])) {
      function_57a8aa1600b3e550(function_7b70c15687fd673c());
    }
  }
}

function function_d8e93127577a3812(waittillstring) {
  self endon("nvg_checkWeapon");
  self waittill(waittillstring, weapon);
  self notify("nvg_checkWeapon", weapon);
}

function function_7b70c15687fd673c() {
  cantoggle = istrue(self.var_a81b0bebe46e1039);
  return cantoggle;
}

function function_18d34f9bb2010a02(cantoggle) {
  if(cantoggle) {
    self.var_a81b0bebe46e1039 = 1;
    return;
  }

  self.var_a81b0bebe46e1039 = undefined;
}

function function_add04ed347410264(weapon) {
  if(!isDefined(weapon.basename)) {
    return 0;
  }

  switch (weapon.basename) {
    case #"hash_22f1c67a16accbe":
    case #"hash_288bc6291d670eaa":
    case #"hash_33c7f389fa9d6dd5":
    case #"hash_b43c2e4c05fafc4b":
    case #"hash_c94fd51fe359fdfe":
    case #"hash_decd8473cdd1b5a9":
      return 1;
    default:
      return 0;
  }
}

function function_dffe59707d84c40f() {
  self endon("manual_drop");
  self endon("force_manual_drop");
  self notify("nvg_monitoringGamePad");
  self endon("nvg_monitoringGamePad");

  while(true) {
    self waittill("input_type_changed");
    function_b8159504f369a68d(!scripts\engine\utility::is_player_gamepad_enabled());
  }
}

function function_b8159504f369a68d(isallowed) {
  if(isallowed) {
    scripts\common\values::reset_all("blockNVGs");
    return;
  }

  scripts\common\values::set("blockNVGs", "nvg", 0);
}

function nvg_get3rdpersonupmodel() {
  modelup = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modelup = level.nvgheadoverrides[self.operatorcustomization.head]["up"];
  }

  modeloverride = getDvar(@ "hash_59fbd1482230b72f");

  if(isDefined(modeloverride) && modeloverride != "") {
    modelup = modeloverride;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    modelup = undefined;
  } else if(!isDefined(modelup)) {
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
    assert(0, "<dev string:x1c>");
    modelup = "offhand_wm_nvgquad_mp_1_up";
  }

  return modelup;
}

function nvg_get3rdpersondownmodel() {
  modeldown = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modeldown = level.nvgheadoverrides[self.operatorcustomization.head]["down"];
  }

  modeloverride = getDvar(@ "hash_59fbd1482230b72f");

  if(isDefined(modeloverride) && modeloverride != "") {
    modeldown = modeloverride;
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
    assert(0, "<dev string:x65>");
    modeldown = "offhand_wm_nvgquad_mp_1";
  }

  return modeldown;
}

function nvg_update3rdperson(enabled) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(getdvarint(@ "hash_e3e35ec6cd674ca", 0) == 1) {
    return;
  }

  if(enabled) {
    modeldown = nvg_get3rdpersondownmodel();

    if(isDefined(modeldown)) {
      self.nvg3rdpersonmodel = modeldown;
      self attach(self.nvg3rdpersonmodel, "j_head");
    }

    return;
  }

  modelup = nvg_get3rdpersonupmodel();

  if(isDefined(modelup)) {
    self.nvg3rdpersonmodel = modelup;
    self attach(self.nvg3rdpersonmodel, "j_head");
  }
}

function function_258c5e445c8b7f80() {
  return scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4() && !namespace_aead94004cf4c147::isbackpackinventoryenabled() && !istrue(self.gulag);
}
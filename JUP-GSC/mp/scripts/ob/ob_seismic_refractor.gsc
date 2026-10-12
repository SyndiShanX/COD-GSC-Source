/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\ob\ob_seismic_refractor.gsc
***********************************************/

#using script_7534b1d3ac3ea47a;
#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace ob_seismic_refractor;

function function_8086d05fcf37c41e() {}

function spawn_refractor(spawn_struct, var_cd74e8066ff626a6, var_c974765ba1e28e93) {
  if(!isDefined(var_cd74e8066ff626a6)) {
    var_cd74e8066ff626a6 = "ob_seismic_refractor";
  }

  if(!isDefined(var_c974765ba1e28e93)) {
    var_c974765ba1e28e93 = "jup_hacking_device_ob";
  }

  if(!isDefined(level.scriptable_notify_callback_funcs["refractor_activated"]) || !array_contains(level.scriptable_notify_callback_funcs["refractor_activated"], &function_aa84440f79224493)) {
    scripts\engine\scriptable::scriptable_addnotifycallback("refractor_activated", &function_aa84440f79224493);
  }

  if(!isDefined(level.scriptable_notify_callback_funcs["refractor_hammer"]) || !array_contains(level.scriptable_notify_callback_funcs["refractor_hammer"], &function_81edae2f148e254e)) {
    scripts\engine\scriptable::scriptable_addnotifycallback("refractor_hammer", &function_81edae2f148e254e);
  }

  refractor = spawnscriptable(var_cd74e8066ff626a6, spawn_struct.origin, spawn_struct.angles);
  refractor.hammer = spawnscriptable("ob_seismic_refractor_hammer", spawn_struct.origin, spawn_struct.angles);
  refractor setscriptablepartstate("model", "unusable", 0);
  refractor.var_aa599c358ec2ad3e = [];
  refractor.var_19cb4df4192822ca = [];
  refractor.var_fb285d0793a4040c = [];
  refractor.var_8b222c47a4c5bc24 = [];
  refractor.var_f9b8a1126400b110 = [];
  namespace_29b5250e9959ea::function_3cec1b2981075936(var_c974765ba1e28e93, refractor, &function_7192fa51a97ee5e9, &function_cbbab99365ff243f, &function_d62d4fe8da417ddd);
  return refractor;
}

function function_d5c87e3695f5b16(callback) {
  if(isfunction(callback)) {
    self.var_aa599c358ec2ad3e[self.var_aa599c358ec2ad3e.size] = callback;
  }
}

function function_d290ab656c9cd6e2(callback) {
  if(isfunction(callback)) {
    self.var_19cb4df4192822ca[self.var_19cb4df4192822ca.size] = callback;
  }
}

function function_3c5ad201440cf164(callback) {
  if(isfunction(callback)) {
    self.var_fb285d0793a4040c[self.var_fb285d0793a4040c.size] = callback;
  }
}

function function_9cdaad2239acc1fc(callback) {
  if(isfunction(callback)) {
    self.var_8b222c47a4c5bc24[self.var_8b222c47a4c5bc24.size] = callback;
  }
}

function function_938ec5691a0782f8(callback) {
  if(isfunction(callback)) {
    self.var_f9b8a1126400b110[self.var_f9b8a1126400b110.size] = callback;
  }
}

function function_c31851330ac22c3c() {}

function private function_cbbab99365ff243f(player) {
  foreach(func in self.var_fb285d0793a4040c) {
    self thread[[func]](player);
  }
}

function private function_d62d4fe8da417ddd(player) {
  thread function_f083c5f7558264f4(player);

  foreach(func in self.var_8b222c47a4c5bc24) {
    self thread[[func]](player);
  }
}

function private function_f083c5f7558264f4(player) {
  player endon("interaction_complete");
  self setscriptablepartstate("flipbook", "activating", 0);
  player waittill("cancel");
  waitframe();
  self setscriptablepartstate("flipbook", "idle", 0);

  foreach(func in self.var_f9b8a1126400b110) {
    self thread[[func]](player);
  }
}

function private function_7192fa51a97ee5e9(player) {
  if(isDefined(self.var_db4f5c48c8cb9a3c)) {
    self thread[[self.var_db4f5c48c8cb9a3c]](player);
    return;
  }

  self setscriptablepartstate("model", "just_used", 0);
  self setscriptablepartstate("effects", "Initial", 0);

  foreach(func in self.var_19cb4df4192822ca) {
    self thread[[func]](player);
  }
}

function private function_cf139bdff2bdcaad(func) {
  self.var_db4f5c48c8cb9a3c = func;
}

function function_e23f7699eb3f384e() {
  if(isDefined(self.hammer)) {
    self.hammer freescriptable();
  }

  self freescriptable();
}

function function_8a76744810afe9be() {}

function private function_aa84440f79224493(instance, notif, param, instigator) {
  foreach(func in instance.var_aa599c358ec2ad3e) {
    instance thread[[func]](instance, notif, param, instigator);
  }
}

function private function_81edae2f148e254e(instance, notif, params, instigator) {
  if(!isDefined(instance.hammer)) {
    return;
  }

  switch (params) {
    case 0:
      instance.hammer setscriptablepartstate("model", "Hidden", 0);
      break;
    case 1:
      instance.hammer setscriptablepartstate("model", "static", 0);
      break;
    case 2:
      instance.hammer setscriptablepartstate("model", "initial", 0);
      break;
    case 3:
      instance.hammer setscriptablepartstate("model", "drop", 0);
      break;
    case 4:
      instance.hammer setscriptablepartstate("model", "rise", 0);
      break;
  }
}
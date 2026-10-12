/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\supers\hb_sensor.gsc
***********************************************/



#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment\hb_sensor;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace hb_sensor;

function autoexec main() {
  registersharedfunc("super_hb_sensor", "init", &hb_sensor_init);
  registersharedfunc("super_hb_sensor", "hb_sensor_used", &hb_sensor_used);
  registersharedfunc("super_hb_sensor", "onSuperButtonHold", &function_6e9e734982349368);
  registersharedfunc("super_hb_sensor", "given", &hb_sensor_given);
  registersharedfunc("super_hb_sensor", "getAmmo", &function_29dadceefda852ce);
  registersharedfunc("super_hb_sensor", "setAmmo", &function_cb98101eefdedaa);
}

function hb_sensor_init() {}

function hb_sensor_used(grenade) {
  flag_init("equipment_interact");
  self.var_d07d8acb673cb5c7 = undefined;
  batteryduration = function_c34b7f440bc57526();

  if(isDefined(self.var_7653bd4be7dd5fdb) && self.var_7653bd4be7dd5fdb < batteryduration) {
    self.var_7653bd4be7dd5fdb -= 0.1;

    if(self.var_7653bd4be7dd5fdb <= 0) {
      self.var_7653bd4be7dd5fdb = 0;
    }

    percentageremaining = int(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration));
    self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);
  }

  waitframe();
  self function_3ac2d6250a4c3f42(0);

  if(isDefined(grenade)) {
    grenade delete();
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](0);
  }

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](0);
  }

  self notify("hb_sensor_put_away");
}

function hb_sensor_given(objweapon) {
  function_3f703abc99c1bb80();
  thread function_323286bf3aa11fbb();
}

function function_6e9e734982349368(objweapon) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("hb_sensor_take");
  self notify("hb_sensor_end_recharge");
  flag_set("equipment_interact");

  if(!issubstr(objweapon, "hb_sensor") || !self superbuttonPressed()) {
    return;
  }

  percentageremaining = 100;

  if(isDefined(self.var_7653bd4be7dd5fdb)) {
    batteryduration = function_c34b7f440bc57526();
    percentageremaining = int(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration));
  }

  if(percentageremaining <= 0) {
    return;
  }

  if(issharedfuncdefined("supers", "setSuperIsInUse")) {
    self[[getsharedfunc("supers", "setSuperIsInUse")]](1);
  }

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self[[getsharedfunc("supers", "setSuperIsActive")]](1);
  }

  thread function_7be962f484c73a3();
  self function_95f24fbb015ee513(0);
  self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);
  wait 0.533;
  scripts\cp_mp\challenges::function_d997435895422ecc("super_hb_sensor", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));

  if(!scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    function_fc7e5d7d7f99703a();
  }
}

function function_7be962f484c73a3() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    msg = waittill_any_return_3("emp_started", "emp_applied", "emp_cleared");

    if(msg == "emp_cleared") {
      function_6a05d3f5b90ab3b2(0);
      continue;
    }

    function_6a05d3f5b90ab3b2(1);
  }
}

function function_6a05d3f5b90ab3b2(isjammed) {
  self function_9b28bd480aaad85f(isjammed);
}

function function_7f948b7f43448ea9(equipmentref, slot) {
  self notify("hb_sensor_take");
  thread function_3f703abc99c1bb80();
}

function function_323286bf3aa11fbb() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread function_3f703abc99c1bb80();
}

function function_3f703abc99c1bb80() {
  self.var_d07d8acb673cb5c7 = undefined;
  self.var_7653bd4be7dd5fdb = undefined;
  flag_clear("equipment_interact");
  self setclientomnvar("ui_hb_sensor_battery_percentage", 100);
  self function_3ac2d6250a4c3f42(0);
}

function function_c34b7f440bc57526() {
  if(utility::iscp()) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
  } else {
    batteryduration = getdvarint(@ "hash_3d0928eec520c586", 600);
  }

  return batteryduration;
}

function function_29dadceefda852ce() {
  return scripts\cp_mp\equipment\hb_sensor::function_db61876aca4e4cd3();
}

function function_cb98101eefdedaa(percentage) {
  return scripts\cp_mp\equipment\hb_sensor::function_30cd943d877dc29f(percentage);
}

function function_fc7e5d7d7f99703a() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.var_d07d8acb673cb5c7 = 1;

  if(!isDefined(self.var_7653bd4be7dd5fdb)) {
    self.var_7653bd4be7dd5fdb = 0;
  }

  counter = 0;
  batteryduration = function_c34b7f440bc57526();
  var_3c41d0b684e437f5 = batteryduration / 100;

  while(istrue(self.var_d07d8acb673cb5c7)) {
    percentageremaining = int(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration));

    if(percentageremaining < 0) {
      percentageremaining = 0;
    }

    self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);

    if(counter >= var_3c41d0b684e437f5) {
      self.var_7653bd4be7dd5fdb += counter;
      counter = 0;
    }

    if(percentageremaining <= 0) {
      thread function_83ef0926b5392999();
      break;
    }

    counter += 0.05;
    wait 0.05;
  }
}

function function_83ef0926b5392999() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  flag_clear("equipment_interact");
  var_4b39e4e78b233f51 = scripts\cp_mp\weapon::getgrenadeinpullback();

  if(isDefined(var_4b39e4e78b233f51)) {
    result = scripts\engine\utility::waittill_notify_or_timeout_return("hb_sensor_put_away", 1);

    if(result == "timeout") {
      self releaseoffhand();
    }
  }
}

function checkperk(perk) {
  if(issharedfuncdefined("perk", "hasPerk")) {
    return self[[getsharedfunc("perk", "hasPerk")]](perk);
  }

  return undefined;
}
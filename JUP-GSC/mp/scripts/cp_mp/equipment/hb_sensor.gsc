/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\equipment\hb_sensor.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace hb_sensor;

function hb_sensor_used(grenade) {
  if(isDefined(self.equipment["secondary"]) && self.equipment["secondary"] != "equip_hb_sensor") {
    return;
  }

  flag_init("equipment_interact");
  self.var_d07d8acb673cb5c7 = undefined;

  if(isDefined(self.var_7653bd4be7dd5fdb)) {
    self.var_7653bd4be7dd5fdb -= 0.1;

    if(self.var_7653bd4be7dd5fdb <= 0) {
      self.var_7653bd4be7dd5fdb = 0;
    }

    if(utility::iscp()) {
      batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
    } else if(checkperk("specialty_extra_tactical")) {
      batteryduration = getdvarint(@ "hash_952c250389735fd7", 60);
    } else {
      batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
    }

    percentageremaining = int(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration));
    self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);
  }

  waitframe();
  self function_3ac2d6250a4c3f42(0);

  if(isDefined(grenade)) {
    grenade delete();
  }

  if(istrue(checkperk("specialty_recharge_equipment"))) {
    thread function_83ed70de721aee0f();
  }

  self notify("hb_sensor_put_away");
}

function function_78ce4bfda3e762b3(equipmentref, slot, variantid) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("hb_sensor_take");
  self notify("hb_sensor_end_recharge");
  thread function_323286bf3aa11fbb();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_7653bd4be7dd5fdb = 0;
    self.var_3dd6d94c7b926688 = function_db61876aca4e4cd3();
  }

  while(true) {
    self waittill("grenade_pullback", objweapon);
    flag_set("equipment_interact");

    if(!issubstr(objweapon.basename, "hb_sensor")) {
      continue;
    }

    self function_95f24fbb015ee513(0);
    percentageremaining = 100;

    if(isDefined(self.var_7653bd4be7dd5fdb)) {
      if(utility::iscp()) {
        batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
      } else if(checkperk("specialty_extra_tactical")) {
        batteryduration = getdvarint(@ "hash_952c250389735fd7", 90);
      } else {
        batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
      }

      percentageremaining = int(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration));
    }

    self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);
    wait 0.533;
    function_fc7e5d7d7f99703a();
  }
}

function function_7f948b7f43448ea9(equipmentref, slot) {
  self notify("hb_sensor_take");
  function_3f703abc99c1bb80();
}

function function_323286bf3aa11fbb() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  function_3f703abc99c1bb80();
}

function function_db61876aca4e4cd3() {
  if(utility::iscp()) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
  } else if(checkperk("specialty_extra_tactical")) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 90);
  } else {
    batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
  }

  secondsused = self.var_7653bd4be7dd5fdb;

  if(!isDefined(secondsused)) {
    secondsused = 0;
  }

  return int(ceil((batteryduration - secondsused) * 100 / batteryduration));
}

function function_30cd943d877dc29f(quantity) {
  self.var_3dd6d94c7b926688 = quantity;

  if(utility::iscp()) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
  } else if(checkperk("specialty_extra_tactical")) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 90);
  } else {
    batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
  }

  self.var_7653bd4be7dd5fdb = quantity * -1 * batteryduration / 100 + batteryduration;
  return true;
}

function function_3f703abc99c1bb80() {
  self.var_d07d8acb673cb5c7 = undefined;
  self.var_7653bd4be7dd5fdb = undefined;
  self.var_3dd6d94c7b926688 = undefined;
  flag_clear("equipment_interact");
  self setclientomnvar("ui_hb_sensor_battery_percentage", 100);
  self function_3ac2d6250a4c3f42(0);
}

function function_fc7e5d7d7f99703a() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.var_d07d8acb673cb5c7 = 1;

  if(!isDefined(self.var_7653bd4be7dd5fdb)) {
    self.var_7653bd4be7dd5fdb = 0;
  }

  counter = 0;

  if(utility::iscp()) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 1200);
  } else if(checkperk("specialty_extra_tactical")) {
    batteryduration = getdvarint(@ "hash_952c250389735fd7", 60);
  } else {
    batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
  }

  var_3c41d0b684e437f5 = batteryduration / 100;

  while(istrue(self.var_d07d8acb673cb5c7)) {
    self.var_3dd6d94c7b926688 = function_db61876aca4e4cd3();

    if(self.var_3dd6d94c7b926688 < 0) {
      self.var_3dd6d94c7b926688 = 0;
    }

    self setclientomnvar("ui_hb_sensor_battery_percentage", self.var_3dd6d94c7b926688);

    if(counter >= var_3c41d0b684e437f5) {
      self.var_7653bd4be7dd5fdb += counter;
      counter = 0;
    }

    if(self.var_3dd6d94c7b926688 <= 0) {
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

    if(!istrue(checkperk("specialty_recharge_equipment"))) {
      ammo = scripts\cp_mp\equipment::getequipmentammo("equip_hb_sensor");
      scripts\cp_mp\equipment::setequipmentammo("equip_hb_sensor", ammo - 1);
    }
  }

  if(!istrue(checkperk("specialty_recharge_equipment"))) {
    function_3f703abc99c1bb80();
  }
}

function function_83ed70de721aee0f() {
  if(!isDefined(level.var_aebbd8276f721d86)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("hb_sensor_end_recharge");

  while(!istrue(self.var_d07d8acb673cb5c7) && isDefined(self.var_7653bd4be7dd5fdb)) {
    self.var_7653bd4be7dd5fdb -= level.var_aebbd8276f721d86 * level.framedurationseconds;

    if(checkperk("specialty_extra_tactical")) {
      batteryduration = getdvarint(@ "hash_952c250389735fd7", 60);
    } else {
      batteryduration = getdvarint(@ "hash_3d0928eec520c586", 60);
    }

    percentageremaining = int(clamp(ceil((batteryduration - self.var_7653bd4be7dd5fdb) * 100 / batteryduration), 0, 100));
    self setclientomnvar("ui_hb_sensor_battery_percentage", percentageremaining);

    if(self.var_7653bd4be7dd5fdb <= 0) {
      self.var_7653bd4be7dd5fdb = 0;
      self notify("hb_sensor_end_recharge");
      break;
    }

    waitframe();
  }
}

function function_8803b12c07518865() {
  if(!isDefined(self.var_7653bd4be7dd5fdb) || self.var_7653bd4be7dd5fdb <= 0) {
    return false;
  }

  self setclientomnvar("ui_hb_sensor_battery_percentage", 100);
  self.var_7653bd4be7dd5fdb = 0;
  self notify("hb_sensor_end_recharge");
  return true;
}

function function_e27c4d2340d9d56b() {
  if(!istrue(self.var_d07d8acb673cb5c7)) {
    self notify("hb_sensor_end_recharge");
    thread function_83ed70de721aee0f();
  }
}

function checkperk(perk) {
  if(issharedfuncdefined("perk", "hasPerk")) {
    return self[[getsharedfunc("perk", "hasPerk")]](perk);
  }

  return undefined;
}

function function_3efd622905908041(ref, currammo) {
  function_30cd943d877dc29f(100);
}
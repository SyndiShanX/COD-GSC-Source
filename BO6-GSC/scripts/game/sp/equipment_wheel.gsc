/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\equipment_wheel.gsc
***********************************************/

#using script_53f4e6352b0b2425;
#using scripts\anim\dialogue;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\loot;
#using scripts\sp\player\input_icon_display;
#using scripts\sp\utility;
#namespace equipment_wheel;

function private autoexec __init__system__() {
  system::register(#"equipment_wheel", undefined, &pre_main, undefined);
}

function private pre_main() {
  level utility::flag_init("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");

  if(!isDefined(level.player)) {
    level.player = getEntArray("K_p\x84a\x01", #classname)[0];
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  gamemodebundle = getgamemodescriptbundle();

  if(!(isDefined(gamemodebundle) && isDefined(gamemodebundle.campaignlootlist))) {
    return;
  }

  campaignlootlistbundle = getscriptbundle(hashcat(%"campaignlootlist:", gamemodebundle.campaignlootlist));

  if(!(isDefined(campaignlootlistbundle) && isDefined(campaignlootlistbundle.equipmentwheel))) {
    return;
  }

  var_7fab6fba92d7fbd2 = getscriptbundle(hashcat(%"equipmentradialmenuitemlist:", campaignlootlistbundle.equipmentwheel));

  if(!isDefined(var_7fab6fba92d7fbd2)) {
    return;
  }

  level.equipmentwheel = spawnStruct();
  level.equipmentwheel.itemsdatabase = var_7fab6fba92d7fbd2.var_f7668fe6431f6431;
  level.equipmentwheel.var_66805376e52addb1 = [];
  level.equipmentwheel.var_66805376e52addb1[#"lethal"] = &function_305e24b45409f9f;
  level.equipmentwheel.var_66805376e52addb1[#"tactical"] = &function_cb2264a5731eb540;
  level.equipmentwheel.var_66805376e52addb1[#"missionability"] = &function_eed6928bb2465cf9;
  level.equipmentwheel.var_66805376e52addb1[#"scorestreak"] = &function_a3ee2983bb9fda81;
  level.equipmentwheel.var_b450db9b592b6d48 = [];
  level.equipmentwheel.var_b450db9b592b6d48[#"lethal"] = &function_45406a2212fde212;
  level.equipmentwheel.var_b450db9b592b6d48[#"tactical"] = &function_d870d304e2d90a7d;
  level.equipmentwheel.var_b450db9b592b6d48[#"missionability"] = &function_67e6b51964842ae4;
  level.equipmentwheel.var_b450db9b592b6d48[#"scorestreak"] = &function_b117d183a4cd6fba;
  level.equipmentwheel.var_a3ac3dcf143c2509 = [];
  level.equipmentwheel.var_2d1dad8f0c9fd535 = [];
  level.player val::group_register("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", utility::array_combine(arrayremove(["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"], "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt "), ["\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", "\xcciN\xca", "\xe4\xf1G", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", "mV\x8d+e", "\xc9\xca\x1boX\x8c", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", "m\xc1\xe5tT\x1d?\xbd|\x9b.qX"]));
  level.player utility::ent_flag_init("\x8e\x12T\xe1h\xd8\x0f\xf2\xdf\x05-\\\x01;1j;m\x069\xfb\x03\x1d5%\xd8");
  utility::registersharedfunc(#"loot", #"_getoffhandcurrentammo", &function_84ba3ea4bf8a6822);
  utility::registersharedfunc(#"loot", #"_isinactiveoffhand", &function_268625f239e1e694);
  utility::registersharedfunc(#"loot", #"_lootoffhand", &function_c95ccd532aaf3aff);
  utility::registersharedfunc(#"offhandbox", #"_allowuse", &offhandbox_allowuse);
  utility::registersharedfunc(#"offhandbox", #"_onuse", &offhandbox_onuse);
  utility::registersharedfunc(#"offhands", #"hash_73aa1370e9574af7", &offhands_incrementequipmentammo);
  setsaveddvar(@ "hash_59dd5cbaa61fca46", 1);
  setsaveddvar(@ "hash_2ca0f4c5f6b2746a", 0);
  level.player utility::ent_flag_init("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");

  if(!isDefined(level.player.equipmentwheel)) {
    level.player.equipmentwheel = spawnStruct();
  }

  level.player.equipmentwheel.items = [];
  ui::lui_registercallback("=\xd3\x86\xfc\xa0!E1\xd5>OO\x89\xea\x05w5", &function_ab97db0799e23c07);
  ui::lui_registercallback("\xdbw\xcf\x8e\xa8ds\xfa&\xa4\xa0\x1c\x02\xc2\x1db", &equipmentfocus);
  ui::lui_registercallback("\xf7`\xc7\x93\xa9{\xb6\xfcs\n\xfcu\xe9\x12A\xab", &equipmentwheelclose);
  level.var_f3738907da301d04 = 0.25;
  level thread function_121d5290e7a01945();
}

function function_e659a935c2da012(equipment, callback) {
  thread function_ef0498ec521f48e7(equipment, callback);
}

function function_80560a909ed0d02f(equipment, func) {
  thread function_3c6a42bb7293d6a4(equipment, func);
}

function prevent_close() {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  self.equipmentwheel.prevent_close = 1;

  if(hud_management::function_48c98ea9a4f0da89(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01")) {
    hud_management::function_d8d634ceece460(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01", "Y\xf8\x18i\xd52\x03s\xb0t\xbb\xb3\x18");
  }
}

function allow_close() {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  self.equipmentwheel.prevent_close = 0;

  if(hud_management::function_48c98ea9a4f0da89(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01")) {
    hud_management::function_d8d634ceece460(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01", "a\x8d\x8d\xedw\xbe\x1b\xb1\xb7\xe6+");
  }
}

function private function_ef0498ec521f48e7(equipment, callback) {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  slot = function_a7a5e4105170fa17(equipment);

  if(slot != #"none") {
    if(!isDefined(level.equipmentwheel.var_a3ac3dcf143c2509[slot])) {
      level.equipmentwheel.var_a3ac3dcf143c2509[slot] = [];
    }

    level.equipmentwheel.var_a3ac3dcf143c2509[slot][equipment] = callback;
  }
}

function private function_3c6a42bb7293d6a4(equipment, func) {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  slot = function_a7a5e4105170fa17(equipment);

  if(slot != #"none") {
    if(!isDefined(level.equipmentwheel.var_2d1dad8f0c9fd535[slot])) {
      level.equipmentwheel.var_2d1dad8f0c9fd535[slot] = [];
    }

    level.equipmentwheel.var_2d1dad8f0c9fd535[slot][equipment] = func;
  }
}

function private function_121d5290e7a01945() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  widget_type = hud_management::function_a1a13273e72bfe46("/o\x84\x96\x89\xd6\xf8\xdf\xc2\r\xbe\n\rg\xb0\x17\xb0l\xca\xb9X\xc9\x1b\xcc<\xe4\x05*\x1d\x0eH$\xfe\xb6\f\xfdv");
  level.equipmentwheel.widget_type = widget_type;
  level.equipmentwheel.slots = [];
  slots = hud_management::function_2d30d3e4449a6631(widget_type, "\xba\x81Y\xf7}");

  foreach(data in slots) {
    slot = _slot;

    if(!isxhash(slot)) {
      slot = getxhash(slot);
    }

    level.equipmentwheel.slots[slot] = spawnStruct();
    level.equipmentwheel.slots[slot].omnvars = [];

    foreach(ref, omnvar in data.omnvars) {
      level.equipmentwheel.slots[slot].omnvars[ref] = omnvar.name;
    }

    foreach(ref, misc_data in data.misc_data) {
      if(ref == "\x9dR\xd0&") {
        level.equipmentwheel.slots[slot].bind = misc_data.value;
        continue;
      }

      if(ref == "\xba\xe4\x8dR=\xce\xc9\xc3\xc2\xea") {
        level.equipmentwheel.slots[slot].bindstring = misc_data.value;
        continue;
      }

      if(ref == "\xbd\xcc\x99hX\xdcd7\xd8\xdbts\xc2\xb5\xb2") {
        level.equipmentwheel.slots[slot].offhandslotname = misc_data.value;
      }
    }
  }

  var_26d98bae757c0b41 = hud_management::function_387c7ccb924458e5(widget_type, "\x06\xa1D\xc8\x12", "\xd7J-x\xcc\xa7");
  level.equipmentwheel.maxitems = var_26d98bae757c0b41.set_num;
  level.equipmentwheel.item_omnvars = [];

  foreach(ref, omnvar in var_26d98bae757c0b41.omnvars) {
    level.equipmentwheel.item_omnvars[ref] = omnvar.name;
  }

  var_caa8679704ee4239 = hud_management::function_f7788e5b5434e49e(level.equipmentwheel.widget_type, "\x11\xca\xcc\v\xab\xd8:", "5\xfcD\x95f\b\xad\x15\xad\xd1<m\x9f \xbf\x04t\xff\x14\x82k\xa3\xbel") ?? "6*H\xbe\xcf\xb3p\xc9\x97\x83\xf4m\xce\xaf\xce\xb2\xa5Q\x16\xee\x03\xf1\x94)\xa5!8\xad\xbe";
  level.player thread function_9db063a96fa77ce0(&"hash_5c33f75407ca32dc", var_caa8679704ee4239, 1);
  level thread function_37a24c7105d5266c(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01", widget_type, "X\xd42.\x140M\xaf\xfbM\xdc\xd6", 0);
  level thread function_f6b4af90143b14bc();
  level.player thread function_ef60517e0f8fcc25();
  level.player thread function_12387644287d5eb();
  level.player thread function_93933f911c490661();

  level thread function_da2e39314e23f147();

  level utility::flag_set("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
}

function private function_9db063a96fa77ce0(var_b4abfca89641f973, image, desired_index) {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(function_43b0da2bcbc81b06()) {
      input_icon_display::function_7c9ff06651218181("\xe8\xa3\x9dOh\x93U+\xf6", var_b4abfca89641f973, image, desired_index, undefined, undefined, "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ");

      if(val::get("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ")) {
        input_icon_display::set_enabled("\xe8\xa3\x9dOh\x93U+\xf6");
      } else {
        input_icon_display::set_disabled("\xe8\xa3\x9dOh\x93U+\xf6");
      }
    } else {
      input_icon_display::function_85f8b957b53e6cba("\xe8\xa3\x9dOh\x93U+\xf6");
    }

    utility::waittill_any("\x95T\x1c@2\xf05_\x8f\xe40\xfc \x93\x80<\x8d@\x93`I\x80=\x0f\a=", "\x1f\xd4\x12Wp\xf9\x13\x17\xc3P\xb0\x97wS\x91\xd6\"V\xc4\xe71@z");
  }
}

function private function_cd0616ab37860d2(index, omnvar, value) {
  index++;
  omnvar = getxhash(omnvar);
  assert(isPlayer(self) && index <= level.equipmentwheel.maxitems && isDefined(level.equipmentwheel.item_omnvars[omnvar]));
  self setclientomnvar(level.equipmentwheel.item_omnvars[omnvar] + "w" + index, value);
}

function private function_91cc94cde9340c33(slot, omnvar, value) {
  omnvar = getxhash(omnvar);
  assert(isPlayer(self) && isDefined(level.equipmentwheel.slots[slot].omnvars[omnvar]));
  self setclientomnvar(level.equipmentwheel.slots[slot].omnvars[omnvar], value);
}

function private function_aab60ae3eaefcdfe(index, omnvar) {
  index++;
  omnvar = getxhash(omnvar);
  assert(isPlayer(self) && index <= level.equipmentwheel.maxitems && isDefined(level.equipmentwheel.item_omnvars[omnvar]));
  return self getclientomnvar(level.equipmentwheel.item_omnvars[omnvar] + "w" + index);
}

function private function_9bb1da04e0ffafcf(slot, omnvar) {
  omnvar = getxhash(omnvar);
  assert(isPlayer(self) && isDefined(level.equipmentwheel.slots[slot].omnvars[omnvar]));
  return self getclientomnvar(level.equipmentwheel.slots[slot].omnvars[omnvar]);
}

function private function_a7a5e4105170fa17(equip_ref) {
  bundle = getscriptbundle(hashcat(%"equipmentradialmenuitem:", equip_ref));

  if(isDefined(bundle)) {
    return getxhash(bundle.slot);
  }

  return #"none";
}

function private function_c340da8a0dfa119c(equip_ref) {
  bundle = getscriptbundle(hashcat(%"equipmentradialmenuitem:", equip_ref));

  if(isDefined(bundle)) {
    return bundle.slot;
  }

  return "\f+x5";
}

function private function_705543cbc50caebd(equip_ref) {
  bundle = getscriptbundle(hashcat(%"equipmentradialmenuitem:", equip_ref));

  if(isDefined(bundle)) {
    return bundle.equipmentitemicon;
  }

  return "";
}

function function_da2e39314e23f147() {
  setdevdvarifuninitialized(@ "hash_860b0c9b01a54e61", 0);
  wait 1;
  adddebugcommand("<dev string:x24>");

  for(i = 0; i < level.offhands.precached.size; i++) {
    equipmentname = level.offhands.precached[i];
    equipmentid = function_5a1287059972c86(equipmentname);

    if(!isDefined(equipmentid) || equipmentid < 0) {
      continue;
    }

    equipmentorder = i + 1;
    adddebugcommand("<dev string:x8c>" + equipmentname + "<dev string:xc7>" + equipmentorder + "<dev string:xcc>" + equipmentname + "<dev string:xef>");
    adddebugcommand("<dev string:xf5>" + equipmentname + "<dev string:xc7>" + equipmentorder + "<dev string:x12b>" + equipmentname + "<dev string:xef>");
    adddebugcommand("<dev string:x14b>" + equipmentname + "<dev string:xc7>" + equipmentorder + "<dev string:x181>" + equipmentname + "<dev string:xef>");
  }

  player = level.player;

  while(true) {
    var_6a23abd4e53b7cb8 = getdvarint(@ "hash_9cefb99fd3a3df05", 0);

    if(var_6a23abd4e53b7cb8) {
      foreach(equipmentname, _ in player.var_31a851ac8387bb4b) {
        if(equipmentname == "<dev string:x1a1>") {
          continue;
        }

        ammoamount = weaponmaxammo(equipmentname);
        player updateammoamount(equipmentname, ammoamount, 1);
      }

      setDvar(@ "hash_9cefb99fd3a3df05", 0);
    }

    ammoequipmentname = getDvar(@ "hash_4583b92bc7652235", "<dev string:x1a9>");

    if(ammoequipmentname != "<dev string:x1a9>") {
      equipmentid = function_5a1287059972c86(ammoequipmentname);

      if(equipmentid < 0) {
        iprintln("<dev string:x1ad>" + ammoequipmentname + "<dev string:x1e2>");
      } else {
        ammoamount = weaponmaxammo(ammoequipmentname);
        slotindex = player function_847d3233c6ffbc71(ammoequipmentname);

        if(slotindex >= 0) {
          player updateammoamount(ammoequipmentname, ammoamount, 1);
        } else if(player function_9a80102d4c5a6a08()) {
          player function_8891a3fdd8abf05f(ammoequipmentname, ammoamount);
        } else {
          iprintln("<dev string:x1ad>" + ammoequipmentname + "<dev string:x21e>");
        }
      }

      setDvar(@ "hash_4583b92bc7652235", "<dev string:x1a9>");
    }

    var_bcffeaba47e3956e = getDvar(@ "hash_39ca4e5e97a8cb0a", "<dev string:x1a9>");

    if(var_bcffeaba47e3956e != "<dev string:x1a9>") {
      setDvar(@ "hash_39ca4e5e97a8cb0a", "<dev string:x1a9>");
      equipmentid = function_5a1287059972c86(var_bcffeaba47e3956e);

      if(equipmentid < 0) {
        iprintln("<dev string:x245>" + var_bcffeaba47e3956e + "<dev string:x1e2>");
      } else {
        slotindex = player function_847d3233c6ffbc71(var_bcffeaba47e3956e);

        if(slotindex >= 0) {
          player assignequipment(var_bcffeaba47e3956e);
        } else if(player function_9a80102d4c5a6a08()) {
          ammoamount = weaponmaxammo(var_bcffeaba47e3956e);
          slot_type = function_a7a5e4105170fa17(var_bcffeaba47e3956e);

          if(isDefined(level.equipmentwheel.slots[slot_type])) {
            player function_8891a3fdd8abf05f(var_bcffeaba47e3956e, ammoamount);
          }
        } else {
          iprintln("<dev string:x245>" + var_bcffeaba47e3956e + "<dev string:x275>");
        }
      }
    }

    equipmenttoremove = getDvar(@ "hash_8b2e6c049f73f3cf", "<dev string:x1a9>");

    if(equipmenttoremove != "<dev string:x1a9>") {
      setDvar(@ "hash_8b2e6c049f73f3cf", "<dev string:x1a9>");
      player remove_equipment(equipmenttoremove, 0);
    }

    waitframe();
  }
}

function private function_38e51c40a4ed78f2() {
  player = self;
  is_toggle = player getlocalplayerprofiledata("\v\xec\xef[\x8b\xc4E\x91\x93e\x89\xce$\xe5\xc2h\xa7\x1dt\xdb\x1bm\xfc\xb9MK\\");
  helper_prompts = [];
  helper_prompts["\x051\xe1\xd7\x14?\x1f%\xd7\x85\xd9,"] = &"hash_65728c1c0090d55d";

  if(is_toggle) {
    helper_prompts["\xf9}\v\xd8\xea8D\xde\xeelp]"] = &"hash_608eea35aa6ae7e3";
  } else {
    helper_prompts["\xf9}\v\xd8\xea8D\xde\xeelp]"] = &"hash_22d7835baff885d6";
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "H+G\x17\x0f\xd1\x16\xc6g\xb5t\x8e\xd5F\xca", helper_prompts);
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", 0, -75, 1, 2);
  }
}

function private function_f604d3193be7cac1() {
  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "H+G\x17\x0f\xd1\x16\xc6g\xb5t\x8e\xd5F\xca");
  }
}

function private function_676275cd858481a9(duration, activationmethod) {
  lethalequip = function_60f21f1fe8be332a(function_9bb1da04e0ffafcf(#"lethal", #"index"));
  tacticalequip = function_60f21f1fe8be332a(function_9bb1da04e0ffafcf(#"tactical", #"index"));
  missionabilityequip = function_60f21f1fe8be332a(function_9bb1da04e0ffafcf(#"missionability", #"index"));
  items = [];

  foreach(ref, item in self.equipmentwheel.items) {
    if(function_a3150fe4725a5f35(ref)) {
      items[items.size] = ref;
    }
  }

  while(items.size < 8) {
    items[items.size] = "\r+x5";
  }

  analytics::function_3728b4e402533bc4(self, lethalequip, tacticalequip, missionabilityequip, items, duration, activationmethod);
}

function function_14954d2fd536dfed(scriptbundle) {
  thread function_91823405b8d036b8(scriptbundle);
}

function private function_91823405b8d036b8(scriptbundle) {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  assert(isDefined(level.player));

  if(!isDefined(scriptbundle)) {
    return;
  }

  function_131d24cb5b9c1a08(scriptbundle);
}

function function_210a9540e37f6136(originalweaponname, overrideweaponname) {
  assert(isDefined(level.equipmentwheel.itemsdatabase));

  for(index = 0; index < level.equipmentwheel.itemsdatabase.size; index++) {
    curitemref = level.equipmentwheel.itemsdatabase[index].bundle;

    if(curitemref == originalweaponname) {
      assert(!isDefined(level.equipmentwheel.itemsdatabase[index].bundleoriginal));
      level.equipmentwheel.itemsdatabase[index].bundleoriginal = level.equipmentwheel.itemsdatabase[index].bundle;
      level.equipmentwheel.itemsdatabase[index].bundle = overrideweaponname;
      break;
    }
  }
}

function function_3adfe608f124a3cc(originalweaponname) {
  assert(isDefined(level.equipmentwheel.itemsdatabase));

  for(index = 0; index < level.equipmentwheel.itemsdatabase.size; index++) {
    originalitemref = level.equipmentwheel.itemsdatabase[index].bundleoriginal;

    if(isDefined(originalitemref) && originalitemref == originalweaponname) {
      level.equipmentwheel.itemsdatabase[index].bundle = originalitemref;
      level.equipmentwheel.itemsdatabase[index].bundleoriginal = undefined;
      break;
    }
  }
}

function function_8891a3fdd8abf05f(equipmentref, ammo, var_e43291f66769079b, var_dee60cedd2c580fe, noautoequip) {
  player = self;
  assert(isPlayer(player));

  if(!isalive(player)) {
    return;
  }

  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");

  if(isDefined(var_e43291f66769079b) && !isarray(var_e43291f66769079b)) {
    var_e43291f66769079b = [var_e43291f66769079b];
  }

  if(isDefined(var_dee60cedd2c580fe) && !isarray(var_dee60cedd2c580fe)) {
    var_dee60cedd2c580fe = [var_dee60cedd2c580fe];
  }

  if(!isDefined(ammo)) {
    ammo = 0;
  }

  if(!level.player function_a3150fe4725a5f35(equipmentref)) {
    equipmentid = function_5a1287059972c86(equipmentref);
    emptyslotindex = function_847d3233c6ffbc71("\r+x5");

    if(emptyslotindex >= 0) {
      function_a20ffc2a2b66a810(equipmentref, emptyslotindex, ammo, noautoequip);
    } else if(isarray(var_e43291f66769079b)) {
      replaceslotindex = function_847d3233c6ffbc71(var_e43291f66769079b);

      if(replaceslotindex >= 0) {
        function_a20ffc2a2b66a810(equipmentref, replaceslotindex, ammo, noautoequip);
      }
    } else if(isarray(var_dee60cedd2c580fe)) {
      replaceslotindex = function_847d3233c6ffbc71(var_dee60cedd2c580fe, 1);

      if(replaceslotindex >= 0) {
        function_a20ffc2a2b66a810(equipmentref, replaceslotindex, ammo, noautoequip);
      }
    }

    if(!player utility::ent_flag("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#")) {
      player utility::ent_flag_set("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");
    }

    player notify("\x95T\x1c@2\xf05_\x8f\xe40\xfc \x93\x80<\x8d@\x93`I\x80=\x0f\a=");
  }
}

function remove_equipment(equipmentref, var_12f9d5c7063cfec6) {
  player = self;
  assert(isPlayer(player));
  var_7fcb64d07c1cf12 = function_847d3233c6ffbc71(equipmentref);

  if(var_7fcb64d07c1cf12 < 0) {
    if(istrue(var_12f9d5c7063cfec6)) {
      assert("<dev string:x29b>" + equipmentref + "<dev string:x2be>");
    }

    return;
  }

  player function_cd0616ab37860d2(var_7fcb64d07c1cf12, "1\xcd", 0);
  player function_cd0616ab37860d2(var_7fcb64d07c1cf12, "\xdfB\x84D", 0);
  player function_cd0616ab37860d2(var_7fcb64d07c1cf12, "\x92\xd3\x9f\xbb", 0);
  player function_cd0616ab37860d2(var_7fcb64d07c1cf12, "\x1c\x93\xbdg9\xacn7", 0);
  player thread function_385fe3a2c4e07467(equipmentref, var_7fcb64d07c1cf12);
}

function private function_385fe3a2c4e07467(equipmentref, var_7fcb64d07c1cf12) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  slot_type = function_a7a5e4105170fa17(equipmentref);

  if(isDefined(level.equipmentwheel.var_b450db9b592b6d48[slot_type])) {
    self thread[[level.equipmentwheel.var_b450db9b592b6d48[slot_type]]](equipmentref, var_7fcb64d07c1cf12);
  }

  player notify("\xb2\x17\xea-8\xd6\x95\xe6t\xafr\x95\xb6o\xd9\xca\xc8_" + equipmentref);
}

function private function_a20ffc2a2b66a810(equipmentref, index, ammo, noautoequip) {
  player = self;
  assert(isPlayer(player));
  assert(index < level.equipmentwheel.maxitems);
  maxequipmentammo = weaponmaxammo(equipmentref);
  assert(ammo <= maxequipmentammo);

  if(ammo > maxequipmentammo) {
    ammo = maxequipmentammo;
  }

  equipmentid = function_5a1287059972c86(equipmentref);
  player function_cd0616ab37860d2(index, "1\xcd", equipmentid);
  player function_cd0616ab37860d2(index, "\xdfB\x84D", ammo);
  player function_cd0616ab37860d2(index, "\x92\xd3\x9f\xbb", 0);
  player function_cd0616ab37860d2(index, "\x1c\x93\xbdg9\xacn7", 0);

  if(equipmentref != "\r+x5") {
    player.equipmentwheel.items[equipmentref] = spawnStruct();
    player.equipmentwheel.items[equipmentref].itemid = equipmentid;
    player.equipmentwheel.items[equipmentref].currentammo = ammo;
    player.equipmentwheel.items[equipmentref].omnvarindex = index;
  }

  if(isDefined(level.equipmentwheel.itemsdatabase[equipmentid].rechargetime)) {
    player utility::ent_flag_set("\x8e\x12T\xe1h\xd8\x0f\xf2\xdf\x05-\\\x01;1j;m\x069\xfb\x03\x1d5%\xd8");
  }

  if(!istrue(noautoequip)) {
    player assignequipment(equipmentid);
  }
}

function force_open_equipment_wheel() {
  self notify("\xde\xdf\xad;\xd9\xa1\xd0Icx#\xc59.\xe9\xf1\xc7\x91\xf3\x18\x9a3\t\x03C\xc8");
}

function is_toggle() {
  return self getlocalplayerprofiledata("\v\xec\xef[\x8b\xc4E\x91\x93e\x89\xce$\xe5\xc2h\xa7\x1dt\xdb\x1bm\xfc\xb9MK\\");
}

function function_37a24c7105d5266c(widget_name, widget_type, command, hold_time) {
  player = level.player;
  assert(isDefined(player));
  player endon("\x1e\xfd\xd1\xa2\a");
  player thread function_3063c0065793f4c9();
  player thread watch_for_death(widget_name);
  player notifyonplayercommand("6\xbcViq\x0e\xb7\x90!\x19fyD.\xf7\x92G\xb7vTx\xf6\xf3", "H" + command);
  player notifyonplayercommand("{\xael\xc4\"A\x05\xce\x87x\xe5\v\xd4\a\vc\xabn\x155\xb4\xc2", "\xcf" + command);

  while(true) {
    ret = player utility::waittill_any_return("6\xbcViq\x0e\xb7\x90!\x19fyD.\xf7\x92G\xb7vTx\xf6\xf3", "\xde\xdf\xad;\xd9\xa1\xd0Icx#\xc59.\xe9\xf1\xc7\x91\xf3\x18\x9a3\t\x03C\xc8");

    if(!player val::get("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ") || istrue(player val::get(";\x9eH\n\xc0Y\xf4iI\x03\x90\xa8l\xd7\xa5\x82`\xfd\x84\xdb\x1eb")) || player getheldoffhand() != nullweapon() || player isuseinprogress()) {
      continue;
    }

    force_open = ret == "\xde\xdf\xad;\xd9\xa1\xd0Icx#\xc59.\xe9\xf1\xc7\x91\xf3\x18\x9a3\t\x03C\xc8";
    is_toggle = player getlocalplayerprofiledata("\v\xec\xef[\x8b\xc4E\x91\x93e\x89\xce$\xe5\xc2h\xa7\x1dt\xdb\x1bm\xfc\xb9MK\\");

    if(!is_toggle && !force_open && hold_time > 0) {
      ret = player utility::waittill_notify_or_timeout_return("{\xael\xc4\"A\x05\xce\x87x\xe5\v\xd4\a\vc\xabn\x155\xb4\xc2", hold_time);

      if(ret == "{\xael\xc4\"A\x05\xce\x87x\xe5\v\xd4\a\vc\xabn\x155\xb4\xc2" || !player val::get("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ")) {
        continue;
      }
    }

    if(isDefined(player.equipmentwheel)) {
      foreach(iteminfo in player.equipmentwheel.items) {
        player updateammoamount(itemref, 0, 0);
      }
    }

    player hud_management::function_35924dfcb78711f4(widget_name, widget_type);
    player hud_management::function_85d8a0ba2e35b6f2(widget_name, 0, 0, 1, 1);
    starttime = gettime();

    if(istrue(player.var_52005982c67ba4e7.prevent_close)) {
      player hud_management::function_d8d634ceece460(",\xa8\xec\xd2x\xe4\xef\xfd5\x1cv\x83xWHRT\xfe\x01", "Y\xf8\x18i\xd52\x03s\xb0t\xbb\xb3\x18");
    }

    function_31fc61f0d88e5046(1);
    player function_38e51c40a4ed78f2();
    player waittill("\x88\xe8/\xc7\xa0\x90\x7f\x10\x16<\x94\xfd\x1dY>\xd8a!\xb1\x16\xe8", activationmethod);

    if(isDefined(activationmethod)) {
      player function_676275cd858481a9((gettime() - starttime) / gettimescale(), activationmethod);
    }

    player function_f604d3193be7cac1();
    player hud_management::scripted_widget_destroy(widget_name);
    function_31fc61f0d88e5046(0);
  }
}

function private function_3063c0065793f4c9() {
  while(true) {
    level waittill("l\xce\x9a\x10\x10\xb9\x99\x0eT\xb7C");

    foreach(player in level.players) {
      player notify("\x88\xe8/\xc7\xa0\x90\x7f\x10\x16<\x94\xfd\x1dY>\xd8a!\xb1\x16\xe8");
    }

    rechargeslots = [#"missionability", #"scorestreak"];
    var_9ec2c37ef93cf309 = ["\xddI\x85 \x1d_\xea\x96l\x89\xda\xb6p\x98", ",\x01[\x14\x91\xc4V\xf8@\xf8\x84"];

    for(i = 0; i < rechargeslots.size; i++) {
      equip_id = player function_9bb1da04e0ffafcf(rechargeslots[i], #"index");
      equip_ref = function_60f21f1fe8be332a(equip_id);
      iteminfo = player.equipmentwheel.items[equip_ref];

      if(istrue(iteminfo.recharging) && isDefined(iteminfo.rechargetime) && isnumber(iteminfo.rechargerecord) && iteminfo.rechargetime > 0) {
        time_delta = iteminfo.rechargerecord / 1000;
        player input_icon_display::function_cc69dd0a921096d5(var_9ec2c37ef93cf309[i], iteminfo.rechargetime - time_delta, time_delta / iteminfo.rechargetime);
      }
    }
  }
}

function private watch_for_death(widget_name) {
  self waittill("\x1e\xfd\xd1\xa2\a");
  function_f604d3193be7cac1();
  hud_management::scripted_widget_destroy(widget_name);
  function_31fc61f0d88e5046(0);
}

function function_31fc61f0d88e5046(stateindex) {
  var_3f532c408d43874b = stateindex == 1;

  if(var_3f532c408d43874b) {
    level.player utility::ent_flag_set("\x1edt\x05bC\xd2W\xe1\x1de\x80\xdd)\x16:3\xec\x1d%");
    level.player val::group_set("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
    level.player enablephysicaldepthoffieldscripting(3);
    level.player setphysicaldepthoffield(1, 0, 10);
    level.player thread function_dd2fdaa2bdb789e8();
    utility_sp::function_712369ee845f814c("H+G\x17\x0f\xd1\x16\xc6g\xb5t\x8e\xd5F\xca", 0.25, 0);
    return;
  }

  level.player utility::ent_flag_clear("\x1edt\x05bC\xd2W\xe1\x1de\x80\xdd)\x16:3\xec\x1d%");
  level.player val::group_reset("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ");
  level.player disablephysicaldepthoffieldscripting();
  utility_sp::function_2853d8d2bf2b2f5("H+G\x17\x0f\xd1\x16\xc6g\xb5t\x8e\xd5F\xca", 0, 0);
}

function private function_10f0c6dd0622b646(itemref) {
  weap = makeweapon(itemref);

  if(weap.inventorytype == "\x10\x89\xc9I\x96$\x8f") {
    return getdvarint(@ "hash_bcd0fec29a9a2d47", 0);
  }

  return 0;
}

function function_7f5cfbd3540bbd6e(offhandonly = 1, var_def05e81ed53f33a = 1) {
  player = self;
  assert(isPlayer(player));

  if(!isarray(player.equipmentwheel.items)) {
    return;
  }

  foreach(itemref, iteminfo in player.equipmentwheel.items) {
    if(offhandonly) {
      weap = makeweapon(itemref);

      if(weap.inventorytype != "\x10\x89\xc9I\x96$\x8f") {
        continue;
      }
    }

    startingammo = iteminfo.startingammo ?? 0;

    if(!var_def05e81ed53f33a || startingammo > 0) {
      iteminfo.currentammo = startingammo + (startingammo > 0 ? function_10f0c6dd0622b646(itemref) : 0);
    }
  }
}

function updateammoamount(itemref, ammoamountadjustment, shouldreplace) {
  thread function_3d1f8b26b9f31388(itemref, ammoamountadjustment, shouldreplace);
}

function private function_3d1f8b26b9f31388(itemref, ammoamountadjustment, shouldreplace) {
  player = self;
  assert(isPlayer(player));

  if(!isalive(player)) {
    return;
  }

  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  player utility::ent_flag_wait("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");
  iteminfo = player.equipmentwheel.items[itemref];
  equippedweapon = player getequippedweapon(itemref);

  if(isDefined(equippedweapon)) {
    iteminfo.currentammo = player getweaponammoclip(equippedweapon);
  }

  ammoamountadjustment = ammoamountadjustment ?? 0;
  iteminfo.currentammo = iteminfo.currentammo ?? 0;
  adjustedammo = istrue(shouldreplace) ? ammoamountadjustment : iteminfo.currentammo + ammoamountadjustment;

  if(adjustedammo > weaponclipsize(itemref)) {
    adjustedammo = weaponclipsize(itemref);
  }

  if(adjustedammo < 0) {
    adjustedammo = 0;
  }

  if(isDefined(equippedweapon)) {
    player setweaponammoclip(equippedweapon, adjustedammo);
  }

  iteminfo.currentammo = adjustedammo;
  player function_cd0616ab37860d2(iteminfo.omnvarindex, "\xdfB\x84D", adjustedammo);
}

function function_62fc0dc627cb5079() {
  player = self;
  assert(isPlayer(player));
  return getarraykeys(self.equipmentwheel.items);
}

function getequipmentammo(itemref) {
  equippedweapon = getequippedweapon(itemref);

  if(isDefined(equippedweapon)) {
    return self getammocount(equippedweapon);
  }

  iteminfo = self.equipmentwheel.items[itemref];

  if(isDefined(iteminfo)) {
    return iteminfo.currentammo;
  }

  return 0;
}

function function_188108cc414aebe0() {
  player = level.player;
  assert(isPlayer(player));
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");

  if(isDefined(player.equipmentwheel)) {
    player.equipmentwheel.items = [];
    player.equipmentwheel.focuseditem = undefined;
  }

  var_f8e91afc62fde654 = getscriptbundle(%"hash_a73cd9f270bfd9f");
  var_d800be958780dae2 = var_f8e91afc62fde654.equipmentradialmenu;

  for(index = 0; index < var_d800be958780dae2.size; index++) {
    listitem = var_d800be958780dae2[index];
    player createiteminfo(listitem, index);
  }

  player utility::ent_flag_set("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");
  player notify("\x1f\xd4\x12Wp\xf9\x13\x17\xc3P\xb0\x97wS\x91\xd6\"V\xc4\xe71@z");
}

function function_131d24cb5b9c1a08(levelscriptbundlelist) {
  player = level.player;
  assert(isPlayer(player));

  if(player utility::ent_flag("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#")) {
    player assignequipment("\r+x5");
    function_188108cc414aebe0();
  }

  if(!isDefined(player.equipmentwheel)) {
    player.equipmentwheel = spawnStruct();
  }

  player.equipmentwheel.items = [];
  var_f0ba783a12b61191 = getscriptbundle(hashcat(%"hash_7699345c8e3e9fd4", levelscriptbundlelist));
  var_f04a0bd038eecdf3 = var_f0ba783a12b61191.equipmentradialmenu;

  for(index = 0; index < var_f04a0bd038eecdf3.size; index++) {
    listitem = var_f04a0bd038eecdf3[index];
    player createiteminfo(listitem, index);
  }

  player utility::ent_flag_set("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");
}

function private equipmentfocus(itemid) {
  ref = function_60f21f1fe8be332a(itemid);
  self.equipmentwheel.focuseditem = ref;
  self notify("&\xa2\x96\x04\xb9\xef4.\xa8\xb2I\xfe\x13\x93\xd5g=\xd3\x10\x15s5\xb4n\xef\xbb", ref);
}

function private function_ab97db0799e23c07(itemid) {
  ref = function_60f21f1fe8be332a(itemid);

  if(isDefined(ref)) {
    assignequipment(ref);
  }
}

function equipmentwheelclose(activationmethod) {
  self.equipmentwheel.focuseditem = undefined;
  self notify("\x88\xe8/\xc7\xa0\x90\x7f\x10\x16<\x94\xfd\x1dY>\xd8a!\xb1\x16\xe8", activationmethod == 1 ? "k\xa6\x83\xcbTP" : "\x11@2\x9a");
}

function assignequipment(itemname) {
  thread function_c86c5df5359cf1dc(itemname);
}

function private function_c86c5df5359cf1dc(itemname) {
  player = self;
  assert(isPlayer(player));

  if(!isalive(player)) {
    return;
  }

  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  player utility::ent_flag_wait("\xcaq\xba-\xc1\xda\x95n\xd1\xaf\xbbCVY\x8d\xbe\x0e\xedp\xae\xb1\xb0t\xb2#");

  if(!isstring(itemname)) {
    itemname = function_60f21f1fe8be332a(itemname);
  }

  slot = function_a7a5e4105170fa17(itemname);

  if(isDefined(level.equipmentwheel.var_66805376e52addb1[slot])) {
    player thread[[level.equipmentwheel.var_66805376e52addb1[slot]]](itemname);
  }
}

function createiteminfo(listitem, ewindex) {
  player = self;
  assert(isPlayer(player));
  itemref = listitem.var_7fada581ebce6aac;
  itemid = function_5a1287059972c86(itemref);

  if(!isDefined(itemid)) {
    return;
  }

  startingammo = int(listitem.equipmentitemstartingammo ?? 0);
  currentammo = startingammo + (startingammo > 0 ? function_10f0c6dd0622b646(itemref) : 0);
  player.equipmentwheel.items[itemref] = spawnStruct();
  player.equipmentwheel.items[itemref].itemid = itemid;
  player.equipmentwheel.items[itemref].startingammo = startingammo;
  player.equipmentwheel.items[itemref].currentammo = currentammo;
  player.equipmentwheel.items[itemref].omnvarindex = ewindex;
  equippedweapon = player getequippedweapon(itemref);

  if(isDefined(equippedweapon)) {
    player setweaponammoclip(equippedweapon, player.equipmentwheel.items[itemref].currentammo);
  }

  player function_cd0616ab37860d2(ewindex, "1\xcd", itemid);
  player function_cd0616ab37860d2(ewindex, "\xdfB\x84D", player.equipmentwheel.items[itemref].currentammo);

  if(isDefined(level.equipmentwheel.itemsdatabase[itemid].rechargetime)) {
    player utility::ent_flag_set("\x8e\x12T\xe1h\xd8\x0f\xf2\xdf\x05-\\\x01;1j;m\x069\xfb\x03\x1d5%\xd8");
  }

  player notify("\x95T\x1c@2\xf05_\x8f\xe40\xfc \x93\x80<\x8d@\x93`I\x80=\x0f\a=");
}

function function_5a1287059972c86(itemref) {
  if(!isDefined(level.equipmentwheel.itemsdatabase)) {
    return;
  }

  if(!isDefined(itemref)) {
    return;
  }

  for(index = 0; index < level.equipmentwheel.itemsdatabase.size; index++) {
    curitemref = level.equipmentwheel.itemsdatabase[index].bundle;

    if(curitemref === itemref) {
      return index;
    }
  }
}

function function_60f21f1fe8be332a(itemid) {
  for(index = 0; index < level.equipmentwheel.itemsdatabase.size; index++) {
    curitemref = level.equipmentwheel.itemsdatabase[index].bundle;

    if(isDefined(curitemref) && index == itemid) {
      return curitemref;
    }
  }
}

function function_563a9fd1ba69a44(ewindex) {
  player = self;
  assert(isPlayer(player));
  ewindex -= 1;

  if(ewindex >= 0 && isDefined(player.equipmentwheel.items)) {
    foreach(item in player.equipmentwheel.items) {
      if(item.omnvarindex == ewindex) {
        return {
          #ammo: item.currentammo, #id: item.itemid, #ref: ref
        };
      }
    }
  }
}

function private function_a3150fe4725a5f35(equipmentref) {
  player = self;
  assert(isPlayer(player));
  equipmentid = function_5a1287059972c86(equipmentref);

  for(index = 0; index < level.equipmentwheel.maxitems; index++) {
    id = player function_aab60ae3eaefcdfe(index, "1\xcd");

    if(id == equipmentid) {
      return true;
    }
  }

  return false;
}

function private function_43b0da2bcbc81b06() {
  player = self;
  assert(isPlayer(player));

  if(isDefined(player.equipmentwheel.items)) {
    foreach(_ in player.equipmentwheel.items) {
      if(item != "\r+x5") {
        return true;
      }
    }
  }

  return false;
}

function function_dd2fdaa2bdb789e8() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level.player setsoundsubmix("\xc2\xd6$\t\xc4\x87\x99\n\v\x87\xfd\x95\x8c\rE\xadY|\xd7");
  level.player setclienttriggeraudiozonepartial("\xc2\xd6$\t\xc4\x87\x99\n\v\x87\xfd\x95\x8c\rE\xadY|\xd7");
  soundsettimescalefactorfromtable("P,\x94\x13yIV\x81%\xfa\x8b@\xc1\xbb\x7f\x9b");
  drone = snd::play("c-V\xc8\xebb<\xde\xf5\xac\xe6\x9fy\x9e\xc4O)0\xe3+\xee", level.player);
  level.player utility::waittill_any("\x88\xe8/\xc7\xa0\x90\x7f\x10\x16<\x94\xfd\x1dY>\xd8a!\xb1\x16\xe8", "\xe6\xb2\r\xcd\xc8fiS[T\xa9(.t\x90\xf7\n\xc7\x7f\xa4\x98@", "\x1e\xfd\xd1\xa2\a");
  soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
  level.player clearsoundsubmix("\xc2\xd6$\t\xc4\x87\x99\n\v\x87\xfd\x95\x8c\rE\xadY|\xd7");
  level.player clearclienttriggeraudiozone(1);
  snd::stop(drone, 0.25);
}

function private getequippedweapon(itemref) {
  player = self;
  assert(isPlayer(player));
  weapons = player getweaponslistall();

  foreach(weap in weapons) {
    if(weap.basename == itemref) {
      if(weaponclass(weap) == ",\xe1\x93So\x98\r") {
        slottype = function_a7a5e4105170fa17(itemref);

        if(slottype == #"lethal" || slottype == #"tactical") {
          var_cc45e1f51f10262b = player getcurrentoffhand(level.equipmentwheel.slots[slottype].offhandslotname);

          if(!isDefined(var_cc45e1f51f10262b) || var_cc45e1f51f10262b.basename != itemref) {
            continue;
          }
        }
      }

      return weap;
    }
  }
}

function private function_847d3233c6ffbc71(var_a75f72e5ea900351, usingexclusionlist) {
  player = self;
  candidates = var_a75f72e5ea900351;

  if(!isarray(var_a75f72e5ea900351)) {
    candidates = [var_a75f72e5ea900351];
  }

  for(index = 0; index < level.equipmentwheel.maxitems; index++) {
    id = player function_aab60ae3eaefcdfe(index, "1\xcd");
    curitemref = level.equipmentwheel.itemsdatabase[id].bundle;

    if(istrue(usingexclusionlist)) {
      if(!arraycontains(candidates, curitemref)) {
        return index;
      }

      continue;
    }

    if(arraycontains(candidates, curitemref)) {
      return index;
    }
  }

  return -1;
}

function private function_9a80102d4c5a6a08() {
  return function_a3150fe4725a5f35("\r+x5");
}

function private function_84ba3ea4bf8a6822(lootname, weaponname) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  equippedweapon = player getequippedweapon(weaponname);

  if(isDefined(equippedweapon)) {
    return player getweaponammoclip(equippedweapon);
  } else {
    index = function_847d3233c6ffbc71(weaponname);

    if(index >= 0) {
      return player function_aab60ae3eaefcdfe(index, "\xdfB\x84D");
    }
  }

  return player getweaponammoclip(weaponname);
}

function private function_268625f239e1e694(lootname, weaponname) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  currentammo = loot::getoffhandcurrentammo(lootname);
  maxammo = loot::function_747691235db172f6(lootname);
  return currentammo >= maxammo;
}

function private function_c95ccd532aaf3aff(lootname, weaponname) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  slotindex = player function_847d3233c6ffbc71(weaponname);
  ammoadded = 0;

  if(slotindex >= 0) {
    player updateammoamount(weaponname, 1);
    ammoadded = 1;
  } else if(player function_9a80102d4c5a6a08()) {
    itemid = function_5a1287059972c86(weaponname);
    slot = function_a7a5e4105170fa17(weaponname);

    if(isDefined(itemid) && isDefined(slot)) {
      wheelid = player function_9bb1da04e0ffafcf(slot, #"index");
      autoassign = wheelid == -1;
      player function_8891a3fdd8abf05f(weaponname, 1, autoassign);
      ammoadded = 1;
    }
  }

  if(ammoadded > 0) {
    player notify("\xcdY4\x11\xcfAx\x81\xbah\x83\xa5.\xa2\"\x1bt\xfc\xa0", lootname);
  }
}

function private offhandbox_allowuse(offhandbox) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  loottypename = offhandbox.item_type;
  weaponname = loot::getoffhandweaponname(loottypename);

  if(player function_a3150fe4725a5f35(weaponname)) {
    currentammo = loot::getoffhandcurrentammo(loottypename);
    maxammo = loot::function_747691235db172f6(loottypename);
    return (currentammo < maxammo);
  }

  return player function_9a80102d4c5a6a08();
}

function private offhandbox_onuse(offhandbox) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  loottypename = offhandbox.item_type;
  weaponname = loot::getoffhandweaponname(loottypename);
  var_284785dc0688cc68 = player function_a3150fe4725a5f35(weaponname);

  if(var_284785dc0688cc68 || player function_9a80102d4c5a6a08()) {
    currentammo = loot::getoffhandcurrentammo(loottypename);
    maxammo = loot::function_747691235db172f6(loottypename);
    ammoneeded = maxammo - currentammo;

    if(ammoneeded > offhandbox.item_count) {
      ammoneeded = offhandbox.item_count;
    }

    if(var_284785dc0688cc68) {
      player updateammoamount(weaponname, ammoneeded);
    } else {
      player function_8891a3fdd8abf05f(weaponname, ammoneeded);
    }

    offhandbox.item_count -= ammoneeded;
    player notify("\xcdY4\x11\xcfAx\x81\xbah\x83\xa5.\xa2\"\x1bt\xfc\xa0", loottypename);
    level thread loot::createnotification(loottypename);
    return;
  }

  iprintlnbold("<dev string:x2ec>");
}

function private offhands_incrementequipmentammo(objweapon) {
  assert(isPlayer(self));
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  weaponname = objweapon.basename;

  if(player function_a3150fe4725a5f35(weaponname)) {
    currentammo = function_84ba3ea4bf8a6822(undefined, weaponname);
    maxammo = weaponmaxammo(weaponname);

    if(currentammo < maxammo) {
      player updateammoamount(weaponname, 1);
      return true;
    }
  } else if(player function_9a80102d4c5a6a08()) {
    player function_8891a3fdd8abf05f(weaponname, 1);
    return true;
  }

  return false;
}

function function_b532f73a75f6291a(equipmentref, rechargetime, rechargestartnotify, var_6ea3cc90ad084721, var_1fe36b4b8ea36dd3, var_897fdedbb4581ff1) {
  assert(isint(rechargetime));
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  itemfound = 0;

  foreach(itemdata in level.equipmentwheel.itemsdatabase) {
    if(equipmentref == itemdata.bundle) {
      itemdata.rechargetime = rechargetime;
      itemdata.rechargestartnotify = rechargestartnotify;
      itemdata.var_6ea3cc90ad084721 = var_6ea3cc90ad084721 ?? &function_700350573d26e2fd;
      itemdata.var_1fe36b4b8ea36dd3 = var_1fe36b4b8ea36dd3 ?? &function_6e2adda6c42bfd58;
      itemdata.var_897fdedbb4581ff1 = var_897fdedbb4581ff1 ?? [];
      itemfound = 1;
      break;
    }
  }

  assert(itemfound, "<dev string:x340>" + equipmentref + "<dev string:x36a>");

  if(level.player function_a3150fe4725a5f35(equipmentref)) {
    level.player utility::ent_flag_set("\x8e\x12T\xe1h\xd8\x0f\xf2\xdf\x05-\\\x01;1j;m\x069\xfb\x03\x1d5%\xd8");
  }
}

function function_fa6320994f6c197c(equipmentref) {
  player = self;
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  iteminfo = player.equipmentwheel.items[equipmentref];
  return isDefined(iteminfo) && istrue(iteminfo.recharging);
}

function function_a97f5817fc499edf(equipmentref) {
  slot = function_a7a5e4105170fa17(equipmentref);
  var_fda1befc9791818b = function_9bb1da04e0ffafcf(slot, #"index");
  var_1da520704981681 = function_60f21f1fe8be332a(var_fda1befc9791818b);
  return var_1da520704981681 === equipmentref;
}

function function_de01ccc8b27be353() {
  return self.equipmentwheel.focuseditem;
}

function function_72dad51fc90d191d(equipmentref) {
  return equipmentref + "\x8e\xb5\x85o)\x1f\x18\xbc|#";
}

function private function_700350573d26e2fd(itemref, iteminfo) {
  player = self;
  equippedweapon = player getequippedweapon(itemref);

  if(isDefined(equippedweapon)) {
    currentammo = player getammocount(equippedweapon);
  } else {
    currentammo = iteminfo.currentammo;
  }

  maxammo = weaponmaxammo(itemref);
  return currentammo < maxammo;
}

function private function_6e2adda6c42bfd58(itemref) {
  player = self;
  player updateammoamount(itemref, 1);
}

function function_2698d152b3fd84c1(equipmentref) {
  player = self;
  itemid = player.equipmentwheel.items[equipmentref].itemid;
  return level.equipmentwheel.itemsdatabase[itemid].rechargetime;
}

function private function_f6b4af90143b14bc() {
  player = level.player;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player utility::ent_flag_wait("\x8e\x12T\xe1h\xd8\x0f\xf2\xdf\x05-\\\x01;1j;m\x069\xfb\x03\x1d5%\xd8");

    for(index = 0; index < level.equipmentwheel.maxitems; index++) {
      id = player function_aab60ae3eaefcdfe(index, "1\xcd");
      curitemref = level.equipmentwheel.itemsdatabase[id].bundle;
      rechargetime = level.equipmentwheel.itemsdatabase[id].rechargetime;

      if(!isDefined(rechargetime)) {
        continue;
      }

      iteminfo = player.equipmentwheel.items[curitemref];
      var_6ea3cc90ad084721 = level.equipmentwheel.itemsdatabase[id].var_6ea3cc90ad084721;

      if(isDefined(var_6ea3cc90ad084721) && player[[var_6ea3cc90ad084721]](curitemref, iteminfo)) {
        if(!istrue(iteminfo.recharging)) {
          rechargestartnotify = level.equipmentwheel.itemsdatabase[id].rechargestartnotify;
          var_1fe36b4b8ea36dd3 = level.equipmentwheel.itemsdatabase[id].var_1fe36b4b8ea36dd3;
          var_897fdedbb4581ff1 = level.equipmentwheel.itemsdatabase[id].var_897fdedbb4581ff1;
          player thread function_21cf7de91f6ba8a(curitemref, index, rechargetime, rechargestartnotify, var_1fe36b4b8ea36dd3, var_897fdedbb4581ff1);
        }

        continue;
      }

      if(istrue(iteminfo.recharging)) {
        player function_112c2e154a2803cb(curitemref);
      }
    }

    waitframe();
  }
}

function private function_112c2e154a2803cb(equipmentref) {
  player = self;
  assert(isPlayer(player));
  var_752d7d0b486daf13 = equipmentref + " D\xba\xdf\x8bG6\xc4\x16\xbfw!\xacR\x0f\x8e\b\x8f\xbc\xe9\xe0\xb0";
  player notify(var_752d7d0b486daf13);
}

function private function_21cf7de91f6ba8a(equipmentref, itemindex, rechargetime, rechargestartnotify, var_1fe36b4b8ea36dd3, var_897fdedbb4581ff1) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("\xb2\x17\xea-8\xd6\x95\xe6t\xafr\x95\xb6o\xd9\xca\xc8_" + equipmentref);
  iteminfo = player.equipmentwheel.items[equipmentref];
  assert(!istrue(iteminfo.recharging));
  iteminfo.recharging = 1;
  var_752d7d0b486daf13 = equipmentref + " D\xba\xdf\x8bG6\xc4\x16\xbfw!\xacR\x0f\x8e\b\x8f\xbc\xe9\xe0\xb0";

  if(isDefined(rechargestartnotify)) {
    if(isarray(rechargestartnotify)) {
      notifyarray = utility_sp::array_merge(rechargestartnotify, [var_752d7d0b486daf13]);
      msg = player utility::waittill_any_in_array_return(notifyarray);
    } else {
      msg = player utility::waittill_any_return(rechargestartnotify, var_752d7d0b486daf13);
    }

    if(msg == var_752d7d0b486daf13) {
      player updateammoamount(equipmentref, 1);

      if(!istrue(iteminfo.cancelrecharge)) {
        rechargedonenotify = player function_72dad51fc90d191d(equipmentref);
        player notify(rechargedonenotify);
      }

      iteminfo.recharging = 0;
      return;
    }
  }

  rechargetimeomnvar = "\xa6\x8e3\b\xffS:\xbb\xee\xa6\xbb\x8d\xce\x03@u\xbd\xf79)\xc9\xe5\x1d\x04\xeep\xd7bc\x1e" + itemindex + 1;
  rechargeprogressomnvar = "3\x19\xd0\xd9M?\x11\xc5MV\x10\xb0\xf8\xceH9:x!\xb4=\x12\x91p\xd5\xd0[W\xc5\xa9r.\xc7\xf4" + itemindex + 1;
  setomnvar(rechargetimeomnvar, rechargetime);
  setomnvar(rechargeprogressomnvar, 0);
  iteminfo.rechargetime = rechargetime;
  slot = function_c340da8a0dfa119c(equipmentref);

  if(player input_icon_display::function_3c1502b13c02a127(slot)) {
    var_fda1befc9791818b = player function_9bb1da04e0ffafcf(getxhash(slot), #"index");
    var_1da520704981681 = function_60f21f1fe8be332a(var_fda1befc9791818b);

    if(var_1da520704981681 === equipmentref) {
      player input_icon_display::function_cc69dd0a921096d5(slot, rechargetime);
    }
  }

  player function_615b8a03f3a58876(rechargetime, var_752d7d0b486daf13, rechargeprogressomnvar, iteminfo);
  player[[var_1fe36b4b8ea36dd3]](equipmentref);

  if(!istrue(iteminfo.cancelrecharge)) {
    rechargedonenotify = player function_72dad51fc90d191d(equipmentref);
    player notify(rechargedonenotify);
    player snd::play("\xeb\xf2ET\xbf\xe4\x82\x1a\xb5\xacr\x9b\xb3k\xe5F\x89`)\xa9\xb6A\xa0=\xd7\bU\xfa}\xbf\xc9y\b");

    if(var_897fdedbb4581ff1.size > 0) {
      var_ef3f653425f54993 = 0.3;
      readyvo = utility::random(var_897fdedbb4581ff1);

      if(soundexists(readyvo)) {
        player thread dialogue::say_delayed(var_ef3f653425f54993, readyvo);
      }
    }
  }

  setomnvar(rechargetimeomnvar, 0);
  setomnvar(rechargeprogressomnvar, 0);

  if(player input_icon_display::function_3c1502b13c02a127(slot)) {
    var_fda1befc9791818b = player function_9bb1da04e0ffafcf(getxhash(slot), #"index");
    var_1da520704981681 = function_60f21f1fe8be332a(var_fda1befc9791818b);

    if(var_1da520704981681 === equipmentref) {
      player input_icon_display::function_cc69dd0a921096d5(slot, 0, 1);
    }
  }

  iteminfo.recharging = 0;
}

function private function_615b8a03f3a58876(rechargetime, var_752d7d0b486daf13, rechargeprogressomnvar, iteminfo) {
  player = self;
  player endon(var_752d7d0b486daf13);
  totaltimems = rechargetime * 1000;
  iteminfo.rechargerecord = 0;

  if(getdvarint(@ "hash_ceba513d7969abd3", 0)) {
    if(!isDefined(level.var_b230d05533957df1)) {
      level.var_b230d05533957df1 = [];
    }

    if(!isDefined(level.var_b230d05533957df1[rechargeprogressomnvar])) {
      yoffset = level.var_b230d05533957df1.size * 12;
      level.var_b230d05533957df1[rechargeprogressomnvar] = player hud_util::createclientfontstring("<dev string:x396>", 1);
      level.var_b230d05533957df1[rechargeprogressomnvar] hud_util::setpoint("<dev string:x3a1>", undefined, 300, 60 + yoffset);
      level.var_b230d05533957df1[rechargeprogressomnvar].color = (1, 1, 0);
      level.var_b230d05533957df1[rechargeprogressomnvar].label = rechargeprogressomnvar + "<dev string:x3ad>";
    }
  }

  while(true) {
    waitframe();
    iteminfo.rechargerecord += level.frameduration;
    progress = clamp(iteminfo.rechargerecord / totaltimems, 0, 1);
    setomnvar(rechargeprogressomnvar, progress);

    if(getdvarint(@ "hash_ceba513d7969abd3", 0)) {
      level.var_b230d05533957df1[rechargeprogressomnvar] setvalue(progress);
    }

    if(iteminfo.rechargerecord >= totaltimems) {
      break;
    }
  }
}

function function_f8049ba6355f36c1(slot, islocked) {
  level utility::flag_wait("\r\x1dv\xfe\ab\xc54\xf2@\"\"\x02\xb4\x1a\xcb\x1f\f\xba\x83\b!\xd2\xb0u\x19\xa6");
  player = self;

  if(slot != #"none") {
    player function_91cc94cde9340c33(slot, #"locked", islocked);
  }

  if(islocked) {
    if(isDefined(level.equipmentwheel.slots[slot].offhandslotname)) {
      weap = player getcurrentoffhand(level.equipmentwheel.slots[slot].offhandslotname);

      if(isDefined(weap)) {
        player utility_sp::take_offhand(weap);
        player function_91cc94cde9340c33(slot, #"index", 0);
      }
    }
  }
}

function private function_ef60517e0f8fcc25() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player waittill("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ");

    if(!player val::get("\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ")) {
      player notify("\x88\xe8/\xc7\xa0\x90\x7f\x10\x16<\x94\xfd\x1dY>\xd8a!\xb1\x16\xe8");
    }
  }
}

function private function_12387644287d5eb() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player waittill("\xc2\xc1u\xd6bI#Jp\x8e\xdcV\xc17O\xfb\xe6|\x16\xf5rd\x82", veh);
    player val::set("\xce\xfe\xfdk\t/\x80\xaew\x95\xb8x\x1b\xebE\xcc\xf3\xab\x1b\x95\xd4s\x90\x99\xa8\agd1\xfd\x8b", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
  }
}

function private function_93933f911c490661() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player waittill("?\xc6\xf5Y\xd1\xd0`W\xba\xbbpT*\x04U\x1d?\xc8\xf7\xfb\xf3\xc0", veh);
    player val::reset_all("\xce\xfe\xfdk\t/\x80\xaew\x95\xb8x\x1b\xebE\xcc\xf3\xab\x1b\x95\xd4s\x90\x99\xa8\agd1\xfd\x8b");
  }
}

function private function_305e24b45409f9f(equip_ref) {
  player = self;
  slot = #"lethal";
  locked = player function_9bb1da04e0ffafcf(slot, #"locked");

  if(locked) {
    return;
  }

  weapon = player getcurrentoffhand(level.equipmentwheel.slots[slot].offhandslotname);

  if(weapon.basename != "\r+x5") {
    player utility_sp::take_offhand(weapon);
    player setoffhandprimaryclass("\r+x5");
  }

  offhands::overrideweaponoffhandtype(equip_ref, 1);
  ammo = player.equipmentwheel.items[equip_ref].currentammo;
  player utility_sp::give_offhand(equip_ref, ammo);
  index = function_5a1287059972c86(equip_ref);
  player function_91cc94cde9340c33(slot, #"index", index);
  player notify("\xba\x88z\x8ai\x1a\x99\xb7\xf6@\x15\x11\x97F\xb0\xbd;pF\x86o\x9d;\xcaW;\x17C\x91", equip_ref, slot);
}

function private function_cb2264a5731eb540(equip_ref) {
  player = self;
  slot = #"tactical";
  locked = player function_9bb1da04e0ffafcf(slot, #"locked");

  if(locked) {
    return;
  }

  weapon = player getcurrentoffhand(level.equipmentwheel.slots[slot].offhandslotname);

  if(weapon.basename != "\r+x5") {
    player utility_sp::take_offhand(weapon);
    player setoffhandsecondaryclass("\r+x5");
  }

  var_53e7cc0d96a8e681 = player getcurrentoffhand("\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e");
  var_66e2ae16c026af85 = undefined;

  if(var_53e7cc0d96a8e681.basename != "\r+x5") {
    var_5106a7b6c553f375 = offhands::getweaponoffhandclass(var_53e7cc0d96a8e681);
    var_e1aa4047336b4ff1 = offhands::getweaponoffhandclass(equip_ref);

    if(var_e1aa4047336b4ff1 == var_5106a7b6c553f375) {
      player utility_sp::take_offhand(var_53e7cc0d96a8e681);
      player setoffhandprimaryclass("\r+x5");
      var_66e2ae16c026af85 = var_53e7cc0d96a8e681.basename;
    }
  }

  offhands::overrideweaponoffhandtype(equip_ref, 0);
  ammo = player.equipmentwheel.items[equip_ref].currentammo;
  player utility_sp::give_offhand(equip_ref, ammo);

  if(isDefined(var_66e2ae16c026af85)) {
    player utility_sp::give_offhand(var_66e2ae16c026af85, player.equipmentwheel.items[var_66e2ae16c026af85].currentammo);
  }

  index = function_5a1287059972c86(equip_ref);
  player function_91cc94cde9340c33(slot, #"index", index);
  player notify("\xba\x88z\x8ai\x1a\x99\xb7\xf6@\x15\x11\x97F\xb0\xbd;pF\x86o\x9d;\xcaW;\x17C\x91", equip_ref, slot);
}

function private function_eed6928bb2465cf9(equip_ref) {
  player = self;
  slot = #"missionability";
  slot_str = "\xddI\x85 \x1d_\xea\x96l\x89\xda\xb6p\x98";
  locked = player function_9bb1da04e0ffafcf(slot, #"locked");

  if(locked) {
    return;
  }

  var_19c215d8ee5b7ea0 = player function_9bb1da04e0ffafcf(slot, #"index");
  prev_equip = function_60f21f1fe8be332a(var_19c215d8ee5b7ea0);
  player utility_sp::take_weapon(prev_equip);
  player input_icon_display::function_85f8b957b53e6cba(slot_str);
  player input_icon_display::function_7c9ff06651218181(slot_str, level.equipmentwheel.slots[slot].bindstring, function_705543cbc50caebd(equip_ref), 4, undefined, 1, "\xe1P+\x1a \xe4\xd7-\xeel]");
  iteminfo = player.equipmentwheel.items[equip_ref];

  if(isDefined(iteminfo) && istrue(iteminfo.recharging) && isDefined(iteminfo.rechargetime) && iteminfo.rechargetime > 0) {
    slot_str = function_c340da8a0dfa119c(equip_ref);
    time_delta = iteminfo.rechargerecord / 1000;
    player input_icon_display::function_cc69dd0a921096d5(slot_str, iteminfo.rechargetime - time_delta, time_delta / iteminfo.rechargetime);
  }

  ammo = getequipmentammo(equip_ref);
  player utility_sp::give_weapon(equip_ref);
  player setweaponammoclip(equip_ref, ammo);
  player thread watch_for_slot_use(slot, slot_str, equip_ref);
  index = function_5a1287059972c86(equip_ref);
  player function_91cc94cde9340c33(slot, #"index", index);
  player notify("\xba\x88z\x8ai\x1a\x99\xb7\xf6@\x15\x11\x97F\xb0\xbd;pF\x86o\x9d;\xcaW;\x17C\x91", equip_ref, slot);
}

function private function_a3ee2983bb9fda81(equip_ref) {
  player = self;
  slot = #"scorestreak";
  slot_str = ",\x01[\x14\x91\xc4V\xf8@\xf8\x84";
  locked = player function_9bb1da04e0ffafcf(slot, #"locked");

  if(locked) {
    return;
  }

  var_19c215d8ee5b7ea0 = player function_9bb1da04e0ffafcf(slot, #"index");
  prev_equip = function_60f21f1fe8be332a(var_19c215d8ee5b7ea0);
  player utility_sp::take_weapon(prev_equip);
  player input_icon_display::function_85f8b957b53e6cba(slot_str);
  player input_icon_display::function_7c9ff06651218181(slot_str, level.equipmentwheel.slots[slot].bindstring, function_705543cbc50caebd(equip_ref), 4, undefined, undefined, "\xe1P+\x1a \xe4\xd7-\xeel]");
  iteminfo = player.equipmentwheel.items[equip_ref];

  if(isDefined(iteminfo) && istrue(iteminfo.recharging) && isDefined(iteminfo.rechargetime) && iteminfo.rechargetime > 0) {
    slot_str = function_c340da8a0dfa119c(equip_ref);
    time_delta = iteminfo.rechargerecord / 1000;
    player input_icon_display::function_cc69dd0a921096d5(slot_str, iteminfo.rechargetime - time_delta, time_delta / iteminfo.rechargetime);
  }

  player utility_sp::give_weapon(equip_ref);
  player thread watch_for_slot_use(slot, slot_str, equip_ref);
  index = function_5a1287059972c86(equip_ref);
  player function_91cc94cde9340c33(slot, #"index", index);
  player notify("\xba\x88z\x8ai\x1a\x99\xb7\xf6@\x15\x11\x97F\xb0\xbd;pF\x86o\x9d;\xcaW;\x17C\x91", equip_ref, slot);
}

function private function_45406a2212fde212(equipmentref, var_7fcb64d07c1cf12) {
  player = self;
  slot = #"lethal";
  weap = player getcurrentoffhand(level.equipmentwheel.slots[slot].offhandslotname);

  if(weap.basename == equipmentref) {
    player val::set("\xc7ma\xdde*\xb6\xf2ZR\xd9\xef\x9b\xd0\xd3\xa46\xd8n\xf7", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", 0);
    player utility_sp::take_offhand(weap);
    player function_91cc94cde9340c33(slot, #"index", 0);
    iteminfo = player.equipmentwheel.items[equipmentref];

    if(istrue(iteminfo.recharging)) {
      iteminfo.cancelrecharge = 1;
      player function_112c2e154a2803cb(equipmentref);
      wait 0.1;
      iteminfo.cancelrecharge = undefined;
    }

    player val::reset_all("\xc7ma\xdde*\xb6\xf2ZR\xd9\xef\x9b\xd0\xd3\xa46\xd8n\xf7");
  }
}

function private function_d870d304e2d90a7d(equipmentref, var_7fcb64d07c1cf12) {
  player = self;
  slot = #"tactical";
  weap = player getcurrentoffhand(level.equipmentwheel.slots[slot].offhandslotname);

  if(weap.basename == equipmentref) {
    player val::set("\xc7ma\xdde*\xb6\xf2ZR\xd9\xef\x9b\xd0\xd3\xa46\xd8n\xf7", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", 0);
    player utility_sp::take_offhand(weap);
    player function_91cc94cde9340c33(slot, #"index", 0);
    iteminfo = player.equipmentwheel.items[equipmentref];

    if(istrue(iteminfo.recharging)) {
      iteminfo.cancelrecharge = 1;
      player function_112c2e154a2803cb(equipmentref);
      wait 0.1;
      iteminfo.cancelrecharge = undefined;
    }

    player val::reset_all("\xc7ma\xdde*\xb6\xf2ZR\xd9\xef\x9b\xd0\xd3\xa46\xd8n\xf7");
  }
}

function private function_67e6b51964842ae4(equipmentref, var_7fcb64d07c1cf12) {
  player = self;
  slot = #"missionability";
  slot_str = "\xddI\x85 \x1d_\xea\x96l\x89\xda\xb6p\x98";
  player input_icon_display::function_85f8b957b53e6cba(slot_str);
  equippedweapon = player getequippedweapon(equipmentref);

  if(isDefined(equippedweapon)) {
    player utility_sp::take_offhand(equippedweapon);
  }

  player function_91cc94cde9340c33(slot, #"index", 0);
  iteminfo = player.equipmentwheel.items[equipmentref];

  if(istrue(iteminfo.recharging)) {
    iteminfo.cancelrecharge = 1;
    player function_112c2e154a2803cb(equipmentref);
    wait 0.1;
    iteminfo.cancelrecharge = undefined;
  }

  player notify("\xd0@H\x8d\x15\xd5\x1d*i\x80\xa79\x80PU2\xd1J\xb0\xf2/\x9d " + slot_str);
  player notifyonplayercommandremove("\x95.\xaei\x1c\xbe\xdc6\xdb\x8e\xf5WnY\xaf" + slot_str, level.equipmentwheel.slots[slot].bind);
}

function private function_b117d183a4cd6fba(equipmentref, var_7fcb64d07c1cf12) {
  player = self;
  slot = #"scorestreak";
  slot_str = ",\x01[\x14\x91\xc4V\xf8@\xf8\x84";
  player input_icon_display::function_85f8b957b53e6cba(slot_str);
  equippedweapon = player getequippedweapon(equipmentref);

  if(isDefined(equippedweapon)) {
    player utility_sp::take_offhand(equippedweapon);
  }

  player function_91cc94cde9340c33(slot, #"index", 0);
  iteminfo = player.equipmentwheel.items[equipmentref];

  if(istrue(iteminfo.recharging)) {
    iteminfo.cancelrecharge = 1;
    player function_112c2e154a2803cb(equipmentref);
    wait 0.1;
    iteminfo.cancelrecharge = undefined;
  }

  player notify("\xd0@H\x8d\x15\xd5\x1d*i\x80\xa79\x80PU2\xd1J\xb0\xf2/\x9d " + slot_str);
  player notifyonplayercommandremove("\x95.\xaei\x1c\xbe\xdc6\xdb\x8e\xf5WnY\xaf" + slot_str, level.equipmentwheel.slots[slot].bind);
}

function private watch_for_slot_use(slot, slot_str, equip_ref) {
  if(!isDefined(level.equipmentwheel.slots[slot].bind)) {
    return;
  }

  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player notify(">?\x01\xa74\x98\rK\xdc\xed\xf5\xde\v\xbbGE\x92_\xb9" + slot_str);
  player endon(">?\x01\xa74\x98\rK\xdc\xed\xf5\xde\v\xbbGE\x92_\xb9" + slot_str);
  player endon("\xd0@H\x8d\x15\xd5\x1d*i\x80\xa79\x80PU2\xd1J\xb0\xf2/\x9d " + slot_str);
  command = "\x95.\xaei\x1c\xbe\xdc6\xdb\x8e\xf5WnY\xaf" + slot_str;
  player notifyonplayercommand(command, level.equipmentwheel.slots[slot].bind);

  while(true) {
    player waittill(command);
    player notify("\x06\xe9\xbc\xdb#e\x1bnp\x93\x03\xe3\x1c\xd0\xe2" + equip_ref);

    if(isDefined(level.equipmentwheel.var_2d1dad8f0c9fd535[slot][equip_ref])) {
      if(![[level.equipmentwheel.var_2d1dad8f0c9fd535[slot][equip_ref]]]()) {
        continue;
      }
    }

    if(player getequipmentammo(equip_ref) > 0 && isDefined(level.equipmentwheel.var_a3ac3dcf143c2509[slot][equip_ref])) {
      player thread[[level.equipmentwheel.var_a3ac3dcf143c2509[slot][equip_ref]]]();
    }
  }
}
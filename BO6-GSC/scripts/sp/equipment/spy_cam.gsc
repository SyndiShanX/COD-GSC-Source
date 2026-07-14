/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\spy_cam.gsc
********************************************/

#using script_3798db193e76a866;
#using script_53f4e6352b0b2425;
#using scripts\common\scene;
#using scripts\common\swim_common;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\player\input_icon_display;
#using scripts\sp\stealth\player;
#using scripts\sp\swim_sp;
#using scripts\sp\utility;
#using scripts\stealth\manager;
#namespace spy_cam;

function private autoexec __init__system__() {
  system::register(#"spy_camera", [#"val"], &pre_main, &post_main);
}

function private pre_main() {
  level._effect[")P1\x93{k\x94W8\xb6\x18\xc3\x12\xe3"] = loadfxasset("\xdcuA\xa0\x9f\x84\x8a\xb2&\xce\xa1\x1f\xf0\xf0y]\xd6\xfe8-\xf9\xe0\x90p\xaa\x1f+]\xed\x83\x13\xe5\xd2");
  precachestring(&"hash_5c33f95407ca3642");

  setdevdvarifuninitialized(@ "hash_f84af8dd52dac20a", 0);
  setdevdvarifuninitialized(@ "hash_72c24a56f65982e5", 7200);
  setdevdvarifuninitialized(@ "hash_cc4f5e5d97fe5cdf", 5);
  setdevdvarifuninitialized(@ "hash_fa79133e4ab41839", 5);
  setdevdvarifuninitialized(@ "hash_7e84d2e32c467d53", 2);
  setdevdvarifuninitialized(@ "hash_894ce22e03607750", 0);
  setdevdvarifuninitialized(@ "hash_db5e344868b375df", 0);

  val::register("\xf0\xe6\xc4=\xba\x91\xbfaF\xef\xde\xc9\xfe{\xbbkm\xbd", 1, 0, "\x127\xca\x8d3", &function_c304c3633ab1eb03, "~\xa9\xccdcE");
  scene::function_f0326a3dac1e025a("T^\x83\xca7\xeb\n6a\xcber", "\xf0\xe6\xc4=\xba\x91\xbfaF\xef\xde\xc9\xfe{\xbbkm\xbd", 0);
  scene::function_f0326a3dac1e025a("T^\x83\xca7\xeb\n6a\xcber", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", 0);
}

function private post_main() {
  var_fc0d5fe6a0381869 = -15;
  utility_sp::hudoutline_add_channel("\x1e\xf2O2\x17qN\x02\xb6B", var_fc0d5fe6a0381869);
  swim_sp::function_d52016582dfb963e(&function_a5271af088087b24);
  swim_sp::function_fda60b40ae0b69a7(&function_650496e44c1c01e5);
}

function private function_a5271af088087b24() {
  player = self;
  player val::reset_all("\x82S\x90\ab\xff\x93?\xef\xed\x15Jb\xf9\x1b\xbe\xcbi ");
  player notify("4m\x97.\x10Wu\xe3%Z(.\xb2\xbb>\xe4^\x8eK\xf3");
}

function private function_650496e44c1c01e5() {
  player = self;
  player val::set("\x82S\x90\ab\xff\x93?\xef\xed\x15Jb\xf9\x1b\xbe\xcbi ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", 0);
  player thread function_7042c3a8d518bb09();
}

function private function_7042c3a8d518bb09() {
  player = self;
  player endon("4m\x97.\x10Wu\xe3%Z(.\xb2\xbb>\xe4^\x8eK\xf3");
  waittillframeend();

  if(!istrue(player.swim.swimming) && player function_e4c7e67e375efb0()) {
    if(player utility::ent_flag("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84")) {
      player waittill("\x84\x05\xf7\xbe \xfdT\x9b\xeb\x8f~b\xe5\x13");
    }

    player notify("\x1e\xf2O2\x17qN\x02\xb6B");
  }
}

function private function_38e51c40a4ed78f2() {
  helper_prompts = [];
  helper_prompts["P\\W\xb6\xddk~\xeb\xc3\xf6\xae\xc0~\xf2X\x01\x14\x94"] = &"hash_7e3f2f6ec3c215f2";
  helper_prompts["\xcd\xef\x1d\xa15\x7f\xe2 \x02\xb54]]\xc9o\xdb\x1b"] = &"hash_2fdc2acb579867f2";

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\x1e\xf2O2\x17qN\x02\xb6B", helper_prompts);
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", -93, -55, 2, 2);
  }
}

function private function_f604d3193be7cac1() {
  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\x1e\xf2O2\x17qN\x02\xb6B");
  }
}

function spy_camera_give(camera_weapon, command, scripted_widget_overlay, allow_photos, var_be82f2379d8b5851, var_70872322ed9d6748, var_6c46c85b36389d87) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("l?\xf0r-p\xcfN\\Z\xc6\xa5\xc8\x1ce ");
  self endon("l?\xf0r-p\xcfN\\Z\xc6\xa5\xc8\x1ce ");
  self endon("a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");

  if(!isDefined(self.spy_camera)) {
    self.spy_camera = spawnStruct();
  }

  if(isDefined(self.spy_camera.weapon)) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  self.spy_camera.weapon = camera_weapon;
  self.spy_camera.command = command;
  self.spy_camera.scripted_widget_overlay = hud_management::function_a1a13273e72bfe46(scripted_widget_overlay);
  self.spy_camera.allow_photos = istrue(allow_photos);
  self.spy_camera.var_be82f2379d8b5851 = var_be82f2379d8b5851 ?? [];
  self.spy_camera.var_70872322ed9d6748 = istrue(var_70872322ed9d6748);
  function_c304c3633ab1eb03(1);
  self.spy_camera.var_f64fc6ca7d982bd4 = [];
  self.spy_camera.var_f64fc6ca7d982bd4["=\xacw\xee"] = 1;
  self.spy_camera.var_f64fc6ca7d982bd4["d\xc1\x87G\x12\xc2\xadt\xb8\xcfE\xcfnH\x15:\xe2\x9b\x88\xa9\x90"] = 0;
  self.spy_camera.var_f64fc6ca7d982bd4["\x97\xcd~\x10R~\xc7/P_\x8e0 R\xc4TU"] = 0;
  self.spy_camera.var_226b2cccd01cb5e4 = 0;
  self.spy_camera.var_e56577c0cb19ef75 = 0;

  if(!isDefined(self.spy_camera.var_7de17bd030d9e4d)) {
    self.spy_camera.var_7de17bd030d9e4d = "\xeb[y\x1e\xb1\xf5\xf8\x1a\x9a\xda \xb8{";
  }

  if(!isDefined(self.spy_camera.var_810dd21377f7f708)) {
    self.spy_camera.var_810dd21377f7f708 = "\xeb[y\x1e\xb1\xf5\xf8\x1a\x9a\xda \xb8{";
  }

  utility_sp::give_weapon(self.spy_camera.weapon);
  self notifyonplayercommand("\x1e\xf2O2\x17qN\x02\xb6B", command);
  thread function_957c21f3a0af7cf0();
  thread function_2a9f008204028ac2(self.spy_camera.weapon);
  childthread function_d2ba7c8df5a33d16();
  childthread function_80fc4c0fadc24c76();

  if(command == "\x13KI\xd7\x9b\xd1\xabpnj]+\xe1") {
    val::set("\x1e\xf2O2\x17qN\x02\xb6B" + "%m\b", "\xee\xacX\x83\xdbs\xbea\xb1G\xebk{#\xb2", 0);

    if(var_6c46c85b36389d87 ?? 1) {
      childthread function_533f3cc899dacdea();
    }
  }

  while(true) {
    thread spy_camera_external_activation_watch();
    ret = utility::waittill_any_return("]\r\x15\xc6*\xd5ho]mQ\xbf\x95[AgL\xc0\xbb\xe5&\xa8ian", "\x1e\xf2O2\x17qN\x02\xb6B");

    if(!val::get("y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a")) {
      assert(ret != "<dev string:x24>");
      continue;
    }

    if(!val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e")) {
      assert(ret != "<dev string:x24>");
      continue;
    }

    if(killstreaks::getkillstreakinuse()) {
      assert(ret != "<dev string:x24>");
      continue;
    }

    if(self isthrowingbackgrenade()) {
      assert(ret != "<dev string:x24>");
      continue;
    }

    last_weapon = self getcurrentweapon();

    if(ret == "\x1e\xf2O2\x17qN\x02\xb6B") {
      if(!utility_sp::player_has_weapon(self.spy_camera.weapon)) {
        utility_sp::give_weapon(self.spy_camera.weapon);
      }

      if(!self switchtoweapon(self.spy_camera.weapon)) {
        continue;
      }
    }

    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "y\x9e\xfa\xb1\x95.\x839", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "KJs\xdb\x1aFe\x17\xbf\xe1\x84\xa8y\xbe\x8d\x93\x99\x97\xab", 1);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xb4RO\xa4\x81\xeed|\xc1c\x95\xe1t'\x7f", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    self notify("l\xdf\x84dhi\x98\x06\xd1\xb6$\x0e|&\xda\xcc\xf5f\xb3L\xc1\xa2*\a!\xf7j/\xae\x1f5\x1b\x98\xed{\xf0gKp\xaf");

    while(!function_e4c7e67e375efb0() && !swim_common::isplayerunderwater()) {
      waitframe();
    }

    val::reset_all("\x1e\xf2O2\x17qN\x02\xb6B");

    if(swim_common::isplayerunderwater()) {
      continue;
    }

    thread function_dabc0180041297ce();

    while(true) {
      ret = utility::waittill_any_return("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", "\x1e\xf2O2\x17qN\x02\xb6B");

      if(ret == "\x1e\xf2O2\x17qN\x02\xb6B" && isDefined(last_weapon) && val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e") && !istrue(self.spy_camera.isdriving) && !self isthrowingbackgrenade()) {
        if(function_2d653d5fceb5ab2(last_weapon)) {
          weaponlist = utility_sp::get_weapons_list_primaries();

          foreach(weaponcandidate in weaponlist) {
            if(isDefined(weaponcandidate) && !function_2d653d5fceb5ab2(weaponcandidate) && self hasweapon(weaponcandidate)) {
              last_weapon = weaponcandidate;
              break;
            }
          }
        }

        self switchtoweapon(last_weapon);
        self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
        break;
      }

      if(ret == "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY") {
        weaponcurrent = self getcurrentweapon();

        if(self isweaponsenabled()) {
          if(getweaponbasename(weaponcurrent) != self.spy_camera.weapon) {
            break;
          }
        }
      }
    }

    self notify(" C\x90\xb1v3\xbf\xfb\xd2\xff\x16\x03\x94\x99\x91\xe8[\x13Z\x0f\xc0\x1f\x1f\xdf");
    player_sp::function_1ce9fde87cbd0430(0);
    val::reset_all("\x1e\xf2O2\x17qN\x02\xb6B");
  }
}

function private function_2d653d5fceb5ab2(weaponobj) {
  return isnullweapon(weaponobj) || isDefined(self.climbfists) && weaponobj == self.climbfists || getweaponbasename(weaponobj) == self.spy_camera.weapon;
}

function function_25f3c3dc847f86e6() {
  return getdvarfloat(@ "cg_targetbasefov");
}

function private function_2a9f008204028ac2(camera_weapon) {
  self notify("\xe3d\x9d]\"z0t\xbb\xcc\xfbM\x1b\xfd\\\xbb");
  self endon("\xe3d\x9d]\"z0t\xbb\xcc\xfbM\x1b\xfd\\\xbb");
  level utility::flag_wait("\x89\xc34\x9b\x05Q\x04\x12\xac\xb3\xd4\x1a\x83\xc1T\f\xa7\xd7wM\x03\xcb-\xfb\xe0");
  level namespace_5a0f99556b0f68f7::function_2da0f17e6869b878(camera_weapon);
}

function private function_763e03a0c6b060df() {
  player = self;
  assert(isPlayer(player));
  assert(isDefined(player.spy_camera));
  player.spy_camera.analytics = spawnStruct();
  player.spy_camera.analytics.starttime = gettime();
  player.spy_camera.analytics.var_45a02bae6dbc4231 = isDefined(level.stealth) && !player stealth_manager::anyone_in_combat();
  player.spy_camera.analytics.numenemiestagged = 0;
  player.spy_camera.analytics.wasphototaken = 0;
  player.spy_camera.analytics.var_5dcbb67b744c0710 = istrue(player.spy_camera.var_e56577c0cb19ef75);
}

function private function_b11427e7e204ea16() {
  player = self;
  assert(isPlayer(player));

  if(isDefined(player.spy_camera.analytics)) {
    cachedanalytics = player.spy_camera.analytics;
    durationseconds = (gettime() - cachedanalytics.starttime) * 0.001;
    analytics::function_486ab2ff479a88e1(player, cachedanalytics.var_45a02bae6dbc4231, cachedanalytics.numenemiestagged, cachedanalytics.wasphototaken, durationseconds, cachedanalytics.var_5dcbb67b744c0710);
    player.spy_camera.analytics = undefined;
  }
}

function private function_13411dfa05fb2751() {
  player = self;
  assert(isPlayer(player));

  if(isDefined(player.spy_camera.analytics)) {
    player.spy_camera.analytics.numenemiestagged += 1;
  }
}

function private function_d9c95d62bc22d2dc() {
  player = self;
  assert(isPlayer(player));

  if(isDefined(player.spy_camera.analytics)) {
    player.spy_camera.analytics.wasphototaken = 1;
  }
}

function function_4db3fa858e5ebca3() {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;
  var_292bc6282994d9f8 = player.spy_camera.var_f64fc6ca7d982bd4["=\xacw\xee"];
  return clamp(1 - var_292bc6282994d9f8, 0, 1);
}

function private spy_camera_external_activation_watch() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");
  player notify("$sV\x85\xa7\xb8]4\b\x99d\xbcf:\x90\xf6\x95\xddq\x14\x83-\xb4\xb0\xb0-x&\n\xc9k\x0f1\xe5\xf5&\x15");
  player endon("$sV\x85\xa7\xb8]4\b\x99d\xbcf:\x90\xf6\x95\xddq\x14\x83-\xb4\xb0\xb0-x&\n\xc9k\x0f1\xe5\xf5&\x15");
  player endon("l\xdf\x84dhi\x98\x06\xd1\xb6$\x0e|&\xda\xcc\xf5f\xb3L\xc1\xa2*\a!\xf7j/\xae\x1f5\x1b\x98\xed{\xf0gKp\xaf");
  player childthread function_5e3f72e0524c9cdf();

  while(true) {
    player waittill("KJ\xdf\x82,\x83\x8e\xab\xbb\xcc\r\xd9\x9c\xf3\xb6Bc\x97^\x19\x1c", weapon);

    if(getweaponbasename(weapon) == player.spy_camera.weapon) {
      player notify("]\r\x15\xc6*\xd5ho]mQ\xbf\x95[AgL\xc0\xbb\xe5&\xa8ian");
    }
  }
}

function private function_5e3f72e0524c9cdf() {
  player = self;

  while(true) {
    player waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", weapon);

    if(getweaponbasename(weapon) == player.spy_camera.weapon) {
      player notify("]\r\x15\xc6*\xd5ho]mQ\xbf\x95[AgL\xc0\xbb\xe5&\xa8ian");
    }
  }
}

function private function_d2ba7c8df5a33d16() {
  player = self;

  while(true) {
    player waittill("\xc2\xc1u\xd6bI#Jp\x8e\xdcV\xc17O\xfb\xe6|\x16\xf5rd\x82", veh);
    player val::set("s\xe0\xcb\xeb\x1b\x85m\xeb\x8c\xe4K\xd9-\xe6\x9d\xfa\xec\x954\xa5l\x1bY", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", 0);
    player.spy_camera.isdriving = 1;
    player thread function_bfcc75b24546db4e(veh);
  }
}

function private function_bfcc75b24546db4e(vehicle) {
  self notify("\x81\x17\xda\xd5\xcb\xa0G\xa6\x93\xd8\x01\xca\x8aHB\xdc");
  self endon("\x81\x17\xda\xd5\xcb\xa0G\xa6\x93\xd8\x01\xca\x8aHB\xdc");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("?\xc6\xf5Y\xd1\xd0`W\xba\xbbpT*\x04U\x1d?\xc8\xf7\xfb\xf3\xc0");
  vehicle waittill("\x1e\xfd\xd1\xa2\a");
  player val::reset_all("s\xe0\xcb\xeb\x1b\x85m\xeb\x8c\xe4K\xd9-\xe6\x9d\xfa\xec\x954\xa5l\x1bY");
  player.spy_camera.isdriving = 0;
}

function private function_80fc4c0fadc24c76() {
  player = self;

  while(true) {
    player waittill("?\xc6\xf5Y\xd1\xd0`W\xba\xbbpT*\x04U\x1d?\xc8\xf7\xfb\xf3\xc0", veh);
    player val::reset_all("s\xe0\xcb\xeb\x1b\x85m\xeb\x8c\xe4K\xd9-\xe6\x9d\xfa\xec\x954\xa5l\x1bY");
    player.spy_camera.isdriving = 0;
  }
}

function function_996a38a577b758ac(hudoutlinetagged, var_8deaad4a87e83c7b) {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;

  if(isDefined(hudoutlinetagged)) {
    player.spy_camera.var_7de17bd030d9e4d = hudoutlinetagged;
  }

  if(isDefined(var_8deaad4a87e83c7b)) {
    player.spy_camera.var_810dd21377f7f708 = var_8deaad4a87e83c7b;
  }
}

function function_b76c3034736353f1(var_cf742d4d6f95eece, tagdurationoverride, var_1ba20ff1c415c8f8) {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;
  player.spy_camera.var_8e862f6bbe0875fd = 1;
  player.spy_camera.var_a3074a8608ddef03 = 1;
  player.spy_camera.var_a40eca6fa3afe900 = var_1ba20ff1c415c8f8 ?? 0;
  var_2511c54f9d4cc5e5 = var_cf742d4d6f95eece ?? 0.6;
  player.spy_camera.var_90ce34e278afe6b5 = int(var_2511c54f9d4cc5e5 * 1000);
  tagdurationseconds = tagdurationoverride ?? 0;
  player.spy_camera.var_cd6449c0365aac48 = tagdurationseconds * 1000;
}

function function_85016960efbadfae() {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;
  player.spy_camera.var_8e862f6bbe0875fd = 0;
  player.spy_camera.var_a40eca6fa3afe900 = 0;
}

function function_c304c3633ab1eb03(enabled) {
  assert(isPlayer(self));
  player = self;

  if(!istrue(enabled)) {
    if(isDefined(player.spy_camera)) {
      player function_85016960efbadfae();
      player utility::ent_flag_clear("\\G\x7fg\x9d\xbf\xd3b\xa0K\x8c\x13\x93\xbd\x9d\xdd\x05\xab\xfc\x9dnE\xf4\x02\x8a%W\x93A\xdf\x1f\x9a\xb2");
    }

    return;
  }

  if(isDefined(player.spy_camera)) {
    player function_b76c3034736353f1();
    player utility::ent_flag_set("\\G\x7fg\x9d\xbf\xd3b\xa0K\x8c\x13\x93\xbd\x9d\xdd\x05\xab\xfc\x9dnE\xf4\x02\x8a%W\x93A\xdf\x1f\x9a\xb2");
  }
}

function function_216c429b5a6ea3d9(targettotag, isrespawn) {
  assert(isPlayer(self));

  if(!isDefined(targettotag.spy_camera)) {
    targettotag function_5059edafb1a46bb1(1);
  }

  assert(function_521e395da724967a(targettotag));
  function_abad79acb6b877e3(targettotag, isrespawn, 1);
  function_74d4d26b4326f8d9(targettotag);
}

function function_8c605f96ffed0aa4(var_29ac54a1ce07d524) {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;
  player.spy_camera.var_29ac54a1ce07d524 = var_29ac54a1ce07d524;
}

function private function_521e395da724967a(potentialtarget) {
  assert(isDefined(self.spy_camera));
  assert(isPlayer(self));
  player = self;

  if(isDefined(player.spy_camera.var_29ac54a1ce07d524) && !player[[player.spy_camera.var_29ac54a1ce07d524]](potentialtarget)) {
    return false;
  }

  return !isDefined(potentialtarget.spy_camera.allow_tagging) || potentialtarget.spy_camera.allow_tagging == 1;
}

function private function_533f3cc899dacdea() {
  self endon("\x1e\xfd\xd1\xa2\a");
  ref = "s\xe0^_\xd8\x16\xb6Yra\xbe\x967\x83\xba\x1d\xfa\xa5\xd8{\xe6";
  input_icon_display::function_7c9ff06651218181(ref, &"hash_5c33f95407ca3642", "\xd2\xd3\x86kC\x88W\x97b\xcd\xec\x02\xd1>\x13\xa4Q\x7f\t\b\xa0\xf1\v@~u\x8a\x81\xa5", 1, undefined, undefined, "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a");

  if(val::get("y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a")) {
    input_icon_display::set_enabled(ref);
    return;
  }

  input_icon_display::set_disabled(ref);
}

function function_5866503a5e053784() {
  self notify("a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");
  utility_sp::take_weapon(self.spy_camera.weapon);
  player_sp::function_1ce9fde87cbd0430(0);
  function_a65209cee99ead02();

  if(isDefined(self.spy_camera.command)) {
    self notifyonplayercommandremove("\x1e\xf2O2\x17qN\x02\xb6B", self.spy_camera.command);
    level.player input_icon_display::function_85f8b957b53e6cba("s\xe0^_\xd8\x16\xb6Yra\xbe\x967\x83\xba\x1d\xfa\xa5\xd8{\xe6");
  }

  self.spy_camera = undefined;
  val::reset_all("\x1e\xf2O2\x17qN\x02\xb6B");
  val::reset_all("\x1e\xf2O2\x17qN\x02\xb6B" + "%m\b");
}

function function_e2728e9455a8842c(bool_allow) {
  self.spy_camera.allow_photos = bool_allow;
}

function function_e4c7e67e375efb0() {
  player = self;

  if(isDefined(player.spy_camera) && isDefined(player.spy_camera.weapon)) {
    return (getweaponbasename(player getcurrentweapon()) == player.spy_camera.weapon);
  }

  return false;
}

function function_9bc256dfd1a9266f() {
  return [5.67, 65];
}

function private function_30a63a743ce05a43() {
  wait 0.5;
  hud_management::function_170c03b36bf19328("\x1e\xf2O2\x17qN\x02\xb6B", "\x9eb\xa6V\x8dGZ\xecen", 0);
}

function function_dabc0180041297ce() {
  self endon("a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");
  self endon(" C\x90\xb1v3\xbf\xfb\xd2\xff\x16\x03\x94\x99\x91\xe8[\x13Z\x0f\xc0\x1f\x1f\xdf");
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  default_fov = 65;
  max_fov = 65;
  var_4504149a75ace2d2 = 65;
  min_fov = 5.67;
  zoom_rate = 2;
  var_7ba3bd2e4c124482 = 0.2;
  visionset = "\xff\xf2H\xe0\"G\xbb\x0fW\xb1Z\f";
  shell_shock = "\x84p\xb7p\x06\b\x1a\x83I6\t\xcc\x06\xbb\x99J";
  snapshot_time = 0.5;
  var_67d5537bac408eac = "-\x97\x17g\xe9gr\x115\xd2\x1e-re\xbd\xfc\xdc%\xfb\x93\xab[5\t\xdd\xe6\x9e";
  var_7a53ca4bc61fa318 = "Y\x8b\xab-\x1c}7\x0e\x97\xafcXm\xac\x93a\xfa\xa7\xb7\xb7k\xfa\xd8\x1c";
  var_5ab76e8c7fe20355 = "\xd0S\x9f_M\x19\xf0V\xf3\x9c\xda\x19\xbe\x98@\xf08@:>\x069\xb0\xc6*p";
  snapshot_sound = "88\xb2t\x147\n1w\x91\x17\x9eR\x97\xd9(\xf98\x8e^\x94\t\xce!";
  snapshot_notify = "\x0fOJ\xa7\xe8\xee\x91z\xaa\xa9q";
  var_e815675bb2b19956 = 7200;
  fstop = 9;
  focus_speed = 5;
  aperture_speed = 2;
  ads_gesture = "\x88\x96F*O\x16_\xf2\xdf\xe4\x97\xe1\xe2\xef\xa0\xadq\x9d";
  var_6274f8cdc1c14089 = 0.15;
  snapshot_time += var_6274f8cdc1c14089;
  was_ads = 0;
  var_be38150a595c9d25 = 0;
  cur_fov = var_4504149a75ace2d2;
  var_500edf56b62cd8dc = 0;
  var_db2484d6777b2ebe = 0;
  finished_ads = 0;
  trace_contents = trace::create_contents(1, 1, 0, 0, 0, 1, 0, 0, 0);
  film_depleted = 0;
  self.spy_camera.var_9c7eff3af81c3adc = 1;
  self.spy_camera.take_snapshot = 0;
  self.spy_camera.var_5c55cd9aa306242b = 0;
  self.spy_camera.focus_dist = var_e815675bb2b19956;
  self.spy_camera.var_596b7f242077deb9 = undefined;
  childthread function_45cda6aa635dcc17();
  childthread function_65ada323ae7d339b();
  var_761faa87501ddf9f = 0.8;
  var_97dca2629d858bd8 = 0.2;

  if(self getcurrentweaponclipammo() == 0) {
    self setweaponammoclip(self.spy_camera.weapon, 1);
  }

  while(true) {
    if(isalive(self) && !self isswitchingweapon() && !self isreloading() && self adsButtonPressed() && self isweaponsenabled() && val::get("y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a")) {
      if(isnullweapon(self getcurrentweapon())) {
        player_sp::function_1ce9fde87cbd0430(0);
        waitframe();
        continue;
      }

      if(!val::get("\xe4\xf1G")) {
        player_sp::function_1ce9fde87cbd0430(0);
        waitframe();
        continue;
      }

      if(self playerads() >= 0.4) {
        player_sp::function_1ce9fde87cbd0430(isDefined(self.var_9da8d412ebfc68f2) ? 1 : 0, self.var_9da8d412ebfc68f2, 1);

        if(!finished_ads) {
          if(!was_ads) {
            was_ads = 1;
            self notify("\x88M\xe8\xee\x90\xa5\x1c\xa7-21\xa3\xe1\xc4\x1cJ");
            waitframe();
          }

          if(isDefined(self.spy_camera.scripted_widget_overlay)) {
            hud_management::function_35924dfcb78711f4("\x1e\xf2O2\x17qN\x02\xb6B", self.spy_camera.scripted_widget_overlay);
            hud_management::function_85d8a0ba2e35b6f2("\x1e\xf2O2\x17qN\x02\xb6B", 0, 0, 3, 3, 0);
            hud_management::function_d8d634ceece460("\x1e\xf2O2\x17qN\x02\xb6B", "r,|\\");
            function_38e51c40a4ed78f2();

            if(self.spy_camera.var_226b2cccd01cb5e4) {
              function_ec5b967b5208106f(1);
            }

            if(self.spy_camera.var_e56577c0cb19ef75) {
              function_688a09df77e0d044(1);
            }

            self.spy_camera.var_f64fc6ca7d982bd4["=\xacw\xee"] = 1;
            hud_management::function_170c03b36bf19328("\x1e\xf2O2\x17qN\x02\xb6B", "S\x1c\xcbh\xb0mV9\x16", 1, 1);
            wait 0.15;
            val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A", 1);
          }

          self.spy_camera.var_596b7f242077deb9 = function_25f3c3dc847f86e6();
          self modifybasefov(cur_fov, level.framedurationseconds);
          self notify("e7\xd1e\x9c_6\xc2\xd6\xcaNX\xfa,F\x9b");
          utility::ent_flag_set("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84");
          utility::ent_flag_set("\xd5HR\xeb\xda,\xce)<>\x90\xeb-J\xfe\xb6");
          function_763e03a0c6b060df();
          finished_ads = 1;

          if(isDefined(self.spy_camera.var_7f465401144e8497)) {
            foreach(guy in self.spy_camera.var_7f465401144e8497) {
              if(isDefined(guy)) {
                guy.spy_camera.var_5e3fe616b0caaf21 = undefined;
              }
            }

            self.spy_camera.var_7f465401144e8497 = undefined;
          }
        }

        visionsetnaked("N)@\x96\xda'\x13\xa4\xfc\xa5D\xc88\xf1\x81N\xde`\xdf&H)A\x06$\xad9\bX\xf0", 0.25);
        left_stick = self getnormalizedmovement();

        if(abs(left_stick[0]) > var_7ba3bd2e4c124482 && (left_stick[0] < 0 && cur_fov < max_fov || left_stick[0] > 0 && cur_fov > min_fov)) {
          zoom_frac = (abs(left_stick[0]) - var_7ba3bd2e4c124482) / (1 - var_7ba3bd2e4c124482) * utility::sign(left_stick[0]) * -1;
          zoom_delta = zoom_frac * zoom_rate * cur_fov * level.framedurationseconds;
          cur_fov = clamp(cur_fov + zoom_delta, min_fov, max_fov);
          perc_zoomed = cur_fov / max_fov;
          self.spy_camera.var_f64fc6ca7d982bd4["=\xacw\xee"] = perc_zoomed;
          function_a37137cc50e42fc5();
          self modifybasefov(cur_fov, level.framedurationseconds);

          if(!var_be38150a595c9d25) {
            var_be38150a595c9d25 = 1;
            self playSound(var_67d5537bac408eac);

            if(!isDefined(self.var_77285e7734d9b90e)) {
              self.var_77285e7734d9b90e = utility::play_loopsound_in_space(var_7a53ca4bc61fa318, self getEye());
            } else {
              self.var_77285e7734d9b90e playLoopSound(var_7a53ca4bc61fa318);
            }
          }
        } else if(var_be38150a595c9d25) {
          var_be38150a595c9d25 = 0;
          self playSound(var_5ab76e8c7fe20355);

          if(isDefined(self.var_77285e7734d9b90e)) {
            self.var_77285e7734d9b90e stoploopsound();
          }
        }

        if(self usinggamepad()) {
          turnrate = 120 * pow(cur_fov / max_fov, 1.25);
          setsaveddvar(@ "hash_35877611dd87a107", 1);
          val::set("r\v5wB\xfa\xa1\x96^l\xff\x19\xbd\rP\xc5$P", "\xe7\x92\xbf\x14\xb1\xdd\xdct\x03\x04\xb5\xb6\x1b", [turnrate, turnrate * 2]);
        }

        if(finished_ads) {
          eye = self getEye();
          fwd = anglesToForward(self getplayerangles());
          trace = trace::ray_trace_detail(eye, eye + fwd * var_e815675bb2b19956, self, trace_contents);
          self.spy_camera.focus_dist = distance(eye, trace["\xc1\xbd\xdci\xe8i{7"]);

          fstop = getdvarfloat(@ "hash_cc4f5e5d97fe5cdf", fstop);
          focus_speed = getdvarfloat(@ "hash_fa79133e4ab41839", focus_speed);
          aperture_speed = getdvarfloat(@ "hash_7e84d2e32c467d53", aperture_speed);

          if(getdvarint(@ "hash_f84af8dd52dac20a", 0)) {
            sphere(trace["<dev string:x41>"], 1, (1, 0, 0), 0, 1);
          }

          function_ab7c6cd8f9142d9c(trace["<dev string:x4d>"]);

          self setphysicaldepthoffield(fstop, self.spy_camera.focus_dist, focus_speed, aperture_speed);

          if(istrue(self.spy_camera.var_8e862f6bbe0875fd)) {
            function_4087f9afb5f678b4();
          }
        }

        if(self.spy_camera.take_snapshot) {
          if(self.spy_camera.allow_photos) {
            hud_management::function_170c03b36bf19328("\x1e\xf2O2\x17qN\x02\xb6B", "\x9eb\xa6V\x8dGZ\xecen", 1);
            utility::ent_flag_set("\xcd\x1c\xcb_\xd8,m\xf5\xa3akZ\x9b\xb3_\xcd\xdc\x858\xdch\xed:");

            if(utility::hastag(self.model, "\xc7\xae?f\x10\xbcr")) {
              playfxontagforclients(utility::getfx(")P1\x93{k\x94W8\xb6\x18\xc3\x12\xe3"), self, "\xc7\xae?f\x10\xbcr", self);
            }

            hud_management::function_d8d634ceece460("\x1e\xf2O2\x17qN\x02\xb6B", "\xb1*kv\xe7\x82E ");
            self playSound(snapshot_sound);
            visionsetnaked(visionset, 0);
            wait var_6274f8cdc1c14089;
            spy_camera_snapshot();

            if(istrue(self.spy_camera.var_a40eca6fa3afe900)) {
              function_77c02e202d09e298();
            }

            hud_management::function_d8d634ceece460("\x1e\xf2O2\x17qN\x02\xb6B", "\x91\xca\xcc\v\xab\xd8:");
            setsaveddvar(@ "r_hudoutlineenable", 0);
            self shellshock(shell_shock, 60, 0, 0);
            cleanupdelay = snapshot_time - var_6274f8cdc1c14089;
            thread utility::delaycall(cleanupdelay, &fadeoutshellshock);
            thread utility::noself_delaycall(cleanupdelay, &setsaveddvar, @ "r_hudoutlineenable", 1);
            thread utility::ent_flag_clear_delayed("\xcd\x1c\xcb_\xd8,m\xf5\xa3akZ\x9b\xb3_\xcd\xdc\x858\xdch\xed:", cleanupdelay);
            thread function_30a63a743ce05a43();
            visionsetnaked("", 0);
            visionsetnaked("N)@\x96\xda'\x13\xa4\xfc\xa5D\xc88\xf1\x81N\xde`\xdf&H)A\x06$\xad9\bX\xf0", 0);
            function_d9c95d62bc22d2dc();

            if(isDefined(snapshot_notify)) {
              self notify(snapshot_notify);
            }
          }

          self.spy_camera.take_snapshot = 0;
        } else if(self.spy_camera.var_5c55cd9aa306242b + snapshot_time * 1000 < gettime() && !self.spy_camera.var_9c7eff3af81c3adc) {
          self.spy_camera.var_9c7eff3af81c3adc = 1;
        }
      } else {
        if(!was_ads) {
          was_ads = 1;
          cur_fov = var_4504149a75ace2d2;
          finished_ads = 0;
          self notify("\x88M\xe8\xee\x90\xa5\x1c\xa7-21\xa3\xe1\xc4\x1cJ");
        }

        if(var_be38150a595c9d25) {
          var_be38150a595c9d25 = 0;
          self playSound(var_5ab76e8c7fe20355);

          if(isDefined(self.var_77285e7734d9b90e)) {
            self.var_77285e7734d9b90e stoploopsound();
            self.var_77285e7734d9b90e delete();
          }
        }
      }

      function_a37137cc50e42fc5();
    } else if(was_ads) {
      was_ads = 0;
      player_sp::function_1ce9fde87cbd0430(0);
      self notify("\f\x14\xbf=\xcc\xfbk\xb6\xc6\xe5\xfa\x10\x8f\xd4\xd0\x0e\x16y\x99W");
      function_f800679d8c8e0406();
      val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xe4\xf1G", 0);

      if(var_be38150a595c9d25) {
        var_be38150a595c9d25 = 0;
        self playSound(var_5ab76e8c7fe20355);

        if(isDefined(self.var_77285e7734d9b90e)) {
          self.var_77285e7734d9b90e stoploopsound();
          self.var_77285e7734d9b90e delete();
        }
      }

      if(finished_ads) {
        prev_fov = self.spy_camera.var_596b7f242077deb9 ?? default_fov;
        self modifybasefov(prev_fov, level.framedurationseconds);
        setsaveddvar(@ "hash_35877611dd87a107", 0);
        val::reset_all("r\v5wB\xfa\xa1\x96^l\xff\x19\xbd\rP\xc5$P");
        self.spy_camera.var_596b7f242077deb9 = undefined;

        if(hud_management::function_48c98ea9a4f0da89("\x1e\xf2O2\x17qN\x02\xb6B")) {
          thread function_13d45c88116ec956();
          thread function_10aab95e05b9dd4f();
          function_f604d3193be7cac1();
          val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\x7f\xf0M( G\xc3\xd1Y\xaa\xb3c\xb1d^\xe9\xc3c\xb6xp{", 1);
        } else {
          visionsetnaked("", 0);
        }

        finished_ads = 0;
        function_b11427e7e204ea16();

        function_4e3572c0a8d67915();
      }

      utility::ent_flag_clear("\xd5HR\xeb\xda,\xce)<>\x90\xeb-J\xfe\xb6");

      while(self playerads() >= 0.25 || hud_management::function_48c98ea9a4f0da89("\x1e\xf2O2\x17qN\x02\xb6B")) {
        waitframe();
      }

      val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\xe4\xf1G");
      self notify("\x84\x05\xf7\xbe \xfdT\x9b\xeb\x8f~b\xe5\x13");
      utility::ent_flag_clear("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84");
    }

    film_depleted = self getweaponammoclip(self.spy_camera.weapon) == 0;
    waitframe();
  }
}

function function_a65209cee99ead02() {
  hud_management::scripted_widget_destroy("\x1e\xf2O2\x17qN\x02\xb6B");
  function_84d81270d17e50e6(0);
}

function function_ec5b967b5208106f(var_edad6d60be2cabbc, var_61ef3d357eaf64d4) {
  self.spy_camera.var_226b2cccd01cb5e4 = var_edad6d60be2cabbc;
  self.spy_camera.var_e2378c5c83436e22 = var_61ef3d357eaf64d4 ?? self.spy_camera.var_e2378c5c83436e22;

  if(!isDefined(var_edad6d60be2cabbc)) {
    var_edad6d60be2cabbc = 1;
  }

  if(var_edad6d60be2cabbc) {
    hud_management::function_b683400f784cb7dc("\x1e\xf2O2\x17qN\x02\xb6B", "\a\x94\xb6cC\x8e<\xdcUH_\x91\xe9\xa0\xec\nA\x92_\xba9c");
    thread function_fbb7989248f2bef4(self.spy_camera.var_e2378c5c83436e22);
    return;
  }

  function_f800679d8c8e0406();
  self.spy_camera.var_e2378c5c83436e22 = undefined;
  hud_management::function_b683400f784cb7dc("\x1e\xf2O2\x17qN\x02\xb6B", "\x11\xca\xcc\v\xab\xd8:");
}

function private function_fbb7989248f2bef4(var_4b68e11de0c61454) {
  self notify("\xce|E8Q\xe7\xdep\x93\xd8\xe6-5_v\xbfG\b\x1f\xf8\xcfE\xb40O\x95\xe6");
  self endon("\xce|E8Q\xe7\xdep\x93\xd8\xe6-5_v\xbfG\b\x1f\xf8\xcfE\xb40O\x95\xe6");

  if(isstring(var_4b68e11de0c61454)) {
    var_4b68e11de0c61454 = [var_4b68e11de0c61454];
  }

  utility::function_98a0531c1b66c9ff(var_4b68e11de0c61454);
  var_d368c4f758193460 = 2;
  function_ddbf919a366e6f23(var_d368c4f758193460);
}

function function_ddbf919a366e6f23(state) {
  self setclientomnvar("\xc5&\x99\xc3\xcf\x8b'\xb890\xe1E\xd2\xb1\x9d\xf9\xcb \xf9\xd8QP\xb089\xbb\xc7\xe3\xf5P}\xdfm\x9e\x1e", state);
}

function function_9a852b3893befa5c(state) {
  self setclientomnvar("\xc8eg\x96\x8dV\xd7\xc2c\x8e\xb4g\xca_6i\x9b:\xac7K\xe6v\xaf\xc8\xac\xceZ\x1be\xaf\xe6taG+", state);
}

function function_688a09df77e0d044(var_dfffff9184489c19, var_61ef3d357eaf64d4) {
  self.spy_camera.var_e56577c0cb19ef75 = var_dfffff9184489c19;
  self.spy_camera.var_8f1f5007289a89d1 = var_61ef3d357eaf64d4 ?? self.spy_camera.var_8f1f5007289a89d1;

  if(!isDefined(var_dfffff9184489c19)) {
    var_dfffff9184489c19 = 1;
  }

  if(var_dfffff9184489c19) {
    hud_management::function_b683400f784cb7dc("\x1e\xf2O2\x17qN\x02\xb6B", "\xe5t\xc2\xe8\xbd\xc9h$\xa1\x8f\x1f3\x9bL?\xe7");
    thread function_25d3e418194dbddf(self.spy_camera.var_8f1f5007289a89d1);
    return;
  }

  self.spy_camera.var_8f1f5007289a89d1 = undefined;
  hud_management::function_b683400f784cb7dc("\x1e\xf2O2\x17qN\x02\xb6B", "\x11\xca\xcc\v\xab\xd8:");
}

function function_11e579d63b3a42d(target_score = 0, listening_score = 0) {
  self setclientomnvar("l\xe1\xccN ;\x17\xec\xd4C6\ngq\xda\xaa9\x958\xc6X\by\x94\x16\x9c\xed\xcd\xc5", target_score);
  self setclientomnvar("2Y\xd9\xd2\xb1+}\x8d-\xb9:\xca\xb9Ks;\xbe\xaen\xca\x93\xafs\xc6\xb7N+", listening_score);
}

function private function_25d3e418194dbddf(var_4b68e11de0c61454) {
  self notify("\x03\xfca\xd1\xe58\xd1&)\\O\xc5IMKlKc\xfbn\xc3\x93=\xcd\xb0\x9aI`\xc4\xf9y");
  self endon("\x03\xfca\xd1\xe58\xd1&)\\O\xc5IMKlKc\xfbn\xc3\x93=\xcd\xb0\x9aI`\xc4\xf9y");

  if(isstring(var_4b68e11de0c61454)) {
    var_4b68e11de0c61454 = [var_4b68e11de0c61454];
  }

  utility::function_98a0531c1b66c9ff(var_4b68e11de0c61454);
  listening_device_complete = 2;
  function_9a852b3893befa5c(listening_device_complete);
}

function function_f800679d8c8e0406(message_str) {
  if(!self.spy_camera.var_226b2cccd01cb5e4) {
    return;
  }

  locindex = 0;

  if(isDefined(message_str)) {
    locindex = function_30e4f86dded0873(message_str);
  }

  self.spy_camera.var_f64fc6ca7d982bd4["d\xc1\x87G\x12\xc2\xadt\xb8\xcfE\xcfnH\x15:\xe2\x9b\x88\xa9\x90"] = locindex;
  function_a37137cc50e42fc5();
}

function function_bb980f7b7c16eb28(var_ba5b85d436f43b55) {
  if(utility::ent_flag("\xcd\x1c\xcb_\xd8,m\xf5\xa3akZ\x9b\xb3_\xcd\xdc\x858\xdch\xed:")) {
    return;
  }

  if(!isDefined(var_ba5b85d436f43b55)) {
    var_ba5b85d436f43b55 = 1;
  }

  var_e77dcd3d6ceeebe0 = "\xca\xa0Y\xbc+\xe2\x96\xf3\x9a\x8b\xf4\xff\x02\xb25\xa4";

  if(var_ba5b85d436f43b55) {
    var_e77dcd3d6ceeebe0 = "b}\xef\xbc`\x87f5k\x92A5!~\xda";
  }

  hud_management::function_d8d634ceece460("\x1e\xf2O2\x17qN\x02\xb6B", var_e77dcd3d6ceeebe0);
}

function private function_ab7c6cd8f9142d9c(ent) {
  player = self;

  if(getdvarint(@ "hash_894ce22e03607750", 0) == 0) {
    return;
  }

  if(!isDefined(level.var_96f7d104d14e8224)) {
    level.var_96f7d104d14e8224 = [];
    entlabels = ["<dev string:x57>", "<dev string:x63>", "<dev string:x76>", "<dev string:x83>", "<dev string:x90>", "<dev string:xaa>", "<dev string:xb3>", "<dev string:xc7>", "<dev string:xdf>", "<dev string:xf3>", "<dev string:x103>"];
    level.var_7850712d438a6703 = entlabels.size;
    startingx = 40;
    startingy = 60;
    lineheight = 12;

    for(i = 0; i < entlabels.size; i++) {
      debugtext = player hud_util::createclientfontstring("<dev string:x117>", 0.8);
      debugtext hud_util::setpoint("<dev string:x122>", undefined, startingx, startingy + i * lineheight);
      debugtext.color = (1, 1, 0);
      debugtext.label = entlabels[i];
      debugtext.alpha = 0;
      level.var_96f7d104d14e8224 = utility::array_add(level.var_96f7d104d14e8224, debugtext);
    }

    cameralabels = ["<dev string:x12e>", "<dev string:x13a>", "<dev string:x143>"];
    startingx += 100;
    lineheight = 12;

    for(i = 0; i < cameralabels.size; i++) {
      debugtext = player hud_util::createclientfontstring("<dev string:x117>", 0.8);
      debugtext hud_util::setpoint("<dev string:x122>", undefined, startingx, startingy + i * lineheight);
      debugtext.color = (1, 1, 0);
      debugtext.label = cameralabels[i];
      level.var_96f7d104d14e8224 = utility::array_add(level.var_96f7d104d14e8224, debugtext);
    }
  }

  if(isDefined(ent) && isDefined(ent.spy_camera)) {
    function_8f95cb488c76dfb5(0, ent getentitynumber());
    function_8f95cb488c76dfb5(1, ent.spy_camera.allow_tagging);
    function_8f95cb488c76dfb5(2, ent.spy_camera.min_fov);
    function_8f95cb488c76dfb5(3, ent.spy_camera.max_fov);
    function_8f95cb488c76dfb5(4, ent.spy_camera.var_6ac4acd8f4d77cef);
    function_8f95cb488c76dfb5(5, ent.spy_camera.tag);
    function_8f95cb488c76dfb5(6, ent.spy_camera.reticle_radius);
    function_8f95cb488c76dfb5(7, ent.spy_camera.var_6e81fd6024f1ebd4);
    function_8f95cb488c76dfb5(8, ent.spy_camera.var_cd1b3f1e9ba81425);
    function_8f95cb488c76dfb5(9, ent.spy_camera.fov_scalar);
    function_8f95cb488c76dfb5(10, ent.spy_camera.var_b01320438f9b3387);
  } else {
    for(i = 0; i < level.var_7850712d438a6703; i++) {
      function_8f95cb488c76dfb5(i, undefined);
    }
  }

  camfov = function_87693d564fcc18cb();
  function_8f95cb488c76dfb5(12, camfov);
  function_8f95cb488c76dfb5(13, player.spy_camera.focus_dist);
}

function private function_8f95cb488c76dfb5(textelemindex, value) {
  textelem = level.var_96f7d104d14e8224[textelemindex];

  if(!isDefined(value)) {
    textelem setvalue(-1);
    textelem.color = (0.3, 0.3, 0.3);
    textelem.alpha = 0.7;
    return;
  }

  if(isnumber(value)) {
    textelem setvalue(value);
    textelem.color = (1, 1, 0);
    textelem.alpha = 1;
    return;
  }

  textelem setdevtext(value);
  textelem.color = (1, 1, 0);
  textelem.alpha = 1;
}

function private function_4e3572c0a8d67915() {
  if(isDefined(level.var_96f7d104d14e8224)) {
    foreach(textelem in level.var_96f7d104d14e8224) {
      textelem destroy();
    }

    level.var_96f7d104d14e8224 = undefined;
  }
}

function private function_a37137cc50e42fc5() {
  hud_management::function_41ff479ac45608d6("\x1e\xf2O2\x17qN\x02\xb6B", self.spy_camera.var_f64fc6ca7d982bd4, 1);
}

function private function_13d45c88116ec956() {
  self endon("\x1e\xfd\xd1\xa2\a");
  thread hud_util::fade_in(0.6);
  waitframe();
  function_a65209cee99ead02();
  val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A");
  wait 0.1;
  visionsetnaked("", 0);
}

function private function_10aab95e05b9dd4f() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x15\xbcX\x19vI\x7f\\\xf7\xeb}l\x168vP\xe7:@\x04fg\xe8D\\\x91" + "\x1e\xf2O2\x17qN\x02\xb6B");
  hud_management::function_a4b07de99918f624("\x1e\xf2O2\x17qN\x02\xb6B");
  val::reset_array("\x1e\xf2O2\x17qN\x02\xb6B", ["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"]);
}

function function_65ada323ae7d339b() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  self notifyonplayercommand(":\x85[V\xf5sn,p\xcd4\xf6\xd1", "\xaaQ\xf1{\xf3\x97\xba");

  while(true) {
    self waittill(":\x85[V\xf5sn,p\xcd4\xf6\xd1");
    self.spy_camera.var_f64fc6ca7d982bd4["d\xc1\x87G\x12\xc2\xadt\xb8\xcfE\xcfnH\x15:\xe2\x9b\x88\xa9\x90"] = 0;
    function_f800679d8c8e0406();

    if(self.spy_camera.var_9c7eff3af81c3adc) {
      self.spy_camera.var_9c7eff3af81c3adc = 0;
      self.spy_camera.var_5c55cd9aa306242b = gettime();
      self.spy_camera.take_snapshot = 1;
    }
  }
}

function function_45cda6aa635dcc17() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xcciN\xca", 0);
  val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\x9a\xe3\xe4\xff\x81%", 0);
  val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xb4RO\xa4\x81\xeed|\xc1c\x95\xe1t'\x7f", 0);
  val::set("\x1e\xf2O2\x17qN\x02\xb6B", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);

  while(true) {
    if(self.spy_camera.var_9c7eff3af81c3adc) {
      self.spy_camera.var_9c7eff3af81c3adc = 0;
    }

    ret = utility::waittill_any_return("\x88M\xe8\xee\x90\xa5\x1c\xa7-21\xa3\xe1\xc4\x1cJ", "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW");

    if(ret == "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW") {
      self.spy_camera.var_9c7eff3af81c3adc = 1;
      return;
    }

    if(val::get("\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A")) {
      continue;
    }

    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xc9\xca\x1boX\x8c", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "y\x9e\xfa\xb1\x95.\x839", 0);
    val::set_array("\x1e\xf2O2\x17qN\x02\xb6B", arrayremove(["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"], "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a"), 0);
    originalminfocusdist = getdvarfloat(@ "hash_ef3c7afddde0af88");
    setsaveddvar(@ "hash_ef3c7afddde0af88", 16);
    ret = utility::waittill_any_return("e7\xd1e\x9c_6\xc2\xd6\xcaNX\xfa,F\x9b", "\f\x14\xbf=\xcc\xfbk\xb6\xc6\xe5\xfa\x10\x8f\xd4\xd0\x0e\x16y\x99W", "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW");

    if(ret == "e7\xd1e\x9c_6\xc2\xd6\xcaNX\xfa,F\x9b") {
      val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xcciN\xca", 1);

      if(!self.spy_camera.var_9c7eff3af81c3adc) {
        self.spy_camera.var_9c7eff3af81c3adc = 1;
      }

      self enablephysicaldepthoffieldscripting(2);
      ret = utility::waittill_any_return("\f\x14\xbf=\xcc\xfbk\xb6\xc6\xe5\xfa\x10\x8f\xd4\xd0\x0e\x16y\x99W", "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW");
      self disablephysicaldepthoffieldscripting();
    }

    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8");

    if(ret != "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW" && utility::ent_flag("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84")) {
      ret = utility::waittill_any_return("\x84\x05\xf7\xbe \xfdT\x9b\xeb\x8f~b\xe5\x13", "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW");
    }

    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\xc9\xca\x1boX\x8c");
    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12");
    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e");
    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "`\x16\xae\xa2\xe4t\x187\xe7");
    val::reset("\x1e\xf2O2\x17qN\x02\xb6B", "y\x9e\xfa\xb1\x95.\x839");
    val::reset_array("\x1e\xf2O2\x17qN\x02\xb6B", ["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"]);
    val::set("\x1e\xf2O2\x17qN\x02\xb6B", "\xcciN\xca", 0);
    setsaveddvar(@ "hash_ef3c7afddde0af88", originalminfocusdist);

    if(ret == "\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW") {
      if(!self.spy_camera.var_9c7eff3af81c3adc) {
        self.spy_camera.var_9c7eff3af81c3adc = 1;
      }

      return;
    }
  }
}

function private function_957c21f3a0af7cf0() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("a#\xf5W\xf3\xd4c\xee2\xa57\xc4\x0fl\xb0US\x9c");
  assert(isDefined(player.spy_camera));
  player.spy_camera.taggedtargets = [];
  var_eced277a7be3d4d4 = player utility::ent_flag("\xd5HR\xeb\xda,\xce)<>\x90\xeb-J\xfe\xb6");
  var_d81b01fffdd7fb09 = player utility::ent_flag("\\G\x7fg\x9d\xbf\xd3b\xa0K\x8c\x13\x93\xbd\x9d\xdd\x05\xab\xfc\x9dnE\xf4\x02\x8a%W\x93A\xdf\x1f\x9a\xb2");

  while(true) {
    var_39f6a90580527761 = 0;
    currenttime = gettime();
    isinads = player utility::ent_flag("\xd5HR\xeb\xda,\xce)<>\x90\xeb-J\xfe\xb6");
    var_b2c37eb150cfa7 = isinads != var_eced277a7be3d4d4;
    var_eced277a7be3d4d4 = isinads;
    issystemenabled = player utility::ent_flag("\\G\x7fg\x9d\xbf\xd3b\xa0K\x8c\x13\x93\xbd\x9d\xdd\x05\xab\xfc\x9dnE\xf4\x02\x8a%W\x93A\xdf\x1f\x9a\xb2");
    var_e2943e05ab31738c = issystemenabled != var_d81b01fffdd7fb09;
    var_d81b01fffdd7fb09 = issystemenabled;

    for(targetindex = 0; targetindex < player.spy_camera.taggedtargets.size; targetindex++) {
      taggedtarget = player.spy_camera.taggedtargets[targetindex];

      if(!isDefined(taggedtarget)) {
        var_39f6a90580527761 = 1;
        continue;
      }

      if(!isalive(taggedtarget)) {
        player function_b1211ce2bd69184c(targetindex);
        var_39f6a90580527761 = 1;
        continue;
      }

      if(player.spy_camera.var_cd6449c0365aac48 > 0) {
        var_7b98f35a43a4db6b = taggedtarget.spy_camera.var_96588a1470877227 ?? 0;

        if(currenttime - var_7b98f35a43a4db6b > player.spy_camera.var_cd6449c0365aac48) {
          player function_b1211ce2bd69184c(targetindex);
          var_39f6a90580527761 = 1;
          continue;
        }
      }

      if(var_e2943e05ab31738c) {
        if(issystemenabled) {
          if(!player function_521e395da724967a(taggedtarget)) {
            player function_b1211ce2bd69184c(targetindex);
            var_39f6a90580527761 = 1;
          } else if(isinads) {
            taggedtarget utility_sp::hudoutline_enable_new(taggedtarget.spy_camera.ads_outline, "\x1e\xf2O2\x17qN\x02\xb6B");
          } else {
            taggedtarget utility_sp::hudoutline_enable_new(taggedtarget.spy_camera.var_4751ca6200674c0d, "\x1e\xf2O2\x17qN\x02\xb6B");
          }
        } else {
          taggedtarget utility_sp::hudoutline_disable("\x1e\xf2O2\x17qN\x02\xb6B");
        }

        continue;
      }

      if(issystemenabled && var_b2c37eb150cfa7) {
        if(isinads) {
          taggedtarget utility_sp::hudoutline_enable_new(taggedtarget.spy_camera.ads_outline, "\x1e\xf2O2\x17qN\x02\xb6B");
          continue;
        }

        taggedtarget utility_sp::hudoutline_enable_new(taggedtarget.spy_camera.var_4751ca6200674c0d, "\x1e\xf2O2\x17qN\x02\xb6B");
      }
    }

    if(var_39f6a90580527761) {
      player.spy_camera.taggedtargets = utility::array_removeundefined(player.spy_camera.taggedtargets);
    }

    waitframe();
  }
}

function private function_abad79acb6b877e3(targettotag, isrespawn = 0, isscripted = 0) {
  player = self;
  adsoutline = player.spy_camera.var_810dd21377f7f708;
  nonadsoutline = player.spy_camera.var_7de17bd030d9e4d;

  if(player utility::ent_flag("\xd5HR\xeb\xda,\xce)<>\x90\xeb-J\xfe\xb6")) {
    targettotag utility_sp::hudoutline_enable_new(adsoutline, "\x1e\xf2O2\x17qN\x02\xb6B");
  } else {
    targettotag utility_sp::hudoutline_enable_new(nonadsoutline, "\x1e\xf2O2\x17qN\x02\xb6B");
  }

  if(isDefined(targettotag.spawner) && isDefined(targettotag.var_f3973f54f310e407)) {
    targettotag.spawner utility_sp::add_spawn_function(&function_447f2dc696db065b);
  }

  player.spy_camera.taggedtargets[player.spy_camera.taggedtargets.size] = targettotag;
  player.spy_camera.var_b39b81c3f7c15eb2 = gettime();
  targettotag.spy_camera.ads_outline = adsoutline;
  targettotag.spy_camera.var_4751ca6200674c0d = nonadsoutline;
  targettotag.spy_camera.var_5e3fe616b0caaf21 = undefined;
  targettotag.spy_camera.var_96588a1470877227 = gettime();

  if(player.spy_camera.var_7de17bd030d9e4d == "F\xc5\x04R\xe0\xee\xe4\x1e\x98\xb7\"\xb2\x87\xd5e\x12\x1f\xaf\x8e\x04\r") {
    targettotag.var_2ba3e3c718e5d66e = 1;
  } else {
    targettotag.visibilitymode_nodepth = 1;
  }

  player.var_79176eb01c063a79 = 1;

  if(!istrue(isrespawn)) {
    snd::play("As}\xda#\n\xaeFf\xab\xb64\xe4\xa0");

    if(!istrue(isscripted)) {
      player function_13411dfa05fb2751();
    }
  }
}

function private function_74d4d26b4326f8d9(targettotag) {
  player = self;

  if(isactor(targettotag) && isDefined(targettotag.ridingvehicle)) {
    parentvehicle = targettotag.ridingvehicle;

    if(!isDefined(parentvehicle.spy_camera)) {
      parentvehicle.spy_camera = spawnStruct();
    }

    player function_abad79acb6b877e3(parentvehicle, 1, 1);
  }
}

function private function_447f2dc696db065b() {
  level.player thread function_216c429b5a6ea3d9(self, 1);
}

function private function_b1211ce2bd69184c(targetindex) {
  player = self;
  var_57b5bf2d6440b7bb = player.spy_camera.taggedtargets[targetindex];
  player.spy_camera.taggedtargets[targetindex] = undefined;
  var_57b5bf2d6440b7bb utility_sp::hudoutline_disable("\x1e\xf2O2\x17qN\x02\xb6B");
  var_57b5bf2d6440b7bb.spy_camera.ads_outline = undefined;
  var_57b5bf2d6440b7bb.spy_camera.var_4751ca6200674c0d = undefined;
  var_57b5bf2d6440b7bb.spy_camera.var_5e3fe616b0caaf21 = undefined;
  var_57b5bf2d6440b7bb.spy_camera.var_96588a1470877227 = undefined;
  var_57b5bf2d6440b7bb.visibilitymode_nodepth = undefined;
  player.var_79176eb01c063a79 = 1;
}

function private spy_camera_snapshot() {
  search_result = spawnStruct();
  var_ea7f108ae9f56f6f = function_f8f8ae094bf8be96(undefined, undefined, search_result);

  foreach(guy in var_ea7f108ae9f56f6f) {
    if(istrue(guy.spy_camera.shottaken)) {
      continue;
    }

    guy.spy_camera.shottaken = 1;
    guy notify("\xa7r\xd4\xea\x88\xc2s\xfd\fk");
  }

  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    corpseorigin = getcorpseorigin(corpse);

    if(distance2dsquared(corpseorigin, level.player.origin) <= 20000 && utility_sp::within_fov_of_players(corpseorigin, cos(25))) {
      function_9fbb69fd9c386e34(search_result, corpse, 1, "\x95\xc1G\x1f5\"\xf5P\x189\xb6p\x13");
    }
  }

  self notify("\xf3\x15\xfb\x80CD`\x16\xa5BR*\x0ew\xd4s\xff\xda\xfd", search_result.entries);
}

function private function_85308e95b3f3ffda(fov) {
  return 560 / 2 * tan(fov / 2);
}

function private function_ff8a35c23e1d2230(playereye, var_760b859b71fa4aad, targetent) {
  targetpos = targetent.origin;
  centerpos = targetent getcentroid();

  if(isDefined(centerpos)) {
    targetpos = centerpos;
  }

  targetdist = distance(targetpos, playereye);
  return targetdist <= var_760b859b71fa4aad;
}

function private function_77c02e202d09e298() {
  player = self;
  current_time = gettime();
  current_fov = function_87693d564fcc18cb();
  var_f103ed147f7eeaf6 = function_85308e95b3f3ffda(current_fov);
  player_eye = self getEye();
  search_result = spawnStruct();
  var_52adf96f3823ec77 = spawnStruct();
  var_52adf96f3823ec77.ignore_facing = self.spy_camera.var_a3074a8608ddef03;
  var_ea7f108ae9f56f6f = function_f8f8ae094bf8be96(undefined, var_52adf96f3823ec77, search_result);

  foreach(guy in var_ea7f108ae9f56f6f) {
    if(!player function_521e395da724967a(guy)) {
      continue;
    }

    if(isDefined(guy.spy_camera.var_96588a1470877227)) {
      guy.spy_camera.var_96588a1470877227 = current_time;
      continue;
    }

    if(!function_ff8a35c23e1d2230(player_eye, var_f103ed147f7eeaf6, guy)) {
      continue;
    }

    player function_abad79acb6b877e3(guy);
    player function_74d4d26b4326f8d9(guy);
  }
}

function function_4087f9afb5f678b4() {
  player = self;
  assert(player.spy_camera.var_8e862f6bbe0875fd);
  var_90ce34e278afe6b5 = player.spy_camera.var_90ce34e278afe6b5;
  search_result = spawnStruct();
  var_52adf96f3823ec77 = spawnStruct();
  var_52adf96f3823ec77.ignore_facing = player.spy_camera.var_a3074a8608ddef03;
  var_52adf96f3823ec77.reticle_radius = 245;
  current_time = gettime();
  current_fov = function_87693d564fcc18cb();
  var_f103ed147f7eeaf6 = function_85308e95b3f3ffda(current_fov);
  player_eye = player getEye();

  if(getdvarint(@ "hash_6fb332c9db8f979e", 0) > 0) {
    var_5ffa2c8207b8526b = anglesToForward(player getplayerangles());
    end_pos = player_eye + var_5ffa2c8207b8526b * var_f103ed147f7eeaf6;
    offset_vec = (0, 0, -3);
    cylinder(player_eye + offset_vec, end_pos + offset_vec, 2, (1, 1, 0), 1, 1);
  }

  var_8d8647b21c86251a = 998001;
  var_5e0b8166ae8d54fa = [];
  var_ea7f108ae9f56f6f = player function_f8f8ae094bf8be96(undefined, var_52adf96f3823ec77, search_result);

  foreach(guy in var_ea7f108ae9f56f6f) {
    if(!player function_521e395da724967a(guy)) {
      continue;
    }

    if(isDefined(guy.spy_camera.var_96588a1470877227)) {
      guy.spy_camera.var_96588a1470877227 = current_time;
      continue;
    }

    if(!function_ff8a35c23e1d2230(player_eye, var_f103ed147f7eeaf6, guy)) {
      guy.spy_camera.var_5e3fe616b0caaf21 = undefined;
      continue;
    }

    var_e6281ed13cd8a82d = player worldpointtoscreenpos(guy getcentroid(), current_fov);

    if(isDefined(var_e6281ed13cd8a82d)) {
      guy.spy_camera.var_4d7dfa239e50423c = lengthsquared(var_e6281ed13cd8a82d);

      if(!isDefined(guy.spy_camera.var_5e3fe616b0caaf21)) {
        guy.spy_camera.var_5e3fe616b0caaf21 = current_time + var_90ce34e278afe6b5;
      }

      var_5e0b8166ae8d54fa[var_5e0b8166ae8d54fa.size] = guy;

      if(getdvarint(@ "hash_894ce22e03607750", 0)) {
        print3d(guy getcentroid(), "<dev string:x153>", (0.1, 0.7, 0.6), 1, 0.6, 1, 0);
      }
    }
  }

  var_f87a00cf05f988db = 0;
  var_86128f5fcfd6f84e = (player.spy_camera.var_b39b81c3f7c15eb2 ?? 0) + 400;
  var_b1183bcb96f98aae = utility_sp::array_sort_by_handler(var_5e0b8166ae8d54fa, &function_e323b0b8f116e92);

  for(target_index = 0; target_index < var_b1183bcb96f98aae.size; target_index++) {
    guy = var_b1183bcb96f98aae[target_index];
    var_26636d6cceb0d561 = current_time >= guy.spy_camera.var_5e3fe616b0caaf21;
    var_b043b98b8bea7cd5 = current_time < var_86128f5fcfd6f84e;

    if(target_index == 0) {
      if(var_26636d6cceb0d561 && var_b043b98b8bea7cd5) {
        var_9fa77767570fcc06 = (var_86128f5fcfd6f84e - current_time) / 400;
      } else {
        var_9fa77767570fcc06 = (guy.spy_camera.var_5e3fe616b0caaf21 - current_time) / var_90ce34e278afe6b5;
      }

      var_f87a00cf05f988db = 1 - clamp(var_9fa77767570fcc06, 0, 1);
    }

    if(var_26636d6cceb0d561 && !var_b043b98b8bea7cd5) {
      player function_abad79acb6b877e3(guy);
      player function_74d4d26b4326f8d9(guy);
      var_86128f5fcfd6f84e = player.spy_camera.var_b39b81c3f7c15eb2 + 400;
    }
  }

  player function_84d81270d17e50e6(var_f87a00cf05f988db);

  if(var_f87a00cf05f988db != player.spy_camera.var_f64fc6ca7d982bd4["\x97\xcd~\x10R~\xc7/P_\x8e0 R\xc4TU"]) {
    player.spy_camera.var_f64fc6ca7d982bd4["\x97\xcd~\x10R~\xc7/P_\x8e0 R\xc4TU"] = var_f87a00cf05f988db;
    function_a37137cc50e42fc5();
  }

  if(isDefined(player.spy_camera.var_7f465401144e8497)) {
    foreach(guy in player.spy_camera.var_7f465401144e8497) {
      if(!arraycontains(var_ea7f108ae9f56f6f, guy)) {
        guy.spy_camera.var_5e3fe616b0caaf21 = undefined;
      }
    }
  }

  player.spy_camera.var_7f465401144e8497 = var_ea7f108ae9f56f6f;
}

function private function_e323b0b8f116e92() {
  return self.spy_camera.var_4d7dfa239e50423c;
}

function private function_84d81270d17e50e6(tag_progress) {
  player = self;

  if(tag_progress > 0) {
    if(!isDefined(player.spy_camera.taggingsoundobject)) {
      player.spy_camera.taggingsoundobject = snd::play("x@\x04\xd8\x06\xf1\x1d\r\xdd\x81a\x1f:\xc5\x973$\xa6:\xaf");
    }

    return;
  }

  if(isDefined(player.spy_camera.taggingsoundobject)) {
    snd::stop(player.spy_camera.taggingsoundobject);
    player.spy_camera.taggingsoundobject = undefined;
  }
}

function private function_87693d564fcc18cb() {
  aspect_ratio = 1.77778;
  fov = function_25f3c3dc847f86e6() * (aspect_ratio - (aspect_ratio - 1) * 0.666);
  return fov;
}

function private function_f8f8ae094bf8be96(limited_candidates, var_995b5afa1fc13bb2, out_search_results) {
  var_3de11ed35ff0143d = 0;
  focus_dist = undefined;

  if(!isDefined(var_995b5afa1fc13bb2)) {
    var_995b5afa1fc13bb2 = spawnStruct();
  }

  if(isDefined(self.spy_camera) && isDefined(self.spy_camera.focus_dist)) {
    focus_dist = self.spy_camera.focus_dist;
  }

  fov = function_87693d564fcc18cb();
  var_5b9a62a5eca6b1e7 = cos(fov / 2);
  guys = limited_candidates;

  if(!isDefined(guys)) {
    guys = [];

    if(isDefined(self.spy_camera.scripted_ents)) {
      guys = self.spy_camera.scripted_ents;
    }

    foreach(team in self.spy_camera.var_be82f2379d8b5851) {
      teamactors = getaiarray(team);

      foreach(teamai in teamactors) {
        guys[guys.size] = teamai;
      }
    }

    if(istrue(self.spy_camera.var_70872322ed9d6748)) {
      fakeactors = getfakeaiarray();

      foreach(fakeai in fakeactors) {
        guys[guys.size] = fakeai;
      }
    }
  }

  foreach(guy in guys) {
    if(!isDefined(guy.spy_camera)) {
      guy.spy_camera = spawnStruct();
    }
  }

  eye_pos = self getEye();
  eye_dir = anglesToForward(self getplayerangles());
  var_f61ca78d8172ba07 = (eye_pos[0], eye_pos[1], 0);
  var_6281a6111643de50 = anglesToForward(self.angles);
  var_ea7f108ae9f56f6f = [];

  foreach(guy in guys) {
    fov_dot = var_5b9a62a5eca6b1e7;

    if(isDefined(guy.spy_camera.fov_scalar)) {
      fov_dot = cos(fov / 2 * guy.spy_camera.fov_scalar);
    }

    var_f0b9c1ef1ca2771f = (guy.origin[0], guy.origin[1], 0);
    var_8add99242e00cdd6 = vectordot(var_6281a6111643de50, vectorNormalize(var_f0b9c1ef1ca2771f - var_f61ca78d8172ba07));

    if(var_8add99242e00cdd6 < fov_dot) {
      function_9fbb69fd9c386e34(out_search_results, guy, 7, "K\xa1&\x06,`\x96\x7f\xf2\xd7\xadU\xf4\xe2y\xd5\xdaa*t");
      continue;
    }

    tag = var_995b5afa1fc13bb2.tag ?? guy.spy_camera.tag;
    guy_pos = guy.origin;

    if(isDefined(tag)) {
      guy_pos = guy gettagorigin(tag);
    } else if(guy tagexists("\xc7\xae?f\x10\xbcr")) {
      guy_pos = guy gettagorigin("\xc7\xae?f\x10\xbcr");
    } else {
      guy_pos = guy getcentroid();
    }

    guy_dot = vectordot(eye_dir, vectorNormalize(guy_pos - eye_pos));

    if(guy_dot < fov_dot) {
      function_9fbb69fd9c386e34(out_search_results, guy, 7, "K\xa1&\x06,`\x96\x7f\xf2\xd7\xadU\xf4\xe2y\xd5\xdaa*t");
      continue;
    }

    reticle_radius = var_995b5afa1fc13bb2.reticle_radius ?? guy.spy_camera.reticle_radius;

    if(isDefined(reticle_radius)) {
      if(!self worldpointinreticle_circle(guy_pos, fov, reticle_radius)) {
        function_9fbb69fd9c386e34(out_search_results, guy, 5, "\x9bC\xc67%\xddQr\xc6\xb18q\xd5e\x11\xf0\x7fO\xa7\xc8\xc2\xe1Q\xdb\xf6Q\x99\xfb\xf4\x82\xe3" + reticle_radius + "L");
        continue;
      }
    } else if(isDefined(guy.spy_camera.var_6e81fd6024f1ebd4) && isDefined(guy.spy_camera.var_cd1b3f1e9ba81425)) {
      if(!self worldpointinreticle_rect(guy_pos, fov, guy.spy_camera.var_6e81fd6024f1ebd4, guy.spy_camera.var_cd1b3f1e9ba81425)) {
        function_9fbb69fd9c386e34(out_search_results, guy, 6, "\x8f\xa2(-t\xfc\b\xf8\x93.\xa0\x99\xd2\x1e5?\x1b\xc6\xfc\a0Vkf\a\xbc!" + guy.spy_camera.var_6e81fd6024f1ebd4 + "\xf8\x01" + guy.spy_camera.var_cd1b3f1e9ba81425 + "L");
        continue;
      }
    }

    if(!istrue(var_995b5afa1fc13bb2.ignore_facing)) {
      var_b01320438f9b3387 = guy.spy_camera.var_b01320438f9b3387 ?? 0.125;
      guy_angles = guy gettagangles("\xc7\xae?f\x10\xbcr", 1);

      if(!isDefined(guy_angles)) {
        guy_angles = guy.angles;
      }

      guy_dot = vectordot(eye_dir, anglesToForward(guy_angles));

      if(guy_dot > 0 - var_b01320438f9b3387) {
        function_9fbb69fd9c386e34(out_search_results, guy, 8, "\xcbE\x16\x1c\t0\x0fcm\a\xb2'\xbc\xddo\xd3\xf3");
        continue;
      }
    }

    min_fov = var_995b5afa1fc13bb2.min_fov ?? guy.spy_camera.min_fov;

    if(isDefined(min_fov) && fov < min_fov) {
      function_9fbb69fd9c386e34(out_search_results, guy, 2, "\xa7o\xbd\xb6\x01:\xbd\xde\x02f\xc2\x93\xb0\x02\xcco\x9d\b[" + fov + "E\xf85\xc1k\avC\xa3\x03X\xe2\x81" + min_fov + "L");
      continue;
    }

    max_fov = var_995b5afa1fc13bb2.max_fov ?? guy.spy_camera.max_fov;

    if(isDefined(max_fov) && fov > max_fov) {
      function_9fbb69fd9c386e34(out_search_results, guy, 3, "W\x1f\xd7#\x1f\xc8&\x18\x18\xa8\xf2\x86\x87yA-\x16\xceR,\x1f\xeb" + fov + "\xa7\xb3\x1f\x89\xe44\xfe\x11\f\xd70w\xec" + max_fov + "L");
      continue;
    }

    var_6ac4acd8f4d77cef = var_995b5afa1fc13bb2.var_6ac4acd8f4d77cef ?? guy.spy_camera.var_6ac4acd8f4d77cef;

    if(isDefined(var_6ac4acd8f4d77cef) && isDefined(focus_dist) && abs(distance(guy.origin, self.origin) - focus_dist) > var_6ac4acd8f4d77cef) {
      function_9fbb69fd9c386e34(out_search_results, guy, 4, "\xc78\xe6D1aO\xbc\xc1\x9e5\x97\xff\xb34\xfe\xb4\xe5\x8d\xf0\x9e\x7f\xe0\xe0kd%[\xe7\x86\x8f\xf3\x19\x14\x1f\v\xf6" + var_6ac4acd8f4d77cef + "L\xfd=\xc1\x84\x162k>w~M`10" + focus_dist + "X\x0e\x1d4\xa4\xcb0\xfa\xf9Cx=\xafJ\xef\xd9" + distance(guy.origin, self.origin) + "L");
      continue;
    }

    guy.var_6b3ce0bfb823b734 = gettime();

    if(guy sightconetrace(eye_pos, self) > 0) {
      var_ea7f108ae9f56f6f = utility::array_add(var_ea7f108ae9f56f6f, guy);
      function_9fbb69fd9c386e34(out_search_results, guy, 10, "\x8d \xc9\x91\xf8j\xb7\x9a\xf2\xaf\xb6\xa2\xbd\xf9\xa0eU\xd9");
      continue;
    }

    function_9fbb69fd9c386e34(out_search_results, guy, 9, "laU\xd0\x1a\\\xbb!\xf0!\xba\xab\xa4\xe6IT");
  }

  return var_ea7f108ae9f56f6f;
}

function private function_9fbb69fd9c386e34(out_search_results, guy, result, dev_log) {
  if(isDefined(out_search_results)) {
    if(!isDefined(out_search_results.entries)) {
      out_search_results.entries = [];
    }

    new_entry = spawnStruct();
    new_entry.ent = guy;
    new_entry.result = result;

    new_entry.dev_log = dev_log;

    out_search_results.entries = utility::array_add(out_search_results.entries, new_entry);
  }
}

function function_ad174e955c4522c6(guy, var_52adf96f3823ec77, var_339c6406eb2260f1) {
  player = self;
  test_result = spawnStruct();
  test_result.success = 0;

  if(!player utility::ent_flag("\xa8\x15\r\xd9=u\xda\x88\xbf\xb1\x83]v\x84")) {
    test_result.result = 0;

    test_result.debug_message = "<dev string:x15e>";

    return test_result;
  }

  out_search_results = spawnStruct();
  var_ea7f108ae9f56f6f = function_f8f8ae094bf8be96([guy], var_52adf96f3823ec77, out_search_results);

  if(var_ea7f108ae9f56f6f.size > 0) {
    assert(var_ea7f108ae9f56f6f.size == 1 && var_ea7f108ae9f56f6f[0] == guy);
    test_result.success = 1;
  } else {
    test_result.success = 0;
  }

  assert(isDefined(out_search_results.entries));
  assert(out_search_results.entries.size == 1);
  assert(out_search_results.entries[0].ent == guy);
  test_result.result = out_search_results.entries[0].result;

  test_result.debug_message = out_search_results.entries[0].dev_log;

  if(isDefined(var_339c6406eb2260f1)) {
    player function_bb980f7b7c16eb28(test_result.success);
  }

  return test_result;
}

function function_b49892ef4fb53f58() {
  player = self;
  assert(isPlayer(player));
  player waittill("\xf3\x15\xfb\x80CD`\x16\xa5BR*\x0ew\xd4s\xff\xda\xfd", var_5516627ad8c86f44);
  return var_5516627ad8c86f44;
}

function function_5059edafb1a46bb1(allow_tagging, min_fov, max_fov, var_6ac4acd8f4d77cef, tag, reticle_radius, var_6e81fd6024f1ebd4, var_cd1b3f1e9ba81425, fov_scalar, var_b01320438f9b3387) {
  if(!isDefined(self.spy_camera)) {
    self.spy_camera = spawnStruct();
  }

  self.spy_camera.allow_tagging = allow_tagging;
  self.spy_camera.min_fov = min_fov;
  self.spy_camera.max_fov = max_fov;
  self.spy_camera.var_6ac4acd8f4d77cef = var_6ac4acd8f4d77cef;
  self.spy_camera.tag = tag;
  self.spy_camera.reticle_radius = reticle_radius;
  self.spy_camera.var_6e81fd6024f1ebd4 = var_6e81fd6024f1ebd4;
  self.spy_camera.var_cd1b3f1e9ba81425 = var_cd1b3f1e9ba81425;
  self.spy_camera.fov_scalar = fov_scalar;
  self.spy_camera.var_b01320438f9b3387 = var_b01320438f9b3387;
}

function function_bb442d3c214af7d5(var_3ce0871c11b09485) {
  player = utility_sp::get_player_from_self();

  if(!isDefined(player.spy_camera)) {
    player.spy_camera = spawnStruct();
  }

  if(!isDefined(player.spy_camera.scripted_ents)) {
    player.spy_camera.scripted_ents = [];
  }

  if(!isarray(var_3ce0871c11b09485)) {
    var_3ce0871c11b09485 = [var_3ce0871c11b09485];
  }

  player.spy_camera.scripted_ents = utility_sp::array_merge(player.spy_camera.scripted_ents, var_3ce0871c11b09485);
  utility::array_thread(var_3ce0871c11b09485, &function_5008fdbee0c97877, player);
}

function function_2d1fe216cdd3d40c(var_3ce0871c11b09485) {
  player = utility_sp::get_player_from_self();

  if(!isDefined(player.spy_camera.scripted_ents)) {
    player.spy_camera.scripted_ents = [];
  }

  if(!isarray(var_3ce0871c11b09485)) {
    var_3ce0871c11b09485 = [var_3ce0871c11b09485];
  }

  player.spy_camera.scripted_ents = utility::array_remove_array(player.spy_camera.scripted_ents, var_3ce0871c11b09485);
  utility_sp::array_notify(var_3ce0871c11b09485, "\xd8S\x020\x9d%\xf9k_rY\nX\x94\x84:EU\xf4\x01\xf5\x1a");
}

function spy_camera_deactivate() {
  if(isDefined(self.spy_camera.var_596b7f242077deb9)) {
    self modifybasefov(self.spy_camera.var_596b7f242077deb9, level.framedurationseconds);
    setsaveddvar(@ "hash_35877611dd87a107", 0);
    val::reset_all("r\v5wB\xfa\xa1\x96^l\xff\x19\xbd\rP\xc5$P");
    self.spy_camera.var_596b7f242077deb9 = undefined;
  }

  if(self isgestureplaying(self.spy_camera.ads_gesture)) {
    self stopgestureviewmodel(self.spy_camera.ads_gesture);
  }

  if(isDefined(self.spy_camera.var_77285e7734d9b90e)) {
    self.spy_camera.var_77285e7734d9b90e stoploopsound();
    self.spy_camera.var_77285e7734d9b90e delete();
    self.spy_camera.var_77285e7734d9b90e = undefined;
  }

  val::reset_all("\x1e\xf2O2\x17qN\x02\xb6B");
}

function private function_5008fdbee0c97877(player) {
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  player endon("\vsP\x1e\xb3\xd7z\xda\xf8[ Z\xd9\xd0\x1b\xebP\xbd\xd1\x1bzW");
  self endon("\xd8S\x020\x9d%\xf9k_rY\nX\x94\x84:EU\xf4\x01\xf5\x1a");
  self notify("\xacl5?\xa5\xec\x97n8\x97_\xa3\x06w\xd4\x8d\xdd01\f");
  self endon("\xacl5?\xa5\xec\x97n8\x97_\xa3\x06w\xd4\x8d\xdd01\f");
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\x83d\x9a\x12\xb9\x93B", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(self)) {
    player.spy_camera.scripted_ents = arrayremove(player.spy_camera.scripted_ents, self);
    return;
  }

  player.spy_camera.scripted_ents = utility::array_removeundefined(player.spy_camera.scripted_ents);
}
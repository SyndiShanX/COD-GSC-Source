/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c6562e198ffa6d3.gsc
*************************************************/

#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace ob_golden_ammo;

function function_93c0f40d62257166() {
  level thread function_d1d70c73f09a1540();

  level._effect["gold_ammo"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_mag_sparks.vfx");
  registersharedfunc("ob_golden_ammo", "set_goldenAmmo", &set_goldenammo);
  registersharedfunc("ob_golden_ammo", "unset_goldenAmmo", &unset_goldenammo);
}

function set_goldenammo() {
  if(istrue(self.hasgoldenammo)) {
    if(function_b3698dc11254f342(self.currentweapon)) {
      iprintlnbold("<dev string:x1c>");

      function_ea51eda9b53c4482();
      return;
    }

    if(istrue(self.goldenammoset)) {
      self setclientomnvar("ui_ob_gold_ammo_counter", 1);
      function_51146b41a3a6c211();
      self setperk("specialty_ammodrainsfromstockfirst", 1);

      iprintlnbold("<dev string:x3e>");

      return;
    }
  } else {
    self.hasgoldenammo = 1;
    self notify("golden_ammo_set");
    thread function_6874d729f66e8fe5();
    thread function_5b5c4a75d3003a7f();
    thread function_d5037faa8258bf74();

    if(function_b3698dc11254f342(self.currentweapon)) {
      iprintlnbold("<dev string:x1c>");

      return;
    }
  }

  self setclientomnvar("ui_ob_gold_ammo_counter", 1);
  function_51146b41a3a6c211();

  iprintlnbold("<dev string:x5c>");

  self setperk("specialty_ammodrainsfromstockfirst", 1);
  self.goldenammoset = 1;
}

function function_a122777d501aabca() {
  hasclip = 0;
  attachment_models = getweaponattachmentworldmodels(self.currentweapon);

  if(!isDefined(attachment_models)) {
    return 0;
  }

  foreach(attachment_model in attachment_models) {
    part_num = getnumparts(attachment_model);

    for(i = 0; i < part_num; i++) {
      if(getpartname(attachment_model, i) == "tag_mag_attach") {
        hasclip = 1;
        break;
      }
    }
  }

  return hasclip;
}

function function_51146b41a3a6c211() {
  self setscriptablepartstate("golden_ammo_fx", "off", 0);

  if(!function_b3698dc11254f342(self.currentweapon)) {
    if(function_a122777d501aabca()) {
      self setscriptablepartstate("golden_ammo_fx", "on", 0);
      return;
    }

    self setscriptablepartstate("golden_ammo_fx", "on_no_clip", 0);
  }
}

function function_5b5c4a75d3003a7f() {
  self endon("disconnect");
  self endon("golden_ammo_unset");
  self endon("golden_ammo_set");

  while(istrue(self.hasgoldenammo)) {
    self waittill("weapon_change");
    self setscriptablepartstate("golden_ammo_fx", "off", 0);
    waitframe();
    set_goldenammo();
  }
}

function function_6874d729f66e8fe5() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("golden_ammo_unset");
  self endon("golden_ammo_set");
  self waittill("last_stand_revived");

  while(!isalive(self)) {
    waitframe();
  }

  self.goldenammoset = 0;
  set_goldenammo();
}

function function_d5037faa8258bf74() {
  self endon("disconnect");
  self endon("golden_ammo_unset");
  self endon("golden_ammo_set");

  while(istrue(self.hasgoldenammo)) {
    self waittill("weapon_change", newweapon);

    if(isweaponequipment(newweapon)) {
      continue;
    }

    if(function_b3698dc11254f342(newweapon)) {
      self setclientomnvar("ui_ob_gold_ammo_counter", 0);
    } else {
      self setclientomnvar("ui_ob_gold_ammo_counter", 1);
    }

    waitframe();
  }
}

function unset_goldenammo() {
  self.hasgoldenammo = 0;
  self notify("golden_ammo_unset");
  self unsetperk("specialty_ammodrainsfromstockfirst", 1);
  self.goldenammoset = 0;
  self setclientomnvar("ui_ob_gold_ammo_counter", 0);
  self setscriptablepartstate("golden_ammo_fx", "off", 0);

  iprintlnbold("<dev string:x6f>");
}

function function_ea51eda9b53c4482() {
  if(!istrue(self.goldenammoset)) {
    return;
  }

  self unsetperk("specialty_ammodrainsfromstockfirst", 1);
  self.goldenammoset = 0;
  self setclientomnvar("ui_ob_gold_ammo_counter", 0);

  iprintlnbold("<dev string:x84>");
}

function function_b3698dc11254f342(weapon) {
  switch (weapon.basename) {
    case #"hash_87262a67e163f7c9":
      return true;
    case #"hash_868281a9f2456993":
      return true;
    default:
      break;
  }

  return weapon::iswonderweapon(weapon) || weapon.ismelee;
}

function function_7c7d7717c1af82bf(params) {
  foreach(player in level.players) {
    player unset_goldenammo();
  }
}

function function_d1d70c73f09a1540() {
  function_6e7290c8ee4f558b("<dev string:xa8>");
  devgui::function_b23a59dfb4ca49a1("<dev string:xc0>", "<dev string:xd4>", &scripts\cp_mp\loot\common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:xfc>", "<dev string:x11a>", &scripts\cp_mp\loot\common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x157>", "<dev string:x176>", &scripts\cp_mp\loot\common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x1ba>", "<dev string:x1da>", &function_7c7d7717c1af82bf);
  function_fe953f000498048f();
}

# /
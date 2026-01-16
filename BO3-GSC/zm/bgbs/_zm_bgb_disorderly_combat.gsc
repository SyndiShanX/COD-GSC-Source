/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_disorderly_combat.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_bgb_disorderly_combat;

function autoexec __init__sytem__() {
  system::register("zm_bgb_disorderly_combat", & __init__, & __main__, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_disorderly_combat", "time", 300, & enable, & disable, undefined, undefined);
  bgb::function_2060b89("zm_bgb_disorderly_combat");
  level.var_8fcdc919 = [];
  level.var_5013e65c = [];
}

function __main__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  function_32710943();
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  self function_7039f685();
}

function disable() {
  function_bd7f98af();
}

function function_32710943() {
  var_dd341085 = getarraykeys(level.zombie_weapons);
  foreach(var_134a15b0 in var_dd341085) {
    var_134a15b0 function_32818605();
  }
  if(isdefined(level.aat)) {
    level.var_5013e65c = getarraykeys(level.aat);
    arrayremovevalue(level.var_5013e65c, "none");
  }
}

function function_a2ab8d19(var_390e457) {
  arrayremovevalue(level.var_8fcdc919, var_390e457);
}

function function_32818605() {
  if(!self.ismeleeweapon && !self.isgrenadeweapon && !self function_f0cecf3c()) {
    array::add(level.var_8fcdc919, self, 0);
  }
}

function function_7039f685() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  level.var_8fcdc919 = array::randomize(level.var_8fcdc919);
  self setperk("specialty_ammodrainsfromstockfirst");
  self thread disable_weapons();
  self.get_player_weapon_limit = & function_7087df78;
  self util::waittill_either("weapon_change_complete", "bgb_flavor_hexed_give_zm_bgb_disorderly_combat");
  if(!isdefined(self.var_fe555a38)) {
    self.var_fe555a38 = self getcurrentweapon();
  }
  b_upgraded = zm_weapons::is_weapon_upgraded(self.var_fe555a38);
  var_6c94ea19 = self aat::getaatonweapon(self.var_fe555a38);
  if(isdefined(var_6c94ea19)) {
    function_c7d73bac(var_6c94ea19.name);
  }
  if(isdefined(self.aat) && self.aat.size) {
    self.var_cc73883d = arraycopy(self.aat);
    self.aat = [];
  }
  n_index = 0;
  var_1ff6fb34 = 0;
  while (true) {
    self bgb::function_378bff5d();
    self function_8a5ef15f();
    if(isdefined(self.var_8cee13f3)) {
      if(self hasweapon(self.var_8cee13f3)) {
        self takeweapon(self.var_8cee13f3);
      } else {
        self takeweapon(self getcurrentweapon());
      }
    }
    self playsoundtoplayer("zmb_bgb_disorderly_weap_switch", self);
    if(isdefined(var_6c94ea19) && level.var_5013e65c.size) {
      var_77bd95a = level.var_5013e65c[var_1ff6fb34];
      var_1ff6fb34++;
      if(var_1ff6fb34 >= level.var_5013e65c.size) {
        level.var_5013e65c = array::randomize(level.var_5013e65c);
        var_1ff6fb34 = 0;
      }
    }
    do {
      var_aca7cde1 = self function_4035ce17(n_index, b_upgraded, var_77bd95a);
      n_index++;
    }
    while (!var_aca7cde1);
    self thread function_dedb7bff();
    wait(10);
  }
}

function function_dedb7bff() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  wait(5);
  self playsoundtoplayer("zmb_bgb_disorderly_5seconds", self);
}

function disable_weapons() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  while (true) {
    waittillframeend();
    self disableweaponcycling();
    self disableoffhandweapons();
    wait(0.05);
  }
}

function function_4035ce17(n_index, b_upgraded, var_77bd95a) {
  if(n_index >= level.var_8fcdc919.size) {
    level.var_8fcdc919 = array::randomize(level.var_8fcdc919);
    n_index = 0;
  }
  var_e3c04036 = level.var_8fcdc919[n_index];
  if(b_upgraded) {
    var_e3c04036 = zm_weapons::get_upgrade_weapon(var_e3c04036);
  }
  if(!self has_weapon(var_e3c04036)) {
    var_e3c04036 = self zm_weapons::give_build_kit_weapon(var_e3c04036);
    self.var_8cee13f3 = var_e3c04036;
    self giveweapon(var_e3c04036);
    self shoulddoinitialweaponraise(var_e3c04036, 0);
    self switchtoweaponimmediate(var_e3c04036);
    if(isdefined(var_77bd95a) && var_77bd95a != "none") {
      self thread aat::acquire(var_e3c04036, var_77bd95a);
    }
    self bgb::do_one_shot_use(1);
    return true;
  }
  println("" + var_e3c04036.displayname);
  return false;
}

function function_f0cecf3c() {
  switch (self.name) {
    case "ar_marksman":
    case "launcher_standard":
    case "none":
    case "pistol_burst":
    case "pistol_c96":
    case "pistol_m1911":
    case "pistol_revolver38":
    case "sniper_fastbolt":
    case "sniper_powerbolt": {
      return true;
      break;
    }
  }
  if(zm_weapons::is_wonder_weapon(self) || level.start_weapon == self) {
    return true;
  }
  return false;
}

function function_bd7f98af() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update_give_" + "zm_bgb_disorderly_combat");
  self thread function_be4232bc();
  self unsetperk("specialty_ammodrainsfromstockfirst");
  self function_8a5ef15f();
  if(isdefined(self.var_8cee13f3) && self hasweapon(self.var_8cee13f3)) {
    self takeweapon(self.var_8cee13f3);
    self.var_8cee13f3 = undefined;
  }
  self.get_player_weapon_limit = undefined;
  if(isdefined(self.var_fe555a38)) {
    self zm_weapons::switch_back_primary_weapon(self.var_fe555a38);
  }
  self enableweaponcycling();
  self enableoffhandweapons();
  self.var_fe555a38 = undefined;
  if(isdefined(self.var_cc73883d)) {
    self.aat = arraycopy(self.var_cc73883d);
    self.var_cc73883d = undefined;
  }
  self notify("hash_46a5bae0");
}

function function_be4232bc() {
  self endon("hash_46a5bae0");
  self waittill("bled_out");
  self.var_8cee13f3 = undefined;
  self.var_fe555a38 = undefined;
}

function function_1f90c35a() {
  if(isdefined(level.var_464197de)) {
    return self[[level.var_464197de]]();
  }
  return 0;
}

function function_8a5ef15f() {
  while (self.is_drinking > 0 || zm_utility::is_placeable_mine(self.currentweapon) || zm_equipment::is_equipment(self.currentweapon) || self zm_utility::is_player_revive_tool(self.currentweapon) || level.weaponnone == self.currentweapon || self zm_equipment::hacker_active() || self laststand::player_is_in_laststand() || self function_1f90c35a()) {
    wait(0.05);
  }
}

function function_c7d73bac(str_name) {
  arrayremovevalue(level.var_5013e65c, str_name);
  level.var_5013e65c = array::randomize(level.var_5013e65c);
  if(!isdefined(level.var_5013e65c)) {
    level.var_5013e65c = [];
  } else if(!isarray(level.var_5013e65c)) {
    level.var_5013e65c = array(level.var_5013e65c);
  }
  level.var_5013e65c[level.var_5013e65c.size] = str_name;
}

function has_weapon(var_382bb75) {
  a_weapons = self getweaponslistprimaries();
  w_base = zm_weapons::get_base_weapon(var_382bb75);
  if(self hasweapon(w_base, 1)) {
    return true;
  }
  var_7321b53b = zm_weapons::get_upgrade_weapon(var_382bb75);
  if(self hasweapon(var_7321b53b, 1)) {
    return true;
  }
  return false;
}

function function_7087df78(e_player) {
  var_dd27188c = 2;
  if(e_player hasperk("specialty_additionalprimaryweapon")) {
    var_dd27188c = level.additionalprimaryweapon_limit;
  }
  var_dd27188c++;
  return var_dd27188c;
}
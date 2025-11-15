/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace genesis_achievements;

function autoexec __init__sytem__() {
  system::register("zm_genesis_achievements", & __init__, undefined, undefined);
}

function __init__() {
  level thread function_c190d113();
  level thread function_902aff55();
  callback::on_connect( & on_player_connect);
  zm_spawner::register_zombie_death_event_callback( & function_71e89ea4);
}

function on_player_connect() {
  self thread function_4d2d1f7a();
  self thread function_553e6274();
  self thread function_7d947aff();
  self thread achievement_wardrobe_change();
  self thread function_e3cc5d03();
  self thread function_c77b5630();
}

function function_c190d113() {
  level waittill("hash_91a3107");
  array::run_all(level.players, & giveachievement, "ZM_GENESIS_EE");
}

function function_902aff55() {
  level waittill("hash_154abf47");
  array::run_all(level.players, & giveachievement, "ZM_GENESIS_SUPER_EE");
}

function function_4d2d1f7a() {
  level waittill("apotho_pack_freed");
  self giveachievement("ZM_GENESIS_PACKECTOMY");
}

function function_553e6274() {
  level endon("end_game");
  self endon("disconnect");
  self.var_71148446 = [];
  self.var_71148446[0] = "mechz";
  self.var_71148446[1] = "zombie";
  self.var_71148446[2] = "parasite";
  self.var_71148446[3] = "spider";
  self.var_71148446[4] = "margwa";
  self.var_71148446[5] = "keeper";
  self.var_71148446[6] = "apothicon_fury";
  self thread function_3c82f182();
}

function function_3c82f182() {
  while(self.var_71148446.size > 0) {
    self waittill("hash_af442f7c");
  }
  self giveachievement("ZM_GENESIS_KEEPER_ASSIST");
}

function function_817b1327() {
  level endon("end_game");
  self endon("disconnect");
  self endon("hash_720f4d71");
  var_ef6b3d38 = 0;
  while(true) {
    level waittill("beam_killed_zombie", e_attacker);
    if(e_attacker === self) {
      var_ef6b3d38++;
    }
    if(var_ef6b3d38 >= 40) {
      self giveachievement("ZM_GENESIS_DEATH_RAY");
      return;
    }
  }
}

function function_7d947aff() {
  level endon("end_game");
  self endon("disconnect");
  self.var_88f45a31 = [];
  self.var_88f45a31[self.var_88f45a31.size] = "start_island";
  self.var_88f45a31[self.var_88f45a31.size] = "prison_island";
  self.var_88f45a31[self.var_88f45a31.size] = "asylum_island";
  self.var_88f45a31[self.var_88f45a31.size] = "temple_island";
  self.var_88f45a31[self.var_88f45a31.size] = "prototype_island";
  self thread function_935679b0();
  while(self.var_88f45a31.size > 0) {
    self waittill("hash_421672a9");
  }
  self giveachievement("ZM_GENESIS_GRAND_TOUR");
  self.var_88f45a31 = undefined;
  self notify("hash_2bec714");
}

function function_935679b0() {
  level endon("end_game");
  self endon("disconnect");
  self endon("hash_2bec714");
  while(!isDefined(self.var_a3d40b8)) {
    util::wait_network_frame();
  }
  var_e274e0c3 = self.var_a3d40b8;
  self thread function_f17c9ba1();
  while(true) {
    if(isDefined(self.var_a3d40b8) && var_e274e0c3 != self.var_a3d40b8) {
      self thread function_f17c9ba1();
      var_e274e0c3 = self.var_a3d40b8;
      self notify("hash_421672a9");
    }
    wait(randomfloatrange(0.5, 1));
  }
}

function function_f17c9ba1() {
  level endon("end_game");
  self endon("disconnect");
  self endon("hash_2bec714");
  var_a43542cc = self.var_a3d40b8;
  if(isDefined(var_a43542cc) && isinarray(self.var_88f45a31, var_a43542cc)) {
    arrayremovevalue(self.var_88f45a31, var_a43542cc);
  } else {
    return;
  }
  self waittill("hash_421672a9");
  wait(120);
  if(isDefined(self.var_88f45a31)) {
    array::add(self.var_88f45a31, var_a43542cc, 0);
  }
}

function achievement_wardrobe_change() {
  level endon("end_game");
  self endon("disconnect");
  var_fc2fd82c = [];
  while(true) {
    self waittill("changed_wearable", var_475b0a4e);
    array::add(var_fc2fd82c, var_475b0a4e, 0);
    if(var_fc2fd82c.size >= 3) {
      self giveachievement("ZM_GENESIS_WARDROBE_CHANGE");
      return;
    }
  }
}

function function_e3cc5d03() {
  self waittill("hash_86cee34e");
  self giveachievement("ZM_GENESIS_WONDERFUL");
}

function function_c77b5630() {
  level flagsys::wait_till("start_zombie_round_logic");
  level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
  if(level.round_number <= 6) {
    self giveachievement("ZM_GENESIS_CONTROLLED_CHAOS");
  }
}

function function_71e89ea4(e_attacker) {
  if(isDefined(self.damageweapon) && zm_weapons::is_wonder_weapon(self.damageweapon)) {
    if(issubstr(self.damageweapon.name, "thundergun")) {
      if(!isDefined(e_attacker.var_2831078e)) {
        e_attacker.var_2831078e = 0;
      }
      e_attacker.var_2831078e++;
    } else if(issubstr(self.damageweapon.name, "idgun")) {
      if(!isDefined(e_attacker.var_29bc01fd)) {
        e_attacker.var_29bc01fd = 0;
      }
      e_attacker.var_29bc01fd++;
    }
    if(isDefined(e_attacker.var_29bc01fd) && e_attacker.var_29bc01fd >= 10 && (isDefined(e_attacker.var_2831078e) && e_attacker.var_2831078e >= 10)) {
      e_attacker notify("hash_86cee34e");
    }
  }
}
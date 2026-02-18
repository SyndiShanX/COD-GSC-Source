/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3e5784d8fa74c940.gsc
***********************************************/

#using script_24c32478acf44108;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_a5ef5769;

function private autoexec __init__system__() {
  system::register(#"hash_52556758a0c8acfe", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.ray_rifle = getweapon(#"ww_ray_rifle_t9");
  level.var_a467bdbc = getweapon(#"hash_ac86d29509a8939");
  level.ray_rifle_upgraded = getweapon(#"ww_ray_rifle_t9_upgraded");
  level.var_3415bf61 = getweapon(#"hash_493fc891e20b4f8a");

  if(!isDefined(level.var_3afb1303)) {
    level.var_3afb1303 = [];
  } else if(!isarray(level.var_3afb1303)) {
    level.var_3afb1303 = array(level.var_3afb1303);
  }

  aiutility::function_254912d7(#"ww_ray_rifle_t9", "MOD_PROJECTILE");
  aiutility::function_254912d7(#"ww_ray_rifle_t9_upgraded", "MOD_PROJECTILE");
  weaponobjects::function_e6400478(#"ww_ray_rifle_t9", &function_5acf1bb9, 1);
  weaponobjects::function_e6400478(#"ww_ray_rifle_t9_upgraded", &function_5acf1bb9, 1);
  zombie_utility::add_zombie_gib_weapon_callback(#"hash_ac86d29509a8939", &function_81027f3e, &function_81027f3e);
  callback::add_weapon_fired(level.ray_rifle, &function_a70ad564);
  callback::add_weapon_fired(level.var_a467bdbc, &function_43a02dae);
  callback::add_weapon_fired(level.ray_rifle_upgraded, &function_a70ad564);
  callback::add_weapon_fired(level.var_3415bf61, &function_43a02dae);
  clientfield::register("scriptmover", "" + # "hash_47e7d5219a26a786", 16000, 3, "int");
  clientfield::register("actor", "" + # "hash_3a47820a21ce3170", 16000, 2, "int");
  clientfield::register("allplayers", "" + # "hash_7508e13e17dd1e3c", 16000, 4, "int");
  namespace_9ff9f642::register_slowdown(#"hash_5c37161904f4bcc9", 0.8, 3);
  namespace_9ff9f642::register_slowdown(#"hash_21cb91304fde349a", 0.5, 5);
  callback::on_weapon_change(&function_54e9969b);
  callback::on_ai_killed(&function_65ba5ec2);
  zm_weapons::function_90953640(level.var_a467bdbc, 5, float(function_60d95f53()) / 1000);
  level.var_c09dd754 = 0;

  if(zm_utility::is_survival()) {
    level.var_1a4cc228[# "hash_7cba8a05511ceedf"] = [# "hash_49adea61f71924bf", #"hash_1798ecca7f98873d", #"hash_26f6708ef92a0eae", #"hash_1c8805fec5806efe", #"hash_4d95f42b33499eba", #"hash_6799427e5e6c417c", #"hash_11e4908180a964c", #"hash_1340313347e93335"];
    level.var_1a4cc228[# "hash_29771ab26cb78d9b"] = [# "hash_69143c727337ba1a", #"hash_299e8cfa6d75ffd4", #"hash_7d223eb036f4a31b", #"hash_11d7f39f088f3822", #"hash_5e074c09a3a31d97", #"hash_1c437f787033a2e5", #"hash_34d9e63476111b5d", #"hash_779daa809936d578"];
    level.var_1a4cc228[# "hash_46c917a1b5ed91e7"] = [# "hash_4729aed4cfa43476"];
    level.var_1a4cc228[# "hash_338eb4103e0ed797"] = [# "hash_59e40ffcdcfbffa6"];
    level.var_1a4cc228[# "hash_124b582ce08d78c0"] = [# "hash_149fa86a9c5d858c", #"hash_63e9d6f275dc720", #"hash_94674cb554826a9", #"hash_6b9e4c8e8e955c71", #"hash_75cfd69ce1d6f3dd", #"hash_33c0e923173d2b48", #"hash_53dbc62471a61f88", #"hash_4ece13caf46c00c7"];
    level.var_1a4cc228[# "hash_30e4941b102093c4"] = [# "hash_5c0dcc3f9d9e1ea5", #"hash_e8b647bb58521c1", #"hash_23492308d6911444", #"hash_5616978b668f07dc", #"hash_31713e12a88def10", #"hash_3e647996c0a4d6b9", #"hash_b35b3dcb7417075", #"hash_53dbc62471a61f88"];
    level.var_1a4cc228[# "hash_78215fa79f5557dc"] = [# "hash_4814b7b3c67568e3"];
    level.var_1a4cc228[# "hash_12a17ab3df5889eb"] = level.var_1a4cc228[# "hash_78215fa79f5557dc"];
    level.var_1a4cc228[# "hash_7a8b592728eec95d"] = [# "hash_2cb37314243526ec"];
    level.var_1a4cc228[# "spawner_zm_steiner_split_radiation_bomb"] = [# "hash_614e3d7d0b75a944"];
    level.var_1a4cc228[# "spawner_zm_steiner_split_radiation_blast"] = [# "hash_53c08317d48a0e49"];
    level.var_1a4cc228[# "hash_6904f5c7bef64405"] = [# "hash_5eafd160d077670d"];
    level.var_1a4cc228[# "hash_7f957e36b4f6160f"] = [# "hash_61df3be05096e9e2"];
    level.var_1a4cc228[# "hash_729b116cf9d044"] = [# "hash_78238b400ae08c28"];
    return;
  }

  if(util::get_map_name() == "zm_gold") {
    level.var_1a4cc228[# "spawner_bo5_zombie_zm_gold"] = [# "hash_a80d8840eaa4e7e", #"hash_36991df55c87dbcb", #"hash_3b5927d61466dc58", #"hash_735b3e8785d43fdb", #"hash_e3b20622eb68c2b", #"hash_1b6585308f85be40", #"hash_15e17500f1c8d0e9", #"hash_63d74789d0b11dbc"];
    level.var_1a4cc228[# "spawner_bo5_zombie_zm_gold_armor_heavy"] = [# "hash_4729aed4cfa43476"];
    level.var_1a4cc228[# "spawner_bo5_zombie_zm_gold_armor_medium"] = [# "hash_59e40ffcdcfbffa6"];
    level.var_1a4cc228[# "hash_5765ccddce11dc6c"] = [# "hash_1c89bc2d12106779", #"hash_78a973a6fb604cf", #"hash_1c8805fec5806efe", #"hash_7b3bac29e8e3bf13", #"hash_7151a0027b3ff314", #"hash_35d84238103deb46", #"hash_5c0dcc3f9d9e1ea5", #"hash_2d07ee0d2dca46d9"];
    level.var_1a4cc228[# "hash_78215fa79f5557dc"] = [# "hash_2cb37314243526ec"];
    level.var_1a4cc228[# "hash_7a8b592728eec95d"] = level.var_1a4cc228[# "hash_78215fa79f5557dc"];
  }
}

function postinit() {
  zm_weapons::function_8389c033(#"ww_ray_rifle_t9", #"ww_ray_rifle_t9");
  zm_weapons::function_8389c033(#"ww_ray_rifle_t9", #"ray_gun");
  zm_weapons::function_8389c033(#"ray_gun", #"ww_ray_rifle_t9");
}

function event_handler[reload] function_b4174270(eventstruct) {
  self function_48d53ca0();
}

function function_48d53ca0() {
  current_weapon = self getcurrentweapon();

  if(!function_2715ee2d(current_weapon)) {
    return;
  }

  var_f0d6790a = function_4f6da2be(current_weapon);

  if(function_4f6da2be(current_weapon)) {
    if(self getweaponammoclip(current_weapon) >= 10) {
      self function_d4759f13(1, function_4ba529a7(current_weapon), 1);
    }

    return;
  }

  self function_d4759f13(1, function_4ba529a7(current_weapon), 0);
}

function function_a70ad564(weapon) {
  if(self getweaponammoclip(weapon) < 1) {
    self function_d4759f13(0, function_4ba529a7(weapon), 0);
  }
}

function function_43a02dae(weapon) {
  if(self getweaponammoclip(weapon) < 10) {
    self function_d4759f13(0, function_4ba529a7(weapon), 1);
  }
}

function function_4ba529a7(weapon) {
  if(isDefined(weapon)) {
    var_1236db9d = zm_weapons::function_386dacbc(weapon).name;

    switch (var_1236db9d) {
      case # "ww_ray_rifle_t9_upgraded":
      case # "hash_493fc891e20b4f8a":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function function_d4759f13(ammo_state, var_a444fb = 0, var_93eafdc0 = 0) {
  if(var_a444fb) {
    ammo_state += 4;
  }

  if(var_93eafdc0) {
    ammo_state += 8;
  }

  self clientfield::set("" + # "hash_7508e13e17dd1e3c", ammo_state);
}

function function_2715ee2d(weapon) {
  return function_cbd0f11(weapon) || function_4f6da2be(weapon);
}

function function_cbd0f11(weapon) {
  if(isDefined(weapon)) {
    var_1236db9d = zm_weapons::function_386dacbc(weapon).name;

    switch (var_1236db9d) {
      case # "ww_ray_rifle_t9_upgraded":
      case # "ww_ray_rifle_t9":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function function_4f6da2be(weapon) {
  if(isDefined(weapon)) {
    var_1236db9d = zm_weapons::function_386dacbc(weapon).name;

    switch (var_1236db9d) {
      case # "hash_ac86d29509a8939":
      case # "hash_493fc891e20b4f8a":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function function_42807ff9() {
  self endon(#"death", #"hash_5240d2339d9ab0cd");
  var_17b7891d = "78938d0458bdc0fc" + "ray_rifle_reload";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    result = self waittill(#"reload_start");
    self function_d4759f13(0);
  }
}

function function_46649524() {
  self endon(#"death", #"hash_9f58c5008141d94");
  var_17b7891d = "11bbdb4af90f3d04" + "ray_rifle_melee";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  while(true) {
    if(!self ismeleeing()) {
      waitframe(1);
      continue;
    }

    while(self ismeleeing()) {
      waitframe(1);
    }

    self function_48d53ca0();
  }
}

function function_54e9969b(params) {
  var_caf81a76 = function_2715ee2d(params.weapon);
  var_b3d1c0bd = function_2715ee2d(params.last_weapon);

  if(var_caf81a76) {
    if(!var_b3d1c0bd) {
      self setactionslot(1, "altmode");
      self thread function_42807ff9();
      self thread function_46649524();

      if(!is_true(self.var_a3eedf85)) {
        self thread zm_equipment::show_hint_text(#"hash_1e6f4f9ae3fb106f");
        self.var_a3eedf85 = 1;
      }
    }

    var_5706eda6 = function_4f6da2be(params.weapon);
    var_2ccb1704 = var_5706eda6 ? 10 : 1;

    if(self getweaponammoclip(params.weapon) >= var_2ccb1704) {
      self function_d4759f13(1, function_4ba529a7(params.weapon), var_5706eda6);
    } else {
      self function_d4759f13(0);
    }

    return;
  }

  if(!function_2715ee2d(params.weapon) && function_2715ee2d(params.last_weapon)) {
    self setactionslot(1, "");
    self notify(#"hash_5240d2339d9ab0cd");
    self notify(#"hash_9f58c5008141d94");
    self function_d4759f13(2);
  }
}

function function_81027f3e(damage_percent) {
  return false;
}

function function_5acf1bb9(watcher) {
  watcher.onspawn = &function_121b803f;
}

function function_121b803f(watcher, player) {
  if(isDefined(player)) {
    var_deaac196 = player getcurrentweapon();

    if(function_cbd0f11(var_deaac196)) {
      if(!isDefined(self.var_6ccc858c)) {
        self.var_6ccc858c = [];
      } else if(!isarray(self.var_6ccc858c)) {
        self.var_6ccc858c = array(self.var_6ccc858c);
      }

      self function_98175f42(watcher, player);

      if(self.var_6ccc858c.size > 0) {
        self thread function_bb80aad0();
      }

      return;
    }

    if(function_4f6da2be(var_deaac196)) {
      var_23130969 = player function_4a074587(var_deaac196);
      self thread function_8376de9c(player, var_23130969);
      self thread watch_for_death(player, var_23130969);
    }
  }
}

function function_98175f42(watcher, player) {
  foreach(vortex in level.var_3afb1303) {
    if(!isDefined(vortex)) {
      continue;
    }

    var_b2c0e3d5 = vortex.origin - self.origin;
    var_b9fb2cb5 = vectorprojection(var_b2c0e3d5, self.var_59ba00f5);
    var_8a98d89 = self.origin + var_b9fb2cb5;
    z_diff = abs(var_8a98d89[2] - vortex.var_13015f04[2]);

    if(z_diff > 28) {
      continue;
    }

    var_37f36aee = distance2dsquared(var_8a98d89, vortex.var_13015f04);

    if(var_37f36aee <= 225) {
      var_7dcfceb3 = spawnStruct();
      var_7dcfceb3.var_7ef7dc23 = vortex;

      if(self.var_59ba00f5[0] != 0) {
        hit_time = var_b9fb2cb5[0] / self.var_59ba00f5[0];
      } else if(self.var_59ba00f5[1] != 0) {
        hit_time = var_b9fb2cb5[1] / self.var_59ba00f5[1];
      } else {
        hit_time = var_b9fb2cb5[2] / self.var_59ba00f5[2];
      }

      var_7dcfceb3.var_a31e9c2 = int(hit_time / float(function_60d95f53()) / 1000);

      if(!isDefined(self.var_6ccc858c)) {
        self.var_6ccc858c = [];
      } else if(!isarray(self.var_6ccc858c)) {
        self.var_6ccc858c = array(self.var_6ccc858c);
      }

      self.var_6ccc858c[self.var_6ccc858c.size] = var_7dcfceb3;
    }
  }
}

function function_bb80aad0() {
  self endon(#"death");
  current_frame = 0;
  var_a8024c64 = 0;

  while(true) {
    foreach(var_7dcfceb3 in self.var_6ccc858c) {
      if(var_7dcfceb3.var_a31e9c2 == current_frame) {
        if(isDefined(var_7dcfceb3.var_7ef7dc23)) {
          var_7dcfceb3.var_7ef7dc23 notify(#"ray_hit");
        }

        var_a8024c64++;

        if(var_a8024c64 >= self.var_6ccc858c.size) {
          break;
        }
      }
    }

    waitframe(1);
    current_frame++;
  }
}

function watch_for_death(owner, var_23130969) {
  self waittilltimeout(3, #"death");

  if(isDefined(self)) {
    self function_1c204e87(owner, var_23130969);
  }
}

function function_8376de9c(owner, var_23130969) {
  self endon(#"death");
  self util::waittillnotmoving();
  self function_1c204e87(owner, var_23130969);
}

function function_1c204e87(owner, var_23130969) {
  if(isentity(self) && !is_true(self.var_274896bb)) {
    self.var_274896bb = 1;
    self detonate(owner);
    function_b80325b1(owner, self.origin, var_23130969);
  }
}

function function_b80325b1(owner, position, var_23130969) {
  dir_up = (0, 0, 1);
  var_7ef7dc23 = spawn("script_model", position);
  var_7ef7dc23 setModel("tag_origin");
  var_7ef7dc23.is_active = 1;
  var_7ef7dc23.var_745ae857 = 0;
  var_7ef7dc23.var_669f67cf = 0;
  var_7ef7dc23.exploded = 0;
  var_7ef7dc23.var_bc60b6e0 = 1;
  var_7ef7dc23.var_23130969 = var_23130969;
  var_7ef7dc23.var_13015f04 = position + (0, 0, 28);

  if(getdvarint(#"hash_49e9d3375f091d35", 0)) {
    cylinder(var_7ef7dc23.origin, var_7ef7dc23.origin + (0, 0, 56), 15, (0, 1, 0), 0, 60);
  }

  if(!isDefined(level.var_3afb1303)) {
    level.var_3afb1303 = [];
  } else if(!isarray(level.var_3afb1303)) {
    level.var_3afb1303 = array(level.var_3afb1303);
  }

  level.var_3afb1303[level.var_3afb1303.size] = var_7ef7dc23;
  arrayremovevalue(level.var_3afb1303, undefined);
  var_7ef7dc23 function_b198b062(1);

  var_7ef7dc23 function_6a0ad00("<dev string:x38>");

  if(isDefined(owner)) {
    var_7ef7dc23 setteam(owner.team);

    if(isPlayer(owner)) {
      var_7ef7dc23 setowner(owner);
      var_7ef7dc23.owner = owner;
    }
  }

  var_7ef7dc23 thread function_d60a354c();
  var_7ef7dc23 thread function_646f5566();
  var_7ef7dc23 thread function_70240b1b();
}

function function_646f5566() {
  level endon(#"end_game");
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"ray_hit");

    if(!isDefined(self) || !self.is_active) {
      return;
    }

    if(self.var_669f67cf == 0) {
      self notify(#"ray_hit");
    }

    self.var_669f67cf++;

    if(self.var_669f67cf >= 8) {
      self function_a0ef7452();
      break;
    }

    waitframe(1);
  }
}

function function_a0ef7452() {
  self function_6a0ad00("<dev string:x4a>");

  if(!is_true(self.exploded)) {
    self.exploded = 1;
    self notify(#"exploded");
    targets = getentitiesinradius(self.origin, 250);

    if(self.var_23130969 > 1) {
      damage_weapon = level.var_3415bf61;
      var_d2e616e1 = 20000;
    } else {
      damage_weapon = level.var_a467bdbc;
      var_d2e616e1 = 10000;
    }

    player = self.owner;

    if(isPlayer(player)) {
      weapon1 = player.inventory.items[17 + 1];
      weapon2 = player.inventory.items[17 + 1 + 8 + 1];
      var_5df29481 = player.inventory.items[17 + 1 + 8 + 1 + 8 + 1];

      if(weapon1.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = weapon1.var_627c698b.altweapon;
      } else if(weapon2.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = weapon2.var_627c698b.altweapon;
      } else if(var_5df29481.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = var_5df29481.var_627c698b.altweapon;
      }
    }

    foreach(target in targets) {
      if(isactor(target) && isalive(target) && target getteam() == level.zombie_team) {
        target dodamage(var_d2e616e1, self.origin, self.owner, self, "none", "MOD_UNKNOWN", 0, damage_weapon);
        continue;
      }

      if(isDefined(target.var_e0412177)) {
        target notify(#"damage", {
          #attacker: self.owner, #weapon: damage_weapon, #amount: var_d2e616e1
        });
      }
    }
  }

  self function_b198b062(3);
  self thread function_e7714941();
}

function function_d60a354c() {
  level endon(#"end_game");
  self endon(#"explode");
  self endon(#"death");
  waitresult = self waittilltimeout(3, #"ray_hit");

  if(waitresult._notify !== "ray_hit") {
    self function_6a0ad00("<dev string:x5d>");

    self function_b198b062(0);
    self thread function_e7714941();
    return;
  }

  self function_6a0ad00("<dev string:x7c>");

  self function_b198b062(2);
  self.var_bc60b6e0 = 1.5;
  wait 3;

  if(isDefined(self)) {
    self function_b198b062(0);
    self thread function_e7714941();
  }
}

function function_e7714941() {
  level endon(#"end_game");

  if(!isDefined(self)) {
    return;
  }

  self.is_active = 0;
  wait 1;

  if(isDefined(self)) {
    self function_6a0ad00("<dev string:x98>");
  }

  if(getdvarint(#"scr_draw_triggers", 0)) {
    level notify(#"hash_3c1bbc5bb28a968c");
  }

  if(isDefined(self.var_fcefdef4)) {
    self.var_fcefdef4 deletedelay();
  }

  if(isDefined(self)) {
    self deletedelay();
  }
}

function function_70240b1b() {
  level endon(#"end_game");
  self endon(#"death");

  while(isDefined(self)) {
    targets = getentitiesinradius(self.origin, self.var_bc60b6e0 * 64, 15);
    damage_weapon = self.var_23130969 < 1 ? level.var_a467bdbc : level.var_3415bf61;
    var_c790ea95 = self.var_23130969 < 1 ? 300 : 600;
    player = self.owner;

    if(isPlayer(player)) {
      weapon1 = player.inventory.items[17 + 1];
      weapon2 = player.inventory.items[17 + 1 + 8 + 1];
      var_5df29481 = player.inventory.items[17 + 1 + 8 + 1 + 8 + 1];

      if(weapon1.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = weapon1.var_627c698b.altweapon;
      } else if(weapon2.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = weapon2.var_627c698b.altweapon;
      } else if(var_5df29481.var_627c698b.altweapon.rootweapon === damage_weapon.rootweapon) {
        damage_weapon = var_5df29481.var_627c698b.altweapon;
      }
    }

    foreach(ai in targets) {
      if(isalive(ai) && ai getteam() == level.zombie_team) {
        ai dodamage(var_c790ea95, self.origin, self.owner, self, "none", "MOD_DOT", 0, damage_weapon);

        if(self.var_bc60b6e0 > 1) {
          ai thread namespace_9ff9f642::slowdown(#"hash_21cb91304fde349a");
          continue;
        }

        ai thread namespace_9ff9f642::slowdown(#"hash_5c37161904f4bcc9");
      }
    }

    wait 0.5;
  }
}

function function_b198b062(stage) {
  if(self.var_23130969 > 1) {
    stage += 4;
  }

  self clientfield::set("" + # "hash_47e7d5219a26a786", stage);
}

function function_65ba5ec2(params) {
  if(params.smeansofdeath === "MOD_MELEE") {
    return;
  }

  if(function_2715ee2d(params.weapon)) {
    if(self function_bdb8126a()) {
      if(isPlayer(params.eattacker) && params.eattacker function_4ba529a7(params.weapon)) {
        self clientfield::set("" + # "hash_3a47820a21ce3170", 2);
      } else {
        self clientfield::set("" + # "hash_3a47820a21ce3170", 1);
      }

      self thread function_5a2447b1(2);
    }

    if(function_4f6da2be(params.weapon) && params.smeansofdeath === "MOD_UNKNOWN") {
      if(level.var_c09dd754 >= 8) {
        return 0;
      }

      var_ad3dca6f = (randomfloat(30), randomfloat(30), randomfloatrange(100, 150));
      zm_utility::function_ffc279(var_ad3dca6f, params.eattacker, self.health, level.var_a467bdbc);
      self thread function_e28429db();
    }
  }
}

function private function_e28429db() {
  level.var_c09dd754++;
  self waittill(#"death");
  level.var_c09dd754--;
}

function private function_4a074587(weapon) {
  var_4bd40253 = self item_inventory::function_230ceec4(weapon);

  if(isDefined(var_4bd40253.paplv)) {
    switch (var_4bd40253.paplv) {
      case 1:
        return 2;
      case 2:
        return 4;
      case 3:
        return 6;
      default:
        return 1;
    }

    return;
  }

  return 1;
}

function function_bdb8126a() {
  if(!isDefined(level.var_1a4cc228[self.aitype])) {
    return false;
  }

  self function_f9b43587();
  entitynum = self getentitynumber();
  var_6f4262ed = level.var_1a4cc228[self.aitype];
  self setModel(var_6f4262ed[entitynum % var_6f4262ed.size]);

  if(isDefined(self.gib_state)) {
    gibserverutils::function_96bedd91(self);
  }

  return true;
}

function function_5a2447b1(time) {
  result = self waittilltimeout(time, #"actor_corpse", #"death");
  waittillframeend();

  if(isDefined(result.corpse)) {
    result.corpse delete();
    return;
  }

  if(isDefined(self)) {
    self deletedelay();
  }
}

function function_6a0ad00(msg, color = (1, 0, 0)) {
  if(!getdvarint(#"hash_49e9d3375f091d35", 0)) {
    return;
  }

  print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 10);
}
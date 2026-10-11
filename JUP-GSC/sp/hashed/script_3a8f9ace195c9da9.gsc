/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3a8f9ace195c9da9.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_4a6760982b403bad;
#using script_56bbc6b044d9068e;
#using script_737f801e6beb18c7;
#using script_7e7eaa110dbb1c83;
#using scripts\anim\dialogue;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_objectives;
#using scripts\cp\globallogic;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\nvg_ai;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\scriptable_ascender;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\player;
#using scripts\stealth\utility;
#namespace namespace_96731f4d002634f6;

function spawn_weapon_model(lootid, index, var_e77bd69b16289bb3, modeltype) {
  if(!isDefined(lootid)) {
    println("<dev string:x1c>" + index + "<dev string:x60>" + var_e77bd69b16289bb3);
    return;
  }

  var_9d5e14018a42cda5 = getStruct("loadout_camera", "targetname");
  playerforward = anglesToForward(level.player.angles);
  spawnpos = (0, 0, -50) + var_9d5e14018a42cda5.origin + playerforward * 50;

  if(modeltype == "weapon") {
    weapon_variant = function_64ccc54bdbae5cf6(lootid);
    base_ref = function_1cc3fd00b6ccc3ba(lootid);

    if(!isDefined(base_ref)) {
      iprintln("<dev string:x76>" + lootid + "<dev string:x94>" + index);

      return;
    }

    if(base_ref != "iw9_lm_dblmg_jup_mp") {
      base_ref = function_c4080e8a53a0fed4(base_ref);
    }

    weapon_camo = function_c7771194200d360e(lootid);

    if(base_ref == "iw9_me_fists") {
      weapon_camo = undefined;
    }

    weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(base_ref, weapon_camo, "none", weapon_variant, undefined, undefined, 1);
    level.var_7cc74eb243f43287[index] = weapon_obj;
    var_962d7583f68be225 = getcompleteweaponname(weapon_obj);
    level.var_a104ae5b3c263ceb[index] = spawn("weapon_" + var_962d7583f68be225, spawnpos, 1);
  } else if(modeltype == "equipment") {
    level.var_ba87eee4c794214f[index] = spawn("script_model", spawnpos, 1);
    bundlename = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[index].equipment;
    equipmentdata = getscriptbundle(hashcat(%"equipment:", bundlename));
    level.var_ba87eee4c794214f[index] setModel(equipmentdata.model);
  } else if(modeltype == "super") {
    level.var_ba87eee4c794214f[index] = spawn("script_model", spawnpos, 1);
    bundlename = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[index].super;
    superdata = getscriptbundle(hashcat(%"super:", bundlename));
    level.var_ba87eee4c794214f[index] setModel(superdata.frontendmodel);
  }

  if(var_e77bd69b16289bb3) {
    level.var_a776d05f784ee5ff[index] = lootid;
    level.var_17584db95edfe6f0[index] = modeltype;
  }
}

function function_a7cfbaaea3046f47() {
  if(isDefined(level.var_a776d05f784ee5ff)) {
    if(isDefined(level.var_ba87eee4c794214f) && level.var_ba87eee4c794214f.size > 0) {
      function_32135cb1e03b2ec8();
    }

    for(i = 0; i < level.var_a776d05f784ee5ff.size; i++) {
      spawn_weapon_model(level.var_a776d05f784ee5ff[i], i, 1, level.var_17584db95edfe6f0[i]);
    }

    return;
  }

  level.var_ba87eee4c794214f = [];
  level.var_a776d05f784ee5ff = [];
  level.var_17584db95edfe6f0 = [];
  unlocklist = self.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist;
  index = 0;

  for(i = 0; i < unlocklist.size; i++) {
    lootid = function_60bebdf35a6b266f(unlocklist, i, function_ce720be6f935d1d4(level.mapname));
    unlock = unlocklist[i];

    if(unlock.weaponblueprint != "" || unlock.weaponid != "") {
      spawn_weapon_model(lootid, index, 1, "weapon");
      index++;
      continue;
    }

    if(unlock.equipment != "") {
      spawn_weapon_model(lootid, index, 1, "equipment");
      index++;
      continue;
    }

    if(unlock.super != "") {
      spawn_weapon_model(lootid, index, 1, "super");
      index++;
    }
  }
}

function function_481bbe989e2575a4(weaponfound, move_amount) {
  weaponfound.origin += move_amount;

  if(isDefined(level.var_b1c663e72c9df6a3)) {
    level.var_b1c663e72c9df6a3.origin += move_amount;
  }

  weaponname = strtok(weaponfound.classname, "+");
  weaponname = weaponname[0];
  println("<dev string:xa0>" + level.var_b1c663e72c9df6a3.targetname + "<dev string:xb0>" + weaponfound.origin);
}

function function_758a56fd5a3d8eb3() {
  level notify("singleton_loadout_shifter");
  level endon("singleton_loadout_shifter");
  up_pressed = 0;
  down_pressed = 0;
  left_pressed = 0;
  right_pressed = 0;
  enter_pressed = 0;
  shift_pressed = 0;
  level.var_61b4827f1d2e9c74 = undefined;

  while(!isDefined(level.player)) {
    wait 1;
  }

  while(true) {
    if(isDefined(level.var_61b4827f1d2e9c74)) {
      weaponfound = level.var_61b4827f1d2e9c74;

      if(level.player buttonPressed("i") && !up_pressed) {
        up_pressed = 1;
      } else if(up_pressed) {
        up_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (0, 0, 0.1));
      }

      if(level.player buttonPressed("k") && !down_pressed) {
        down_pressed = 1;
      } else if(down_pressed) {
        down_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (0, 0, -0.1));
      }

      if(level.player buttonPressed("j") && !left_pressed) {
        left_pressed = 1;
      } else if(left_pressed) {
        left_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (0, 0.1, 0));
      }

      if(level.player buttonPressed("l") && !right_pressed) {
        right_pressed = 1;
      } else if(right_pressed) {
        right_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (0, -0.1, 0));
      }

      if(level.player buttonPressed("enter") && !enter_pressed) {
        enter_pressed = 1;
      } else if(enter_pressed) {
        enter_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (0.1, 0, 0));
      }

      if(level.player buttonPressed("rshift") && !shift_pressed) {
        shift_pressed = 1;
      } else if(shift_pressed) {
        shift_pressed = 0;
        function_481bbe989e2575a4(weaponfound, (-0.1, 0, 0));
      }

      waitframe();
      continue;
    }

    wait 0.5;
  }
}

function function_c33f5b700efef63b(slot, equipname) {
  for(i = 0; i < level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist.size; i++) {
    itemref = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].equipment;
    itemref = strip_suffix(itemref, "_cp");
    itemref = strip_suffix(itemref, "_mp");
    itemref = strip_suffix(itemref, "_jup");

    if(itemref == equipname) {
      if(slot == "primary") {
        function_b28ea2077fe04c46(function_ce720be6f935d1d4(level.mapname), "lethalGrenade", i);
        break;
      }

      if(slot == "secondary") {
        function_b28ea2077fe04c46(function_ce720be6f935d1d4(level.mapname), "tacticalGrenade", i);
        break;
      }
    }
  }
}

function function_769d5ba5e4540f87(supername) {
  for(i = 0; i < level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist.size; i++) {
    itemref = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].super;
    itemref = strip_suffix(itemref, "_cp");
    itemref = strip_suffix(itemref, "_mp");
    itemref = strip_suffix(itemref, "_jup");

    if(itemref == supername) {
      function_b28ea2077fe04c46(function_ce720be6f935d1d4(level.mapname), "fieldEquipment", i);
      break;
    }
  }
}

function function_b66c3d85ea26d412() {
  self endon("loadout_class_selected");
  assert(isDefined(level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist));
  setDvar(@ "hash_4b2ffd34fab7a20", 0);
  previndex = -1;
  prevclass = "";
  var_9d5e14018a42cda5 = getStruct("loadout_camera", "targetname");

  while(true) {
    self waittill("luinotifyserver", channel, value);

    if(channel == "loadout_item_hovered") {
      self notify("loadout_item_hovered_received");

      for(i = 0; i < level.var_a776d05f784ee5ff.size; i++) {
        if(isDefined(level.var_a776d05f784ee5ff[i]) && level.var_a776d05f784ee5ff[i] == value) {
          if(i != previndex && issubstr(prevclass, "weapon")) {
            if(isDefined(level.var_ba87eee4c794214f[previndex])) {
              level.var_ba87eee4c794214f[previndex] delete();
              level.var_ba87eee4c794214f[previndex] = undefined;
            }
          }

          if(getdvarint(@ "hash_4b5c7d9c5837b915", 0) == 1) {
            level.var_61b4827f1d2e9c74 = level.var_ba87eee4c794214f[i];
          }

          itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(level.var_a776d05f784ee5ff[i]));

          if(level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].weaponblueprint != "") {
            itemref = function_1cc3fd00b6ccc3ba(int(level.var_a776d05f784ee5ff[i]));
            itemref = function_c4080e8a53a0fed4(itemref);
            sub_class = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].weaponblueprint;
          }

          if(level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].equipment != "") {
            class = "equipment";
            sub_class = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].equipment;
          } else if(level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].super != "") {
            class = "super";
            sub_class = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].super;
          } else {
            class = getweaponclass(itemref);

            if(!isDefined(sub_class)) {
              sub_class = itemref;
            }
          }

          var_f64d8a4a0e335169 = getStruct("loadout_" + sub_class, "targetname");

          if(isDefined(var_f64d8a4a0e335169) && level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].weaponblueprint == "jup_jp13_sn_svictor_sp_v1" && isDefined(level.mapname) && level.mapname == "cp_jup_chemical") {
            var_f64d8a4a0e335169.origin = (-3076.54, 25692.1, -847.321);
          }

          sub_class = undefined;
          var_bbce82cf6d52a22b = (0, 90, 0);

          if(!isDefined(var_f64d8a4a0e335169)) {
            switch (class) {
              case #"hash_8af0086b038622b5":
                var_f64d8a4a0e335169 = getStruct("loadout_ars", "targetname");
                break;
              case #"hash_ab10f9c080fe4faf":
                var_f64d8a4a0e335169 = getStruct("loadout_smgs", "targetname");
                break;
              case #"hash_bef5ec0b3e197ae":
                var_f64d8a4a0e335169 = getStruct("loadout_lmgs", "targetname");
                break;
              case #"hash_16cf6289ab06bd30":
                var_f64d8a4a0e335169 = getStruct("loadout_shotguns", "targetname");
                break;
              case #"hash_c095d67337b1f5a1":
                var_f64d8a4a0e335169 = getStruct("loadout_snipes", "targetname");
                break;
              case #"hash_47368bc0d2ef1565":
                var_f64d8a4a0e335169 = getStruct("loadout_dmrs", "targetname");
                break;
              case #"hash_34340d457a63e7f1":
                var_f64d8a4a0e335169 = getStruct("loadout_pistols", "targetname");
                break;
              case #"hash_a1f27f97be15d620":
                var_f64d8a4a0e335169 = getStruct("loadout_melee2", "targetname");
                break;
              case #"hash_9d18adab1b65a661":
                var_f64d8a4a0e335169 = getStruct("loadout_launchers", "targetname");
                break;
              case #"hash_93c71e7b6c0b81d7":
                var_f64d8a4a0e335169 = getStruct("loadout_lethals", "targetname");
                break;
              case #"hash_e534fd8ec73eafb4":
                var_f64d8a4a0e335169 = getStruct("loadout_field_upgrades", "targetname");
                break;
              default:
                var_f64d8a4a0e335169 = getStruct("loadout_ars", "targetname");
                break;
            }
          }

          playerforward = anglesToForward(level.player.angles);
          spawnpos = (0, 0, -50) + level.player.origin + playerforward * 50;

          if(previndex >= 0) {
            if(isDefined(level.var_ba87eee4c794214f[previndex])) {
              level.var_ba87eee4c794214f[previndex].origin = spawnpos;
              level.var_ba87eee4c794214f[previndex] dontinterpolate();
            }
          }

          waitframe();

          if(issubstr(class, "weapon")) {
            if(!isDefined(level.var_ba87eee4c794214f[i])) {
              var_962d7583f68be225 = getcompleteweaponname(level.var_7cc74eb243f43287[i]);
              level.var_ba87eee4c794214f[i] = spawn("weapon_" + var_962d7583f68be225, spawnpos, 1);
            }
          }

          if(isDefined(level.var_ba87eee4c794214f[i])) {
            thread function_a2100ee5afee7876(var_f64d8a4a0e335169, class, i);
          }

          previndex = i;
          prevclass = class;
          break;
        }
      }

      continue;
    }

    if(channel == "item_selection_exit") {
      if(getdvarint(@ "hash_4b5c7d9c5837b915", 0) == 1) {
        level.var_61b4827f1d2e9c74 = undefined;
      }

      println(level.var_a776d05f784ee5ff.size);

      for(i = 0; i < level.var_a776d05f784ee5ff.size; i++) {
        println(i + "<dev string:xb4>" + level.var_a776d05f784ee5ff[i]);
        playerforward = anglesToForward(level.player.angles);
        spawnpos = (0, 0, -50) + var_9d5e14018a42cda5.origin + playerforward * 50;

        if(isDefined(level.var_ba87eee4c794214f[i])) {
          level.var_ba87eee4c794214f[i].origin = spawnpos;
          level.var_ba87eee4c794214f[i] dontinterpolate();
        }
      }
    }
  }
}

function function_a2100ee5afee7876(var_f64d8a4a0e335169, class, i) {
  self endon("loadout_item_hovered_received");

  if(isDefined(var_f64d8a4a0e335169)) {
    if(issubstr(class, "weapon")) {
      var_b60f4ada498a350c = 50;
      var_a4007eb2a63d3e78 = var_b60f4ada498a350c;

      while(!level.var_7cc74eb243f43287[i] function_f4070ccd888c07b9(3, 1)) {
        wait 0.1;
        var_a4007eb2a63d3e78 -= 1;

        if(var_a4007eb2a63d3e78 == 0) {
          println("<dev string:xc5>" + level.var_a776d05f784ee5ff[i] + "<dev string:xe1>" + var_b60f4ada498a350c * 0.1 + "<dev string:xf5>");
          break;
        }
      }
    }

    println("<dev string:xc5>" + level.var_a776d05f784ee5ff[i] + "<dev string:x129>" + var_f64d8a4a0e335169.origin);
    level.var_ba87eee4c794214f[i].origin = var_f64d8a4a0e335169.origin;

    if(getdvarint(@ "hash_4b5c7d9c5837b915", 0) == 1) {
      level.var_b1c663e72c9df6a3 = var_f64d8a4a0e335169;
    }

    if(isDefined(var_f64d8a4a0e335169.angles) && isvector(var_f64d8a4a0e335169.angles)) {
      var_bbce82cf6d52a22b = var_f64d8a4a0e335169.angles;
    }
  }

  level.var_ba87eee4c794214f[i].angles = var_bbce82cf6d52a22b;
  level.var_ba87eee4c794214f[i] dontinterpolate();
}

function function_32135cb1e03b2ec8() {
  if(isDefined(level.var_ba87eee4c794214f)) {
    for(i = level.var_ba87eee4c794214f.size - 1; i >= 0; i--) {
      if(isDefined(level.var_ba87eee4c794214f[i])) {
        level.var_ba87eee4c794214f[i] delete();
      }

      level.var_ba87eee4c794214f[i] = undefined;
    }

    level.var_ba87eee4c794214f = undefined;
  }

  if(isDefined(level.var_a104ae5b3c263ceb)) {
    for(i = level.var_a104ae5b3c263ceb.size - 1; i >= 0; i--) {
      if(isDefined(level.var_a104ae5b3c263ceb[i])) {
        level.var_a104ae5b3c263ceb[i] delete();
      }

      level.var_a104ae5b3c263ceb[i] = undefined;
    }

    level.var_a104ae5b3c263ceb = undefined;
  }
}

function function_8d89ce0ee29f2012() {
  self waittill("loadout_class_selected", value);

  if(value == 1) {
    function_2381e221a64411c2();
  }
}

function function_2381e221a64411c2() {
  setDvar(@ "hash_4b2ffd34fab7a20", 1);

  if(!isDefined(level.scriptperks["specialty_incendiary"])) {
    scripts\cp\perks\cp_perks::registerscriptperk("specialty_incendiary");
    scripts\cp\utility::giveperk("specialty_incendiary");
  }

  currentplatecount = scripts\cp_mp\equipment::getequipmentslotammo("health");

  if(isDefined(level.var_a18b35bc1529ade3)) {
    self[[level.var_a18b35bc1529ade3]]();
  }

  self takeallweapons();
  level thread function_32135cb1e03b2ec8();
  var_15d0dde23ad3bb64 = function_d97519ec24ef0572(level.var_82191bfa9f751f4c, "primaryWeapon");
  var_80b92ef4bf8f4da4 = function_d97519ec24ef0572(level.var_82191bfa9f751f4c, "secondaryWeapon");
  var_35f27656995012fa = function_d97519ec24ef0572(level.var_82191bfa9f751f4c, "lethalGrenade");
  var_2838a63ddcefcddb = function_d97519ec24ef0572(level.var_82191bfa9f751f4c, "tacticalGrenade");
  var_4587f0e982edf200 = function_d97519ec24ef0572(level.var_82191bfa9f751f4c, "fieldEquipment");
  self.var_ff741d59e10631a = [];
  self.var_ff741d59e10631a[0] = var_15d0dde23ad3bb64;
  self.var_ff741d59e10631a[1] = var_80b92ef4bf8f4da4;
  var_9633e389beca7d52 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64)));
  var_1bfc508d9d4df492 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4)));
  var_8967bb722103cd58 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_35f27656995012fa)));
  var_acf4240d189539a7 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_2838a63ddcefcddb)));
  var_7acc1a8b69e79b42 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_4587f0e982edf200)));
  var_dc3cf59695a3e26b = function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64);
  var_e01354377432ecab = function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4);
  var_7eb440195b5b964d = function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_35f27656995012fa);
  var_b89095f886e9dcaa = function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_2838a63ddcefcddb);
  var_de7804d5414e8c51 = function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_4587f0e982edf200);
  currentloadout = [var_dc3cf59695a3e26b, var_e01354377432ecab, var_7eb440195b5b964d, var_b89095f886e9dcaa, var_de7804d5414e8c51];
  currentloadout = array_removeundefined(currentloadout);
  defaultloadout = level.var_1b908bf18691b097.var_9fe46adfd5a9aa19;
  var_bcaf3654a128dc26 = 1;

  foreach(itemid in currentloadout) {
    if(!istrue(array_contains(defaultloadout, itemid))) {
      var_bcaf3654a128dc26 = 0;
      break;
    }
  }

  if(!istrue(var_bcaf3654a128dc26)) {
    println("<dev string:x13b>" + level.var_82191bfa9f751f4c);
    level.player setprogressiondata("SandBoxAchievementData", level.var_82191bfa9f751f4c + "_changedloadout", 1);
    level thread function_de2d867ede2eebdf();
  }

  var_2c657d4291f00115 = function_1cc3fd00b6ccc3ba(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64)));
  var_2c657d4291f00115 = function_c4080e8a53a0fed4(var_2c657d4291f00115);

  if(var_2c657d4291f00115 == "iw9_drown") {
    var_2c657d4291f00115 = "iw9_me_fists";
  }

  primaryvariantid = function_64ccc54bdbae5cf6(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64)));
  var_2be2590c0684a555 = function_1cc3fd00b6ccc3ba(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4)));
  var_2be2590c0684a555 = function_c4080e8a53a0fed4(var_2be2590c0684a555);

  if(var_2be2590c0684a555 == "iw9_drown") {
    var_2be2590c0684a555 = "iw9_me_fists";
  }

  secondaryvariantid = function_64ccc54bdbae5cf6(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4)));
  primarycamo = function_c7771194200d360e(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64)));
  primary = scripts\cp_mp\weapon::buildweapon_blueprint(var_2c657d4291f00115, primarycamo, undefined, primaryvariantid);
  secondary = undefined;
  secondarycamo = function_c7771194200d360e(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4)));

  if(var_2be2590c0684a555 != "") {
    secondary = scripts\cp_mp\weapon::buildweapon_blueprint(var_2be2590c0684a555, secondarycamo, undefined, secondaryvariantid);
  } else {
    secondary = scripts\cp_mp\weapon::buildweapon(var_1bfc508d9d4df492, undefined, secondarycamo);
  }

  if(!function_7ff93cc9f74e1d68(primary) && var_2c657d4291f00115 != "<dev string:x161>") {
    var_f8b3d328c425a168 = makeweapon(function_1cc3fd00b6ccc3ba(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_15d0dde23ad3bb64))), primary.attachments);
    primary = var_f8b3d328c425a168;
  }

  if(!function_7ff93cc9f74e1d68(secondary) && var_2be2590c0684a555 != "<dev string:x161>") {
    var_1a6922fe693b3eb8 = makeweapon(function_1cc3fd00b6ccc3ba(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_80b92ef4bf8f4da4))), secondary.attachments);
    secondary = var_1a6922fe693b3eb8;
  }

  if(primary.basename != "defaultweapon") {
    self giveweapon(primary, undefined, primary.isdualwield, -1, istrue(self.var_a4f4164908559548));
    var_a315a5e37d7f0f61 = self.var_a4f4164908559548;
    self.var_a4f4164908559548 = undefined;
    self.weapongiven = 1;
    self notify("gave_weapon");
  }

  if(istrue(level.var_b9d5a2af2d535f77)) {
    self waittill("swap_weapon");
  }

  self switchtoweapon(primary);

  if(secondary.basename != "defaultweapon") {
    self giveweapon(secondary);
  }

  scripts\cp\pickups::giveammo(self);
  scripts\cp_mp\equipment::clearallequipment();

  if(scripts\cp_mp\utility\loot::function_282cf83c9eeda744(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_35f27656995012fa))) == "equipment") {
    scripts\cp_mp\equipment::giveequipment(var_8967bb722103cd58, "primary");
  }

  if(scripts\cp_mp\utility\loot::function_282cf83c9eeda744(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_2838a63ddcefcddb))) == "equipment") {
    scripts\cp_mp\equipment::giveequipment(var_acf4240d189539a7, "secondary");
  }

  scripts\cp_mp\equipment::function_1ab06e1478168800();

  if(scripts\cp_mp\utility\loot::function_282cf83c9eeda744(int(function_e511e6f4347ff261(level.var_82191bfa9f751f4c, var_4587f0e982edf200))) == "super") {
    forcegivesuper(var_7acc1a8b69e79b42);
  }

  if(isDefined(currentplatecount)) {
    function_774133dc8df0ccd5(currentplatecount);
  }

  var_34c0881201a93176 = "jup_execution_first_person_001";

  if(isDefined(level.var_2a226e97d7ab297)) {
    var_34c0881201a93176 = level.var_2a226e97d7ab297;
  }

  scripts\cp_mp\execution::_giveexecution(var_34c0881201a93176, 1);
  loadoutstruct = spawnStruct();
  loadoutstruct.player = level.player;
  loadoutstruct.primaryweapon = var_9633e389beca7d52;
  loadoutstruct.secondaryweapon = var_1bfc508d9d4df492;
  loadoutstruct.lethalgrenade = var_8967bb722103cd58;
  loadoutstruct.tactical = var_acf4240d189539a7;
  loadoutstruct.fieldupgrade = var_7acc1a8b69e79b42;
  scripts\cp\loadout::function_a6eb74f88574f882();
  scripts\cp\loadout::function_a01818ae9edecbe6(1);
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_loadout_changed", loadoutstruct);
}

function function_8b4a89ac15af6483(spawned) {
  thread function_aaaf73cfeb6433fb(spawned);
}

function function_aaaf73cfeb6433fb(spawned) {
  if(issubstr(self.model, "body") && self.classname == "script_model") {
    self endon("death");
    spawned endon("death");
    scripts\common\visibility_mode::function_8ba05ef17e2b7d10(spawned, self.team);

    while(true) {
      active_anims = self getactiveanimations();

      if(isDefined(active_anims) && (active_anims.size == 1 || active_anims.size == 2)) {
        if(active_anims.size == 1 || active_anims[0]["animtime"] < active_anims[1]["animtime"]) {
          active_anim = active_anims[0];
        } else {
          active_anim = active_anims[1];
        }

        time_norm = active_anim["animtime"];
        animation_name = active_anim["name"];

        if(time_norm < 0.015) {
          spawned scriptmodelplayanim(animation_name, undefined, 0);
        } else {
          animation = active_anim["animation"];
          var_ceaeb39d91d4f57f = getanimlength(animation) * time_norm;
          spawned scriptmodelplayanim(animation, undefined, var_ceaeb39d91d4f57f);
        }

        self waittill("stop_sequencing_notetracks");
        continue;
      }

      break;
    }
  }
}

function function_65938d8e60837b34() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();

    if(getdvarint(@ "hash_93e4fa38585a6c6f", 0) != 0) {
      function_531194f673a06de5(1);
    } else {
      function_531194f673a06de5(0);
    }

    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }
}

function function_51f974c859969b7e() {
  if(isDefined(level.var_6465a2cba220aab3)) {
    return;
  }

  function_574f8f02f2bbf6fa("price", "jup_cp_price");
  function_574f8f02f2bbf6fa("gaz", "jup_cp_gaz");
  function_574f8f02f2bbf6fa("soap", "jup_cp_soap");
  function_574f8f02f2bbf6fa("ghost", "jup_cp_ghost");
  function_574f8f02f2bbf6fa("farah", "jup_cp_farah");
  function_574f8f02f2bbf6fa("farah_port", "jup_cp_farah_port");
}

function function_61411c49eaca86e2(character_name) {
  forced_operator = undefined;
  var_15655027aaaacf68 = undefined;
  var_965cd465abaa1a = undefined;
  var_3e8686bd64fd3f91 = undefined;
  var_7c8ee05acd3a6e01 = undefined;
  var_461d3a38ea2cbe91 = undefined;

  if(!isDefined(level.var_6465a2cba220aab3)) {
    function_51f974c859969b7e();
  }

  if(getDvar(@ "hash_9a41dcb00ef528c4", "<dev string:x16e>") != "<dev string:x16e>") {
    character_name = getDvar(@ "hash_9a41dcb00ef528c4");
  }

  if(character_name == "null") {
    return;
  }

  operator_str = level.var_6465a2cba220aab3[character_name];

  if(isDefined(operator_str)) {
    scripts\cp\loadout::function_ef21ab05bfa5c5a1(operator_str.forced_operator, operator_str.var_15655027aaaacf68, operator_str.var_965cd465abaa1a, operator_str.var_3e8686bd64fd3f91, operator_str.var_7c8ee05acd3a6e01, operator_str.var_461d3a38ea2cbe91);
  }
}

function function_574f8f02f2bbf6fa(char_string, operator, head, body, vm, suit, var_461d3a38ea2cbe91) {
  if(!isDefined(level.var_6465a2cba220aab3)) {
    level.var_6465a2cba220aab3 = [];
  }

  operator_str = spawnStruct();
  operator_str.forced_operator = operator;
  operator_str.var_15655027aaaacf68 = head;
  operator_str.var_965cd465abaa1a = body;
  operator_str.var_3e8686bd64fd3f91 = vm;
  operator_str.var_7c8ee05acd3a6e01 = suit;
  operator_str.var_461d3a38ea2cbe91 = var_461d3a38ea2cbe91;
  level.var_6465a2cba220aab3[char_string] = operator_str;

  function_682da8addae457fd(char_string, level.var_6465a2cba220aab3.size);
}

function function_9250dfcc43a9ccb9() {
  level.getspawnpoint = &function_361c013a939bf3b7;
}

function function_361c013a939bf3b7() {
  var_d95f0483aa7fd94d = level.start_point + "_start";
  var_89770fe705541944 = getStructArray(var_d95f0483aa7fd94d, "targetname");

  if(var_89770fe705541944.size == 0) {
    assertmsg("getCustomSpawnPoint() - Trying to spawn player at struct w/ targetname '" + var_d95f0483aa7fd94d + "' for startpoint '" + level.start_point + "' but there are no such structs");
  }

  for(i = 0; i < level.players.size; i++) {
    if(self == level.players[i]) {
      if(!isDefined(level.player_respawn)) {
        level.player_respawn = [];
      }

      if(!isDefined(level.player_respawn[i])) {
        self.respawn_index = i;
        level.player_respawn[i] = var_89770fe705541944[i];
      }

      return level.player_respawn[i];
    }
  }
}

function function_14f52e3e375a2355(ent1, ent2) {
  dist1 = distance(ent1.origin, level.player.origin);
  dist2 = distance(ent2.origin, level.player.origin);
  return dist1 < dist2;
}

function delaynotify(time, notify_string) {
  wait time;
  self notify(notify_string);
}

function function_1c4d592029f2b0d3(name) {
  if(!isDefined(name)) {
    return undefined;
  }

  return getEnt(name, "targetname");
}

function function_3fd029c94a177d06(name) {
  if(!isDefined(name)) {
    return undefined;
  }

  return getEntArray(name, "targetname");
}

function function_7a18da6e48b71c35(name) {
  if(!isDefined(name)) {
    return undefined;
  }

  return getStruct(name, "targetname");
}

function function_da0fc97699b7c873(ent_targetname) {
  ent_array = getEntArray(ent_targetname, "targetname");

  foreach(ent in ent_array) {
    if(level.player istouching(ent)) {
      return true;
    }
  }

  return false;
}

function function_ef5226389e773adc(name) {
  if(!isDefined(name)) {
    return undefined;
  }

  return getnode(name, "targetname");
}

function delete_on_flag(wait_flag) {
  self endon("death");
  flag_wait(wait_flag);

  if(isDefined(self)) {
    self delete();
  }
}

function function_ec0d7ba8c7cd4120(var_197fd3fbcd4abbff, var_63c7e7f5afe86d25, var_edbc734145da38e, var_f56aa5622073f649, var_8758e8a11616e552) {
  grass_vols = getEntArray(var_197fd3fbcd4abbff, "targetname");
  level thread function_c7a2e07632403134(grass_vols, var_63c7e7f5afe86d25, var_edbc734145da38e, var_f56aa5622073f649, var_8758e8a11616e552);
}

function private function_c7a2e07632403134(grass_vols, var_63c7e7f5afe86d25, var_edbc734145da38e, var_f56aa5622073f649, var_8758e8a11616e552) {
  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  level.players[0] endon("death");
  level.players[0] endon("disconnect");

  if(!isDefined(var_63c7e7f5afe86d25)) {
    var_63c7e7f5afe86d25["prone"] = 100;
    var_63c7e7f5afe86d25["crouch"] = 200;
    var_63c7e7f5afe86d25["stand"] = 600;
  }

  if(!isDefined(var_edbc734145da38e)) {
    var_edbc734145da38e["prone"] = 200;
    var_edbc734145da38e["crouch"] = 600;
    var_edbc734145da38e["stand"] = 800;
  }

  if(!isDefined(var_f56aa5622073f649)) {
    var_f56aa5622073f649["prone"] = 0;
    var_f56aa5622073f649["crouch"] = 0;
    var_f56aa5622073f649["stand"] = 0;
  }

  if(!isDefined(var_8758e8a11616e552)) {
    var_8758e8a11616e552["prone"] = 0;
    var_8758e8a11616e552["crouch"] = 0;
    var_8758e8a11616e552["stand"] = 0;
  }

  scripts\stealth\utility::function_f3883fe06a11269(var_f56aa5622073f649, var_8758e8a11616e552);
  level.var_9e86aa94cdbc3b82 = 0;

  while(true) {
    var_ce23b5f1f6a7ac71 = 0;

    foreach(vol in grass_vols) {
      if(level.players[0] istouching(vol)) {
        var_ce23b5f1f6a7ac71 = 1;
        break;
      }
    }

    if(level.var_9e86aa94cdbc3b82 != var_ce23b5f1f6a7ac71) {
      if(var_ce23b5f1f6a7ac71) {
        var_fac370d058479827 = var_63c7e7f5afe86d25;
        var_fb574b7959625bf0 = var_edbc734145da38e;
      } else {
        var_fac370d058479827 = var_f56aa5622073f649;
        var_fb574b7959625bf0 = var_8758e8a11616e552;
      }

      scripts\stealth\utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
      level.var_9e86aa94cdbc3b82 = var_ce23b5f1f6a7ac71;
    }

    waitframe();
  }
}

function function_fa7c87f2585bd907(is_victory) {
  if(!isDefined(is_victory)) {
    is_victory = 1;
  }

  if(is_victory) {
    level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
    return;
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
}

function function_a0d4a0a7264d1772(mission_name, item_id, unlock_state) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  self setprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "unlockState", unlock_state);
  level.var_a314f28155dfb0f9[item_id] = unlock_state;
}

function function_fef34e1a36b57bf6(mission_name, item_id) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  return self getprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "unlockState");
}

function function_23092c668a272b35(mission_name, item_id, item_ref) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  self setprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "itemID", item_ref);
  level.var_a314f28155dfb0f9[item_id] = item_ref;
}

function function_e511e6f4347ff261(mission_name, item_id) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  return self getprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "itemID");
}

function function_10e81f91fc857e5e(mission_name, item_id, var_847005bc86397401) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  self setprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "isNewUnlock", var_847005bc86397401);
  level.var_bf0aff1dbb6d18ce[item_id] = var_847005bc86397401;
}

function function_4c4f0a229229ad62(mission_name, item_id) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  return self getprogressiondata("sandboxInventoryData", mission_name, "SboxItems", item_id, "isNewUnlock");
}

function function_d97519ec24ef0572(mission_name, loadout_slot) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  return self getprogressiondata("sandboxLoadoutData", mission_name, loadout_slot);
}

function function_b28ea2077fe04c46(mission_name, loadout_slot, item_id) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  self setprogressiondata("sandboxLoadoutData", mission_name, loadout_slot, item_id);
}

function function_46c9df4f42d97bfd(mission_name) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));

  for(i = 0; i < 40; i++) {
    level.player function_a0d4a0a7264d1772(mission_name, i, 0);
    level.var_a314f28155dfb0f9[i] = 0;
  }
}

function function_9a4cab249e22a036(mission_name) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));

  for(i = 0; i < 40; i++) {
    level.player function_a0d4a0a7264d1772(mission_name, i, 1);
    level.var_a314f28155dfb0f9[i] = 1;
  }
}

function function_c2368b5493761df9(mission_name) {
  mission_name = default_to(mission_name, function_ce720be6f935d1d4(level.mapname));
  level.var_a314f28155dfb0f9 = [];
  level.var_bf0aff1dbb6d18ce = [];

  for(i = 0; i < 40; i++) {
    level.var_a314f28155dfb0f9[i] = istrue(level.player function_fef34e1a36b57bf6(mission_name, i));
    level.var_bf0aff1dbb6d18ce[i] = istrue(level.player function_4c4f0a229229ad62(mission_name, i));
  }
}

function function_f7475c0922084f67(mission_name) {
  default_to(mission_name, function_ce720be6f935d1d4(level.mapname));

  for(i = 0; i < 40; i++) {
    level.player function_a0d4a0a7264d1772(mission_name, i, 0);
    level.player function_10e81f91fc857e5e(mission_name, i, 0);
    level.var_a314f28155dfb0f9[i] = 0;
    level.var_bf0aff1dbb6d18ce[i] = 0;
  }

  level.player function_b28ea2077fe04c46(mission_name, "lethalGrenade", 0);
  level.player function_b28ea2077fe04c46(mission_name, "primaryWeapon", 0);
}

function function_f912da4730b0d087() {
  return 40;
}

function create_interact(var_8b0921e666da27c8, offset, userange, displayrange, hintstring, hinticon, var_d1fdd329f0bbe3e5, priority, useanglesoverride) {
  var_cffca1a9623f41d5 = spawn("script_model", self.origin, 40);
  var_cffca1a9623f41d5.angles = self.angles;

  if(isDefined(offset)) {
    var_cffca1a9623f41d5.origin += offset;
  }

  if(isDefined(var_8b0921e666da27c8)) {
    var_cffca1a9623f41d5 setModel(var_8b0921e666da27c8);
  }

  displayrange = default_to(displayrange, 200);
  userange = default_to(userange, 60);
  priority = default_to(priority, -10);
  var_d1fdd329f0bbe3e5 = default_to(var_d1fdd329f0bbe3e5, "show");
  hintstring = default_to(hintstring, &"MP/LIGHT_SWITCH");
  hinttag = undefined;
  hinttype = "HINT_BUTTON";
  usefov = 360;
  hintfov = 360;
  duration = "duration_short";
  var_cffca1a9623f41d5 scripts\cp\utility::sethintobject(hinttag, hinttype, hinticon, hintstring, priority, duration, var_d1fdd329f0bbe3e5, displayrange, hintfov, userange, usefov);

  foreach(player in level.players) {
    var_cffca1a9623f41d5 enableplayeruse(player);
  }

  if(isDefined(useanglesoverride)) {
    thread internal_hint_toggle_use_by_angles(var_cffca1a9623f41d5, useanglesoverride, userange);
  }

  return var_cffca1a9623f41d5;
}

function private internal_hint_toggle_use_by_angles(hintent, useangles, userange) {
  assert(isDefined(self.angles), "<dev string:x16f>");
  self endon("death");
  self endon("hint_destroyed");

  if(!isDefined(level.player)) {
    iprintlnbold("<dev string:x1b4>");

    return;
  }

  level.player endon("death");
  could_use = 1;
  desired_dot = cos(useangles);

  while(true) {
    if(!playerwithindistance(level.player, self.origin, userange * 3)) {
      wait 2;
      continue;
    } else {
      waitframe();
    }

    origin = self.origin;
    angles = self.angles;
    fwd = anglesToForward(angles);
    nml = vectorNormalize(level.player getEye() - origin);
    dot = vectordot(fwd, nml);
    can_use = dot >= desired_dot;

    if(can_use != could_use) {
      if(can_use) {
        hintent setuserange(userange);
      } else {
        hintent setuserange(1);
      }

      could_use = can_use;
    }
  }
}

function function_7546ccfe83476b5c() {
  var_8af4b3d4b300ab3f = getEntArray("cp_jup_itembox", "targetname");

  foreach(itembox in var_8af4b3d4b300ab3f) {
    var_20dcca919eadf136 = spawnStruct();
    var_20dcca919eadf136.origin = itembox.origin;
    var_20dcca919eadf136.angles = itembox.angles;
    itembox.usetrigger = var_20dcca919eadf136 thread create_interact(undefined, (0, 0, 20), 100, undefined, "", undefined, "hide");
    itembox.var_41dd6b4fc3fbbd3c = int(itembox.script_noteworthy);
    itembox thread function_ad29c6d3e109149d();
  }
}

function function_ad29c6d3e109149d() {
  self.usetrigger waittill("trigger");
  namespace_23750629c2b7a3d3::temp_dialogue("Item box collected!");
  level.player function_a0d4a0a7264d1772(level.mapname, self.var_41dd6b4fc3fbbd3c, 1);
  self.usetrigger delete();
}

function function_17e182dda2380009() {
  lootboxes = getEntArray("cp_loot_box", "targetname");

  foreach(lootbox in lootboxes) {
    var_7b140f3d2485af1a = getStruct(lootbox.target, "targetname");
    var_d89706e203d76d4c = getEnt(var_7b140f3d2485af1a.target, "targetname");
    lootbox.usetrigger = var_7b140f3d2485af1a thread create_interact(undefined, undefined, undefined, undefined, "", undefined, "hide");
    lootbox.var_f89520dab87e80de = var_d89706e203d76d4c;
    lootbox thread function_c60d6a7e70d312c2();
  }
}

function function_295fb0103fd4f3b9() {
  var_d1baff6e6a8fe26c = getEntArray("cp_loadout_pile", "targetname");

  foreach(var_78ba9777544f5f97 in var_d1baff6e6a8fe26c) {
    var_f1434fd5dfcf684d = getStruct(var_78ba9777544f5f97.target, "targetname");
    var_f1434fd5dfcf684d.angles = (0, 0, 0);
    var_a47b297ace5691c9 = getEnt(var_f1434fd5dfcf684d.target, "targetname");
    var_78ba9777544f5f97.usetrigger = var_f1434fd5dfcf684d thread create_interact(undefined, undefined, 120, undefined, "", undefined, "hide");
    var_78ba9777544f5f97.var_f89520dab87e80de = var_a47b297ace5691c9;
    var_78ba9777544f5f97 thread function_4af250952ae91caf();
  }
}

function function_4af250952ae91caf() {
  while(true) {
    self.usetrigger waittill("trigger");
    function_b5587a46d5f44f68(level.player);
    waitframe();
  }
}

function function_c60d6a7e70d312c2() {
  self.usetrigger waittill("trigger");
  namespace_23750629c2b7a3d3::temp_dialogue("Loot box collected!");
  self.var_f89520dab87e80de connectpaths();
  self.var_f89520dab87e80de delete();
  self.usetrigger delete();
  self delete();
}

function function_c2a4331f598ca13e(disconnect_paths) {
  if(isDefined(self)) {
    self hide();
    self notsolid();

    if(self.classname != "script_model" && istrue(disconnect_paths)) {
      self connectpaths();
    }
  }
}

function function_702ec76ba0d8ebad(connect_paths) {
  if(isDefined(self)) {
    self show();
    self solid();

    if(self.classname != "script_model" && istrue(connect_paths)) {
      self disconnectPaths();
    }
  }
}

function change_fov(fov_value, fov_time) {
  if(!isDefined(level.defaultbasefov)) {
    level.defaultbasefov = getdvarint(@ "hash_b38fcf293d1e91a8", 65);
  }

  if(!isDefined(fov_value)) {
    fov_value = level.defaultbasefov;
  }

  if(!isDefined(fov_time)) {
    fov_time = 0;
  }

  level.player modifybasefov(fov_value, fov_time);
}

function function_79a4d351eac40e17(toggle) {
  if(!isDefined(toggle)) {
    toggle = 1;
  }

  if(istrue(toggle)) {
    self scriptabledoorfreeze(1);
    self function_9af4c9b2cc1bf989(1);
    self.blocked = 1;
    self.var_a16669fdd0578e00 = 0;
    self disablescriptableplayeruse(level.player);
    return;
  }

  self scriptabledoorfreeze(0);
  self function_80902296b05be00a();
  self enablescriptableplayeruse(level.player);
  self.blocked = undefined;
  self.var_a16669fdd0578e00 = 1;
}

function function_d8e8164dba3b33c9(steam) {
  vehicles = vehicle_getarray();

  if(vehicles.size < 1) {
    return vehicles;
  }

  steam = default_to(steam, "axis");
  temp_array = [];

  foreach(vehicle in vehicles) {
    if(is_equal(vehicle.team, steam)) {
      temp_array[temp_array.size] = vehicle;
    }
  }

  vehicles = temp_array;

  if(vehicles.size < 1) {
    return vehicles;
  }

  touching_vehicles = [];

  foreach(vehicle in vehicles) {
    if(vehicle istouching(self)) {
      touching_vehicles[touching_vehicles.size] = vehicle;
    }
  }

  return touching_vehicles;
}

function function_7cc9b8f5c34a4300(ent) {
  trigger = function_1c4d592029f2b0d3(ent);

  while(!level.player istouching(trigger)) {
    waitframe();
  }
}

function spawn_anim_model(animname, origin, angles) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  model = spawn("script_model", origin);
  model.animname = animname;
  model assign_model();
  model assign_animtree();

  if(isDefined(angles)) {
    model.angles = angles;
  }

  return model;
}

function assign_animtree(animname) {
  if(isDefined(animname)) {
    self.animname = animname;
  }

  assertex(isDefined(level.scr_animtree[self.animname]), "There is no level.scr_animtree for animname " + self.animname);
  self useanimtree(level.scr_animtree[self.animname]);
}

function assign_model() {
  assertex(isDefined(level.scr_model[self.animname]), "There is no level.scr_model for animname " + self.animname);

  if(isarray(level.scr_model[self.animname])) {
    randindex = randomint(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][randindex]);
    return;
  }

  self setModel(level.scr_model[self.animname]);
}

function function_acc596689d609fdf() {
  if(!isDefined(level.player)) {
    level waittill("player_spawned");
  }

  weapon_string = undefined;
  string_attachments = undefined;

  foreach(weapon in level.player.primaryweapons) {
    if(function_fd11e651c16415b4(weapon.basename)) {
      weapon_string = weapon.basename;
      string_attachments = weapon.attachments;
      break;
    }
  }

  if(!isDefined(weapon_string)) {
    weapon_string = "iw9_ar_mike4_mp";
  }

  objweapon = scripts\cp\weapon::spawn_script_weapon(weapon_string, string_attachments, self gettagorigin("j_gun"), self gettagangles("j_gun"));
  objweapon dontinterpolate();
  objweapon makeunusable();
  objweapon linkTo(self, "j_gun");
  return objweapon;
}

function function_fd11e651c16415b4(weapon_name) {
  if(!isDefined(weapon_name)) {
    return false;
  }

  if(issubstr(weapon_name, "iw9_la_") || issubstr(weapon_name, "iw9_me_")) {
    return false;
  }

  if(issubstr(weapon_name, "iw9_pi_")) {
    return false;
  }

  if(issubstr(weapon_name, "gunless")) {
    return false;
  }

  return true;
}

function function_a88c360e19062b00(show_models) {
  if(istrue(show_models)) {
    if(isDefined(level.var_5e84860df880bbce)) {
      level.var_5e84860df880bbce show();

      if(isDefined(level.var_5e84860df880bbce.headmodel)) {
        level.var_5e84860df880bbce.headmodel show();
      }

      if(isDefined(level.var_5e84860df880bbce.weapon)) {
        level.var_5e84860df880bbce.weapon show();
      }
    }

    return;
  }

  if(isDefined(level.var_5e84860df880bbce)) {
    level.var_5e84860df880bbce hide();

    if(isDefined(level.var_5e84860df880bbce.headmodel)) {
      level.var_5e84860df880bbce.headmodel hide();
    }

    if(isDefined(level.var_5e84860df880bbce.weapon)) {
      level.var_5e84860df880bbce.weapon hide();
    }
  }
}

function igc_camera(bool) {
  registered = "igc";
  function_1ae8f046dee579e0(bool);

  if(bool) {
    level.player setstance("stand", 1, 1, 1);
    level.player val::set(registered, "freezecontrols", 1);
    level.player val::set(registered, "cinematic_motion", 0);
    level.player val::set(registered, "weapon", 0);
    level.player val::set(registered, "damage", 0);
    level.player val::set(registered, "breath_system", 0);
    level.player cleardamageindicators();
    return;
  }

  level.player val::reset_all(registered);
}

function function_1ae8f046dee579e0(bool) {
  setomnvar("ui_cutscene_active", bool);
}

function function_63171981a45b3ad8() {
  return getomnvar("ui_cutscene_active") > 0;
}

function function_e483413541e6f5cc() {
  self notify("stop_loop");
  scripts\asm\shared\mp\utility::cancelanimscriptmp();
  waittillframeend();
}

function function_a455e04c3087c72b(channel, val) {
  if(channel == "bink_complete") {
    level notify("bink_complete");
    return;
  }

  if(channel == "skip_bink_input") {
    level notify("skip_bink_input");
  }
}

function skip_intro(anim_org, final_actors, var_86738c912cfa8014) {
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 0);

  foreach(ent in final_actors) {
    ent dontinterpolate();
    anim_org thread anim_single_solo(ent, var_86738c912cfa8014);

    if(isai(ent)) {
      ent show();
    }
  }

  wait 0.1;

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 0.05);
  }

  var_3868e4075b0909ab = 0.7;
  var_2224d55de2f81930 = var_3868e4075b0909ab - 2;

  if(var_2224d55de2f81930 < 0) {
    var_2224d55de2f81930 = 0;
  }

  foreach(ent in final_actors) {
    anim_length = getanimlength(ent getanim(var_86738c912cfa8014));

    if(ent == level.player_rig) {
      buffer = var_3868e4075b0909ab;
    } else {
      buffer = var_2224d55de2f81930;
    }

    time = (anim_length - buffer) / anim_length;
    ent setanimtime(ent getanim(var_86738c912cfa8014), time);

    if(isDefined(ent.var_42d97b626fd6d9cf)) {
      foreach(head in ent.var_42d97b626fd6d9cf) {
        if(issubstr(head.model, "head")) {
          head scriptmodelclearanim();
          head hide();
        }
      }
    }
  }

  delaythread(0.5, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0, 0.7);
  level delaythread(var_3868e4075b0909ab, &function_860a5c1214190a7c, anim_org);
}

function function_860a5c1214190a7c(anim_org) {
  level.player scripts\cp\globallogic::userskip_stop();

  if(isDefined(anim_org) && (isDefined(level.player_rig) || isDefined(level.var_8176a36d7ccf27ed))) {
    anim_org unlink_player_from_rig(undefined, undefined, undefined, 1);
  }

  if(isDefined(level.player.hidehudenabled) && level.player.hidehudenabled > 0) {
    level.player utility::hidehuddisable();
  }

  if(isDefined(level.player_rig)) {
    level.player_rig hide();
  }

  function_a88c360e19062b00(0);

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 0.5);
  }

  if(!istrue(level.player.pers["saw_intro"])) {
    level.player.pers["saw_intro"] = 1;
  }

  flag_set("flag_dungeon_intro_complete");
}

function function_666769c607f16d10() {
  if(should_play_intro() || istrue(level.checkpoint_reached)) {
    return;
  }

  utility::flag_set("flag_dungeon_intro_complete");
}

function should_play_intro() {
  if(is_equal(getdvarint(@ "hash_bc9e12bc3b91798", 0), 1)) {
    return true;
  }

  if(is_equal(getdvarint(@ "hash_dbb53c7a147a3ed1", 0), 1)) {
    return false;
  }

  var_8c7cb31a334adfc0 = function_87ce7c6cba6c393();

  if(var_8c7cb31a334adfc0.size) {
    return false;
  }

  return !istrue(level.player.pers["saw_intro"]) || istrue(level.player.pers["pauseMenu_restart"]);
}

function function_aa47047a0f7d56da(player, fadetoblack, fadetime, var_dd8b0e146fd638e) {
  player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, fadetoblack, fadetime);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, fadetoblack, fadetime);
}

function function_b96b3877eda7204() {
  visionsetnaked("", 0.1);
  level.player disablephysicaldepthoffieldscripting();
  hidecinematicletterboxing(2, 0);
  level.player clearcinematicmotionoverride();
  level.player hidelegsandshadow();

  if(isDefined(level.player getlinkedparent())) {
    level.player unlink();
  }

  if(flag("chyrons_on")) {
    level.player namespace_9766820f5baa93fb::function_b809ac841a0c626e();
  }

  scene_cleanup();
}

function scene_cleanup() {
  sceneroot = self;

  if(isDefined(sceneroot.scenedata) && isDefined(sceneroot.scenedata.sceneobjectdata)) {
    foreach(object in sceneroot.scenedata.sceneobjectdata) {
      if(!isDefined(object)) {
        continue;
      }

      if(isent(object)) {
        object stopsounds();
      }

      if(!isDefined(object.entity) || !isDefined(object.entity.var_42d97b626fd6d9cf)) {
        continue;
      }

      foreach(head in object.entity.var_42d97b626fd6d9cf) {
        if(issubstr(head.model, "head")) {
          head scriptmodelclearanim();
          head hide();
        }
      }
    }
  }

  sceneroot scripts\common\scene::cleanup(1);
}

function link_player_to_rig(anime, stance, var_56d6792605cbc9d5, blendtime, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_26967d556f885965, var_fc98921609ed148d) {
  rig = get_player_rig(1, var_fc98921609ed148d);
  rig endon("unlink_player");
  level notify("link_player_to_rig");

  if(isDefined(rigspawnfunc)) {
    rig[[rigspawnfunc]]();
  }

  if(!isDefined(rig.allows)) {
    set_player_rig_allows();
  }

  level.player dontcastshadows();
  rig hide();

  if(isDefined(anime)) {
    thread scripts\common\anim::anim_first_frame_solo(rig, anime);
  }

  rig.ogstance = level.player getstance();

  if(!isDefined(stance)) {
    stance = "stand";
  }

  rig.stance = stance;

  switch (stance) {
    case #"hash_c6775c88e38f7803":
      rig.allows = array_combine_unique(rig.allows, ["crouch", "prone"]);
      break;
    case #"hash_3fed0cbd303639eb":
      rig.allows = array_combine_unique(rig.allows, ["stand", "prone"]);
      break;
    case #"hash_d91940431ed7c605":
      rig.allows = array_combine_unique(rig.allows, ["crouch", "stand"]);
      break;
  }

  level.player setstance(stance);
  level.player function_73341653f76b4e43();

  if(!isDefined(var_56d6792605cbc9d5)) {
    var_56d6792605cbc9d5 = 1;
  }

  if(var_56d6792605cbc9d5) {
    if(!isDefined(blendtime)) {
      blendtime = 0.2;
    }

    blendtime = max(0, blendtime - 0.05);
    level.player playerlinktoblend(rig, "tag_player", blendtime);
    wait blendtime;
    waitframe();
  }

  if(istrue(restrictcamera)) {
    level.player playerlinktoabsolute(rig, "tag_player");
  } else {
    if(!isDefined(usetagangles)) {
      usetagangles = 0;
    }

    level.player playerlinktodelta(rig, "tag_player", 1, 0, 0, 0, 0, usetagangles, 0, 1);

    if(!isDefined(rightarc)) {
      rightarc = 45;
    }

    if(!isDefined(leftarc)) {
      leftarc = 45;
    }

    if(!isDefined(toparc)) {
      toparc = 15;
    }

    if(!isDefined(bottomarc)) {
      bottomarc = 15;
    }

    if(rightarc || leftarc || toparc || bottomarc) {
      level.player thread function_32511959517bbb91(1, 0.2, 0.1, 0.1, rightarc, leftarc, toparc, bottomarc);
    }
  }

  rig show();
  nvidiaansel_scriptdisable(1);
  return rig;
}

function get_player_rig(reset_origin, var_a871c06af7cb87c6) {
  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig");
    reset_origin = 1;

    if(default_to(var_a871c06af7cb87c6, 0)) {
      level.player_rig hide();
    }
  }

  if(istrue(reset_origin)) {
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  return level.player_rig;
}

function set_player_rig_allows(allows) {
  assert(isDefined(level.player_rig) || isDefined(level.var_8176a36d7ccf27ed));

  if(!isDefined(allows)) {
    allows = function_62d61f52bf8d2cbf();
  }

  if(isDefined(level.player_rig)) {
    level.player_rig.allows = allows;
  }

  if(isDefined(level.var_8176a36d7ccf27ed)) {
    level.var_8176a36d7ccf27ed.allows = allows;
  }
}

function function_62d61f52bf8d2cbf() {
  allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "usability", "backpack_inventory", "tacmap_scoreboard"];
  return allows;
}

function function_73341653f76b4e43(allows) {
  assert(isDefined(level.player_rig));
  assert(isDefined(level.player_rig.allows));
  level.player val::reset_all("player_rig");
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
}

function function_32511959517bbb91(delay_time, time, time_accel, time_decel, rightarc, leftarc, toparc, bottomarc) {
  self endon("death");
  self endon("disconnect");
  level endon("unlink_player_from_rig");
  wait delay_time;

  if(self islinked() && !self isufo()) {
    self lerpviewangleclamp(time, time_accel, time_decel, rightarc, leftarc, toparc, bottomarc);
  }
}

function unlink_player_from_rig(resetstance, exitstance, setstanceimmediate, retainplayerrig, var_fc98921609ed148d, var_13d9b15b8a937b29) {
  if(istrue(var_fc98921609ed148d) && isDefined(level.var_8176a36d7ccf27ed)) {
    rig = level.var_8176a36d7ccf27ed;
  } else {
    rig = level.player_rig;
  }

  rig notify("unlink_player");
  level notify("unlink_player_from_rig");
  level.player val::reset_all("player_rig");

  if(istrue(resetstance)) {
    exitstance = rig.ogstance;
  }

  if(isDefined(exitstance)) {
    if(istrue(setstanceimmediate)) {
      level.player setstance(exitstance, 1, 1, 1);
      new_origin = drop_to_ground(level.player getEye(), 0, -60, (0, 0, 1));

      if(isDefined(var_13d9b15b8a937b29)) {
        level.player setOrigin(new_origin + var_13d9b15b8a937b29, 1);
      } else {
        level.player setOrigin(new_origin, 1);
      }
    } else if(exitstance != rig.stance) {
      level.player setstance(exitstance);
    }
  }

  if(isDefined(rig.var_8fddf836ad6d3406)) {
    level.player playersetgroundreferenceent(undefined);
    rig.var_8fddf836ad6d3406 delete();
    rig.var_8fddf836ad6d3406 = undefined;
  }

  level.player castshadows();
  level.player hidelegsandshadow();
  level.player unlink();

  if(!istrue(retainplayerrig)) {
    rig delete();
  }

  nvidiaansel_scriptdisable(0);
}

function function_2311740fe797906a(key, value) {
  level.player.pers["dungeon"][key] = value;
}

function function_69fa4a2561ada985(key) {
  if(!isDefined(level.player)) {
    return undefined;
  }

  if(!isDefined(level.player.pers)) {
    return undefined;
  }

  if(!isDefined(level.player.pers["dungeon"])) {
    return undefined;
  }

  return level.player.pers["dungeon"][key];
}

function createquestcircle(objectivestruct, origin, radius) {
  objectivestruct scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("TestCircle", origin, radius);
  objectivestruct scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
}

function function_2ca95efba5b5d995(objectivestruct, triggertargetname, var_e16949feebc0262b, label, complete_flag) {
  level endon("game_ended");
  trigger = getEnt(triggertargetname, "targetname");

  if(isDefined(trigger)) {
    trigger function_ae165af362de18a2();
    objectivestruct scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    objindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_small", var_e16949feebc0262b, "current", label, undefined, undefined, 0, 0);

    if(isDefined(complete_flag)) {
      level flag_set(complete_flag);
    }
  }
}

function function_ae165af362de18a2() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", entity);

    if(isDefined(entity.vehicletype)) {
      vehicleoccupants = entity.occupants;
      var_95dfb4ea629973 = 0;

      if(!isDefined(vehicleoccupants)) {
        continue;
      }

      foreach(occupant in vehicleoccupants) {
        if(isPlayer(occupant)) {
          var_95dfb4ea629973 = 1;
          break;
        }
      }

      if(var_95dfb4ea629973) {
        break;
      }
    }

    if(!isPlayer(entity)) {
      continue;
    }

    if(!scripts\cp\utility\player::isreallyalive(entity)) {
      continue;
    }

    break;
  }

  self notify("player_trigger", entity);
}

function function_d14fcd3a04720601(trig_targetname) {
  trigs = getEntArray(trig_targetname, "targetname");
  array_thread(trigs, &function_ae165af362de18a2);
  waittill_any_ents_array(trigs, "player_trigger");
}

function function_e2f14dc89a2fa632(targetname) {
  assert(isstring(targetname));
  trig = getEnt(targetname, "targetname");

  while(level.player istouching(trig)) {
    waitframe();
  }

  self notify("player_left_trigger_" + targetname);
}

function delete_grenade_when_thrown() {
  level.player waittill("grenade_fire", grenade, weapon);

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function nvidiaansel_scriptdisable(val) {
  if(nvidiaanselisenabled()) {
    setsaveddvar(@ "hash_941ecb757e3d818e", val);
  }
}

function function_f60f3ac2fb2776f7(objectivestruct, icon, minimapiconsize, location, objstate, label, description, background, playintro, playoutro) {
  playintro = default_to(playintro, 1);
  playoutro = default_to(playoutro, 1);
  assertex(isDefined(objectivestruct.index), "The objective struct has no index.");
  var_ef16180c22171af4 = scripts\cp\cp_objectives::requestworldid("marker_obj" + objectivestruct.index, 1 + int(objectivestruct.index));
  objectivestruct.var_aa2e0492a2d8b18d = var_ef16180c22171af4;
  playintro = default_to(playintro, 1);
  objective_setplayintro(var_ef16180c22171af4, playintro);
  objective_setplayoutro(var_ef16180c22171af4, playoutro);
  objective_icon(var_ef16180c22171af4, icon);
  objective_setminimapiconsize(var_ef16180c22171af4, minimapiconsize);
  objective_setlocation(var_ef16180c22171af4, 0, location);
  state = ter_op(isDefined(objstate), objstate, "current");
  objective_state(var_ef16180c22171af4, state);

  if(isDefined(label)) {
    objective_setlabel(var_ef16180c22171af4, label);
  }

  if(isDefined(description)) {
    objective_setdescription(var_ef16180c22171af4, description);
  }

  if(!isDefined(background)) {
    objective_setbackground(var_ef16180c22171af4, 1);
  } else {
    objective_setbackground(var_ef16180c22171af4, background);
  }

  return var_ef16180c22171af4;
}

function function_448adabb169120d7(objectivestruct, objstate) {
  if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
    state = ter_op(isDefined(objstate), objstate, "empty");
    objective_state(objectivestruct.var_aa2e0492a2d8b18d, state);
    scripts\cp\cp_objectives::freeworldidbyobjid(objectivestruct.var_aa2e0492a2d8b18d);
    objectivestruct.var_aa2e0492a2d8b18d = undefined;
  }
}

function function_9b14a4ae42c7de46(objectivestruct, location) {
  if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
    objective_setlocation(objectivestruct.var_aa2e0492a2d8b18d, 0, location);
  }
}

function function_d2d3ee8c76511439(conditions_array) {
  var_873549b569d7b961 = 1;

  if(isDefined(conditions_array)) {
    foreach(trig in conditions_array) {
      if(isstring(trig)) {
        if(!flag(trig)) {
          var_873549b569d7b961 = 0;
          break;
        }

        continue;
      }

      if(isfunction(trig)) {
        if(![[trig]]()) {
          var_873549b569d7b961 = 0;
          break;
        }
      }
    }
  }

  return var_873549b569d7b961;
}

function function_6907702392fb190c(conditions_array) {
  var_873549b569d7b961 = 0;

  if(isDefined(conditions_array)) {
    foreach(trig in conditions_array) {
      if(isstring(trig)) {
        if(flag(trig)) {
          var_873549b569d7b961 = 1;
          break;
        }

        continue;
      }

      if(isfunction(trig)) {
        if([[trig]]()) {
          var_873549b569d7b961 = 1;
          break;
        }
      }
    }
  }

  return var_873549b569d7b961;
}

function function_916233af1855619c() {
  if(isDefined(self.script_parameters)) {
    self.var_55cc71192b8f1931 = strtok(self.script_parameters, ",");
    return;
  }

  if(isDefined(self.struct) && isDefined(self.struct.script_parameters)) {
    self.struct.var_55cc71192b8f1931 = strtok(self.struct.script_parameters, ",");
    return;
  }

  if(isDefined(self.directorspawndata) && isDefined(self.directorspawndata.script_parameters)) {
    self.var_55cc71192b8f1931 = strtok(self.struct.script_parameters, ",");
    return;
  }
}

function function_68f8b8bd65b54d3(tag) {
  return isDefined(self.var_55cc71192b8f1931) && array_contains(self.var_55cc71192b8f1931, tag) || isDefined(self.struct) && isDefined(self.struct.var_55cc71192b8f1931) && array_contains(self.struct.var_55cc71192b8f1931, tag);
}

function function_60bebdf35a6b266f(itemlist, id, var_82191bfa9f751f4c) {
  itemid = 0;

  if(itemlist[id].weaponblueprint != "") {
    itemid = scripts\cp_mp\utility\loot::getlootidfromref(itemlist[id].weaponblueprint);
  } else if(itemlist[id].weaponid != "") {
    var_4c13446bfa1c38c3 = itemlist[id].weaponid;
    var_4c13446bfa1c38c3 = function_c4080e8a53a0fed4(var_4c13446bfa1c38c3);
    itemid = scripts\cp_mp\utility\loot::getlootidfromref(var_4c13446bfa1c38c3);
  } else if(itemlist[id].equipment != "") {
    var_5a3a473d25f13add = 0;

    for(j = 0; j < level.equipmentbundle.equipment_list.size; j++) {
      if(isDefined(level.equipmentbundle.equipment_list[j].bundle) && itemlist[id].equipment == level.equipmentbundle.equipment_list[j].bundle) {
        itemid = scripts\cp_mp\utility\loot::getlootidfromref(level.equipmentbundle.equipment_list[j].ref);
        var_5a3a473d25f13add = 1;
        break;
      }
    }

    if(!var_5a3a473d25f13add) {
      assertmsg("Equipment at index " + id + " in " + var_82191bfa9f751f4c + "_unlocklist with name " + itemlist[id].equipment + " is not found in equipment_list_jup_cp, please ask the level owner to use the version in equipment_list_jup_cp");
    }
  } else if(itemlist[id].super != "") {
    for(j = 0; j < level.superbundle.super_list.size; j++) {
      if(isDefined(level.superbundle.super_list[j].bundle) && itemlist[id].super == level.superbundle.super_list[j].bundle) {
        itemid = scripts\cp_mp\utility\loot::getlootidfromref(level.superbundle.super_list[j].ref);
        break;
      }
    }
  } else {
    setDvar(@ "hash_c11db9baa9e5bc9b", 1);
    assertmsg("Item at index " + id + " is completely empty in " + var_82191bfa9f751f4c + "_unlocklist! Please ask the level owner to verify. You will be given default weapons and loadouts will be disabled in this level!");
    return;
  }

  return itemid;
}

function function_c4080e8a53a0fed4(var_4c13446bfa1c38c3) {
  if(!isDefined(var_4c13446bfa1c38c3) || var_4c13446bfa1c38c3 == "") {
    return var_4c13446bfa1c38c3;
  }

  if(issubstr(var_4c13446bfa1c38c3, "_mp") || issubstr(var_4c13446bfa1c38c3, "_cp")) {
    var_4c13446bfa1c38c3 = strip_suffix(var_4c13446bfa1c38c3, "_cp");
    var_4c13446bfa1c38c3 = strip_suffix(var_4c13446bfa1c38c3, "_mp");
  }

  return var_4c13446bfa1c38c3;
}

function function_97ccc150115699dc(objectiveid, mission) {
  if(!isDefined(mission)) {
    mission = level.mapname;
  }

  return self getprogressiondata("sandboxMissionObjectiveData", function_ce720be6f935d1d4(mission), "objective_" + objectiveid);
}

function function_a9652366b0728328(state, objectiveid, mission) {
  if(!isDefined(mission)) {
    mission = level.mapname;
  }

  self setprogressiondata("sandboxMissionObjectiveData", function_ce720be6f935d1d4(mission), "objective_" + objectiveid, state);
}

function function_50f02a42c72031cb(mission) {
  if(getdvarint(@ "hash_f004b2ccc04fdc8d", 0)) {
    last_map = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map");

    if(isDefined(last_map) && last_map == mission) {
      return self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint");
    } else {
      return undefined;
    }

    return;
  }

  return undefined;
}

function function_1fcb318b0c28347b() {
  last_map = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map");

  if(isDefined(last_map)) {
    return last_map;
  }

  return "";
}

function function_f66bc987efb3cd9() {
  last_map = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map");
  current_map = level.script;

  if(isDefined(last_map) && last_map == current_map) {
    return istrue(self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_nvg_state"));
  }

  return 0;
}

function function_5de16de5f3a1776f(mission, checkpoint, difficulty, var_e746c8aa068de268, player_origin, player_angles) {
  game["<dev string:x1d3>"] = spawnStruct();
  game["<dev string:x1d3>"].last_checkpoint_map = default_to(mission, "<dev string:x16e>");
  game["<dev string:x1d3>"].last_checkpoint = default_to(checkpoint, "<dev string:x16e>");
  game["<dev string:x1d3>"].last_checkpoint_difficulty = default_to(difficulty, -1);
  game["<dev string:x1d3>"].last_checkpoint_nvg_state = default_to(var_e746c8aa068de268, 0);
  game["<dev string:x1d3>"].last_checkpoint_position = default_to(player_origin, "<dev string:x16e>");
  game["<dev string:x1d3>"].last_checkpoint_angles = default_to(player_angles, "<dev string:x16e>");
  game["<dev string:x1d3>"].last_checkpoint_armor_plates = scripts\cp_mp\armor::function_600f6cf462e983f();
  game["<dev string:x1d3>"].last_checkpoint_armor_health = scripts\cp_mp\armor::function_ac266fc218266d08();
  game["<dev string:x1d3>"].last_checkpoint_self_revive = scripts\cp\laststand::hasselfrevivetoken();

  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map", default_to(mission, ""));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint", default_to(checkpoint, ""));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_difficulty", default_to(difficulty, -1));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_nvg_state", default_to(var_e746c8aa068de268, 0));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_position", default_to(player_origin, ""));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_angles", default_to(player_angles, ""));
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_armor_plates", scripts\cp_mp\armor::function_600f6cf462e983f());
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_armor_health", scripts\cp_mp\armor::function_ac266fc218266d08());
  self setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_self_revive", scripts\cp\laststand::hasselfrevivetoken());
  function_2bc461567e40437d();
}

function function_3b5e6f57536a8c76() {
  last_map = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map");
  current_map = level.script;
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(isDefined(last_map) && last_map == current_map && isDefined(checkpoint) && checkpoint != "") {
    return 1;
  }

  return 0;
}

function function_beebc333010c5122() {
  if(function_3b5e6f57536a8c76()) {
    return istrue(self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_self_revive"));
  }

  return 0;
}

function function_25ae243b0c56d3fc() {
  if(function_3b5e6f57536a8c76()) {
    return self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_armor_plates");
  }

  return 0;
}

function function_a00ff86fba36d23e() {
  if(function_3b5e6f57536a8c76()) {
    return self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_armor_health");
  }

  return 0;
}

function function_124086d0afefcee3() {
  last_map = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map");
  current_map = level.script;

  if(isDefined(last_map) && last_map == current_map) {
    origin = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_position");
    angles = self getprogressiondata("sandboxLastCheckpointData", "last_checkpoint_angles");
    return [origin, angles];
  }

  return [undefined, undefined];
}

function function_2bc461567e40437d() {
  level.player setprogressiondata("sandboxLastCheckpointData", "sandboxCheckpointTimestamp", getsystemtime());
}

function function_5da6074f59f93979(mission) {
  objective_struct = spawnStruct();
  objective_struct.objectives = [];

  for(i = 0; i < 16; i++) {
    objective_struct.objectives[i] = level.player function_97ccc150115699dc(i, mission);
  }

  return objective_struct;
}

function function_8dcc0f3d1bacc30c() {
  level.var_4898102a23066ba = function_5da6074f59f93979(level.mapname);
}

function function_2f51d89f7ca2ea6f() {
  level.var_89c4ca17a73081fd = function_e37f7811ae4599ea();
}

function function_e37f7811ae4599ea() {
  tutorial_struct = spawnStruct();
  tutorial_struct.var_3eb0a25d6bf9529b = [];

  for(i = 0; i < 15; i++) {
    tutorial_struct.var_3eb0a25d6bf9529b[i] = level.player getprogressiondata("gameplaytutorials", "tutorial_" + i + "_displays");
  }

  return tutorial_struct;
}

function function_f12562902f6f598b(var_b33ddc0995abe29e, count) {
  if(count >= 0 && count < 4) {
    self setprogressiondata("gameplaytutorials", "tutorial_" + var_b33ddc0995abe29e + "_displays", count);
  }
}

function function_7d97fa985af1c8a5(var_b33ddc0995abe29e) {
  return self getprogressiondata("gameplaytutorials", "tutorial_" + var_b33ddc0995abe29e + "_displays");
}

function function_600a40840f16740a() {
  for(i = 0; i < 15; i++) {
    self setprogressiondata("gameplaytutorials", "tutorial_" + i + "_displays", 0);
    level.var_89c4ca17a73081fd.var_3eb0a25d6bf9529b[i] = 0;
  }
}

function function_5e2bfc80545dc98e(var_b33ddc0995abe29e) {
  self setprogressiondata("gameplaytutorials", "tutorial_" + var_b33ddc0995abe29e + "_displays", 0);
  level.var_89c4ca17a73081fd.var_3eb0a25d6bf9529b[var_b33ddc0995abe29e] = 0;
}

function function_7e6994d769b9b3cd(missionname) {
  var_82191bfa9f751f4c = function_ce720be6f935d1d4(missionname);
  level.var_82191bfa9f751f4c = var_82191bfa9f751f4c;

  if(!isDefined(var_82191bfa9f751f4c)) {
    return undefined;
  }

  while(!isDefined(level.players[0])) {
    waitframe();
  }

  var_b4e0ee16bfdf7885 = level.players[0];
  var_bf7ad4203d026205 = spawnStruct();
  var_bf7ad4203d026205.attempts = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_attempts");
  var_bf7ad4203d026205.should_show_loadout = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_should_show_loadout");
  var_bf7ad4203d026205.successes = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_successes");
  var_bf7ad4203d026205.failures = var_bf7ad4203d026205.attempts - var_bf7ad4203d026205.successes;
  var_bf7ad4203d026205.checkpoint = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_checkpoint_id");
  var_bf7ad4203d026205.ascender_tool = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_ascender_tool");
  var_bf7ad4203d026205.parachute_activated = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", "cp_jup_parachute_activated");
  var_bf7ad4203d026205.plate_level = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_plate_level");
  var_bf7ad4203d026205.nvg = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_nvg");

  if(var_bf7ad4203d026205.plate_level < 1) {
    var_bf7ad4203d026205.plate_level = 1;
  }

  var_bf7ad4203d026205.var_eee1738f65c4792a = [];

  for(i = 0; i < 16; i++) {
    var_bf7ad4203d026205.var_eee1738f65c4792a[i] = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_map_unlocks", i);
  }

  var_bf7ad4203d026205.var_761018175530ce24 = [];

  for(i = 0; i < 4; i++) {
    var_bf7ad4203d026205.var_761018175530ce24[i] = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_ks_unlocks", i);
  }

  for(i = 0; i < function_e1e2c6c4a3a0ebad(); i++) {
    var_bf7ad4203d026205.discoverables[i] = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_discoverables", i);
  }

  for(i = 0; i < 25; i++) {
    var_bf7ad4203d026205.plate_carriers[i] = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_82191bfa9f751f4c + "_plate_carriers", i);
  }

  if(!isDefined(var_bf7ad4203d026205.var_f8228bcbbb16cbf)) {
    var_bf7ad4203d026205.var_f8228bcbbb16cbf = [];
  }

  var_bf7ad4203d026205.var_884e10986cbfccc7 = getscriptbundle("sandboxmission_unlocklist:" + var_82191bfa9f751f4c + "_unlocklist");
  level.var_c335132972e17f77 = getscriptbundle(hashcat(%"hash_2c963b11e7ff7304", "jup_weapon_class_list"));
  level.equipmentbundle = getscriptbundle(hashcat(%"equipmentlist:", "equipment_list_jup_cp"));
  level.superbundle = getscriptbundle(hashcat(%"superlist:", "super_list_jup_cp"));

  if(var_bf7ad4203d026205.attempts == 0) {
    for(id = 0; id < var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist.size; id++) {
      var_bf7ad4203d026205.var_f8228bcbbb16cbf[id] = var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[id].isunlocked;
      var_b4e0ee16bfdf7885 function_a0d4a0a7264d1772(var_82191bfa9f751f4c, id, var_bf7ad4203d026205.var_f8228bcbbb16cbf[id]);
      itemid = function_60bebdf35a6b266f(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist, id, var_82191bfa9f751f4c);
      var_b4e0ee16bfdf7885 function_23092c668a272b35(var_82191bfa9f751f4c, id, itemid);

      if(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[id].isdefault && itemid != 0) {
        itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(int(itemid));
        itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(int(itemid));

        if(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[id].weaponblueprint != "") {
          itemref = function_1cc3fd00b6ccc3ba(int(itemid));
          itemref = function_c4080e8a53a0fed4(itemref);
        }

        itemslot = undefined;

        if(isDefined(itemtype)) {
          if(itemtype == "weapon") {
            var_56e092bae310563a = getweaponclass(itemref);

            for(j = 0; j < level.var_c335132972e17f77.var_c4845e17f657feec.size; j++) {
              weaponclassdata = getscriptbundle(hashcat(%"hash_231e89190f5116c0", level.var_c335132972e17f77.var_c4845e17f657feec[j].bundle));

              if(weaponclassdata.classreference == var_56e092bae310563a) {
                itemslot = weaponclassdata.weaponslot;

                if(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[id].var_840b562ce1809de) {
                  itemslot = 1;
                }

                break;
              }
            }
          } else if(itemtype == "equipment") {
            for(j = 0; j < level.equipmentbundle.equipment_list.size; j++) {
              if(itemref == level.equipmentbundle.equipment_list[j].ref) {
                equipmentdata = getscriptbundle(hashcat(%"equipment:", level.equipmentbundle.equipment_list[j].bundle));

                if(equipmentdata.equipmenttype == "lethal") {
                  itemslot = 3;
                  break;
                }

                if(equipmentdata.equipmenttype == "tactical" || equipmentdata.equipmenttype == "equipment_other") {
                  itemslot = 4;
                  break;
                }
              }
            }
          } else if(itemtype == "super") {
            itemslot = 5;
          }
        }

        if(isDefined(itemslot)) {
          switch (itemslot) {
            case 1:
              var_b4e0ee16bfdf7885 function_b28ea2077fe04c46(var_82191bfa9f751f4c, "primaryWeapon", id);
              break;
            case 2:
              var_b4e0ee16bfdf7885 function_b28ea2077fe04c46(var_82191bfa9f751f4c, "secondaryWeapon", id);
              break;
            case 3:
              var_b4e0ee16bfdf7885 function_b28ea2077fe04c46(var_82191bfa9f751f4c, "lethalGrenade", id);
              break;
            case 4:
              var_b4e0ee16bfdf7885 function_b28ea2077fe04c46(var_82191bfa9f751f4c, "tacticalGrenade", id);
              break;
            case 5:
              var_b4e0ee16bfdf7885 function_b28ea2077fe04c46(var_82191bfa9f751f4c, "fieldEquipment", id);
              break;
            default:
              break;
          }
        }
      }
    }
  } else {
    for(i = 0; i < var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist.size; i++) {
      itemid = function_60bebdf35a6b266f(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist, i, var_82191bfa9f751f4c);

      if(itemid != var_b4e0ee16bfdf7885 function_e511e6f4347ff261(var_82191bfa9f751f4c, i)) {
        var_b4e0ee16bfdf7885 function_23092c668a272b35(var_82191bfa9f751f4c, i, itemid);
        var_b4e0ee16bfdf7885 function_a0d4a0a7264d1772(var_82191bfa9f751f4c, i, var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[i].isunlocked);
      }

      if(var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[i].isunlocked && !istrue(var_b4e0ee16bfdf7885 function_fef34e1a36b57bf6(var_82191bfa9f751f4c, i))) {
        var_b4e0ee16bfdf7885 function_a0d4a0a7264d1772(var_82191bfa9f751f4c, i, var_bf7ad4203d026205.var_884e10986cbfccc7.unlocklist[i].isunlocked);
      }

      var_bf7ad4203d026205.var_f8228bcbbb16cbf[i] = var_b4e0ee16bfdf7885 getprogressiondata("sandboxInventoryData", var_82191bfa9f751f4c, "SboxItems", i, "unlockState");
    }
  }

  return var_bf7ad4203d026205;
}

function function_225de78e99eb1232(perk) {
  perkbundle = getscriptbundle("perk:" + perk);
  perkid = perkbundle.lootid;
  println("<dev string:x1e3>" + perkid);
  return perkid;
}

function function_ce720be6f935d1d4(missionname, var_d25dda2927a1f8da) {
  mission_ddl = undefined;

  if(istrue(level.var_bb3505b72e24c478) && !istrue(var_d25dda2927a1f8da)) {
    missionname = "cp_jup_chemical";
  }

  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  missionname = strip_suffix(missionname, "_dev");

  switch (missionname) {
    case #"hash_c3c819184bc33817":
      mission_ddl = "cp_jup_chemical";
      break;
    case #"hash_5c03122b70ff4094":
      mission_ddl = "cp_jup_port";
      break;
    case #"hash_48fc93178a593780":
      mission_ddl = "cp_jup_milbase";
      break;
    case #"hash_619829c7b3c4c3e3":
      mission_ddl = "cp_jup_ranch";
      break;
    case #"hash_3705bde815a332ea":
      mission_ddl = "cp_jup_resort";
      break;
    case #"hash_6b2477606925177a":
      mission_ddl = "cp_jup_apt";
      break;
    case #"hash_8e2389607af0427b":
      mission_ddl = "cp_jup_dam";
      break;
    case #"hash_2f7993e5b4a6dc99":
      mission_ddl = "cp_jup_chemical";
      break;
    case #"hash_ddd09c6970ff6bef":
      mission_ddl = "cp_jup_chemical";
      break;
    case #"hash_52a1e348843c18ee":
      mission_ddl = "cp_jup_chemical";
      break;
    case #"hash_8bb4791ca384f2f5":
      mission_ddl = "cp_jup_chemical";
      break;
    default:
      println("<dev string:x1f0>" + missionname + "<dev string:x1ff>");
      mission_ddl = "cp_jup_chemical";
      break;
  }

  if(isDefined(mission_ddl)) {
    return mission_ddl;
  }

  if(istrue(level.var_bb3505b72e24c478)) {
    mission_ddl = "cp_jup_chemical";
    return mission_ddl;
  }

  return undefined;
}

function function_43ff573da0995241(missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
}

function function_3fc39fc10ef1d9d1(var_aff9ed3ed38ceba9, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  if(!isDefined(var_aff9ed3ed38ceba9)) {
    var_aff9ed3ed38ceba9 = 0;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];
  mission_attempts = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_2bfb2e8196104365 + "_attempts");
  mission_successes = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_2bfb2e8196104365 + "_successes");

  if(mission_attempts < 99) {
    mission_attempts++;
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_attempts", mission_attempts);
    level.var_1b908bf18691b097.attempts = mission_attempts;
  }

  if(var_aff9ed3ed38ceba9 && mission_successes < 99) {
    mission_successes++;
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_successes", mission_successes);
    level.var_1b908bf18691b097.successes = mission_successes;
  }
}

function function_bd9c984cefed4209(checkpoint_id, missionname) {
  if(!isDefined(checkpoint_id)) {
    checkpoint_id = 0;
  }

  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(checkpoint_id >= 0 && checkpoint_id <= 15) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_checkpoint_id", checkpoint_id);
  }

  if(isDefined(level.var_1b908bf18691b097)) {
    level.var_1b908bf18691b097.checkpoint = checkpoint_id;
  }

  setomnvar("ui_cp_checkpoint", 1);
}

function function_965540c9de8803c9(isunlocked, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(isunlocked == 1 || isunlocked == 0) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_ascender_tool", isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.ascender_tool = isunlocked;
    }
  }
}

function function_f045fd5df4bf1896(isunlocked) {
  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  var_b4e0ee16bfdf7885 = level.players[0];

  if(isunlocked == 1 || isunlocked == 0) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", "cp_jup_parachute_activated", isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.parachute_activated = isunlocked;
    }
  }
}

function function_ed4f7e1b0b42e2c4(isunlocked, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(isunlocked == 1 || isunlocked == 0) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_nvg", isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.nvg = isunlocked;
    }
  }
}

function function_58311dfacdcaf94c(plate_level, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(!isDefined(plate_level)) {
    var_60e6f0db21be5b54 = var_b4e0ee16bfdf7885 getprogressiondata("spProgData", var_2bfb2e8196104365 + "_plate_level");
    plate_level = var_60e6f0db21be5b54 + 1;
  }

  if(plate_level <= 3) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_plate_level", plate_level);
    level.var_1b908bf18691b097.plate_level = plate_level;
  }
}

function function_7b9d564209811c6e(index, isunlocked, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  assertex(isDefined(index), "UpdateMissionDDL_ks_unlock called without specifying the index");

  if(!isDefined(index)) {
    return;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(index >= 0 && index < 4) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_ks_unlocks", index, isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.var_761018175530ce24[index] = isunlocked;
    }
  }
}

function function_3c666ab28a3f2008(index, isunlocked, missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  assertex(isDefined(index), "UpdateMissionDDL_map_unlock called without specifying the index");

  if(!isDefined(index)) {
    return;
  }

  var_2bfb2e8196104365 = function_ce720be6f935d1d4(missionname);
  var_b4e0ee16bfdf7885 = level.players[0];

  if(index >= 0 && index < 16) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_map_unlocks", index, isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.var_eee1738f65c4792a[index] = isunlocked;
    }
  }
}

function function_cc8a338bb3b0a9fe(index, isunlocked, missionname) {
  var_2bfb2e8196104365 = default_to(missionname, function_ce720be6f935d1d4(level.mapname));

  if(!isDefined(isunlocked)) {
    isunlocked = 1;
  }

  assertex(isDefined(index), "UpdateMissionDDL_discoverables_unlock called without specifying the index");

  if(!isDefined(index)) {
    return;
  }

  var_b4e0ee16bfdf7885 = level.players[0];

  if(index >= 0 && index < function_e1e2c6c4a3a0ebad()) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_discoverables", index, isunlocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.discoverables[index] = isunlocked;
    }
  }
}

function function_bad5ef3aa306f41f(index, islocked, missionname) {
  var_2bfb2e8196104365 = default_to(missionname, function_ce720be6f935d1d4(level.mapname));

  if(!isDefined(islocked)) {
    islocked = 1;
  }

  assertex(isDefined(index), "UpdateMissionDDL_plate_carriers_unlock called without specifying the index");

  if(!isDefined(index)) {
    return;
  }

  var_b4e0ee16bfdf7885 = level.players[0];

  if(index >= 0 && index < 25) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_2bfb2e8196104365 + "_plate_carriers", index, islocked);

    if(isDefined(level.var_1b908bf18691b097)) {
      level.var_1b908bf18691b097.plate_carriers[index] = islocked;
    }
  }
}

function function_e1e2c6c4a3a0ebad(missionname) {
  missionname = default_to(missionname, function_ce720be6f935d1d4(level.mapname));

  switch (missionname) {
    case #"hash_c3c819184bc33817":
      var_8fd4f4614f12573 = 350;
      break;
    case #"hash_5c03122b70ff4094":
      var_8fd4f4614f12573 = 200;
      break;
    case #"hash_619829c7b3c4c3e3":
      var_8fd4f4614f12573 = 64;
      break;
    case #"hash_3705bde815a332ea":
      var_8fd4f4614f12573 = 128;
      break;
    case #"hash_6b2477606925177a":
      var_8fd4f4614f12573 = 128;
      break;
    case #"hash_8e2389607af0427b":
      var_8fd4f4614f12573 = 128;
      break;
    default:
      var_8fd4f4614f12573 = 64;
      break;
  }

  return var_8fd4f4614f12573;
}

function function_c9e9a9b526daf36a() {
  return 3;
}

function function_7a8132b8df34eec4() {
  return true;
}

function function_5b284c7d428229fb() {
  return 25;
}

function function_c795e60600c096c9() {
  return ["cp_jup_apt", "cp_jup_chemical", "cp_jup_dam", "cp_jup_port", "cp_jup_ranch", "cp_jup_resort"];
}

function function_e4c6e53c9f6e94c8(var_ed8ae2e428c38839, var_c31c79e40a0f1610, predicate, var_e2e57e89a2e974e0, var_b3484693f17ad5a) {
  if(!isDefined(var_ed8ae2e428c38839) || level.gametype != "dungeons") {
    return;
  }

  if(function_809ac4c516df27d3(predicate) || isDefined(predicate) && !isint(predicate)) {
    return;
  }

  currentprogress = 0;
  var_b3484693f17ad5a = default_to(var_b3484693f17ad5a, 1);
  var_e2e57e89a2e974e0 = default_to(var_e2e57e89a2e974e0, 1);

  if(isDefined(var_c31c79e40a0f1610)) {
    currentprogress = function_fb43dbfed97eef6a(var_c31c79e40a0f1610);
  }

  newprogress = currentprogress + var_b3484693f17ad5a;

  level.player iprintlnbold("<dev string:x235>" + var_ed8ae2e428c38839 + "<dev string:x238>" + newprogress);

  if(var_e2e57e89a2e974e0 || isDefined(predicate) && isint(predicate) && newprogress >= predicate) {
    level.player function_6a369480dbaf1090(var_ed8ae2e428c38839, newprogress);
  }

  if(isDefined(var_c31c79e40a0f1610)) {
    level.player setprogressiondata("spData", var_c31c79e40a0f1610, newprogress);
  }
}

function function_fb43dbfed97eef6a(var_c31c79e40a0f1610) {
  return default_to(level.player getprogressiondata("spData", var_c31c79e40a0f1610), 0);
}

function private function_809ac4c516df27d3(predicate) {
  if(isDefined(predicate)) {
    if(isfunction(predicate)) {
      return istrue([[predicate]]());
    } else if(isstring(predicate)) {
      var_62edc2f36ec2afb7 = function_fb43dbfed97eef6a(predicate);

      if(istrue(var_62edc2f36ec2afb7)) {
        return true;
      }
    }
  }

  return false;
}

function function_5c700aae58d02578() {
  level endon("game_ended");

  while(true) {
    if(level.mapname == "cp_jup_chemical") {
      flag_wait("infil_player_landed");
      waittillframeend();
    }

    level.player waittill("player_landed", var_b6a57549a0ce42f1);

    if(!isDefined(var_b6a57549a0ce42f1) || !istrue(var_b6a57549a0ce42f1.var_4ade7c346de27170.parachute)) {
      continue;
    }

    if(level.mapname == "cp_jup_port") {
      roof = getnoentvolumearray("achievement_fightOrFlight_roof", "script_noteworthy");

      if(isDefined(roof) && roof[0] namespace_d18e5dabdf7709e4::function_b7755ccb57f05b94(level.player.origin)) {
        cranes = getnoentvolumearray("achievement_fightOrFlight_crane", "script_noteworthy");

        if(isDefined(cranes)) {
          foreach(crane in cranes) {
            if(crane namespace_d18e5dabdf7709e4::function_b7755ccb57f05b94(var_b6a57549a0ce42f1.last_good_pos)) {
              namespace_1170726b2799ea65::function_e4c6e53c9f6e94c8("jup_sp_fightorflight");
            }
          }
        }
      }
    }

    distancemeters = distance(var_b6a57549a0ce42f1.last_good_pos, level.player.origin) * 0.0254;

    if(distancemeters >= 150) {
      function_e4c6e53c9f6e94c8("jup_sp_frequentflier");
    }

    waitframe();
  }
}

function private function_7cdf2ace21ffd216() {}

function function_40b2971a2486ffe1() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_blueprint_crate_dungeons", &function_d6f497a23e94db93);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_loadout_crate_dungeons", &function_b716a25f1ab9e6f6);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_loadout_pile", &function_b5587a46d5f44f68);
  setdvarifuninitialized(@ "hash_9c7b7540824ac88e", 0);

  level thread namespace_cfe848c6b27fe834::function_e3c4d9826d0b82f6();
}

function function_2e9d1ffd6d4f7e1(missionname) {
  missiondata = spawnStruct();
  missiondata.missionname = missionname;
  missiondata.scriptbundle = getscriptbundle("sandboxmission_unlocklist:" + missionname + "_unlocklist");
  missiondata.attempts = level.player getprogressiondata("spProgData", missionname + "_attempts");
  missiondata.unlocks = [];
  var_dec1d52ffce12e7b = [];
  var_884e10986cbfccc7 = [];

  if(missiondata.attempts == 0) {
    for(i = 0; i < missiondata.scriptbundle.unlocklist.size; i++) {
      var_dec1d52ffce12e7b[i] = level.player function_fef34e1a36b57bf6(missionname, i);
      var_884e10986cbfccc7[i] = missiondata.scriptbundle.unlocklist[i].isunlocked;
    }

    var_cce446b3e29a3f83 = 0;

    for(i = 0; i < var_dec1d52ffce12e7b.size; i++) {
      if(var_dec1d52ffce12e7b[i] == 1) {
        var_cce446b3e29a3f83 = 1;
        break;
      }
    }

    if(var_cce446b3e29a3f83 == 0) {
      var_dec1d52ffce12e7b = var_884e10986cbfccc7;

      for(i = 0; i < missiondata.scriptbundle.unlocklist.size; i++) {
        level.player function_a0d4a0a7264d1772(missionname, i, var_884e10986cbfccc7[i]);
      }
    }

    if(array_compare(var_dec1d52ffce12e7b, var_884e10986cbfccc7) == 1) {
      missiondata.unlocks = var_884e10986cbfccc7;
    } else {
      missiondata.unlocks = var_dec1d52ffce12e7b;
    }
  } else {
    for(i = 0; i < missiondata.scriptbundle.unlocklist.size; i++) {
      missiondata.unlocks[i] = level.player function_fef34e1a36b57bf6(missionname, i);
    }
  }

  return missiondata;
}

function function_29c7b140e0c906de(mission) {
  flag_wait("strike_init_done");
  flag_wait("scriptables_ready");
  flag_wait("dungeon_load_finished");
  flag_wait("loot_hack_complete");
  var_d25dda2927a1f8da = 0;
  var_2bf46003ba58c954 = [];
  flag_wait("item_caches_populated");

  if(getdvarint(@ "hash_9c7b7540824ac88e", 0) == 1) {
    var_2bf46003ba58c954 = level.var_2bf46003ba58c954;
  } else {
    var_141babbdcbee2031 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_pistol");
    var_d9b74d1eb592e7d8 = getentitylessscriptablearray("cp_blueprint_crate_dungeons");
    var_d9b74d1eb592e7d8 = array_combine(var_d9b74d1eb592e7d8, getentitylessscriptablearray("cp_blueprint_crate_dungeons_depth01"));
    var_d9b74d1eb592e7d8 = array_combine(var_d9b74d1eb592e7d8, getentitylessscriptablearray("cp_blueprint_crate_dungeons_depth03"));
    var_d9b74d1eb592e7d8 = array_combine(var_d9b74d1eb592e7d8, getentitylessscriptablearray("cp_blueprint_crate_dungeons_depth06"));
    var_d4fa1b0bd1f675c5 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_large");
    var_d4fa1b0bd1f675c5 = array_combine(var_d4fa1b0bd1f675c5, getentitylessscriptablearray("cp_blueprint_crate_dungeons_large_depth01"));
    var_d4fa1b0bd1f675c5 = array_combine(var_d4fa1b0bd1f675c5, getentitylessscriptablearray("cp_blueprint_crate_dungeons_large_depth03"));
    var_d4fa1b0bd1f675c5 = array_combine(var_d4fa1b0bd1f675c5, getentitylessscriptablearray("cp_blueprint_crate_dungeons_large_depth06"));
    var_d4fa1b0bd1f675c5 = array_combine(var_d4fa1b0bd1f675c5, getentitylessscriptablearray("cp_blueprint_crate_dungeons_large_depth10"));
    var_eb101bd59341bbe1 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge");
    var_eb101bd59341bbe1 = array_combine(var_eb101bd59341bbe1, getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge_depth03"));
    var_eb101bd59341bbe1 = array_combine(var_eb101bd59341bbe1, getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge_depth07"));
    var_eb101bd59341bbe1 = array_combine(var_eb101bd59341bbe1, getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge_depth15"));
    var_eb101bd59341bbe1 = array_combine(var_eb101bd59341bbe1, getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge_depth30"));
    var_2bf46003ba58c954 = array_combine(var_d9b74d1eb592e7d8, var_d4fa1b0bd1f675c5, var_eb101bd59341bbe1, var_141babbdcbee2031);
    level.var_2bf46003ba58c954 = var_2bf46003ba58c954;
  }

  if(mission == "cp_jup_lootbox_unlock_wb") {
    var_d25dda2927a1f8da = 1;
  }

  if(mission == "cp_jup_lootbox_unlock_wb") {
    sandboxmissions = ["cp_jup_apt", "cp_jup_chemical", "cp_jup_dam", "cp_jup_port", "cp_jup_ranch", "cp_jup_resort"];
  } else {
    sandboxmissions = [function_ce720be6f935d1d4(mission)];
  }

  var_5db3d9282f4cd51b = [];

  for(i = 0; i < sandboxmissions.size; i++) {
    missionname = sandboxmissions[i];
    var_5db3d9282f4cd51b[i] = function_2e9d1ffd6d4f7e1(missionname);
  }

  if(!isDefined(var_2bf46003ba58c954) || is_equal(var_2bf46003ba58c954.size, 0)) {
    return;
  }

  for(id = 0; id < var_2bf46003ba58c954.size; id++) {
    var_fa819f01102b9048 = var_2bf46003ba58c954[id];
    missionname = var_fa819f01102b9048.missionname;
    var_614ed255922d8001 = 1;
    mission_override = 0;

    if(!isDefined(missionname)) {
      if(isDefined(mission)) {
        missionname = function_ce720be6f935d1d4(mission);
      } else {
        missionname = function_ce720be6f935d1d4(level.mapname, 1);
        mission_override = 1;
      }
    } else {
      mission_override = 1;
    }

    box_contents = isDefined(var_fa819f01102b9048.script_noteworthy) ? var_fa819f01102b9048.script_noteworthy : var_fa819f01102b9048.itemname;

    if(!isDefined(box_contents)) {
      println("<dev string:x23b>" + var_fa819f01102b9048.origin);
      var_614ed255922d8001 = 0;
    }

    if(var_614ed255922d8001 == 1) {
      if(!isDefined(mission)) {
        var_d7a6548f32143da5 = undefined;

        for(i = 0; i < var_5db3d9282f4cd51b.size; i++) {
          if(var_5db3d9282f4cd51b[i].missionname == missionname) {
            missionindex = i;
          }
        }
      } else {
        var_d7a6548f32143da5 = function_ce720be6f935d1d4(mission);
        missionindex = 0;
      }

      itemslot = undefined;

      for(i = 0; i < var_5db3d9282f4cd51b[missionindex].scriptbundle.unlocklist.size; i++) {
        item_checking = var_5db3d9282f4cd51b[missionindex].scriptbundle.unlocklist[i];

        if(item_checking.equipment == box_contents || item_checking.super == box_contents || item_checking.weaponblueprint == box_contents || item_checking.weaponid == box_contents) {
          itemslot = i;
          break;
        }
      }

      if(isDefined(itemslot)) {
        if(level.player function_fef34e1a36b57bf6(missionname, itemslot) == 1) {
          function_63bb9d1cd72deb8b(var_fa819f01102b9048, box_contents);
        } else {
          thread function_4342188980d175a(var_fa819f01102b9048, box_contents);
        }
      }
    }

    waitframe();
  }
}

function function_a15b9a53bdf93971(var_1b276f35dd9e0aea, dropinfo) {
  var_acc87f20536c1e10 = undefined;
  spawneditem = undefined;
  var_1b276f35dd9e0aea = strip_suffix(var_1b276f35dd9e0aea, "_mp");
  var_1b276f35dd9e0aea = strip_suffix(var_1b276f35dd9e0aea, "_ob");
  var_1b276f35dd9e0aea = strip_suffix(var_1b276f35dd9e0aea, "_jup");
  println("<dev string:x260>" + var_1b276f35dd9e0aea);

  switch (var_1b276f35dd9e0aea) {
    case #"hash_ac2ab6307a9fe4ec":
      var_acc87f20536c1e10 = "brloot_super_armorbox";
      break;
    case #"hash_3d18c216d6eeb2cc":
      var_acc87f20536c1e10 = "brloot_super_suppressionrounds";
      break;
    case #"hash_6f4c7534ae718637":
      var_acc87f20536c1e10 = "brloot_super_taccover";
      break;
    case #"hash_cedad6d52b2b36c2":
      var_acc87f20536c1e10 = "brloot_super_heartbeatsensor";
      break;
    case #"hash_29972969a98220a1":
      var_acc87f20536c1e10 = "brloot_super_munitionsbox";
      break;
    case #"hash_4599084f04ba2bfe":
      var_acc87f20536c1e10 = "brloot_super_sonarpulse";
      break;
    case #"hash_7266a252f51150e9":
      var_acc87f20536c1e10 = "brloot_super_recondrone";
      break;
    case #"hash_2a2d382fc09b9c1b":
      var_acc87f20536c1e10 = "brloot_super_tacticalcamera";
      break;
    default:
      var_acc87f20536c1e10 = undefined;
      break;
  }

  if(isDefined(var_acc87f20536c1e10)) {
    spawneditem = scripts\cp\pickups::spawnpickup(var_acc87f20536c1e10, dropinfo, 1);
    spawneditem disablescriptableplayeruse(level.player);
  }

  return spawneditem;
}

function function_7f422514e0bd54e4(weapon_obj) {
  switch (weapon_obj.basename) {
    case #"hash_87262a67e163f7c9":
      ammo_count = weaponclipsize(weapon_obj) * 10;
      break;
    default:
      ammo_count = weaponclipsize(weapon_obj) * 3;
      break;
  }

  return ammo_count;
}

function function_ac85cab902c62430(newweapon) {
  return 60;
}

function function_57ecbf1081ef772c(newweapon) {
  return 60;
}

function function_4ff8438426311e0f(var_1b276f35dd9e0aea, item_name, item_id, var_7391e47bc337367c) {
  objweapon = scripts\cp\weapon::function_768c9a047aed19f4(var_1b276f35dd9e0aea);
  weapon_name = scripts\cp_mp\weapon::getweaponrootname(item_name);

  if(isDefined(var_7391e47bc337367c)) {
    weapon_variant = function_64ccc54bdbae5cf6(var_7391e47bc337367c);
    weapon_camo = function_c7771194200d360e(var_7391e47bc337367c);
  } else {
    weapon_variant = function_64ccc54bdbae5cf6(item_id);
    weapon_camo = function_c7771194200d360e(item_id);
  }

  if(!isDefined(weapon_camo)) {
    weapon_camo = "none";
  }

  println("<dev string:x273>" + weapon_name);

  if(isDefined(weapon_variant)) {
    weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(weapon_name, weapon_camo, "none", weapon_variant);
  } else {
    println("<dev string:x28b>");
    weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(weapon_name, weapon_camo, "none", 0);
  }

  return weapon_obj;
}

function function_ab13214d963e223f(weapon_obj, item_id, var_7391e47bc337367c, var_fa819f01102b9048, dropinfo) {
  var_962d7583f68be225 = getcompleteweaponname(weapon_obj);

  if(isDefined(var_fa819f01102b9048.script_count)) {
    ammo_count = var_fa819f01102b9048.script_count;
  } else {
    ammo_count = function_7f422514e0bd54e4(weapon_obj);
  }

  var_d226ec5acedacd3c = weapon_obj.displayname;
  spawneditem = scripts\cp\pickups::spawnpickup(var_962d7583f68be225, dropinfo, ammo_count, 0, weapon_obj, 0);
  spawneditem disablescriptableplayeruse(level.player);

  if(isDefined(var_7391e47bc337367c) && isDefined(item_id)) {
    spawneditem.var_9b7df99df9e2fe65 = item_id;
  }

  spawneditem.var_b5c99a0d29afb1ac = 1;
  return spawneditem;
}

function function_e7aaa45f3161e592(var_1b276f35dd9e0aea, item_name, item_id, var_7391e47bc337367c, var_fa819f01102b9048, dropinfo) {
  objweapon = scripts\cp\weapon::function_768c9a047aed19f4(var_1b276f35dd9e0aea);
  weapon_name = scripts\cp_mp\weapon::getweaponrootname(item_name);

  if(isDefined(var_7391e47bc337367c)) {
    weapon_variant = function_64ccc54bdbae5cf6(var_7391e47bc337367c);
    weapon_camo = function_c7771194200d360e(var_7391e47bc337367c);
  } else {
    weapon_variant = function_64ccc54bdbae5cf6(item_id);
    weapon_camo = function_c7771194200d360e(item_id);
  }

  if(!isDefined(weapon_camo)) {
    weapon_camo = "none";
  }

  println("<dev string:x273>" + weapon_name);

  if(isDefined(weapon_variant)) {
    weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(weapon_name, weapon_camo, "none", weapon_variant);
  } else {
    println("<dev string:x28b>");
    weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(weapon_name, weapon_camo, "none", 0);
  }

  var_962d7583f68be225 = getcompleteweaponname(weapon_obj);

  if(isDefined(var_fa819f01102b9048.script_count)) {
    ammo_count = var_fa819f01102b9048.script_count;
  } else {
    ammo_count = function_7f422514e0bd54e4(weapon_obj);
  }

  var_6112042b063efd67 = function_ac85cab902c62430(weapon_obj);
  var_b9870ce12dac56b3 = function_57ecbf1081ef772c(weapon_obj);
  var_d226ec5acedacd3c = weapon_obj.displayname;
  spawneditem = scripts\cp\pickups::spawnpickup(var_962d7583f68be225, dropinfo, ammo_count, 0, weapon_obj, 0, var_b9870ce12dac56b3, var_6112042b063efd67);
  spawneditem disablescriptableplayeruse(level.player);

  if(isDefined(var_7391e47bc337367c) && isDefined(item_id)) {
    spawneditem.var_9b7df99df9e2fe65 = item_id;
  }

  spawneditem.var_b5c99a0d29afb1ac = 1;
  return spawneditem;
}

function function_3de9d7877f75c529(var_fa819f01102b9048, iteminfo, var_1f213921962c951e, item_type) {
  new_angles = (0, 0, 0);
  bonus_offset = (0, 0, 6);
  box_offset = var_1f213921962c951e.box_offset;

  switch (var_fa819f01102b9048.type) {
    case #"hash_1c91a53a2491ebf6":
    case #"hash_7d4f4a065120d548":
      new_angles += (0, 0, 90);
      break;
    default:
      if(item_type == "weapon") {
        new_angles += (0, 0, 90);
      } else {
        new_angles += (0, -90, 0);
      }

      break;
  }

  new_angles += iteminfo.var_298349d024e91598;
  weapon_offset = iteminfo.weaponoffset;

  if(var_fa819f01102b9048.type == "scriptable_cp_blueprint_crate_dungeons_pistol" || var_fa819f01102b9048.type == "cp_blueprint_crate_dungeons_pistol") {
    bonus_offset = (0, 0, 0);
    box_offset = (0, 0, 0);
  }

  final_angles = combineangles(var_fa819f01102b9048.angles, new_angles);
  combined_offsets = box_offset + weapon_offset + bonus_offset;
  world_offset = rotatevector(combined_offsets, var_fa819f01102b9048.angles);
  final_position = var_fa819f01102b9048.origin + world_offset;
  dropinfo = spawnStruct();
  dropinfo.origin = final_position;
  dropinfo.angles = final_angles;
  dropinfo.var_b5c99a0d29afb1ac = 1;
  dropinfo.payload = 0;
  dropinfo.var_97331585b4002aa7 = 1;
  return dropinfo;
}

function function_7f8a8c961b21d573(item_name) {
  if(string_starts_with(item_name, " ") && item_name != "") {
    item_name = getsubstr(item_name, 1);
  }

  if(issubstr(item_name, "_mp") || issubstr(item_name, "_cp")) {
    item_name = strip_suffix(item_name, "_cp");
    item_name = strip_suffix(item_name, "_mp");

    if(string_starts_with(item_name, "equip_")) {
      item_name = strip_suffix(item_name, "_jup");
    }
  }

  return item_name;
}

function function_63bb9d1cd72deb8b(var_fa819f01102b9048, item_name) {
  if(istrue(var_fa819f01102b9048.isopened)) {
    return;
  }

  var_fa819f01102b9048.isopened = 1;
  var_f4c6bda68d182f75 = 0;

  if(isent(var_fa819f01102b9048)) {
    var_f4c6bda68d182f75 = 1;
  }

  spawneditem = undefined;
  var_1794342ed0ece8ff = item_name;
  item_name = function_7f8a8c961b21d573(item_name);
  item_id = scripts\cp_mp\utility\loot::getlootidfromref(item_name);
  item_type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(item_id);
  var_1b276f35dd9e0aea = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(item_id);
  boxtype = var_fa819f01102b9048.type;
  iteminfo = namespace_cfe848c6b27fe834::function_231f43f1d8cf0ef1(var_1794342ed0ece8ff);
  var_1f213921962c951e = namespace_cfe848c6b27fe834::function_6c8f43b0ad6fe1(boxtype, iteminfo.var_3124d97e64e2ed57);
  dropinfo = function_3de9d7877f75c529(var_fa819f01102b9048, iteminfo, var_1f213921962c951e, item_type);
  var_fa819f01102b9048.var_1f213921962c951e = var_1f213921962c951e;

  switch (item_type) {
    case #"hash_27124c6c97ccffa1":
      spawneditem = function_e7aaa45f3161e592(var_1b276f35dd9e0aea, item_name, item_id, undefined, var_fa819f01102b9048, dropinfo);
      break;
    case #"hash_e534fd8ec73eafb4":
      spawneditem = function_a15b9a53bdf93971(var_1b276f35dd9e0aea, dropinfo);
      break;
  }

  var_fa819f01102b9048.spawneditem = spawneditem;
  var_fa819f01102b9048.var_cea55c49c1be059f = spawneditem.origin;
  spawneditem.itembox = var_fa819f01102b9048;
  spawneditem.box_offset = var_1f213921962c951e.box_offset;
  spawneditem.weapon_offset = iteminfo.weaponoffset;
  var_fa819f01102b9048 setscriptablepartstate("cp_blueprint_crate_dungeons", "fully_open_unusable");
  spawneditem enablescriptableplayeruse(level.player);
}

function function_d6f497a23e94db93(instance, part, state, player, bautouse, usestring) {
  thread function_d100e5bc9c6f93b9(instance, part, state, player, bautouse, usestring);
}

function function_d100e5bc9c6f93b9(instance, part, state, player, bautouse, usestring) {
  var_fa819f01102b9048 = instance;
  var_f4c6bda68d182f75 = 0;

  if(isDefined(instance.entity)) {
    var_f4c6bda68d182f75 = 1;
    var_fa819f01102b9048 = instance.entity;
  }

  if(istrue(var_fa819f01102b9048.isopened)) {
    return;
  }

  var_fa819f01102b9048.isopened = 1;
  var_b1384b7a11a4b6d = 0;

  if(isDefined(var_fa819f01102b9048.itemname)) {
    item_name = var_fa819f01102b9048.itemname;
  } else {
    item_name = var_fa819f01102b9048.script_noteworthy;
  }

  if(isDefined(var_fa819f01102b9048.missionname)) {
    mission_unlock = var_fa819f01102b9048.missionname;
    var_b1384b7a11a4b6d = 1;
  } else {
    mission_unlock = function_ce720be6f935d1d4(level.mapname);
  }

  println("<dev string:x2b5>" + mission_unlock);
  var_d226ec5acedacd3c = undefined;
  var_d3ba0e31867f03fc = undefined;
  var_7391e47bc337367c = undefined;
  var_5c3c19452417fd1c = 0;
  var_e0fbe3abd2214926 = item_name;
  println("<dev string:x2ca>" + item_name);
  item_name = function_7f8a8c961b21d573(item_name);
  var_7391e47bc337367c = scripts\cp_mp\utility\loot::getlootidfromref(item_name);
  println("<dev string:x2e1>" + var_7391e47bc337367c);

  if(var_7391e47bc337367c == 0) {
    println("<dev string:x2f8>");
    var_7391e47bc337367c = getlootidfromref(item_name);
  }

  item_id = undefined;
  var_a47a8cad864ef139 = 0;
  println("<dev string:x31f>" + mission_unlock);

  for(i = 0; i < 40; i++) {
    if(int(var_7391e47bc337367c) == int(level.player function_e511e6f4347ff261(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), i))) {
      var_a47a8cad864ef139 = 1;
      item_id = i;
      break;
    }
  }

  item_type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(var_7391e47bc337367c);
  var_1b276f35dd9e0aea = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(var_7391e47bc337367c);
  box_type = var_fa819f01102b9048.type;
  iteminfo = namespace_cfe848c6b27fe834::function_231f43f1d8cf0ef1(var_e0fbe3abd2214926);
  var_1f213921962c951e = namespace_cfe848c6b27fe834::function_6c8f43b0ad6fe1(box_type, iteminfo.var_3124d97e64e2ed57);
  var_fa819f01102b9048.var_1f213921962c951e = var_1f213921962c951e;
  dropinfo = function_3de9d7877f75c529(var_fa819f01102b9048, iteminfo, var_1f213921962c951e, item_type);

  if(!flag("map_scanner_idle") && istrue(var_fa819f01102b9048.var_b0a89836085223fc) && (!isDefined(var_fa819f01102b9048.var_c19e3c62ad7e396c) || !isDefined(var_fa819f01102b9048.spawneditem))) {
    var_fa819f01102b9048 waittill_notify_or_timeout("item_spawned", 1);
  }

  if(!isDefined(var_fa819f01102b9048.spawneditem)) {
    var_fa819f01102b9048 notify("item_cache_preload_aborted");

    if(isDefined(var_fa819f01102b9048.var_c19e3c62ad7e396c) && var_fa819f01102b9048.var_c19e3c62ad7e396c isscriptableinstance()) {
      var_fa819f01102b9048.var_c19e3c62ad7e396c freescriptable();
    }

    switch (item_type) {
      case #"hash_27124c6c97ccffa1":
        weapon_obj = function_4ff8438426311e0f(var_1b276f35dd9e0aea, item_name, item_id, var_7391e47bc337367c);
        spawneditem = function_ab13214d963e223f(weapon_obj, item_id, var_7391e47bc337367c, var_fa819f01102b9048, dropinfo);

        if(isDefined(weapon_obj)) {
          var_b60f4ada498a350c = 50;
          var_a4007eb2a63d3e78 = var_b60f4ada498a350c;

          while(!weapon_obj function_f4070ccd888c07b9()) {
            wait 0.1;
            var_a4007eb2a63d3e78 -= 1;

            if(var_a4007eb2a63d3e78 == 0) {
              println("<dev string:x333>" + item_name + "<dev string:xe1>" + var_b60f4ada498a350c * 0.1 + "<dev string:xf5>");
              break;
            }
          }

          if(var_a4007eb2a63d3e78 > 0) {
            println("<dev string:x333>" + item_name + "<dev string:x348>" + (var_b60f4ada498a350c - var_a4007eb2a63d3e78) * 0.1 + "<dev string:x359>");
          }
        }

        break;
      case #"hash_e534fd8ec73eafb4":
        spawneditem = function_a15b9a53bdf93971(var_1b276f35dd9e0aea, dropinfo);
        break;
    }
  } else {
    var_fa819f01102b9048.spawneditem.origin = dropinfo.origin;
    spawneditem = var_fa819f01102b9048.spawneditem;
  }

  println("<dev string:x35c>" + level.player function_fef34e1a36b57bf6(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), item_id));

  if(!istrue(level.player function_fef34e1a36b57bf6(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), item_id))) {
    level notify("new_splash");
    level.player setclientomnvar("ui_new_item_discovered", var_7391e47bc337367c);
    level.player function_10e81f91fc857e5e(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), item_id, 1);
    var_5c3c19452417fd1c = 1;
    level.player function_a0d4a0a7264d1772(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), item_id, 1);
    println("<dev string:x374>" + var_7391e47bc337367c + "<dev string:x394>" + item_id);
  }

  if(var_5c3c19452417fd1c == 1) {
    spawneditem.var_da00cb32efd73efc = 1;
  }

  telemetrydata = spawnStruct();
  telemetrydata.player = level.player;
  telemetrydata.item_name = item_name;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_open_lootcrate", telemetrydata);
  var_fa819f01102b9048.spawneditem = spawneditem;
  var_fa819f01102b9048.var_cea55c49c1be059f = spawneditem.origin;
  spawneditem.itembox = var_fa819f01102b9048;
  instance setscriptablepartstate(part, "opening_unusable");
  level.player setprogressiondata("spProgData", level.var_82191bfa9f751f4c + "_should_show_loadout", 1);
  function_a946c5633329882(mission_unlock);
  spawneditem enablescriptableplayeruse(level.player);
  var_fa819f01102b9048 notify("blueprint_crate_opened");
  level.player notify("blueprint_crate_opened");
  level notify("blueprint_crate_used", item_name);
  waitframe();

  if(isDefined(var_fa819f01102b9048.spawneditem) && isDefined(var_fa819f01102b9048.spawneditem.origin) && isDefined(dropinfo) && var_fa819f01102b9048.spawneditem.origin[2] == -650) {
    var_fa819f01102b9048.spawneditem.origin = dropinfo.origin;

    for(i = 0; i <= 3; i++) {
      waitframe();

      if(isDefined(var_fa819f01102b9048.spawneditem) && isDefined(var_fa819f01102b9048.spawneditem.origin) && var_fa819f01102b9048.spawneditem.origin[2] == -650) {
        var_fa819f01102b9048.spawneditem.origin = dropinfo.origin;
      }
    }
  }
}

function function_4342188980d175a(var_fa819f01102b9048, item_name) {
  level endon("game_ended");

  if(isDefined(level.player)) {
    level.player endon("death_or_disconnect");
  }

  var_fa819f01102b9048 notify("item_cache_discovery_thread_start");
  var_fa819f01102b9048 endon("item_cache_discovery_thread_start");
  var_fa819f01102b9048 endon("item_cache_preload_aborted");
  var_fa819f01102b9048 waittill("object_discovered");

  if(istrue(var_fa819f01102b9048.var_b0a89836085223fc)) {
    return;
  }

  var_fa819f01102b9048.var_b0a89836085223fc = 1;
  var_b1384b7a11a4b6d = 0;

  if(isDefined(var_fa819f01102b9048.missionname)) {
    mission_unlock = var_fa819f01102b9048.missionname;
    var_b1384b7a11a4b6d = 1;
  } else {
    mission_unlock = function_ce720be6f935d1d4(level.mapname);
  }

  var_e0fbe3abd2214926 = item_name;
  item_name = function_7f8a8c961b21d573(item_name);
  var_7391e47bc337367c = scripts\cp_mp\utility\loot::getlootidfromref(item_name);

  if(var_7391e47bc337367c == 0) {
    println("<dev string:x2f8>");
    var_7391e47bc337367c = getlootidfromref(item_name);
  }

  item_id = undefined;
  var_a47a8cad864ef139 = 0;

  for(i = 0; i < 40; i++) {
    if(int(var_7391e47bc337367c) == int(level.player function_e511e6f4347ff261(function_ce720be6f935d1d4(mission_unlock, var_b1384b7a11a4b6d), i))) {
      var_a47a8cad864ef139 = 1;
      item_id = i;
      break;
    }
  }

  item_type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(var_7391e47bc337367c);
  var_1b276f35dd9e0aea = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(var_7391e47bc337367c);
  box_type = var_fa819f01102b9048.type;
  iteminfo = namespace_cfe848c6b27fe834::function_231f43f1d8cf0ef1(var_e0fbe3abd2214926);
  var_1f213921962c951e = namespace_cfe848c6b27fe834::function_6c8f43b0ad6fe1(box_type, iteminfo.var_3124d97e64e2ed57);
  var_fa819f01102b9048.var_1f213921962c951e = var_1f213921962c951e;
  dropinfo = function_3de9d7877f75c529(var_fa819f01102b9048, iteminfo, var_1f213921962c951e, item_type);

  switch (item_type) {
    case #"hash_27124c6c97ccffa1":
      weapon_obj = function_4ff8438426311e0f(var_1b276f35dd9e0aea, item_name, item_id, var_7391e47bc337367c);
      spawneditem = function_ab13214d963e223f(weapon_obj, item_id, var_7391e47bc337367c, var_fa819f01102b9048, dropinfo);
      var_fa819f01102b9048.var_c19e3c62ad7e396c = spawneditem;

      if(isDefined(weapon_obj)) {
        var_b60f4ada498a350c = 50;
        var_a4007eb2a63d3e78 = var_b60f4ada498a350c;

        while(!weapon_obj function_f4070ccd888c07b9()) {
          wait 0.1;
          var_a4007eb2a63d3e78 -= 1;

          if(var_a4007eb2a63d3e78 == 0) {
            println("<dev string:x333>" + item_name + "<dev string:xe1>" + var_b60f4ada498a350c * 0.1 + "<dev string:xf5>");
            break;
          }
        }

        if(var_a4007eb2a63d3e78 > 0) {
          println("<dev string:x333>" + item_name + "<dev string:x348>" + (var_b60f4ada498a350c - var_a4007eb2a63d3e78) * 0.1 + "<dev string:x359>");
        }
      }

      break;
    case #"hash_e534fd8ec73eafb4":
      spawneditem = function_a15b9a53bdf93971(var_1b276f35dd9e0aea, dropinfo);
      var_fa819f01102b9048.var_c19e3c62ad7e396c = spawneditem;
      break;
  }

  if(isDefined(var_fa819f01102b9048.var_c19e3c62ad7e396c)) {
    var_fa819f01102b9048.spawneditem = var_fa819f01102b9048.var_c19e3c62ad7e396c;
    waitframe();

    if(!istrue(var_fa819f01102b9048.isopened)) {
      var_fa819f01102b9048.spawneditem.origin = (var_fa819f01102b9048.spawneditem.origin[0], var_fa819f01102b9048.spawneditem.origin[1], -650);
    }
  }

  var_fa819f01102b9048 notify("item_spawned");
}

function private function_d36ffa7b1ad228e9() {}

function function_b5587a46d5f44f68(instance, part, state, player, bautouse, usestring) {
  if(player val::get("crate_use")) {
    thread function_2047a0d96c8e7504();
    player setclientomnvar("ui_requested_loadout_state", 2);
    player setclientomnvar("ui_options_menu", 5);
    thread function_683f31a0f8a1a6bf(self);
  }
}

function function_b716a25f1ab9e6f6(instance, part, state, player, bautouse, usestring) {
  instance setscriptablepartstate(part, "opening_unusable", 0);
  instance thread function_62f168ca703b055c(instance, part);
  player setclientomnvar("ui_requested_loadout_state", 2);
  player setclientomnvar("ui_options_menu", 5);
}

function function_683f31a0f8a1a6bf(loadout_pile) {
  while(true) {
    level.player waittill("luinotifyserver", channel, value);

    if(channel == "dungeon_loadout_selected") {
      thread function_32ab00dfd93d0138();
      level.player setclientomnvar("ui_options_menu", 0);

      if(value == 1) {
        level.player function_2381e221a64411c2();
      }

      stopmusicstate("mx_frontend_loadout");
      break;
    }
  }
}

function function_2047a0d96c8e7504() {
  level.player playSound("ui_cp_loadout_change_open");
  level.player setsoundsubmix("jup_ui_cp_loadout_change");
}

function function_32ab00dfd93d0138() {
  level.player playSound("ui_cp_loadout_change_close_01");
  level.player clearsoundsubmix("jup_ui_cp_loadout_change", 2);
}

function function_62f168ca703b055c(instance, part) {
  while(true) {
    level.player waittill("luinotifyserver", channel, value);

    if(channel == "dungeon_loadout_selected") {
      level.player setclientomnvar("ui_options_menu", 0);

      if(value == 1) {
        level.player function_2381e221a64411c2();
      }

      instance setscriptablepartstate(part, "closing_unusable");
      instance notify("loadout_crate_opened");
      break;
    }
  }
}

function function_1605b19eafaf18c4() {
  unlock_itemlist = [];
  var_8ad3ed6e5b80bf6b = [];

  for(i = 0; i < 40; i++) {
    unlock_itemlist[i] = level.player function_e511e6f4347ff261(function_ce720be6f935d1d4(level.mapname), i);
  }

  println("<dev string:x3a1>");

  if(unlock_itemlist.size > 0) {
    for(i = 0; i < unlock_itemlist.size; i++) {
      var_8ad3ed6e5b80bf6b[i] = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(unlock_itemlist[i]);
      println("<dev string:x3dc>" + i + "<dev string:x3e3>" + var_8ad3ed6e5b80bf6b[i]);
    }
  }

  var_141babbdcbee2031 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_pistol");
  var_d9b74d1eb592e7d8 = getentitylessscriptablearray("cp_blueprint_crate_dungeons");
  var_d4fa1b0bd1f675c5 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_large");
  var_eb101bd59341bbe1 = getentitylessscriptablearray("cp_blueprint_crate_dungeons_xlarge");
  var_d502a63e660a35b8 = array_combine(var_d9b74d1eb592e7d8, var_d4fa1b0bd1f675c5, var_eb101bd59341bbe1, var_141babbdcbee2031);
  var_64aea63c1344ad60 = [];

  if(var_d502a63e660a35b8.size > 0) {
    println("<dev string:x16e>");
    println("<dev string:x3e5>");

    for(i = 0; i < var_d502a63e660a35b8.size; i++) {
      var_64aea63c1344ad60[i] = var_d502a63e660a35b8[i].script_noteworthy;
      println("<dev string:x420>" + i + "<dev string:x3e3>" + var_64aea63c1344ad60[i]);
    }
  }
}

function function_70a87a63a6332a7b() {
  level.var_b2c3be1433210f36 = 1;
  var_156316a832e946db = ["cp_jup_chemical", "cp_jup_port", "cp_jup_ranch", "cp_jup_resort", "cp_jup_apt", "cp_jup_dam"];

  foreach(mission in var_156316a832e946db) {
    function_6184d3208cbeb4fa(mission);
  }

  flag_set("wait_for_map_data_clear");
  function_84f24763bf2bd555();
}

function function_84f24763bf2bd555() {
  level flag_wait("player_spawned_pre_loadout");
  level.player scripts\cp_mp\armor::givestartingarmor();
}

function function_6184d3208cbeb4fa(missionname) {
  if(!isDefined(missionname)) {
    missionname = level.mapname;
  }

  println("<dev string:x436>" + missionname);
  var_347c6359b52d0f63 = function_ce720be6f935d1d4(missionname);
  function_f7475c0922084f67(var_347c6359b52d0f63);
  var_b4e0ee16bfdf7885 = level.players[0];

  for(i = 0; i < 16; i++) {
    var_b4e0ee16bfdf7885 function_a9652366b0728328(0, i, level.mapname);
  }

  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_attempts", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_should_show_loadout", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_successes", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_ascender_tool", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_nvg", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_checkpoint_id", 0);
  var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_plate_level", 1);

  for(i = 0; i < 16; i++) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_map_unlocks", i, 0);
    level.var_1b908bf18691b097.var_eee1738f65c4792a[i] = 0;
  }

  for(i = 0; i < 4; i++) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_ks_unlocks", i, 0);
    level.var_1b908bf18691b097.var_761018175530ce24[i] = 0;
  }

  for(i = 0; i < function_e1e2c6c4a3a0ebad(var_347c6359b52d0f63); i++) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_discoverables", i, 0);
    level.var_1b908bf18691b097.discoverables[i] = 0;
  }

  for(i = 0; i < 25; i++) {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", var_347c6359b52d0f63 + "_plate_carriers", i, 0);
    level.var_1b908bf18691b097.plate_carriers[i] = 0;
  }

  for(i = 0; i < 16; i++) {
    var_b4e0ee16bfdf7885 function_a9652366b0728328(0, i);
    level.var_4898102a23066ba.objectives[i] = 0;
  }

  if(missionname == "cp_jup_port") {
    var_b4e0ee16bfdf7885 setprogressiondata("spProgData", "cp_jup_parachute_activated", 0);
    level.var_1b908bf18691b097.parachute_activated = 0;
  }

  level.var_1b908bf18691b097.attempts = 0;
  level.var_1b908bf18691b097.successes = 0;
  level.var_1b908bf18691b097.failures = 0;
  level.var_1b908bf18691b097.tacmap = 0;
  level.var_1b908bf18691b097.ascender_tool = 0;
  level.var_1b908bf18691b097.nvg = 0;
  level.var_1b908bf18691b097.checkpoint = 0;
  level.var_1b908bf18691b097.plate_level = 1;
  println(var_347c6359b52d0f63 + "<dev string:x451>");

  if(!isDefined(level.var_b2c3be1433210f36) || level.var_b2c3be1433210f36 == 0) {
    flag_set("wait_for_mission_DDL_data_clear");
    function_84f24763bf2bd555();
  }
}

function private function_37cb5c6458f8c10e() {}

function function_682da8addae457fd(char_string, order) {
  var_9af94c1035c9530e = "<dev string:x477>" + char_string;
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x48e>" + char_string, var_9af94c1035c9530e, &function_83491a0cdbf890f7, undefined, order);
}

function function_83491a0cdbf890f7(param_array) {
  char_string = param_array[0];
  operator_str = level.var_6465a2cba220aab3[char_string];
  scripts\cp\loadout::function_ef21ab05bfa5c5a1(operator_str.forced_operator, operator_str.var_15655027aaaacf68, operator_str.var_965cd465abaa1a, operator_str.var_3e8686bd64fd3f91, operator_str.var_7c8ee05acd3a6e01, operator_str.var_461d3a38ea2cbe91);
  level.player.operatorcustomization.rebuild = 1;
  level.player.operator_struct = level.var_e129f1e4a5717456 deck_draw();
  level.player.pers["<dev string:x4b0>"] = level.player.operator_struct;
  level.player scripts\cp\loadout::setupplayermodel();
}

function function_748fe2e59aef2dea() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x4c2>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4d5>", "<dev string:x4df>", &function_172e687f6523940f);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4e9>", "<dev string:x4fc>", &function_bb319aa2451fc716);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x50d>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x52c>", "<dev string:x53d>", &function_1605b19eafaf18c4);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x54e>", "<dev string:x565>", &function_f7475c0922084f67);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x57c>", "<dev string:x593>", &function_3b07a2411def7296, 1);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x5b0>", "<dev string:x5c7>", &function_6184d3208cbeb4fa);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x5de>", "<dev string:x5fd>", &function_a63edf793f189f5a);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x61c>", "<dev string:x62d>", &function_9a4cab249e22a036);
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x64e>", "<dev string:x65b>");
  scripts\common\devgui::function_fe953f000498048f();
}

function function_a63edf793f189f5a() {
  var_cef669281c67d8aa = level.player getweaponslistall();
  println("<dev string:x67a>");
  println("<dev string:x6c5>");
  println("<dev string:x67a>");

  foreach(weapon in var_cef669281c67d8aa) {
    scripts\cp_mp\weapon::function_c7901c1f857aa1a0(weapon);
  }
}

function function_172e687f6523940f() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player visionsetthermalforplayer("<dev string:x6f5>");
  level.player scripts\cp\pickups::additemtobackpackbyref("<dev string:x70b>", "<dev string:x713>", 1);
  level.player.pers["<dev string:x71e>"] = 1;
}

function function_bb319aa2451fc716() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player scripts\cp\utility::giveperk("<dev string:x725>");
}

function function_3b07a2411def7296() {
  if(!flag_exist("<dev string:x73b>")) {
    flag_init("<dev string:x73b>");
  }

  if(flag("<dev string:x73b>")) {
    flag_clear("<dev string:x73b>");
    return;
  }

  var_141babbdcbee2031 = getentitylessscriptablearray("<dev string:x755>");
  var_d9b74d1eb592e7d8 = getentitylessscriptablearray("<dev string:x778>");
  var_d4fa1b0bd1f675c5 = getentitylessscriptablearray("<dev string:x794>");
  var_eb101bd59341bbe1 = getentitylessscriptablearray("<dev string:x7b6>");
  var_4267c3fd3d6b7247 = array_combine(var_d9b74d1eb592e7d8, var_d4fa1b0bd1f675c5, var_eb101bd59341bbe1, var_141babbdcbee2031);

  if(isDefined(level.var_92bc844b6f90242a)) {
    var_4267c3fd3d6b7247 = array_combine(var_4267c3fd3d6b7247, level.var_92bc844b6f90242a);
  }

  if(var_4267c3fd3d6b7247.size > 0) {
    flag_set("<dev string:x73b>");
    thread function_15a346834cfb21b0(var_4267c3fd3d6b7247);
  }
}

function function_15a346834cfb21b0(var_4267c3fd3d6b7247) {
  while(flag("<dev string:x73b>")) {
    foreach(itembox in var_4267c3fd3d6b7247) {
      if(isDefined(itembox.itemname)) {
        var_cfc56849e630ba66 = itembox.itemname;
      } else {
        var_cfc56849e630ba66 = itembox.script_noteworthy;
      }

      var_6cbaadcccd58952 = itembox.origin + (0, 0, 25);

      if(isDefined(var_cfc56849e630ba66)) {
        if(!isDefined(itembox.isopened) || itembox.isopened == 0) {
          var_1568e57fd0e55e34 = 0;
          print3d(var_6cbaadcccd58952, var_cfc56849e630ba66, (0.48, 9.4, 0.76), 0.85, 0.7, 1, 1);
        } else if(isDefined(itembox.isopened) && itembox.isopened == 1) {
          print3d(var_6cbaadcccd58952, "<dev string:x7d9>" + var_cfc56849e630ba66, (1, 0, 0), 0.85, 0.7, 1, 1);
          var_1568e57fd0e55e34 = 1;
        }
      } else {
        print3d(var_6cbaadcccd58952, "<dev string:x7ed>", (0.48, 9.4, 0.76), 0.85, 0.7, 1, 1);
      }

      if(isDefined(level.player)) {
        if(var_1568e57fd0e55e34 == 0) {
          line(level.player.origin, var_6cbaadcccd58952, (0.48, 9.4, 0.76), 0.75);
          continue;
        }

        line(level.player.origin, var_6cbaadcccd58952, (1, 0, 0), 0.75);
      }
    }

    wait 0.05;
  }
}

function function_dfd16174f3e3cd29(targetname, end_targetname, delay, var_6a856aaa6ed967d7) {
  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(targetname)) {
    object = getEnt(targetname, "targetname");
  } else {
    object = self;
  }

  end = undefined;

  if(isDefined(end_targetname)) {
    end = function_1c4d592029f2b0d3(end_targetname);
  } else {
    end = function_1c4d592029f2b0d3(object.target);
  }

  while(true) {
    if(!isDefined(end)) {
      break;
    }

    speed = 120;

    if(isDefined(end.script_noteworthy)) {
      if(!isnumber(end.script_noteworthy)) {
        switch (end.script_noteworthy) {
          case #"hash_fd151a3694ec335":
            speed = 12000;
            break;
          case #"hash_24da4a3cf8d69647":
            speed = 2000;
            break;
          case #"hash_fde9200bb250ca8e":
            speed = 1000;
            break;
          case #"hash_50b13b06e3c137e0":
            speed = 480;
            break;
          case #"hash_9c8ed152deb360f":
            speed = 240;
            break;
          case #"hash_e8f0758a10ec7618":
            speed = 60;
            break;
          default:
            break;
        }
      } else {
        speed = end.script_noteworthy;
      }
    }

    if(isDefined(end.script_flag_true)) {
      flag_wait(end.script_flag_true);
    }

    if(isDefined(end.script_delay)) {
      wait end.script_delay;
    }

    time = distance(object.origin, end.origin) / speed;

    if(time > 0) {
      object rotateTo(end.angles, time);
      object moveTo(end.origin, time);
      wait time;
    }

    if(isDefined(end.script_flag)) {
      flag_set(end.script_flag);
    }

    if(isDefined(end.target)) {
      end = function_1c4d592029f2b0d3(end.target);
      continue;
    }

    break;
  }

  if(istrue(var_6a856aaa6ed967d7)) {
    object delete();
  }
}

function function_5be116fa7a9eb7a7(targetname, end_targetname, delay, var_6a856aaa6ed967d7) {
  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(targetname)) {
    object = getEnt(targetname, "targetname");
  } else {
    object = self;
  }

  end = undefined;

  if(isDefined(end_targetname)) {
    end = function_7a18da6e48b71c35(end_targetname);
  } else {
    end = function_7a18da6e48b71c35(object.target);
  }

  while(true) {
    if(!isDefined(end)) {
      break;
    }

    speed = 120;

    if(isDefined(end.script_noteworthy)) {
      if(!isnumber(end.script_noteworthy)) {
        switch (end.script_noteworthy) {
          case #"hash_fd151a3694ec335":
            speed = 12000;
            break;
          case #"hash_24da4a3cf8d69647":
            speed = 2000;
            break;
          case #"hash_fde9200bb250ca8e":
            speed = 1000;
            break;
          case #"hash_50b13b06e3c137e0":
            speed = 480;
            break;
          case #"hash_9c8ed152deb360f":
            speed = 240;
            break;
          case #"hash_e8f0758a10ec7618":
            speed = 60;
            break;
          default:
            break;
        }
      } else {
        speed = end.script_noteworthy;
      }
    }

    if(isDefined(end.script_flag_true)) {
      flag_wait(end.script_flag_true);
    }

    if(isDefined(end.script_delay)) {
      wait end.script_delay;
    }

    time = distance(object.origin, end.origin) / speed;

    if(time > 0) {
      object rotateTo(end.angles, time);
      object moveTo(end.origin, time);
      wait time;
    }

    if(isDefined(end.script_flag)) {
      flag_set(end.script_flag);
    }

    if(isDefined(end.target)) {
      end = function_7a18da6e48b71c35(end.target);
      continue;
    }

    break;
  }

  if(istrue(var_6a856aaa6ed967d7)) {
    object delete();
  }
}

function function_4090b944fec04037(flag_name, vol_targetname) {
  level flag_wait("level_ready_for_script");
  ents = getEntArray(vol_targetname, "targetname");

  foreach(vol in ents) {
    level thread function_7f9af65edd6122c3(flag_name, vol);
  }
}

function private function_7f9af65edd6122c3(flag_name, vol) {
  level endon("game_ended");
  level endon(flag_name);

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(!level.player istouching(vol)) {
    waitframe();
  }

  level flag_set(flag_name);
}

function private function_1cf18ac15ae7df3f(state) {
  ascenders = getentitylessscriptablearray("military_ascendertop_heavy");

  foreach(ascender in ascenders) {
    ascender setscriptablepartstate("top", state);
  }
}

function function_5933e14a9af84b82(var_ad62847b6044e732) {
  if(var_ad62847b6044e732) {
    level.var_4ed3f3b99d808198 = 1;
    function_1cf18ac15ae7df3f("use");
    return;
  }

  level.var_4ed3f3b99d808198 = 0;
  function_1cf18ac15ae7df3f("inoperable");
}

function function_9529eb86e25b4574() {
  level.var_4ed3f3b99d808198 = undefined;

  if(function_1f067aa9b7648939()) {
    function_1cf18ac15ae7df3f("use");
    return;
  }

  function_1cf18ac15ae7df3f("inoperable");
}

function function_dbf55c8b4e2d4fd1() {
  level flag_wait("<dev string:x7fa>");
  self endon("<dev string:x810>");
  self endon("<dev string:x816>");
  var_8fc496a9b6de32ae = 1;

  while(true) {
    var_9a91c16857c1cf45 = getdvarint(@ "hash_dae30cab4377b4c8", 1);

    if(var_9a91c16857c1cf45 != var_8fc496a9b6de32ae) {
      if(!var_9a91c16857c1cf45) {
        function_5933e14a9af84b82(1);
      } else {
        function_9529eb86e25b4574();
      }

      var_8fc496a9b6de32ae = var_9a91c16857c1cf45;
    }

    waitframe();
  }
}

function function_418b23e1002e9083() {
  level flag_wait("dungeon_load_finished");

  setdvarifuninitialized(@ "hash_dae30cab4377b4c8", 1);

  function_c57e43adc31f7c33("cp_ascender_device");
  var_12e16f1e390a88d0 = getentitylessscriptablearray("cp_ascender_device");

  if(var_12e16f1e390a88d0.size >= 1) {
    function_9529eb86e25b4574();
  } else {
    function_5933e14a9af84b82(1);
  }

  function_547c48dc070b2109(&function_b55d95d35f24de72);

  level.player thread function_dbf55c8b4e2d4fd1();
}

function function_b55d95d35f24de72(instance, player, edgeindex, isinverted, isvertical, ascendervec) {
  if(isDefined(level.player.values["nvg"]) && istrue(level.player val::get("nvg"))) {
    level.player val::set("runNVG", "nvg", 0);
    level.player delaythread(1, &val::set, "runNVG", "nvg", 1);
  }

  level.player notify("ascender_device_use_success");
}

function function_1f067aa9b7648939() {
  if(isDefined(level.var_4ed3f3b99d808198)) {
    return level.var_4ed3f3b99d808198;
  }

  if(!istrue(level.var_bb3505b72e24c478)) {
    is_unlocked = level.var_1b908bf18691b097.ascender_tool;
  } else {
    is_unlocked = istrue(level.player.pers["ascender_device_unlocked"]);
  }

  return is_unlocked;
}

function function_7edca09707286001() {
  level flag_wait("dungeon_load_finished");

  if(!isDefined(level.var_1b908bf18691b097)) {
    if(!isDefined(level.player.pers["kick_downs"])) {
      level.player.pers["kick_downs"] = [];
    }
  }

  var_b4195d9651125898 = getStructArray("unlock_ascender", "targetname");
  array_thread(var_b4195d9651125898, &function_772603b1ff80fa1c);
}

function function_772603b1ff80fa1c() {
  unlock = self;
  var_89019d958485f73a = getentitylessscriptablearray(unlock.target, "targetname");
  assert(var_89019d958485f73a.size == 1);
  var_4b2a6bd9f76be9de = var_89019d958485f73a[0];

  if(istrue(var_4b2a6bd9f76be9de.deployed)) {
    return;
  }

  assert(isDefined(unlock.script_noteworthy));
  unlock_idx = int(unlock.script_noteworthy);
  is_unlocked = 0;

  if(!istrue(level.var_bb3505b72e24c478)) {
    is_unlocked = level.var_1b908bf18691b097.var_eee1738f65c4792a[unlock_idx];
  } else {
    is_unlocked = istrue(level.player.pers["kick_downs"][unlock_idx]);
  }

  if(is_unlocked) {
    function_1083fd74c5a3eece(var_4b2a6bd9f76be9de, 1);
    return;
  }

  var_4b2a6bd9f76be9de setscriptablepartstate("top", "off");
  unlock.angles = (0, 0, 0);
  var_cffca1a9623f41d5 = unlock create_interact(undefined, undefined, 100, 400, &"DUNGEONS/KICKDOWN_ASCENDER_INTERACT");
  var_cffca1a9623f41d5 setusepriority(0);
  var_cffca1a9623f41d5 waittill("trigger");
  var_cffca1a9623f41d5 delete();

  if(!istrue(level.var_bb3505b72e24c478)) {
    function_3c666ab28a3f2008(unlock_idx, 1);
  } else {
    level.player.pers["kick_downs"][unlock_idx] = 1;
  }

  function_1083fd74c5a3eece(var_4b2a6bd9f76be9de, 0);
}

function function_1083fd74c5a3eece(var_4b2a6bd9f76be9de, instant_deploy) {
  if(istrue(var_4b2a6bd9f76be9de.deployed)) {
    return;
  }

  interact = self;
  spool = function_1c4d592029f2b0d3(var_4b2a6bd9f76be9de.target);

  if(!isDefined(spool)) {
    return;
  }

  rope = function_1c4d592029f2b0d3(spool.target);
  var_e1669931c25ceae6 = getStructArray("bottom_marker", "targetname");
  bottom_marker = undefined;

  foreach(marker in var_e1669931c25ceae6) {
    if(is_equal(marker.script_noteworthy, var_4b2a6bd9f76be9de.script_noteworthy)) {
      bottom_marker = marker;
      break;
    }
  }

  assert(isDefined(bottom_marker));
  var_9b9dc458865328ab = rope.origin + (0, 0, 16);
  var_3be3b66a20321f8e = 200;
  var_ac11b9ba0095d9a7 = rope.origin[2] - bottom_marker.origin[2];
  var_7094f05aaa0c4e3d = 0.3;
  var_1d4b9f529e03338a = 1.5;

  if(istrue(instant_deploy)) {
    var_3be3b66a20321f8e = 2000;
    var_7094f05aaa0c4e3d = 0;
    var_1d4b9f529e03338a = 0;
    travel_time = 0.1;
  } else {
    travel_time = var_ac11b9ba0095d9a7 / var_3be3b66a20321f8e;
  }

  var_4b2a6bd9f76be9de.deployed = 1;
  var_de3d56d1f133410f = rope;

  if(!instant_deploy) {
    rope moveTo((rope.origin[0], rope.origin[1], bottom_marker.origin[2]), travel_time, var_7094f05aaa0c4e3d, var_1d4b9f529e03338a);
    spool rotateby((2160, 0, 0), travel_time, var_7094f05aaa0c4e3d, var_1d4b9f529e03338a);
    thread namespace_23750629c2b7a3d3::function_a60e7c732b5440e2(var_9b9dc458865328ab);

    while(true) {
      if(rope.origin[2] <= bottom_marker.origin[2]) {
        break;
      }

      if(var_9b9dc458865328ab[2] - var_de3d56d1f133410f.origin[2] < 16) {
        waitframe();
        continue;
      }

      while(var_9b9dc458865328ab[2] > var_de3d56d1f133410f.origin[2]) {
        new_rope = spawn("script_model", var_de3d56d1f133410f.origin + (0, 0, 16));
        new_rope setModel("decor_dock_boat_rope_spline_01_16_zipline_test");
        new_rope linkTo(var_de3d56d1f133410f, "tag_origin", (0, 0, 16), (0, 0, 0));
        var_de3d56d1f133410f = new_rope;
      }

      waitframe();
    }
  } else {
    steps = var_ac11b9ba0095d9a7 / 16 - 1;

    for(i = 1; i < steps; i++) {
      new_rope = spawn("script_model", rope.origin + (0, 0, -16 * i));
      new_rope setModel("decor_dock_boat_rope_spline_01_16_zipline_test");
      new_rope.angles = rope.angles;
    }
  }

  var_4b2a6bd9f76be9de setscriptablepartstate("top", "use");
}

function function_1c928f4978365d99() {
  level flag_wait("dungeon_load_finished");
  var_24107c4e2ac158a6 = getStructArray("trigger_ascender", "targetname");
  array_thread(var_24107c4e2ac158a6, &function_6fb419ba35f2db16);
}

function function_6fb419ba35f2db16() {
  unlock = self;
  var_89019d958485f73a = getentitylessscriptablearray(unlock.target, "targetname");
  assert(var_89019d958485f73a.size == 1);
  var_4b2a6bd9f76be9de = var_89019d958485f73a[0];
  assert(isDefined(unlock.script_noteworthy));
  var_4b2a6bd9f76be9de setscriptablepartstate("top", "off");
  unlock.angles = (0, 0, 0);
  assert(isDefined(unlock.script_flag_wait));
  level flag_wait(unlock.script_flag_wait);
  function_1083fd74c5a3eece(var_4b2a6bd9f76be9de, 0);
}

function function_6f0de80fb3c3b9d4() {
  level flag_wait("dungeon_load_finished");
  setdvarifuninitialized(@ "hash_3f45e8048e5cf1c6", 1);
  function_c57e43adc31f7c33("cp_parachute_activator");
  var_ccd5c755d9b62345 = getentitylessscriptablearray("cp_parachute_activator");

  if(var_ccd5c755d9b62345.size >= 1) {
    level.var_3d4e22af11e4c0c5 = 1;
    return;
  }

  level.var_3d4e22af11e4c0c5 = 0;
}

function function_26cd112800a1c035() {
  if(!level.var_3d4e22af11e4c0c5 || !getdvarint(@ "hash_3f45e8048e5cf1c6", 1)) {
    return 1;
  }

  if(!istrue(level.var_bb3505b72e24c478)) {
    is_unlocked = level.var_1b908bf18691b097.parachute_activated;
  } else {
    is_unlocked = istrue(level.player.pers["parachute_activator_unlocked"]);
  }

  return is_unlocked;
}

function function_c57e43adc31f7c33(scriptable) {
  structs = getStructArray(scriptable, "targetname");

  if(isDefined(structs) && structs.size > 0) {
    foreach(struct in structs) {
      spawnscriptable(scriptable, struct.origin, struct.angles);
    }
  }
}

function function_525da54dd2ac1fe2(scriptable) {
  self endon("death");
  self endon("disconnect");
  pickups = getentitylessscriptablearray(scriptable);

  if((!isDefined(pickups) || pickups.size == 0) && !flag("cp_custom_pickups_spawned") || !flag("dungeon_load_finished")) {
    flag_wait_all("cp_custom_pickups_spawned", "dungeon_load_finished");
    waitframe();
    pickups = getentitylessscriptablearray(scriptable);
  }

  if(isDefined(pickups) && pickups.size > 0) {
    foreach(instance in pickups) {
      instance setscriptablepartstate(scriptable, "hidden");
    }
  }
}

function waittill_player_lookat(player_fov, min_dist, max_dist, offset, look_radius, hold_time, poll_time, predicates) {
  level endon("game_ended");
  poll_time = default_to(poll_time, 0.25);

  if(!isnumber(poll_time)) {
    assertmsg("waittill_player_lookat requires poll_time to be a number.");
    return;
  }

  var_51013b329d94fb94 = isnumber(hold_time);
  hold_count = 0;

  while(true) {
    wait poll_time;
    target = function_61aef23379ae7542(self, player_fov, min_dist, max_dist, offset, look_radius, predicates);

    if(!isDefined(target)) {
      continue;
    }

    if(!var_51013b329d94fb94) {
      return target;
    }

    hold_count += poll_time;

    if(hold_count >= hold_time) {
      return target;
    }
  }
}

function function_1418dfaca3b1702a() {
  if(isDefined(level.player)) {
    cg_fov = getdvarint(@ "cg_fov");
    zoomfov = level.player playergetzoomfov();
    var_1c2b9d4c764a8bd8 = level.player playerads() || level.player namespace_e875ad14b292bd61::binoculars_isads();
    current_fov = var_1c2b9d4c764a8bd8 ? zoomfov : cg_fov;
    return current_fov;
  }

  return 65;
}

function function_61aef23379ae7542(targets, player_fov, min_dist, max_dist, offset, look_radius, predicates) {
  player = level.player;
  min_dist = default_to(min_dist, 0);
  max_dist = default_to(max_dist, 4000);
  player_fov = default_to(player_fov, function_1418dfaca3b1702a());
  offset = default_to(offset, (0, 0, 0));
  look_radius = default_to(look_radius, 300);
  min_dist_sq = squared(min_dist);
  max_dist_sq = squared(max_dist);
  types_match = isnumber(player_fov) && isnumber(min_dist) && isnumber(max_dist) && isvector(offset) && isnumber(look_radius);

  if(!types_match) {
    assertmsg("player_lookat_any was provided a parameter with the wrong type.");
    return;
  }

  if(!isarray(targets)) {
    targets = [targets];
  }

  if(!isarray(predicates)) {
    predicates = [predicates];
  }

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }

    var_b183161a9e5cab9a = distancesquared(player.origin, target.origin);

    if(var_b183161a9e5cab9a > max_dist_sq || var_b183161a9e5cab9a < min_dist_sq) {
      continue;
    }

    look_at_point = offset;

    if(isai(target)) {
      look_at_point += target getEye() + (0, 0, 12);
    } else if(isDefined(target.origin)) {
      look_at_point += target.origin;
    } else {
      assertmsg("No valid target for player_lookat");
      return undefined;
    }

    is_looking_at = player worldpointinreticle_circle(look_at_point, player_fov, look_radius);
    var_a49fe39fe684c761 = sighttracepassed(look_at_point + (0, 0, 18), player getEye(), 0, target);
    var_98d00ca8ed146469 = 1;

    foreach(predicate in predicates) {
      if(!istrue(var_98d00ca8ed146469)) {
        break;
      }

      if(!isfunction(predicate)) {
        continue;
      }

      var_98d00ca8ed146469 = istrue([[predicate]]());
    }

    if(is_looking_at && var_a49fe39fe684c761 && istrue(var_98d00ca8ed146469)) {
      return target;
    }
  }

  return undefined;
}

function function_8f65921ce7cbe746() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isDefined(level.player.pers)) {
    waitframe();
  }

  level.player.pers["dungeonsPlayerActive"] = 1;
}

function function_8dccb7c870f39d61() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isDefined(level.player.pers)) {
    waitframe();
  }

  while(!isDefined(level.player.pers["dungeonsPlayerActive"])) {
    waitframe();
  }
}

function function_de5ae0c94d33b9c8() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    wait 1;
  }

  level.player endon("death");
  flag_wait("level_ready_for_script");
  oow_vol = function_1c4d592029f2b0d3("debug_outofworld");

  while(isDefined(oow_vol)) {
    oow_vol waittill("trigger", ent);

    if(isPlayer(ent) && (ent isnoclip() || ent isufo())) {
      wait 0.1;
      continue;
    }

    assertmsg("<dev string:x821>" + ent.origin);
    iprintlnbold("<dev string:x821>" + ent.origin);

    if(isPlayer(ent) || isai(ent) || ent scripts\common\vehicle::isvehicle()) {
      ent kill();
    }
  }
}

function function_57d85dbfbd24236() {
  level endon("game_ended");
  self endon("disconnect");
  wait 5;
  maxdistsq = istrue(level.var_dfd215e11ace150f) ? 47886400 : 4000000;

  while(true) {
    wait 0.25;

    if(!isalive(self)) {
      continue;
    }

    if(!isDefined(level.soldier_allies) || level.soldier_allies.size == 0) {
      continue;
    }

    var_c984f49843a26a7b = 0;

    for(i = 0; i < level.soldier_allies.size; i++) {
      if(distance2dsquared(self.origin, level.soldier_allies[i].origin) <= maxdistsq) {
        var_c984f49843a26a7b++;
      }
    }

    if(var_c984f49843a26a7b == 0) {
      self setclientomnvar("ui_target_entity_num", -1);
      self setclientomnvar("ui_target_name_index", -1);
      level.var_9149aa09e5534d8b = -1;
      level.var_e8a53778eb5c127d = undefined;
      continue;
    }

    function_8cefc66e54e3d02e();
  }
}

function function_7c2d0e47d44a53a6() {
  tracestart = self getEye();
  playerangles = self getplayerangles();
  playerlookdir = anglesToForward(playerangles);
  traceend = tracestart + playerlookdir * 2500;
  results = scripts\engine\trace::_bullet_trace(tracestart, traceend, 1, self, 0, 0, 0, 0, 0);
  hitentity = results["entity"];

  if(isDefined(hitentity) && issentient(hitentity) && !isPlayer(hitentity)) {
    if(isDefined(hitentity.team) && isDefined(hitentity.entity_number)) {
      var_e0143f4f183d8a12 = isDefined(hitentity.var_e0143f4f183d8a12);
      team = hitentity.team;
      self setclientomnvar("ui_target_has_callsign", var_e0143f4f183d8a12);
      self setclientomnvar("ui_target_team", team);
      self setclientomnvar("ui_target_entity_num", hitentity.entity_number);
      return hitentity.entity_number;
    }
  }

  self setclientomnvar("ui_target_entity_num", -1);
  self setclientomnvar("ui_target_name_index", -1);
  return -1;
}

function function_f0772b50fc376504() {
  tracestart = self getEye();
  playerangles = self getplayerangles();
  playerlookdir = anglesToForward(playerangles);
  traceend = tracestart + playerlookdir * 2500;
  results = scripts\engine\trace::_bullet_trace(tracestart, traceend, 1, self, 0, 0, 0, 0, 0);
  hitentity = results["entity"];

  if(isDefined(hitentity) && issentient(hitentity) && !isPlayer(hitentity)) {
    if(isDefined(hitentity.team)) {
      var_e0143f4f183d8a12 = isDefined(hitentity.var_e0143f4f183d8a12);
      self setclientomnvar("ui_target_has_callsign", var_e0143f4f183d8a12);
      team = hitentity.team;
      self setclientomnvar("ui_target_team", team);
      name_index = function_ec4bba595b3af91e(hitentity);
      self setclientomnvar("ui_target_name_index", name_index);
      return hitentity.name;
    }
  }

  return undefined;
}

function function_5d38a925b3f9ef49(fov_ents) {
  foreach(ent in fov_ents) {
    if(isDefined(ent.entity_number)) {
      return true;
    }
  }

  return false;
}

function function_8cefc66e54e3d02e() {
  tracestart = self getEye();
  playerangles = self getplayerangles();
  playerlookdir = anglesToForward(playerangles);
  traceend = istrue(level.var_dfd215e11ace150f) ? tracestart + playerlookdir * 7735 : tracestart + playerlookdir * 2500;
  within_fov = 1;

  if(istrue(level.var_dfd215e11ace150f)) {
    var_421f592f3c5f5c57 = 131072;
    fov_ents = self function_c5140fff72feca2d(7735, 0.85, var_421f592f3c5f5c57, 1);
    within_fov = function_5d38a925b3f9ef49(fov_ents);
  }

  if(within_fov) {
    results = scripts\engine\trace::_bullet_trace(tracestart, traceend, 1, self, 0, 0, 0, 0, 0);
    hitentity = results["entity"];

    if(isDefined(hitentity) && issentient(hitentity) && !isPlayer(hitentity)) {
      if(isDefined(hitentity.team) && isDefined(hitentity.entity_number)) {
        var_e0143f4f183d8a12 = isDefined(hitentity.var_e0143f4f183d8a12);
        team = hitentity.team;
        self setclientomnvar("ui_target_has_callsign", var_e0143f4f183d8a12);
        self setclientomnvar("ui_target_team", team);
        self setclientomnvar("ui_target_entity_num", hitentity.entity_number);
        name_index = function_ec4bba595b3af91e(hitentity);
        self setclientomnvar("ui_target_name_index", name_index);
        level.var_9149aa09e5534d8b = hitentity.entity_number;
        level.var_e8a53778eb5c127d = hitentity.name;
        return;
      }
    }
  }

  self setclientomnvar("ui_target_entity_num", -1);
  self setclientomnvar("ui_target_name_index", -1);
  level.var_9149aa09e5534d8b = -1;
  level.var_e8a53778eb5c127d = undefined;
}

function function_ec4bba595b3af91e(hitentity) {
  if(!isDefined(level.ally_names)) {
    function_70829df0e123dce4();
  }

  if(!isDefined(level.axis_names)) {
    function_a598e3b3c0a6eb3d();
  }

  index = -1;
  i = 0;

  foreach(friendly_name in level.ally_names) {
    if(isDefined(hitentity.name) && friendly_name == hitentity.name) {
      index = i;
      return i;
    }

    i += 1;
  }

  index = -1;
  i = 0;

  foreach(enemy_name in level.axis_names) {
    if(isDefined(hitentity.name) && enemy_name == hitentity.name) {
      index = i;
      return i;
    }

    i += 1;
  }

  return index;
}

function function_70829df0e123dce4() {
  row = 0;

  if(!isDefined(level.ally_names)) {
    level.ally_names = [];
  }

  table = "cp/ally_name_table.csv";

  for(i = 0; i < tablelookupgetnumrows("cp/ally_name_table.csv"); i++) {
    level.ally_names[level.ally_names.size] = tablelookupbyrow(table, i, 1);
  }
}

function function_a598e3b3c0a6eb3d() {
  row = 0;

  if(!isDefined(level.axis_names)) {
    level.axis_names = [];
  }

  table = "cp/axis_name_table.csv";

  for(i = 0; i < tablelookupgetnumrows("cp/axis_name_table.csv"); i++) {
    level.axis_names[level.axis_names.size] = tablelookupbyrow(table, i, 1);
  }
}

function function_624150e2bc78e81f(name_override) {
  if(isDefined(name_override)) {
    self.name = name_override;
  }

  if(!isDefined(level.soldier_allies)) {
    level.soldier_allies = [];
  }

  level.soldier_allies[level.soldier_allies.size] = self;
  self.ally_index = level.soldier_allies.size - 1;
  self.entity_number = self getentitynumber();
}

function function_5b13a92c82e81024(killai, var_c4b6602cdb280094) {
  if(!isDefined(var_c4b6602cdb280094)) {
    var_c4b6602cdb280094 = 1;
  }

  level.player freezecontrols(1);
  level.player utility::hidehudenable();
  level.player playerhide();
  level.player.vo_disabled = 1;
  level.player function_54d3bd59bff7e908(1, 1);
  level.player clearhudtutorialmessage();
  battlechatter_off();

  if(isDefined(killai) &killai == 1) {
    enemy_ai = getaiarray("axis");
    enemy_ai = utility::array_removedead_or_dying(enemy_ai);

    if(isDefined(enemy_ai)) {
      foreach(enemy in enemy_ai) {
        if(isDefined(enemy) && isalive(enemy)) {
          enemy.diequietly = 1;
          enemy scripts\cp_mp\agents\agent_utils::despawnagent();
        }
      }
    }
  }

  if(istrue(var_c4b6602cdb280094)) {
    vehicles = getvehiclearray();

    if(isDefined(vehicles)) {
      foreach(vehicle in vehicles) {
        vehicle delete();
      }
    }
  }
}

function function_a946c5633329882(mission) {
  if(!isDefined(mission)) {
    mission = function_ce720be6f935d1d4(level.mapname);
  }

  currentmission = mission;
  var_c7c7a5d27dba64ef = 1;
  bundle = getscriptbundle("sandboxmission_unlocklist:" + mission + "_unlocklist");
  bundle = bundle.unlocklist;
  id_table = [];

  debug_table = [];

  var_ccd658e1ff8631db = 0;

  for(i = 0; i < bundle.size; i++) {
    if(bundle[i].isunlocked == 0) {
      id_table[id_table.size] = i;

      debug_table[debug_table.size] = spawnStruct();
      updated_id = debug_table.size - 1;
      debug_table[updated_id].id = i;
      debug_table[updated_id].unlockstate = level.player function_fef34e1a36b57bf6(currentmission, i);

      var_ccd658e1ff8631db++;
    }
  }

  for(i = 0; i < var_ccd658e1ff8631db; i++) {
    if(!istrue(level.player function_fef34e1a36b57bf6(currentmission, id_table[i]))) {
      var_c7c7a5d27dba64ef = 0;
    }
  }

  if(istrue(var_c7c7a5d27dba64ef)) {
    println("<dev string:x898>" + currentmission);
    level.player setprogressiondata("SandBoxAchievementData", currentmission + "_allitemscollected", 1);
    function_1e54b6af8762d82c();
  }
}

function function_1e54b6af8762d82c() {
  var_15e57f992aae2f7c = 1;
  sandboxmissions = namespace_1170726b2799ea65::function_c795e60600c096c9();

  debug_table = [];

  foreach(mission in sandboxmissions) {
    debug_table[debug_table.size] = spawnStruct();
    debug_table[debug_table.size - 1].mission = mission;
    debug_table[debug_table.size - 1].var_132100fe57354bb1 = level.player getprogressiondata("<dev string:x8ba>", mission + "<dev string:x8d1>");
  }

  for(i = 0; i < sandboxmissions.size; i++) {
    currentmission = sandboxmissions[i];
    var_b0027c0373e9680 = level.player getprogressiondata("SandBoxAchievementData", currentmission + "_allitemscollected");

    if(!istrue(var_b0027c0373e9680)) {
      var_15e57f992aae2f7c = 0;
      return;
    }
  }

  level.player function_6a369480dbaf1090("jup_sp_professionalhoarder");
}

function function_de2d867ede2eebdf() {
  var_140cf66c6caa3b60 = 1;
  sandboxmissions = namespace_1170726b2799ea65::function_c795e60600c096c9();

  for(i = 0; i < sandboxmissions.size; i++) {
    currentmission = sandboxmissions[i];

    if(!istrue(level.player getprogressiondata("SandBoxAchievementData", currentmission + "_changedloadout"))) {
      var_140cf66c6caa3b60 = 0;
      return;
    }
  }

  level.player function_6a369480dbaf1090("jup_sp_timeforanewplan");
}

function function_cece888a7dfbeb0b() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player.var_eb504fc7e1cfeb4c = 1;
  level.player.ff_participation = 0;
  level.var_bf2dc0f07fa83cf0 = -700;
  level.var_8f710a4504c6b92a = 1000;
  level.var_d0194f1352d26da0 = 650;
  level.var_71af99b8f5d6ec32 = 1.25;
}

function function_4576aecf9d0c4082(entity) {
  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    return;
  }

  level endon("ff_mission_failed");
  level childthread notifydamage(entity);
  level childthread notifydeath(entity);
  team = entity.team;

  for(;;) {
    if(!isDefined(entity)) {
      return;
    }

    if(entity.health <= 0) {
      return;
    }

    damage = undefined;
    attacker = undefined;
    direction = undefined;
    point = undefined;
    method = undefined;
    weaponname = undefined;
    entity waittill("friendlyfire_notify", damage, attacker, direction, point, method, objweapon);
    function_937a5f05c5c6114b(entity, team, damage, attacker, direction, point, method, objweapon);
  }
}

function function_937a5f05c5c6114b(entity, team, damage, attacker, direction, point, method, objweapon) {
  if(!isDefined(attacker)) {
    return;
  }

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(objweapon)) {
    objweapon = entity.damageweapon;
  }

  if(isPlayer(attacker)) {
    bplayersdamage = 1;
  } else {
    return;
  }

  if(!bplayersdamage) {
    return;
  }

  killed = damage == -1;

  if(!isDefined(level.team) || !istrue(level.team == "allies")) {
    if(team == "axis" && istrue(killed)) {
      level.player.ff_participation += level.var_d0194f1352d26da0;
      level.player.ff_participation = clamp(level.player.ff_participation, level.var_bf2dc0f07fa83cf0, level.var_8f710a4504c6b92a);
      return;
    } else if(team == "allies") {
      addbattlechatternotify(entity, undefined, "friendly_fire");
    } else {
      return;
    }
  } else {
    addbattlechatternotify(entity, undefined, "friendly_fire");
  }

  if(isDefined(objweapon)) {
    basename = objweapon.basename;

    if(basename == "claymore") {
      return;
    }

    if(basename == "flash") {
      return;
    }

    if(basename == "semtex" && isDefined(entity.semtexstuckto)) {
      damage = 9999;
    }

    if(basename == "throwingknife") {
      damage = 9999;
    }

    if(basename == "molotov") {
      damage = 9999;
    }
  }

  level.player.ff_participation -= damage;
  level.player.ff_participation = clamp(level.player.ff_participation, level.var_bf2dc0f07fa83cf0, level.var_8f710a4504c6b92a);
  childthread function_705bd86edccd093(level.var_71af99b8f5d6ec32, damage);

  if(level.player.ff_participation <= level.var_bf2dc0f07fa83cf0 || istrue(killed)) {
    setomnvar("ui_death_hint", 990);
    thread function_fa7c87f2585bd907(0);
    level notify("ff_mission_failed");
  }
}

function notifydamage(entity) {
  entity endon("death");

  for(;;) {
    entity waittill("damage", damage, attacker, direction, point, method, unused, unused, unused, unused, objweapon);
    entity notify("friendlyfire_notify", damage, attacker, direction, point, method, objweapon);
  }
}

function notifydeath(entity) {
  team = entity.team;
  entity waittill("death", attacker, method, objweapon);
  function_937a5f05c5c6114b(entity, team, -1, attacker, undefined, undefined, method, objweapon);
}

function function_705bd86edccd093(time, damage) {
  wait time;
  level.player.ff_participation += damage;
  level.player.ff_participation = clamp(level.player.ff_participation, level.var_bf2dc0f07fa83cf0, level.var_8f710a4504c6b92a);
}

function function_8e01c459332b0111() {
  flag_wait("dungeon_load_finished");
  flag_wait("scriptables_ready");
  wait 0.2;
  var_277cca8770388aaa = getStructArray("one_way", "script_noteworthy");
  var_1ff5d2ac0e927779 = 100;

  foreach(var_61aca9339f58c4dd in var_277cca8770388aaa) {
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(var_61aca9339f58c4dd.origin, var_1ff5d2ac0e927779, var_1ff5d2ac0e927779);
    door = getclosest(var_61aca9339f58c4dd.origin, doors);
    door thread function_1caab8ea824ad63f(var_61aca9339f58c4dd);
  }
}

function function_1caab8ea824ad63f(unlock_struct) {
  level endon("game_ended");
  var_574153d380277441 = function_7a18da6e48b71c35(unlock_struct.target);
  locked_struct = function_7a18da6e48b71c35(var_574153d380277441.target);
  locked_clip = function_1c4d592029f2b0d3(locked_struct.target);

  if(!isDefined(level.player.pers["one_way_doors"])) {
    level.player.pers["one_way_doors"] = [];
  }

  door_id = function_c5e1e53d08d84cf1();
  function_79a4d351eac40e17();
  self.var_7b4b93daa27c204e = 1;
  locked_prompt = spawn("script_model", locked_struct.origin);
  locked_prompt setModel("tag_origin");
  locked_prompt makeusable();
  var_c220fc433755156a = isDefined(level.var_af4d3c79160d24d9) ? level.var_af4d3c79160d24d9 : 200;
  locked_prompt setHintString(&"MP/DOOR_USE_OPEN");
  locked_prompt setCursorHint("HINT_BUTTON");
  locked_prompt sethintdisplayrange(var_c220fc433755156a);
  locked_prompt sethintdisplayfov(90);
  locked_prompt setuserange(72);
  locked_prompt setusefov(180);
  locked_prompt sethintonobstruction("hide");
  locked_prompt setuseholdduration("duration_short");
  unlock_prompt = spawn("script_model", unlock_struct.origin);
  unlock_prompt setModel("tag_origin");
  unlock_prompt makeusable();
  unlock_prompt setHintString(&"DUNGEONS/ONE_WAY_DOOR_CLEAR");
  unlock_prompt setCursorHint("HINT_BUTTON");
  unlock_prompt sethintdisplayrange(300);
  unlock_prompt sethintdisplayfov(90);
  unlock_prompt setuserange(72);
  unlock_prompt setusefov(180);
  unlock_prompt sethintonobstruction("hide");
  unlock_prompt setuseholdduration("duration_short");
  unlock_prompt.owner = self;
  blocker = spawnscriptable("furniture_wood_rustic_chair_01_apt", var_574153d380277441.origin, var_574153d380277441.angles);
  thread function_963d07814fa1b80a(blocker, door_id);
  thread function_b9f61f4082e19b9f(unlock_prompt, door_id);
  thread function_8c72288bbef1b705(locked_prompt, door_id);
  unlock_condition = undefined;

  if(!istrue(level.player.pers["one_way_doors"][door_id]) || getdvarint(@ "hash_efb137e10a8a6268", 0) == 1) {
    unlock_condition = waittill_any_return_2("blocker_destroyed", "door_unlatched");
  }

  if(is_equal(unlock_condition, "door_unlatched") || istrue(level.player.pers["one_way_doors"][door_id])) {
    blocker setscriptablepartstate("base", "spawn vfx");
  }

  self.var_7b4b93daa27c204e = undefined;
  locked_prompt hide();
  unlock_prompt hide();
  locked_clip hide();
  locked_clip connectpaths();
  function_79a4d351eac40e17(0);
  self scriptabledooropen();
  level.player.pers["one_way_doors"][door_id] = 1;
  level flag_set(door_id + "_solved");
}

function function_8c72288bbef1b705(locked_prompt, door_id) {
  self endon("door_unlatched");
  player_used = 0;

  while(true) {
    locked_prompt function_ae165af362de18a2();

    if(!player_used) {
      thread function_45d78b7e9abdb484(locked_prompt);
      player_used = 1;
    }

    if(isDefined(level.var_83782d6266ec4fb4)) {
      thread[[level.var_83782d6266ec4fb4]]();
    }

    wait 0.25;
    level notify("door_attempted " + door_id);
    wait 0.25;
  }
}

function function_45d78b7e9abdb484(locked_prompt) {
  self endon("door_unlatched");
  locked_prompt hide();
  wait 0.15;
  locked_prompt show();
  locked_prompt setHintString(&"MP_DMZ_LOCKS/STUCK");
}

function function_963d07814fa1b80a(door_blocker, door_id) {
  self endon("door_unlatched");

  while(true) {
    state = door_blocker getscriptablepartstate("base");

    if(state != "pristine vfx-dyn") {
      break;
    }

    wait 0.1;
  }

  self notify("blocker_destroyed");
  level notify("blocker_destroyed " + door_id);
}

function function_b9f61f4082e19b9f(use_prompt, door_id) {
  self endon("blocker_destroyed");
  use_prompt function_ae165af362de18a2();
  self notify("door_unlatched");
  level notify("door_unlatched " + door_id);
}

function function_c5e1e53d08d84cf1() {
  return "" + self.origin;
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\land_mine.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\damage;
#using scripts\core_common\dev_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;
#namespace land_mine;

function private autoexec __init__system__() {
  system::register(#"land_mine", &preinit, undefined, &finalize, undefined);
}

function preinit() {
  if(!isDefined(level.var_261f640c)) {
    level.var_261f640c = spawnStruct();
  }

  level.var_261f640c.var_9e2c9bc2 = [];
  weaponobjects::function_e6400478(#"land_mine", &function_14428e95, 0);

  if(sessionmodeiscampaigngame()) {
    weaponobjects::function_e6400478(#"land_mine_cp", &function_14428e95, 0);
  }

  callback::on_player_killed(&onplayerkilled);
}

function finalize() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"land_mine"), &function_bff5c062);
  }
}

function function_14428e95(var_cd03ffa) {
  var_cd03ffa.watchforfire = 1;
  var_cd03ffa.ownergetsassist = 1;
  var_cd03ffa.ignoredirection = 1;
  var_cd03ffa.immediatedetonation = 1;
  var_cd03ffa.immunespecialty = "specialty_landminetrigger";
  var_cd03ffa.var_8eda8949 = (0, 0, 0);
  var_cd03ffa.detectiongraceperiod = 0;
  var_cd03ffa.stuntime = 1;
  var_cd03ffa.var_10efd558 = "switched_field_upgrade";

  if(isDefined(var_cd03ffa.weapon.customsettings)) {
    var_6f1c6122 = getscriptbundle(var_cd03ffa.weapon.customsettings);
    assert(isDefined(var_6f1c6122));
    level.var_261f640c.var_a74161cc = var_6f1c6122;
    var_cd03ffa.activationdelay = isDefined(level.var_261f640c.var_a74161cc.var_a3fd61e7) ? level.var_261f640c.var_a74161cc.var_a3fd61e7 : 0;
    var_cd03ffa.timeout = isDefined(level.var_261f640c.var_a74161cc.var_bd063370) ? level.var_261f640c.var_a74161cc.var_bd063370 : 3000;
  }

  var_cd03ffa.ondetonatecallback = &function_3bcaeef4;
  var_cd03ffa.onspawn = &function_6392cd30;
  var_cd03ffa.ondamage = &function_6d1a12d3;
  var_cd03ffa.stun = &weaponobjects::weaponstun;
  var_cd03ffa.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  var_cd03ffa.ontimeout = &weaponobjects::weaponobjectfizzleout;
  var_cd03ffa.var_994b472b = &function_fb1ccfa6;
  level.var_261f640c.var_74ac4720 = var_cd03ffa;
}

function function_80b82a4d() {
  return self flag::get(#"hash_5f2dea08efab6bbc") ? isDefined(self.var_396b2ca4.origin) ? self.var_396b2ca4.origin : self.origin : self.origin;
}

function function_fe8abb3(var_651a8943, vposition, vforward, vup) {
  if(isDefined(var_651a8943)) {
    var_54d68ee6 = isDefined(vposition) ? vposition : function_80b82a4d();
    var_bec4f825 = groundtrace(var_54d68ee6 + (0, 0, 70), var_54d68ee6 + (0, 0, -100), 0, self);
    var_4be8e019 = self getfxfromsurfacetable(var_651a8943, var_bec4f825[# "surfacetype"]);
    playFX(var_4be8e019, var_54d68ee6, vforward, vup);
  }
}

function function_c2111ea5() {
  var_396b2ca4 = spawn("script_model", self.origin);
  var_396b2ca4.angles = self.angles;
  var_396b2ca4.owner = self.owner;
  var_396b2ca4 setowner(self.owner);
  var_396b2ca4.team = self.team;
  var_396b2ca4 setteam(self.team);
  var_396b2ca4 enablelinkto();
  var_396b2ca4 linkto(self);
  self.var_396b2ca4 = var_396b2ca4;
}

function function_b0bc024c() {
  var_2624b6bd = isDefined(level.var_261f640c.var_a74161cc.var_2a7507d) ? level.var_261f640c.var_a74161cc.var_2a7507d : 0;

  if(var_2624b6bd > 0) {
    var_54d68ee6 = function_80b82a4d();

    foreach(entity in getentitiesinradius(var_54d68ee6, isDefined(level.var_261f640c.var_a74161cc.var_b922e118) ? level.var_261f640c.var_a74161cc.var_b922e118 : 0)) {
      if(shouldtrigger(entity)) {
        entity dodamage(var_2624b6bd, var_54d68ee6, self.owner, self, undefined, "MOD_EXPLOSIVE", 0, self.weapon);
      }
    }
  }
}

function function_3bcaeef4(attacker, weapon, target) {
  function_fe8abb3(level.var_261f640c.var_a74161cc.var_f374e513);
  weaponobjects::proximitydetonate(attacker, weapon, target);
}

function function_f7f83267() {
  function_fe8abb3(level.var_261f640c.var_a74161cc.var_4699084d);

  if(isDefined(self.weapon.projexplosionsound)) {
    self playSound(self.weapon.projexplosionsound);
  }

  self delete();
}

function function_338f99f5() {
  self endon(#"death", #"detonating");

  if(self.var_83cc2c9 !== 1) {
    self playSound(isDefined(level.var_261f640c.var_a74161cc.var_a021aadb) ? level.var_261f640c.var_a74161cc.var_a021aadb : "");
    self.var_83cc2c9 = 1;
  }

  wait isDefined(level.var_261f640c.var_a74161cc.var_4c3ef8d4) ? level.var_261f640c.var_a74161cc.var_4c3ef8d4 : 0;
  function_b0bc024c();
  weaponobjects::proximityweaponobject_dodetonation(level.var_261f640c.var_74ac4720, undefined, function_80b82a4d());
}

function function_b6dde12d() {
  self endon(#"death");

  if(isDefined(self.var_396b2ca4)) {
    waitframe(1);

    function_bb195195("<dev string:x38>");

    if(level.var_261f640c.var_a74161cc.var_69ff03c3 === 1) {
      var_a883d625 = self.var_396b2ca4.var_f20af839;
    } else {
      var_a883d625 = (0, 0, 1);
    }

    playsoundatposition(isDefined(level.var_261f640c.var_a74161cc.var_df4a92e4) ? level.var_261f640c.var_a74161cc.var_df4a92e4 : "", self.var_396b2ca4.origin);
    playrumbleonposition(#"hash_718ba886b3205e3f", self.var_396b2ca4.origin);
    function_fe8abb3(level.var_261f640c.var_a74161cc.var_d9aa8220, undefined, var_a883d625);
    var_36ef4af8 = isDefined(level.var_261f640c.var_a74161cc.var_fc21999b) ? level.var_261f640c.var_a74161cc.var_fc21999b : 10;
    var_d9c1b66c = isDefined(level.var_261f640c.var_a74161cc.var_54f4d94) ? level.var_261f640c.var_a74161cc.var_54f4d94 : 300;
    var_30d9899f = isDefined(level.var_261f640c.var_a74161cc.var_4c600aeb) ? level.var_261f640c.var_a74161cc.var_4c600aeb : 200;
    var_118c0bbc = isDefined(level.var_261f640c.var_a74161cc.var_34eaeabd) ? level.var_261f640c.var_a74161cc.var_34eaeabd : 100;
    var_d1e53dda = isDefined(level.var_261f640c.var_a74161cc.var_b0b1c21b) ? level.var_261f640c.var_a74161cc.var_b0b1c21b : 100;

    if(isDefined(self.owner)) {
      owner = self.owner;
    } else {
      owner = undefined;
    }

    self cylinderdamage(var_a883d625 * var_d1e53dda, self.var_396b2ca4.origin, var_36ef4af8, var_d9c1b66c, var_30d9899f, var_118c0bbc, owner, "MOD_EXPLOSIVE", self.weapon);

    self.var_396b2ca4 function_bdff0e71(var_a883d625, var_d1e53dda, var_36ef4af8, var_d9c1b66c);

    self delete();
  }
}

function function_cb491e62(var_789c84fd) {
  if(level.var_261f640c.var_a74161cc.var_69ff03c3 !== 1) {
    var_fade8670 = self.var_396b2ca4 getangles();
    var_506743ed = (0, var_fade8670[1], 0);
    self.var_396b2ca4 rotateto(var_506743ed, var_789c84fd, 0, 0);
  }
}

function function_6cbaafc6() {
  self endon(#"death");
  self.canthack = 1;

  if(self.var_83cc2c9 !== 1) {
    self playSound(isDefined(level.var_261f640c.var_a74161cc.var_9a29cecd) ? level.var_261f640c.var_a74161cc.var_9a29cecd : "");
    self.var_83cc2c9 = 1;
  }

  wait isDefined(level.var_261f640c.var_a74161cc.var_88b0248b) ? level.var_261f640c.var_a74161cc.var_88b0248b : 0;

  function_bb195195("<dev string:x55>");

  self.var_396b2ca4 setModel(self.model);
  self ghost();
  self notsolid();
  self.var_396b2ca4 unlink();

  if(level.var_261f640c.var_a74161cc.var_99f70df7 === 1) {
    self.var_396b2ca4.var_f20af839 = vectornormalize(anglestoup(self.var_396b2ca4.angles));
  } else {
    self.var_396b2ca4.var_f20af839 = (0, 0, 1);
  }

  var_f0efa00d = isDefined(level.var_261f640c.var_a74161cc.var_1065654c) ? level.var_261f640c.var_a74161cc.var_1065654c : 25;
  self flag::set(#"hash_5f2dea08efab6bbc");
  var_78983824 = self.var_396b2ca4.origin + self.var_396b2ca4.var_f20af839 * var_f0efa00d;
  var_7895a956 = isDefined(level.var_261f640c.var_a74161cc.var_564c2203) ? level.var_261f640c.var_a74161cc.var_564c2203 : 1;
  playsoundatposition(isDefined(level.var_261f640c.var_a74161cc.var_69029368) ? level.var_261f640c.var_a74161cc.var_69029368 : "", self.var_396b2ca4.origin);
  self.var_396b2ca4 moveto(var_78983824, var_7895a956, 0, var_7895a956);
  function_cb491e62(var_7895a956 * 0.25);
  function_fe8abb3(level.var_261f640c.var_a74161cc.var_5afd2a1d, undefined, self.var_396b2ca4.var_f20af839);
  self.var_396b2ca4 waittilltimeout(var_7895a956, #"movedone");
  var_b6bebc60 = isDefined(level.var_261f640c.var_a74161cc.var_b140445d) ? level.var_261f640c.var_a74161cc.var_b140445d : 10;
  var_3503290a = isDefined(level.var_261f640c.var_a74161cc.var_dfc89b2a) ? level.var_261f640c.var_a74161cc.var_dfc89b2a : 1;
  self.var_396b2ca4 moveto(self.var_396b2ca4.origin + (0, 0, -1) * var_b6bebc60, var_3503290a, var_3503290a, 0);
  self.var_396b2ca4 waittilltimeout(var_3503290a, #"movedone");
  function_b6dde12d();
}

function function_4e2fe8ed() {
  var_dfb72bf5 = self.var_d2318975;

  foreach(var_a58f4914 in getarraykeys(var_dfb72bf5)) {
    function_bb195195(var_a58f4914 + "<dev string:x62>");
  }

  if(self.var_d235cef4.size == 0) {
    if(var_dfb72bf5.size > 0) {
      function_bb195195("<dev string:x76>");

      self.var_7e7d9d86 = gettime();
    }
  }
}

function function_bb441173() {
  if(isDefined(self.var_7e7d9d86)) {
    var_cc84da8f = float(gettime() - self.var_7e7d9d86) / 1000;
    var_39eb023 = (isDefined(level.var_261f640c.var_a74161cc.var_c367e5) ? level.var_261f640c.var_a74161cc.var_c367e5 : 0.25) - var_cc84da8f;

    if(var_39eb023 <= 0) {
      function_bb195195("<dev string:xaa>");

      self.var_937978c9 = int((isDefined(level.var_261f640c.var_a74161cc.var_af22b5dc) ? level.var_261f640c.var_a74161cc.var_af22b5dc : 3) * 1000);
      self.var_9a25b7e0 = int((isDefined(level.var_261f640c.var_a74161cc.var_af22b5dc) ? level.var_261f640c.var_a74161cc.var_af22b5dc : 3) * 1000);
      self.var_5a64415f = int((isDefined(level.var_261f640c.var_a74161cc.var_98ba0e9b) ? level.var_261f640c.var_a74161cc.var_98ba0e9b : 0) * 1000);
    } else {
      function_bb195195("<dev string:xdd>" + var_39eb023);
    }

    self.var_7e7d9d86 = undefined;
  }
}

function function_975a46a() {
  if(!isvehicle(self)) {
    return false;
  }

  var_c1d7860f = self getvehoccupants();

  if(isDefined(var_c1d7860f.size) && var_c1d7860f.size != 0) {
    return false;
  }

  return true;
}

function shouldtrigger(entity) {
  return self != entity && weaponobjects::proximityweaponobject_validtriggerentity(level.var_261f640c.var_74ac4720, entity) && !weaponobjects::proximityweaponobject_isspawnprotected(level.var_261f640c.var_74ac4720, entity) && !weaponobjects::isjammed() && !entity function_975a46a();
}

function function_bf99f93f(entity) {
  var_a58f4914 = entity getentitynumber();

  if(!isDefined(self.var_d235cef4[var_a58f4914])) {
    self.var_d235cef4[var_a58f4914] = 0;
  }

  self.var_d235cef4[var_a58f4914]++;

  if(!isDefined(self.var_d2318975[var_a58f4914])) {
    self function_bb195195(var_a58f4914 + "<dev string:xf2>");

    self function_bb441173();
    return;
  }

  arrayremoveindex(self.var_d2318975, var_a58f4914, 1);
}

function function_53909c68() {
  self.var_c65aa5bf = undefined;

  if(self.var_c3e7ab73 !== 1) {
    foreach(player in getplayers(undefined, function_80b82a4d(), isDefined(level.var_261f640c.var_a74161cc.var_29467698) ? level.var_261f640c.var_a74161cc.var_29467698 : 180)) {
      if(self shouldtrigger(player) && !player isinvehicle()) {
        self.var_c65aa5bf = 1;
        self function_bf99f93f(player);
      }
    }
  }
}

function function_6b505982() {
  self.var_e5845f1 = undefined;

  if(self.var_c3e7ab73 !== 1) {
    position = function_80b82a4d();

    foreach(actor in function_fd768835(self.team, position, isDefined(level.var_261f640c.var_a74161cc.var_29467698) ? level.var_261f640c.var_a74161cc.var_29467698 : 180)) {
      if(!isactor(actor) || !isalive(actor)) {
        continue;
      }

      if(self shouldtrigger(actor)) {
        if(is_true(self.var_e5845f1) || sighttracepassed(actor geteyeapprox(), position + (0, 0, 30), 0, self)) {
          self.var_e5845f1 = 1;
          self function_bf99f93f(actor);
        }
      }
    }
  }
}

function function_a5b5d269(vehicle) {
  var_f37028af = isDefined(level.var_261f640c.var_a74161cc.var_40e96f5e) ? level.var_261f640c.var_a74161cc.var_40e96f5e : 25;
  var_c174cf1 = anglestoup(self.angles);
  var_54d68ee6 = self function_80b82a4d();
  var_938b52b8 = self getboundsmidpoint();
  var_9080bd0b = var_54d68ee6 + var_938b52b8 + var_c174cf1 * var_f37028af * -1;
  var_e5cf14da = vehicle.origin + rotatepoint(vehicle.mins, vehicle.angles);
  var_e945d0d7 = vehicle.origin + rotatepoint(vehicle.maxs, vehicle.angles);

  drawdebugline(var_9080bd0b, var_9080bd0b + var_c174cf1 * var_f37028af * 2);
  drawdebugline(var_9080bd0b, var_e5cf14da);
  drawdebugline(var_9080bd0b, var_e945d0d7);

  var_c8846d83 = vectordot(var_c174cf1, var_e5cf14da - var_9080bd0b) > 0;
  var_afda0584 = vectordot(var_c174cf1, var_e945d0d7 - var_9080bd0b) > 0;
  return var_c8846d83 && var_afda0584;
}

function function_85f3cf29(vehicle, var_ce282718) {
  var_54d68ee6 = self function_80b82a4d();
  var_938b52b8 = self getboundsmidpoint();
  var_6f827f51 = (var_ce282718, var_ce282718, var_ce282718);
  var_302c9a00 = vehicle getboundsmidpoint();
  var_be6be396 = vehicle getboundshalfsize();

  function_f8d33ba4(var_54d68ee6 + var_938b52b8, var_6f827f51 * -1, var_6f827f51, self.angles);
  function_f8d33ba4(vehicle.origin + var_302c9a00, var_be6be396 * -1, var_be6be396, vehicle.angles);

  return function_ecdf9b24(var_54d68ee6 + var_938b52b8, self.angles, var_6f827f51, vehicle.origin + var_302c9a00, vehicle.angles, var_be6be396);
}

function function_372e295b(vehicle) {
  return function_85f3cf29(vehicle, isDefined(level.var_261f640c.var_a74161cc.var_40e96f5e) ? level.var_261f640c.var_a74161cc.var_40e96f5e : 25) && function_a5b5d269(vehicle);
}

function function_e761fbc2() {
  self.var_1096f0a1 = undefined;

  if(self.var_3c07863f !== 1) {
    foreach(vehicle in getentitiesinradius(function_80b82a4d(), isDefined(level.var_261f640c.var_a74161cc.var_40e96f5e) ? level.var_261f640c.var_a74161cc.var_40e96f5e : 25, 12)) {
      if(self shouldtrigger(vehicle) && function_372e295b(vehicle)) {
        self.var_1096f0a1 = 1;
        self function_bf99f93f(vehicle);
      }
    }
  }
}

function function_3e2ef4c6() {
  foreach(var_f9982904 in level.var_261f640c.var_9e2c9bc2) {
    if(!isDefined(var_f9982904) || var_f9982904.var_3c07863f === 1) {
      continue;
    }

    var_f9982904.var_d2318975 = isDefined(var_f9982904.var_d235cef4) ? var_f9982904.var_d235cef4 : [];
    var_f9982904.var_d235cef4 = [];
    var_f9982904 function_53909c68();
    var_f9982904 function_e761fbc2();

    if(sessionmodeiscampaigngame()) {
      var_f9982904 function_6b505982();
    }

    var_f9982904 function_4e2fe8ed();
  }
}

function function_de00142b(var_659a9f4f) {
  foreach(var_f9982904 in level.var_261f640c.var_9e2c9bc2) {
    if(isDefined(var_f9982904)) {
      if(var_f9982904.var_c65aa5bf === 1) {
        var_f9982904.var_937978c9 -= var_659a9f4f;

        var_f9982904 function_bb195195("<dev string:x107>" + float(var_f9982904.var_937978c9) / 1000);

        if(var_f9982904.var_937978c9 < 0) {
          var_f9982904.var_c3e7ab73 = 1;
          var_f9982904 thread function_6cbaafc6();
        }
      }

      if(var_f9982904.var_1096f0a1 === 1) {
        var_f9982904.var_5a64415f -= var_659a9f4f;

        var_f9982904 function_bb195195("<dev string:x11d>" + float(var_f9982904.var_5a64415f) / 1000);

        if(var_f9982904.var_5a64415f < 0) {
          var_f9982904.var_3c07863f = 1;

          if(flag::get(#"hash_5f2dea08efab6bbc")) {
            var_f9982904 thread function_b6dde12d();
          } else {
            var_f9982904 thread function_338f99f5();
          }
        }
      }

      if(var_f9982904.var_e5845f1 === 1) {
        var_f9982904.var_9a25b7e0 -= var_659a9f4f;

        var_f9982904 function_bb195195("<dev string:x134>" + float(var_f9982904.var_9a25b7e0) / 1000);

        if(var_f9982904.var_9a25b7e0 < 0) {
          var_f9982904.var_c3e7ab73 = 1;
          var_f9982904 thread function_6cbaafc6();
        }
      }
    }
  }
}

function function_63c13dff() {
  self notify("727218002c901371");
  self endon("727218002c901371");

  if(!isDefined(level.var_261f640c.var_1270895)) {
    level.var_261f640c.var_1270895 = gettime();
  }

  while(true) {
    var_77c4d94d = gettime();
    profilestart();
    function_3e2ef4c6();
    function_de00142b(var_77c4d94d - level.var_261f640c.var_1270895);
    profilestop();

    if(level.var_261f640c.var_9e2c9bc2.size == 0) {
      level.var_261f640c.var_1270895 = undefined;
      break;
    }

    level.var_261f640c.var_1270895 = var_77c4d94d;
    waitframe(1);
  }
}

function function_fb1ccfa6(player) {
  weaponobjects::weaponobjectfizzleout();
}

function function_6392cd30(var_cd03ffa, owner) {
  self endon(#"death");
  callback::function_d8abfc3d(#"on_entity_deleted", &function_ee5d9464);
  self.var_e744cea3 = &function_df5749e2;
  self.var_3f9bd15 = &function_9b8337c3;
  self.var_63be5750 = &function_7bc9fe48;
  self.delete_on_death = 1;
  self.var_48d842c3 = 1;
  self.var_515d6dda = 1;
  self function_619a5c20();
  self.var_937978c9 = int((isDefined(level.var_261f640c.var_a74161cc.var_af22b5dc) ? level.var_261f640c.var_a74161cc.var_af22b5dc : 3) * 1000);
  self.var_9a25b7e0 = int((isDefined(level.var_261f640c.var_a74161cc.var_af22b5dc) ? level.var_261f640c.var_a74161cc.var_af22b5dc : 3) * 1000);
  self.var_5a64415f = int((isDefined(level.var_261f640c.var_a74161cc.var_98ba0e9b) ? level.var_261f640c.var_a74161cc.var_98ba0e9b : 0) * 1000);
  self util::waittillnotmoving();

  if(self depthinwater() > 10) {
    weaponobjects::weaponobjectfizzleout();
  }

  if(var_cd03ffa.activationdelay) {
    wait var_cd03ffa.activationdelay;
  }

  self playSound(#"hash_59ac94ba0cea7587");
  owner battlechatter::function_fc82b10(self.weapon, self.origin, self);
  function_c2111ea5();
  var_a58f4914 = self getentitynumber();
  level.var_261f640c.var_9e2c9bc2[var_a58f4914] = self;
  level thread function_63c13dff();

  self thread function_47ff3ce7();
}

function function_ee5d9464() {
  if(isDefined(self.var_396b2ca4)) {
    self.var_396b2ca4 deletedelay();
  }

  arrayremoveindex(level.var_261f640c.var_9e2c9bc2, self getentitynumber());
}

function function_6d1a12d3(var_cd03ffa) {
  self endon(#"death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.damagetaken = 0;

  while(true) {
    var_cc5d20f7 = self waittill(#"damage");
    eattacker = var_cc5d20f7.attacker;
    weapon = var_cc5d20f7.weapon;
    ndamage = var_cc5d20f7.amount;
    type = var_cc5d20f7.mod;
    idflags = var_cc5d20f7.flags;
    inflictor = var_cc5d20f7.inflictor;
    eattacker = self[[level.figure_out_attacker]](eattacker);

    if(isvehicle(inflictor) && type === "MOD_CRUSH") {
      continue;
    }

    if(isDefined(weapon)) {
      self weaponobjects::weapon_object_do_damagefeedback(weapon, eattacker, type, var_cc5d20f7.inflictor);

      if(var_cd03ffa.stuntime > 0 && weapon.dostun) {
        self thread weaponobjects::stunstart(var_cd03ffa, var_cd03ffa.stuntime);
        continue;
      }
    }

    if(!level.weaponobjectdebug && level.teambased && isPlayer(eattacker) && isDefined(self.owner)) {
      if(!level.hardcoremode && !util::function_fbce7263(self.owner.team, eattacker.pers[# "team"]) && self.owner != eattacker) {
        continue;
      }
    }

    if(!isvehicle(self) && !damage::friendlyfirecheck(self.owner, eattacker)) {
      continue;
    }

    self.damagetaken += ndamage;

    if(self.damagetaken < (isDefined(level.var_261f640c.var_a74161cc.var_d56aa2d4) ? level.var_261f640c.var_a74161cc.var_d56aa2d4 : 15)) {
      continue;
    }

    if(isDefined(var_cd03ffa.isfataldamage) && !self[[var_cd03ffa.isfataldamage]](var_cd03ffa, eattacker, weapon, ndamage)) {
      continue;
    }

    if(util::function_fbce7263(eattacker.team, self.team)) {
      killstreaks::function_e729ccee(eattacker, weapon);
    }

    break;
  }

  if(level.weaponobjectexplodethisframe) {
    wait 0.1 + randomfloat(0.4);
  } else {
    waitframe(1);
  }

  level.weaponobjectexplodethisframe = 1;
  thread weaponobjects::resetweaponobjectexplodethisframe();
  self entityheadicons::setentityheadicon("none");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isPlayer(eattacker) && eattacker != self.owner && util::function_fbce7263(eattacker.team, self.team)) {
    var_46aa2edd = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
    self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_46aa2edd);
    eattacker challenges::destroyedequipment(weapon);
    self battlechatter::function_d2600afc(eattacker, self.owner, self.weapon);
    self.owner globallogic_score::function_5829abe3(eattacker, weapon, self.weapon);
  }

  function_f7f83267();
}

function function_bff5c062(landmine, attackingplayer) {
  var_f3ab6571 = landmine.owner weaponobjects::function_8481fc06(landmine.weapon) > 1;
  landmine.owner thread globallogic_audio::function_a2cde53d(landmine.weapon, var_f3ab6571);
  landmine.owner weaponobjects::hackerremoveweapon(landmine);
  landmine weaponobjects::function_fb7b0024(landmine.owner);
  landmine.team = attackingplayer.team;
  landmine setteam(attackingplayer.team);
  landmine.owner = attackingplayer;
  landmine setowner(attackingplayer);
  landmine weaponobjects::function_386fa470(attackingplayer);
  landmine weaponobjects::function_931041f8(attackingplayer);

  if(isDefined(landmine) && isDefined(level.var_f1edf93f)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      landmine notify(#"cancel_timeout");
      landmine thread weaponobjects::weapon_object_timeout(landmine.var_2d045452, _station_up_to_detention_center_triggers);
    }
  }

  landmine thread weaponobjects::function_6d8aa6a0(attackingplayer, landmine.var_2d045452);

  if(isDefined(level.var_b7bc3c75.var_1d3ef959)) {
    attackingplayer[[level.var_b7bc3c75.var_1d3ef959]]();
  }
}

function function_df5749e2(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(self.var_4f5edd7d)) {
    return (self.maxhealth * self.var_4f5edd7d * 0.01);
  }

  return self.maxhealth;
}

function onplayerkilled(params) {
  weapon = params.weapon;
  eattacker = params.eattacker;
  einflictor = params.einflictor;

  if(weapon.name == # "land_mine" && eattacker util::isenemyplayer(self)) {
    if(self isinvehicle()) {
      if(!isDefined(einflictor.var_3c0a7eef)) {
        einflictor.var_3c0a7eef = [];
      }

      sparams = spawnStruct();
      sparams.player = self;
      sparams.playerentnum = self getentitynumber();
      sparams.vehicle = self getvehicleoccupied();
      sparams.var_33c9fbd5 = gettime();

      if(!isDefined(einflictor.var_3c0a7eef)) {
        einflictor.var_3c0a7eef = [];
      } else if(!isarray(einflictor.var_3c0a7eef)) {
        einflictor.var_3c0a7eef = array(einflictor.var_3c0a7eef);
      }

      einflictor.var_3c0a7eef[einflictor.var_3c0a7eef.size] = sparams;
      return;
    }

    if(!isDefined(einflictor.var_f6aff8ff)) {
      einflictor.var_f6aff8ff = [];
    }

    entnum = self getentitynumber();

    if(!isDefined(einflictor.var_f6aff8ff[entnum])) {
      einflictor.var_f6aff8ff[entnum] = 1;

      if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
        eattacker[[level.var_b7bc3c75.var_fbbc4c75]](einflictor);
      }
    }
  }
}

function function_7bc9fe48(eattacker, einflictor, weapon, smeansofdeath, damage) {
  self shellshock(#"hash_160e95f6745dddf3", 0.5);
}

function function_9b8337c3(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, occupants) {
  if(isDefined(occupants.size) && occupants.size > 0) {
    foreach(occupant in occupants) {
      if(psoffsettime util::isenemyplayer(occupant)) {
        shitloc function_af9b1762(psoffsettime, occupant getentitynumber());
        break;
      }
    }

    return;
  }

  if(isDefined(shitloc.var_3c0a7eef)) {
    foreach(sparams in shitloc.var_3c0a7eef) {
      if(self == sparams.vehicle && sparams.var_33c9fbd5 == gettime()) {
        shitloc function_af9b1762(psoffsettime, sparams.playerentnum);
        break;
      }
    }
  }
}

function function_af9b1762(eattacker, victimentnum) {
  scoreevents = globallogic_score::function_3cbc4c6c(self.weapon.var_2e4a8800);

  if(isDefined(scoreevents.var_f8792376)) {
    scoreevents::processscoreevent(scoreevents.var_f8792376, eattacker, undefined, self.weapon, undefined);
  }

  if(!isDefined(self.var_f6aff8ff)) {
    self.var_f6aff8ff = [];
  }

  if(!isDefined(self.var_f6aff8ff[victimentnum])) {
    self.var_f6aff8ff[victimentnum] = 1;

    if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
      eattacker[[level.var_b7bc3c75.var_fbbc4c75]](self);
    }
  }
}

function function_bb195195(var_c208f27f, var_d71889f) {
  if(!isDefined(var_d71889f)) {
    var_d71889f = 2;
  }

  if(getdvarint(#"hash_3c54e6d747dd7a6d", 0) >= var_d71889f) {
    var_a58f4914 = self getentitynumber();
    println("<dev string:x149>" + var_a58f4914 + "<dev string:x157>" + var_c208f27f);
  }
}

function function_47ff3ce7() {
  self endon(#"death");

  if(getdvarint(#"hash_3c54e6d747dd7a6d", 0) >= 1) {
    while(true) {
      var_54d68ee6 = function_80b82a4d();
      dev::debug_sphere(var_54d68ee6, isDefined(level.var_261f640c.var_a74161cc.var_29467698) ? level.var_261f640c.var_a74161cc.var_29467698 : 25, (1, 0.85, 0), 0.25, 1);
      dev::debug_sphere(var_54d68ee6, isDefined(level.var_261f640c.var_a74161cc.var_40e96f5e) ? level.var_261f640c.var_a74161cc.var_40e96f5e : 180, (0, 1, 0), 0.25, 1);

      if(isDefined(self.weapon.explosioninnerradius)) {
        dev::debug_sphere(var_54d68ee6, self.weapon.explosioninnerradius, (0, 0, 1), 0.25, 1);
      }

      if(isDefined(self.weapon.explosionradius)) {
        dev::debug_sphere(var_54d68ee6, self.weapon.explosionradius, (1, 0, 0), 0.25, 1);
      }

      if(isDefined(level.var_261f640c.var_a74161cc.var_b922e118)) {
        dev::debug_sphere(var_54d68ee6, level.var_261f640c.var_a74161cc.var_b922e118, (1, 0, 1), 0.25, 1);
      }

      waitframe(1);
    }
  }
}

function function_bdff0e71(var_a883d625, var_d1e53dda, var_36ef4af8, var_d9c1b66c) {
  if(getdvarint(#"hash_3c54e6d747dd7a6d", 0) >= 1) {
    cylinder(self.origin, self.origin + var_a883d625 * var_d1e53dda, var_36ef4af8, (0, 0, 1), 0, 200);
    cylinder(self.origin, self.origin + var_a883d625 * var_d1e53dda, var_d9c1b66c, (1, 0, 0), 0, 200);
  }
}

function function_f8d33ba4(pos, mins, maxs, angles) {
  if(getdvarint(#"hash_3c54e6d747dd7a6d", 0) >= 1) {
    box(pos, mins, maxs, angles, (0, 1, 1), 1, 0, 25);
  }
}

function drawdebugline(start, end) {
  if(getdvarint(#"hash_3c54e6d747dd7a6d", 0) >= 1) {
    line(start, end, (0, 1, 1), undefined, undefined, 200);
  }
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7f36f22bad523244.gsc
*************************************************/

#using script_239a365a92ee4476;
#using script_2d9d24f7c63ac143;
#using script_44102c05f33e9b1e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\perks\perks;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#namespace mutation;

function private autoexec __init__system__() {
  system::register(#"mutation", undefined, undefined, &function_d010653789d638e0);
}

function autoexec init() {
  if(getdvarint(@ "hash_fedf285d2e082de8", 0) == 0) {
    return;
  }

  level.var_39faa7e60a6a717c = 1;
  registersharedfunc(#"mutationshadowskin", #"hash_2e70af38af7a98db", &function_b8128567e19b342a);
  registersharedfunc(#"mutationbubbleshield", #"hash_2e70af38af7a98db", &function_19085bb04b8d04f0);
  registersharedfunc(#"mutationdensitydive", #"hash_2e70af38af7a98db", &function_9baadb9bddb687a3);
  registersharedfunc(#"mutationfrogleap", #"hash_2e70af38af7a98db", &function_d48346e3f4db2e17);
  registersharedfunc(#"mutationmutantvision", #"hash_2e70af38af7a98db", &function_364f9fa90ff10118);
  registersharedfunc(#"mutationsludgesling", #"hash_2e70af38af7a98db", &function_cab1eff594f99bca);
  registersharedfunc(#"mutationtoxiccloud", #"hash_2e70af38af7a98db", &function_3bfa78f82fc49657);
  registersharedfunc(#"mutationjuggernaut", #"hash_2e70af38af7a98db", &function_752fbfc22375566b);
  level.var_4a441348252f9629 = default_to(level.var_4a441348252f9629, []);
}

function function_d010653789d638e0() {
  if(!istrue(level.var_39faa7e60a6a717c)) {
    return;
  }

  level.var_91cf9086501beb32 = getdvarint(@ "hash_b3279cdb640e2489", 1);
  level.var_59bcee9ab02a2469 = getdvarfloat(@ "hash_790645c0e2d91708", 10);
  level.var_d6a96dc3229dfd3c = &function_79e14c2d99eab2f6;
  level.modeupdateloadoutclass = &function_7c11761caacdce4e;
  function_9f4e0fae0ebf143a();

  if(isDefined(level.brgametype.funcs["lootAllowedInBackpack"])) {
    level.var_d0130afb7434c9c0 = level.brgametype.funcs["lootAllowedInBackpack"];
    scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("lootAllowedInBackpack");
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("lootAllowedInBackpack", &function_e080ec840f4eee8e);
}

function function_e080ec840f4eee8e(scriptablename) {
  allowedinbackpack = 1;
  equipname = level.br_pickups.br_equipname[scriptablename];

  if(isDefined(equipname)) {
    if(isDefined(level.var_bd992a9543567a0e[equipname])) {
      allowedinbackpack = 0;
    } else {
      foreach(mutation in level.var_bd992a9543567a0e) {
        if(mutation.equipname == equipname) {
          allowedinbackpack = 0;
          break;
        }
      }
    }
  }

  if(isDefined(level.var_d0130afb7434c9c0)) {
    return (allowedinbackpack && [[level.var_d0130afb7434c9c0]](scriptablename));
  }

  return allowedinbackpack;
}

function function_9f4e0fae0ebf143a() {
  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.namekey)) {
    if(level.gametypebundle.namekey == "poires_quads_mut") {
      level.brgametype.var_98ade9e8627af484 = 1;
      level.brgametype.dialogprefix = "dx_br_urzi_";
      game["dialog"]["match_start"] = "urzk_grav_murn";
      game["dialog"]["offense_obj"] = "urzk_grav_murd";
    } else if(level.gametypebundle.namekey == "br_quads_bb_mut") {
      level.brgametype.var_98ade9e8627af484 = 1;
      level.brgametype.dialogprefix = "dx_br_urzi_";
      game["dialog"]["match_start"] = "urzk_grav_mbyn";
      game["dialog"]["offense_obj"] = "urzk_grav_mubd";
    }
  }

  game["dialog"]["mutation_first_pickup"] = "urzk_grav_oapp";
  game["dialog"]["mutation_toxic_trail"] = "urzk_grav_oapu";
}

function function_85f54808acc1e3a6() {
  waitframe();

  if(level.var_bd992a9543567a0e.size == 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  var_bbcf94cc05cbb192 = getDvar(@ "hash_75ad4530998978ca", "");

  if(var_bbcf94cc05cbb192 == "") {
    var_bbcf94cc05cbb192 = random_key(level.var_bd992a9543567a0e);
  }

  function_bed0a2694c61021b(var_bbcf94cc05cbb192, 1);
}

function function_bed0a2694c61021b(var_efa2c453b6e3070f, var_8f1aa50fddb49b01) {
  var_bd992a9543567a0e = level.var_bd992a9543567a0e[var_efa2c453b6e3070f];
  assertex(isDefined(var_bd992a9543567a0e), "<dev string:x3d>" + var_efa2c453b6e3070f + "<dev string:x69>");

  if(istrue(var_8f1aa50fddb49b01)) {
    function_46788d61ce65b3a7(var_bd992a9543567a0e);
  }

  thread function_c0ceaa035b675fbe();
  function_4b18dc217e68e612(var_efa2c453b6e3070f, 2);
  [[var_bd992a9543567a0e.var_9f562cc981a3f22a]]();
}

function private function_46788d61ce65b3a7(var_bd992a9543567a0e) {
  equipname = var_bd992a9543567a0e.equipname;
  slot = level.equipment.table[equipname].defaultslot;

  if(isDefined(self.var_475ffd1b4c1bd315) && isDefined(self.var_475ffd1b4c1bd315[slot])) {
    function_2f29283af6ca7518(slot);
  }

  function_3d22ad543b952bf1(slot, var_bd992a9543567a0e.rechargetime);
}

function function_c0ceaa035b675fbe() {
  self endon("disconnect");
  self visionsetnakedforplayer("battlerage-full-health", 0.5);
  self setscriptablepartstate("mutation_mutant_vision_vfx", "injection_vfx", 0);
  wait 1;

  if(self getscriptablepartstate("mutation_mutant_vision_vfx") == "injection_vfx") {
    self setscriptablepartstate("mutation_mutant_vision_vfx", "injection_vfx_off", 0);
    self visionsetnakedforplayer("", 0.5);
  }
}

function function_c5030224f9fb72f6(equipname, var_efa2c453b6e3070f, rechargetime, var_9f562cc981a3f22a) {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("init_supers");
  scripts\mp\flags::function_1240434f4201ac9d("br_pickups_init");
  scriptablename = level.br_pickups.br_equipnametoscriptable[var_efa2c453b6e3070f];
  registersharedfunc(equipname, "modifyGetEquipmentAmmoForDrop", &function_f6164ebc5412a1c9);
  registersharedfunc(equipname, "overrideExtraEquipmentAmmoDrop", &function_13f5dc66b64d9512);
  registerpickupcreatedcallback(scriptablename, &function_67d001c1d6cb5b2e, 0);
  registersharedfunc(var_efa2c453b6e3070f, "onScriptablePickedUp", &function_c8f780a20db84444);
  level.equipment.callbacks[equipname]["onDropped"] = &function_7fcdfe391582a80;
  level.equipment.callbacks[var_efa2c453b6e3070f]["onDropped"] = &function_7fcdfe391582a80;
  level.equipment.callbacks[var_efa2c453b6e3070f]["onGive"] = &mutation_ongiveitemequipped;
  level.equipment.callbacks[var_efa2c453b6e3070f]["onFired"] = &function_7496654ea4a53178;
  data = spawnStruct();
  data.rechargetime = rechargetime;
  data.var_9f562cc981a3f22a = var_9f562cc981a3f22a;
  data.equipname = equipname;
  data.slot = level.equipment.table[var_efa2c453b6e3070f].defaultslot;
  level.var_bd992a9543567a0e[var_efa2c453b6e3070f] = data;

  if(data.slot == "super") {
    data.var_97e6c172c6a491a0 = level.br_pickups.var_14bd11727c4b6629[level.br_pickups.br_equipnametoscriptable[var_efa2c453b6e3070f]];
    data.supername = level.br_pickups.var_14bd11727c4b6629[level.br_pickups.br_equipnametoscriptable[equipname]];

    if(level.superglobals.staticsuperdata[data.supername].var_9270ee84f5a4a7a1) {
      level.superglobals.staticsuperdata[data.supername].var_1ee3cdaf7e0e4486 = rechargetime;
    }

    assert(isDefined(data.var_97e6c172c6a491a0), "<dev string:x9d>" + var_efa2c453b6e3070f + "<dev string:xca>");
    assert(isDefined(data.supername), "<dev string:x9d>" + equipname + "<dev string:xca>");
    supers::function_53110a12409d01da(data.var_97e6c172c6a491a0, undefined, undefined, &function_73a4a24cd1340db1, undefined, undefined, undefined, undefined);
    registersharedfunc(data.supername, "onSuperRecharged", &function_805c81b407b23701);
    function_e7f40551b644fb00(data.var_97e6c172c6a491a0);
    return;
  }

  level.var_4a441348252f9629[level.var_4a441348252f9629.size] = equipname;
  level.var_4a441348252f9629[level.var_4a441348252f9629.size] = var_efa2c453b6e3070f;
}

function mutation_ongiveitemequipped(ref, slot, variantid) {
  self notify("mutation_onGiveItemEquipped");
  self endon("mutation_onGiveItemEquipped");
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint(@ "hash_8fb4d83be6581a8", 1) == 1) {
    waitframe();
    function_f4361ea8ce0fbca4();
    self disableusability();
    tableinfo = getequipmenttableinfo(ref);
    function_4b18dc217e68e612(ref, 1);
    deploysuccess = scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(tableinfo.objweapon);
    self enableusability();
    state = function_fe24de35294e540e(ref);

    if(isalive(self) && hasequipment(ref) && state == 1) {
      thread function_bed0a2694c61021b(ref);
    }
  }
}

function function_73a4a24cd1340db1() {
  if(getdvarint(@ "hash_8fb4d83be6581a8", 1) == 0) {
    thread function_1f1c9b9b0ec5f470();
  }

  return true;
}

function private function_1f1c9b9b0ec5f470() {
  ref = self.equipment["super"];
  self waittill("super_use_finished");
  thread function_bed0a2694c61021b(ref);
}

function function_7496654ea4a53178(equipmentref, slot, objweapon) {
  if(getdvarint(@ "hash_8fb4d83be6581a8", 1) == 0) {
    thread function_bed0a2694c61021b(equipmentref);
  }
}

function function_4b18dc217e68e612(ref, state) {
  self.var_4d14cdb0f8ca35c0 = default_to(self.var_475ffd1b4c1bd315, []);
  self.var_4d14cdb0f8ca35c0[ref] = state;
}

function function_fe24de35294e540e(ref) {
  if(isDefined(ref) && isDefined(self.var_4d14cdb0f8ca35c0) && isDefined(self.var_4d14cdb0f8ca35c0[ref])) {
    return self.var_4d14cdb0f8ca35c0[ref];
  }

  return 0;
}

function function_1ce88a7adf3083e6(var_9439db23a48f7be1) {
  namespace_91fad7208d9cd856::function_28f32fc9e57814f6(var_9439db23a48f7be1);

  if(var_9439db23a48f7be1 == #"mutationshadowskin" && !istrue(self.var_6b49dad897ca252c)) {
    self.var_6b49dad897ca252c = 1;
    brleaderdialogplayer("mutation_toxic_trail", self, undefined, undefined, undefined, undefined, "dx_br_urzi_");
  }
}

function function_60738229f5b7aad0() {
  if(!level.var_91cf9086501beb32) {
    return;
  }

  self notify("restartMutatedFootprintsTime");
  self endon("restartMutatedFootprintsTime");
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\utility\perk::giveperk("specialty_self_tracked");
  waittill_any_timeout_1(level.var_59bcee9ab02a2469, "death");
  scripts\mp\utility\perk::removeperk("specialty_self_tracked");
}

function function_7c11761caacdce4e(struct) {
  var_44f255eb9f7a8624 = function_d3b696fc21922074(struct.loadoutequipmentprimary);
  var_44f255eb9f7a8624 |= function_d3b696fc21922074(struct.loadoutequipmentsecondary);

  if(var_44f255eb9f7a8624) {
    thread_on_notify("juggernaut_start", &function_c0ceaa035b675fbe);
  }
}

function private function_d3b696fc21922074(ref) {
  scriptable = level.br_pickups.br_equipnametoscriptable[ref];

  if(!isDefined(scriptable)) {
    return false;
  }

  dropoverride = level.br_pickups.var_ea924219fe414fa2[scriptable];

  if(!isDefined(dropoverride)) {
    return false;
  }

  mutation = level.var_bd992a9543567a0e[dropoverride.lootname];

  if(!isDefined(mutation)) {
    return false;
  }

  function_46788d61ce65b3a7(mutation);
  function_4b18dc217e68e612(dropoverride.lootname, 2);
  return true;
}

function function_16f326a92c92258a() {
  thread function_85f54808acc1e3a6();
  return true;
}

function function_5105241703ca4202(fromdeath, attacker) {
  if(isDefined(self) && issharedfuncdefined("br", "superSlotCleanUp")) {
    [[getsharedfunc("br", "superSlotCleanUp")]](self);
  }

  return true;
}

function function_3d22ad543b952bf1(slot, rechargetime, var_cd03d0ed896be605) {
  self.var_475ffd1b4c1bd315 = default_to(self.var_475ffd1b4c1bd315, []);
  assert(!isDefined(self.var_475ffd1b4c1bd315[slot]));
  assert(rechargetime > 0, "<dev string:x11d>");
  rechargetime = max(rechargetime, 1);
  var_9b1b7807584e9ab9 = spawnStruct();
  var_9b1b7807584e9ab9.progress = 0;
  var_9b1b7807584e9ab9.recharged = 0;
  var_9b1b7807584e9ab9.rechargetime = rechargetime;
  var_9b1b7807584e9ab9.ammo = getequipmentslotammo(slot);
  var_9b1b7807584e9ab9.var_cd03d0ed896be605 = var_cd03d0ed896be605;
  self.var_475ffd1b4c1bd315[slot] = var_9b1b7807584e9ab9;
}

function function_ac1d7cccc34673ad(slot) {
  state = self.var_475ffd1b4c1bd315[slot];
  assert(isDefined(state));

  if(isDefined(state.var_cd03d0ed896be605)) {
    function_642f28e370f65a9c(slot, state.var_cd03d0ed896be605);
  }

  if(slot != "super") {
    thread function_5d0be424276118b6();
    self.var_755a747d2250ffd8 = 1;
    self notify("mutation_recharge_set");
  }
}

function function_642f28e370f65a9c(slot, var_cd03d0ed896be605) {
  assert(isDefined(var_cd03d0ed896be605));
  currentstate = self.var_475ffd1b4c1bd315[slot];
  elapsedtime = gettime() - var_cd03d0ed896be605.var_881746078cc7ac37;
  var_cae8621d25e35a48 = elapsedtime / 1000 / currentstate.rechargetime;
  totalcharge = var_cd03d0ed896be605.savedprogress + var_cae8621d25e35a48;
  var_658325eaadca8b48 = floor(totalcharge);
  var_50f748118f0d70f0 = totalcharge - var_658325eaadca8b48;

  if(slot == "super") {
    pointsneeded = getsuperpointsneeded();
    newpoints = ter_op(totalcharge >= 1, pointsneeded, var_50f748118f0d70f0 * pointsneeded);
    setsuperbasepoints(newpoints);

    if(totalcharge < 1) {
      self.var_1066fbd86c88a6df = 0;
    }

    return;
  }

  setequipmentslotammo(slot, var_cd03d0ed896be605.var_e43197047c0639ee);

  if(var_658325eaadca8b48 > 0) {
    incrementequipmentslotammo(slot, var_658325eaadca8b48);
  }

  currentstate.progress = var_50f748118f0d70f0;
}

function function_2f29283af6ca7518(slot) {
  if(!isDefined(self.var_475ffd1b4c1bd315) || !isDefined(self.var_475ffd1b4c1bd315[slot])) {
    return;
  }

  self.var_475ffd1b4c1bd315[slot] = undefined;

  if(slot != "super") {
    if(!isDefined(self.var_475ffd1b4c1bd315["primary"]) && !isDefined(self.var_475ffd1b4c1bd315["secondary"])) {
      self notify("mutation_recharge_stop");
      self.var_755a747d2250ffd8 = 0;
      function_f9a207358d70923c(level.framedurationseconds, ["mutation_recharge_set", "disconnect"], &function_7b17e939dc4b9f10);
    }
  }
}

function function_5d0be424276118b6() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mutation_recharge_stop");

  if(istrue(self.var_755a747d2250ffd8)) {
    return;
  }

  slots = ["primary", "secondary"];

  while(isalive(self)) {
    foreach(slot in slots) {
      currentstate = self.var_475ffd1b4c1bd315[slot];

      if(isDefined(currentstate)) {
        equipment = getcurrentequipment(slot);

        if(!isDefined(equipment)) {
          continue;
        }

        ammomax = getequipmentmaxammo(equipment);
        rechargetime = currentstate.rechargetime;
        currentstate.ammo = getequipmentammo(equipment);
        rechargeperupdate = level.framedurationseconds / rechargetime;
        currentstate.recharged = 0;

        if(currentstate.ammo < ammomax) {
          currentstate.progress += rechargeperupdate;
        } else {
          currentstate.progress = 0;
        }

        if(currentstate.progress > 1 || abs(currentstate.progress - 1) < 0.001) {
          incrementequipmentslotammo(slot);
          currentstate.progress = 0;
          currentstate.recharged = 1;
        }
      }
    }

    function_7b17e939dc4b9f10();
    waitframe();
  }

  function_2f29283af6ca7518("primary");
  function_2f29283af6ca7518("secondary");
}

function function_7b17e939dc4b9f10() {
  slots = ["primary", "secondary"];
  var_7732b71eb53c0af1 = -1;
  var_7732b71eb53c0af1 += 4;

  foreach(slot in slots) {
    var_fa6b7447c87e80be = "";
    currentstate = self.var_475ffd1b4c1bd315[slot];
    var_de9210d2a8663729 = 0;

    if(isDefined(currentstate)) {
      if(slot == "primary") {
        var_fa6b7447c87e80be = "ui_lethal_recharge_progress";
        var_de9210d2a8663729 = 1;
      } else if(slot == "secondary") {
        var_fa6b7447c87e80be = "ui_tactical_recharge_progress";
        var_de9210d2a8663729 = 2;
      }

      self setclientomnvar(var_fa6b7447c87e80be, currentstate.progress);
      self setpowerprogress(slot, currentstate.progress);

      if(currentstate.recharged) {
        var_7732b71eb53c0af1 += var_de9210d2a8663729;
      }
    }
  }

  self setclientomnvar("ui_recharge_notify", var_7732b71eb53c0af1);
}

function function_79e14c2d99eab2f6(slot) {
  return !isDefined(self.var_475ffd1b4c1bd315) || !isDefined(self.var_475ffd1b4c1bd315[slot]);
}

function function_805c81b407b23701() {
  if(!isbot(self)) {
    self playsoundtoplayer("zxp_charge_jump_full", self);
  }
}

function function_67d001c1d6cb5b2e() {
  if(!isDefined(self.var_1eef5048f92c4951)) {
    return;
  }

  equipname = level.br_pickups.br_equipname[self.type];
  slot = level.equipment.table[equipname].defaultslot;
  player = self.var_1eef5048f92c4951;
  var_78291e588cc5f416 = spawnStruct();
  var_e24fb363769e1264 = player.var_475ffd1b4c1bd315[slot];
  assert(isDefined(var_e24fb363769e1264));

  if(slot == "super") {
    var_78291e588cc5f416.savedprogress = player getcurrentsuperpoints() / player getsuperpointsneeded();
  } else {
    var_78291e588cc5f416.savedprogress = var_e24fb363769e1264.progress;
    var_78291e588cc5f416.var_e43197047c0639ee = var_e24fb363769e1264.ammo;
  }

  var_78291e588cc5f416.var_881746078cc7ac37 = gettime();
  self.var_85266fd997112dc3 = var_78291e588cc5f416;
  player function_4b18dc217e68e612(equipname, undefined);
  player function_2f29283af6ca7518(slot);
}

function function_7fcdfe391582a80(ref, slot) {
  equipment::takeequipment(slot);
}

function function_c8f780a20db84444(pickupent) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  var_cd03d0ed896be605 = pickupent.instance.var_85266fd997112dc3;
  assert(isDefined(level.var_bd992a9543567a0e[equipname]));
  function_3d22ad543b952bf1(slot, level.var_bd992a9543567a0e[equipname].rechargetime, var_cd03d0ed896be605);

  if(!istrue(self.var_fa0499c0739ef84d)) {
    self.var_fa0499c0739ef84d = 1;
    brleaderdialogplayer("mutation_first_pickup", self, undefined, undefined, undefined, undefined, "dx_br_urzi_");
  }
}

function function_f6164ebc5412a1c9(ref, ammo) {
  var_3be4228af7d04ce8 = ammo;

  if(isDefined(ref) && isDefined(level.equipment.table[ref])) {
    slot = level.equipment.table[ref].defaultslot;

    if(isDefined(self.var_475ffd1b4c1bd315[slot])) {
      var_3be4228af7d04ce8 = int(max(ammo, 1));
    }
  }

  return var_3be4228af7d04ce8;
}

function function_13f5dc66b64d9512(var_75e244e5f45c894d, var_bab9e4f8ba9f23d0) {
  return false;
}

function function_d0ff3887d23c6207(key, execfunc) {
  data = spawnStruct();
  data.key = key;
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 30;
  data.execfunc = execfunc;
  return data;
}

function function_b8128567e19b342a() {
  return function_d0ff3887d23c6207("MutationShadowSkin", &function_1e4184126e71015d);
}

function function_19085bb04b8d04f0() {
  return function_d0ff3887d23c6207("MutationBubbleShield", &function_28d406de324fef2f);
}

function function_9baadb9bddb687a3() {
  return function_d0ff3887d23c6207("MutationDensityDive", &function_f2cfd7829ef59d52);
}

function function_d48346e3f4db2e17() {
  return function_d0ff3887d23c6207("MutationFrogLeap", &function_5a4330d8f69e6f24);
}

function function_364f9fa90ff10118() {
  return function_d0ff3887d23c6207("MutationMutantVision", &function_633d1d4abd6b0097);
}

function function_cab1eff594f99bca() {
  return function_d0ff3887d23c6207("MutationSludgeSling", &function_1134e9a64dede8f);
}

function function_3bfa78f82fc49657() {
  return function_d0ff3887d23c6207("MutationToxicCloud", &function_ee0af8ce2a93ede8);
}

function function_752fbfc22375566b() {
  return function_d0ff3887d23c6207("MutationJuggernaut", &function_cd6c2418d4c00d60);
}

function function_1e4184126e71015d() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_98d8c48e89a99b59");
}

function function_28d406de324fef2f() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_cc77872d0d0d8a4b");
}

function function_f2cfd7829ef59d52() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_f38fa8c80a22bae0");
}

function function_5a4330d8f69e6f24() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_d8cee024f058a20c");
}

function function_633d1d4abd6b0097() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_68d7ea2d589cca9");
}

function function_1134e9a64dede8f() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"mutation_sludge_sling");
}

function function_ee0af8ce2a93ede8() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_b380f83200ac2c94");
}

function function_cd6c2418d4c00d60() {
  namespace_d3289d7a0f087014::function_607860ac17c15475(#"hash_cb44a59f2b0bdf2b");
}
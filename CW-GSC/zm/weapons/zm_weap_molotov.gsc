/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_molotov.gsc
***********************************************/

#using script_62caa307a394c18c;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\molotov;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_weap_molotov;

function private autoexec __init__system__() {
  system::register(#"molotov_zm", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_31179876 = &function_16a57018;
  zm_weapons::function_90953640(getweapon(#"molotov_fire"));
  zm_weapons::function_90953640(getweapon(#"eq_molotov"));
  zm_weapons::function_be9d79c3(getweapon(#"molotov_fire"));
  clientfield::register("actor", "molotov_zm_fire_fx", 1, 1, "int");
}

function function_b107b600(position, var_efa24ea4, damageendtime, updateinterval) {
  level endon(#"game_ended");

  while(gettime() < damageendtime) {
    actor_array = self.var_8928bbff[!self.var_87dae7f1];
    var_b1de6a06 = getentitiesinradius(position, var_efa24ea4, 15);

    foreach(actor in var_b1de6a06) {
      if(isalive(actor) && !isinarray(actor_array, actor)) {
        actor_array[actor_array.size] = actor;
      }
    }

    wait updateinterval;
  }
}

function function_16a57018(damageendtime, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, customsettings) {
  if(isDefined(fireeffectarea)) {
    maxs = fireeffectarea getmaxs();
    var_efa24ea4 = max(max(maxs[0], maxs[1]), maxs[2]);
  }

  if(isDefined(var_289a74bc)) {
    maxs = var_289a74bc getmaxs();
    var_efa24ea4 = max(max(max(isDefined(var_efa24ea4) ? var_efa24ea4 : 0, maxs[0]), maxs[1]), maxs[2]);
  }

  self.var_8928bbff = array([], []);
  self.var_87dae7f1 = 1;
  self thread function_b107b600(position, var_efa24ea4, damageendtime, customsettings.var_4bf1fc1f);

  while(gettime() < damageendtime) {
    damageapplied = 0;
    self.var_8928bbff[self.var_87dae7f1] = [];
    self.var_87dae7f1 = !self.var_87dae7f1;
    potential_targets = self.var_8928bbff[self.var_87dae7f1];
    function_1eaaceab(potential_targets);
    start_time = gettime();
    var_ba904176 = customsettings.var_ba904176;

    if(zm_utility::is_survival()) {
      var_39fef10c = zm_equipment::function_739fbb72(var_ba904176);
    } else {
      var_39fef10c = zm_equipment::function_379f6b5d(var_ba904176);
    }

    foreach(index, actor in potential_targets) {
      if(is_true(actor.takedamage)) {
        actor thread function_f0bbc1f4(owner, var_39fef10c, customsettings.var_4bf1fc1f, start_time + int(float(function_60d95f53()) / 1000 * index * 1000));
      }
    }

    for(i = 0; i < potential_targets.size; i++) {
      target = potential_targets[i];

      if(isDefined(target)) {
        self trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, customsettings, start_time);
      }

      waitframe(1);
    }

    wait_time = customsettings.var_4bf1fc1f - float(gettime() - start_time) / 1000;

    if(wait_time > 0) {
      wait wait_time;
    }
  }
}

function trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, customsettings, start_time) {
  if(!(isDefined(fireeffectarea) || isDefined(var_289a74bc)) || isDefined(target) && is_true(target.var_8ef7113a)) {
    return false;
  }

  var_4c3c1b32 = 0;
  var_75046efd = 0;
  sourcepos = position;

  if(isDefined(fireeffectarea)) {
    var_4c3c1b32 = target istouching(fireeffectarea);
    sourcepos = fireeffectarea.origin;
  }

  if(isDefined(var_289a74bc)) {
    var_75046efd = target istouching(var_289a74bc);
    sourcepos = var_289a74bc.origin;
  }

  var_be45d685 = !(var_4c3c1b32 || var_75046efd);
  targetentnum = target getentitynumber();

  if(var_be45d685) {
    target notify(#"hash_50bc036c8d6c0018");
  } else if(molotov::candofiredamage(killcament, target, customsettings.var_4bf1fc1f) && (!isDefined(target.sessionstate) || target.sessionstate == "playing")) {
    trace = bulletTrace(position, target getshootatpos(), 0, target);

    if(trace[# "fraction"] == 1) {
      target thread function_8422dabd(sourcepos, killcament, trace, position, weapon, customsettings, owner, start_time);
    } else {
      var_be45d685 = 1;
    }

    return true;
  }

  return false;
}

function function_8422dabd(origin, killcament, trace, position, weapon, customsettings, owner, start_time) {
  self endon(#"death");
  var_4dd4e6ee = owner;

  if(!isDefined(self.var_84e41b20)) {
    self.var_84e41b20 = [];
  }

  if(isDefined(position)) {
    self.var_84e41b20[position.starttime] = 1;
  }

  var_5c4f174b = max(float(gettime() - start_time) / 1000, customsettings.var_4bf1fc1f);
  var_341dfe48 = int(customsettings.var_ba904176 * var_5c4f174b);
  self dodamage(var_341dfe48, self.origin, owner, weapon, "none", "MOD_BURNED", 0, weapon);
  self.var_ae639436 = var_4dd4e6ee;
}

function function_f0bbc1f4(attacker, var_b1b43d4c, var_fec8031e, var_900ddd04) {
  self endoncallback(&function_177886db, #"death", #"hash_4d4b47a468584441");
  var_9b7f2db1 = int(max(1, ceil((var_900ddd04 - gettime()) / int(var_fec8031e * 1000))));
  damage_amount = int(var_b1b43d4c * var_fec8031e);
  self clientfield::set("molotov_zm_fire_fx", 1);

  for(i = 0; i < var_9b7f2db1; i++) {
    var_ebcff177 = 1;

    if(isDefined(self.var_306ee014) && is_true([[self.var_306ee014]](self))) {
      var_ebcff177 = 4;
    }

    point = self.origin;
    point = aiutility::function_cb552839(self);
    hud::function_c9800094(attacker, point, damage_amount, var_ebcff177, self namespace_42457a0::function_1b3815a7(#"fire"));
    wait var_fec8031e;
  }

  self clientfield::set("molotov_zm_fire_fx", 0);
}

function function_177886db(notifyhash) {
  if(isDefined(self)) {
    self clientfield::set("molotov_zm_fire_fx", 0);
  }
}
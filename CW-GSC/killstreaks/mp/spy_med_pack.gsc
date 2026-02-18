/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\spy_med_pack.gsc
***********************************************/

#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#using scripts\weapons\weapons;
#namespace spy_med_pack;

function private autoexec __init__system__() {
  system::register(#"spy_med_pack", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  killstreaks::register_killstreak("killstreak_spy_med_pack", &function_12db55ec);
  level.var_c9404b0a = spawnStruct();
  level.var_c9404b0a.var_8e10bc5d = [];
  level.var_c9404b0a.medpacks = [];
  level.var_c9404b0a.audiothrottletracker = [];
  level.var_c9404b0a.bundle = getscriptbundle("killstreak_spy_med_pack");
  level.var_c9404b0a.weapon = getweapon("spy_med_pack");
  level.var_c9404b0a.bundle.var_bdc8276 = 2;
  level.var_40346f16 = &function_e6d37a78;
  game.var_f39ffe9 = "med_pack_";
  weaponobjects::function_e6400478(#"spy_med_pack", &function_2ee8eb59, 1);
  deployable::register_deployable(level.var_c9404b0a.weapon, &function_4e22b9e6);
}

function function_12db55ec(killstreaktype) {
  killstreak_id = self killstreakrules::killstreakstart("spy_med_pack", self.team);

  if(killstreak_id == -1) {
    return 0;
  }

  var_29cabbb2 = getweapon("spy_med_pack");
  var_86d3b295 = self deployable::function_b3d993e9(var_29cabbb2);

  if(var_86d3b295) {
    self gestures::function_e62f6dde("gestable_spy_med_pack", undefined, 0);
    medpack = self magicgrenadeplayer(var_29cabbb2, self.var_b8878ba9, self.var_ddc03e10);
    medpack thread function_cc39bcf1(undefined, self);
    waitframe(2);
    var_970221b1 = self weapons::function_fe1f5cc();
    self weapons::function_d571ac59(var_970221b1, 1, undefined, 1);
    self stats::function_e24eec31(var_29cabbb2, #"used", 1);
  }

  return var_86d3b295;
}

function function_2ee8eb59(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &function_cc39bcf1;
  watcher.timeout = float(level.var_c9404b0a.bundle.ksduration) / 1000;
  watcher.ontimeout = &function_42c401bb;
  watcher.var_994b472b = &function_5d668640;
}

function function_5d668640(player) {
  if(!isDefined(self.medpack)) {
    return;
  }

  self.medpack.var_8d834202 = 1;
  self.medpack thread function_e6d37a78(0);
}

function function_42c401bb() {
  if(!isDefined(self.medpack)) {
    return;
  }

  self.medpack thread function_e6d37a78(0);
}

function function_cc39bcf1(watcher, owner) {
  self endon(#"death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
  self hide();
  self.canthack = 1;
  self.ignoreemp = 1;
  self.delete_on_death = 1;

  if(!is_true(self.previouslyhacked)) {
    if(isDefined(owner)) {
      owner stats::function_e24eec31(self.weapon, #"used", 1);
    }

    self waittilltimeout(10, #"stationary");

    if(!owner deployable::location_valid()) {
      owner setriotshieldfailhint();
      self deletedelay();
      return;
    }

    self deployable::function_dd266e08(owner);
    self.var_2625f7cb = owner.var_2625f7cb;
    owner.var_2625f7cb = undefined;
    owner function_9346db70(self);
  }
}

function playdeathfx() {
  weaponobjects::function_b4793bda(self, level.var_c9404b0a.weapon);
  self playSound(level.var_c9404b0a.bundle.destructionaudio);
}

function function_263be969() {
  weaponobjects::function_f2a06099(self, level.var_c9404b0a.weapon);
  self playSound(level.var_c9404b0a.bundle.destructionaudio);
}

function function_4e22b9e6(origin, angles, player) {
  if(!isDefined(player.var_2625f7cb)) {
    player.var_2625f7cb = spawnStruct();
  }

  var_7e37effb = isDefined(level.var_c9404b0a.bundle.var_bdc8276) ? level.var_c9404b0a.bundle.var_bdc8276 : 0;
  testdistance = var_7e37effb * var_7e37effb;
  ids = getarraykeys(level.var_c9404b0a.var_8e10bc5d);

  foreach(id in ids) {
    if(id == player.clientid) {
      continue;
    }

    packs = level.var_c9404b0a.var_8e10bc5d[id];

    foreach(medpack in packs) {
      if(!isDefined(medpack)) {
        continue;
      }

      distsqr = distancesquared(angles, medpack.origin);

      if(distsqr <= testdistance) {
        return false;
      }
    }
  }

  return true;
}

function function_9346db70(medpack) {
  medpack setvisibletoall();

  if(isDefined(medpack.othermodel)) {
    medpack.othermodel setinvisibletoall();
  }

  if(isDefined(medpack.var_2625f7cb)) {
    self function_cb436f32(medpack);
  }
}

function function_780f9aa(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
  bundle = level.var_c9404b0a.bundle;
  chargelevel = 0;
  weapon_damage = killstreak_bundles::get_weapon_damage("killstreak_spy_med_pack", bundle.kshealth, vdir, imodelindex, iboneindex, shitloc, psoffsettime, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(vdir, imodelindex, iboneindex, shitloc, 1);
  }

  return int(weapon_damage);
}

function function_438ca4e0() {
  medpack = self;
  medpack endon(#"hash_5f25f60b7159ac0f", #"death");
  level waittill(#"game_ended");

  if(!isDefined(self)) {
    return;
  }

  medpack.var_8d834202 = 1;
  self thread function_e6d37a78(0, 0);
  medpack.var_648955e6 = 1;
}

function function_530817e7() {
  currentid = game.var_f39ffe9;
  game.var_f39ffe9 += 1;
  return currentid;
}

function function_cb436f32(object) {
  player = self;

  if(isDefined(level.var_c9404b0a.var_8e10bc5d[player.clientid]) && level.var_c9404b0a.var_8e10bc5d[player.clientid].size >= (isDefined(level.var_c9404b0a.bundle.var_cbe1e532) ? level.var_c9404b0a.bundle.var_cbe1e532 : 1)) {
    obj = level.var_c9404b0a.var_8e10bc5d[player.clientid][0];

    if(isDefined(obj)) {
      obj.var_8d834202 = 1;
      obj thread function_e6d37a78(0);
    } else {
      level.var_c9404b0a.var_8e10bc5d[self.clientid] = undefined;
    }
  }

  medpack = spawn("script_model", object.origin);
  medpack function_619a5c20();
  medpack setModel(level.var_c9404b0a.weapon.var_22082a57);
  object.medpack = medpack;
  medpack.var_2d045452 = object;
  medpack setdestructibledef("wpn_t9_eqp_med_pack_destructible");
  medpack useanimtree("generic");
  medpack.owner = player;
  medpack.clientid = medpack.owner.clientid;
  medpack.angles = player.angles;
  medpack.var_86a21346 = &function_780f9aa;
  medpack solid();
  medpack show();
  medpack.victimsoundmod = "vehicle";
  medpack.weapon = level.var_c9404b0a.weapon;
  medpack setweapon(medpack.weapon);
  medpack.maxusecount = isDefined(level.var_c9404b0a.bundle.var_5a0d87e0) ? level.var_c9404b0a.bundle.var_5a0d87e0 : 3;
  medpack.usecount = 0;
  medpack.objectiveid = gameobjects::get_next_obj_id();
  level.var_c9404b0a.medpacks[medpack.objectiveid] = medpack;

  if(!isDefined(level.var_c9404b0a.var_8e10bc5d[player.clientid])) {
    level.var_c9404b0a.var_8e10bc5d[player.clientid] = [];
  }

  var_a7edcaed = level.var_c9404b0a.var_8e10bc5d.size + 1;
  array::push(level.var_c9404b0a.var_8e10bc5d[player.clientid], medpack, var_a7edcaed);
  medpack setCanDamage(1);
  medpack.builttime = gettime();
  medpack.uniqueid = function_530817e7();
  playcommanderaudio(level.var_c9404b0a.bundle.var_69b1ff7);

  if(isDefined(level.var_c9404b0a.bundle.ambientaudio)) {
    medpack playLoopSound(level.var_c9404b0a.bundle.ambientaudio);
  }

  triggerradius = level.var_c9404b0a.bundle.var_366f43e9;
  triggerheight = level.var_c9404b0a.bundle.var_2f1567fb;
  var_b1a6d849 = level.var_c9404b0a.bundle.var_2d890f85;
  usetrigger = spawn("trigger_radius_use", object.origin - (0, 0, 50), 0, triggerradius, triggerheight);
  usetrigger usetriggerrequirelookat();
  usetrigger sethintstring(#"hash_75acfdc16a0732df");
  usetrigger triggerignoreteam();
  usetrigger setvisibletoall();
  usetrigger triggerenable(1);
  medpack.gameobject = gameobjects::create_use_object(player getteam(), usetrigger, [], undefined, level.var_c9404b0a.bundle.var_9333131b, 1);
  medpack.gameobject gameobjects::set_objective_entity(medpack);
  medpack.gameobject gameobjects::set_visible(#"group_all");
  medpack.gameobject gameobjects::allow_use(#"group_all");
  medpack.gameobject gameobjects::set_use_time(var_b1a6d849);
  usetrigger function_9b047eda(1);
  medpack.gameobject.onbeginuse = &function_8c8fb7b5;
  medpack.gameobject.onenduse = &function_a1434496;
  medpack.gameobject.parentobj = medpack;
  medpack.gameobject.var_33d50507 = 1;
  player deployable::function_6ec9ee30(medpack, level.var_c9404b0a.weapon);
  medpack animation::play(#"hash_7540bb5a61e603a");
  medpack thread function_438ca4e0();
  medpack thread watchfordamage();
  medpack thread watchfordeath();
  player notify(#"medpack_placed", {
    #medpack: medpack
  });
}

function private function_8c8fb7b5(player) {}

function private function_a1434496(team, player, result) {
  if(!isDefined(player)) {
    return;
  }

  playerhealth = player getnormalhealth();

  if(playerhealth >= 0.99) {
    return;
  }

  medpack = self.parentobj;
  medpack.isdisabled = 0;

  if(is_true(result)) {
    medpack.usecount++;
    medpack thread animation::play(#"hash_79647b3513fd2190");
    var_94d1a3ec = getweapon(#"hash_44678c77a1fa37b0");

    if(isDefined(var_94d1a3ec)) {
      var_70aa8c50 = player hasweapon(var_94d1a3ec);
      var_e6f54cba = 0;

      if(var_70aa8c50) {
        var_e6f54cba = player getweaponammoclip(var_94d1a3ec);

        if(var_e6f54cba == 0) {
          player setweaponammoclip(var_94d1a3ec, 1);
        }
      } else {
        player giveweapon(var_94d1a3ec);
        player setweaponammoclip(var_94d1a3ec, 1);
      }

      player switchtoweapon(var_94d1a3ec, 1);
      player gestures::function_e62f6dde("gestable_t9_stimshot", undefined, 1);
      util::wait_network_frame(2);

      if(!isDefined(player)) {
        return;
      }

      slot = player gadgetgetslot(var_94d1a3ec);
      player function_ac25fc1f(slot, var_94d1a3ec);
      player gadgetactivate(slot, var_94d1a3ec);
      player gadget_health_regen::function_34daf34a(slot, var_94d1a3ec);
      util::wait_network_frame(2);

      if(!isDefined(player)) {
        return;
      }

      if(var_70aa8c50) {
        if(var_e6f54cba > 0) {
          if(!player hasweapon(var_94d1a3ec)) {
            player giveweapon(var_94d1a3ec);
          }

          player setweaponammoclip(var_94d1a3ec, var_e6f54cba);
        } else {
          player takeweapon(var_94d1a3ec);
        }
      } else {
        player takeweapon(var_94d1a3ec);
      }

      util::wait_network_frame(2);

      if(isDefined(player)) {
        prevweapon = player weapons::function_fe1f5cc();

        if(isDefined(prevweapon)) {
          player switchtoweapon(prevweapon);
        }
      }
    }

    if(medpack.usecount == medpack.maxusecount) {
      medpack thread function_e6d37a78(0);
    }
  }
}

function watchfordeath() {
  level endon(#"game_ended");
  self endon(#"hash_523ddcbd662010e5");
  waitresult = self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  self thread function_e6d37a78(0);
}

function watchfordamage() {
  self endon(#"death");
  level endon(#"game_ended");
  self endon(#"hash_523ddcbd662010e5");
  medpack = self;
  medpack endon(#"death");
  medpack.health = level.var_c9404b0a.bundle.kshealth;
  startinghealth = medpack.health;

  while(true) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
      waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
    }
  }
}

function function_134ae768() {
  if(!isDefined(level.var_35814054.var_8e10bc5d[self.clientid])) {
    return;
  }

  indextoremove = undefined;

  for(index = 0; index < level.var_35814054.var_8e10bc5d[self.clientid].size; index++) {
    if(level.var_35814054.var_8e10bc5d[self.clientid][index] == self) {
      indextoremove = index;
    }
  }

  if(isDefined(indextoremove)) {
    level.var_35814054.var_8e10bc5d[self.clientid] = array::remove_index(level.var_35814054.var_8e10bc5d[self.clientid], indextoremove, 0);
  }
}

function function_e6d37a78(destroyedbyenemy, var_7497ba51 = 1) {
  self notify(#"hash_523ddcbd662010e5");
  self.var_ab0875aa = 1;

  if(isDefined(self.var_1ba7e28e) && self.var_1ba7e28e) {
    return;
  }

  if(isDefined(self.objectiveid)) {
    objective_delete(self.objectiveid);
    gameobjects::release_obj_id(self.objectiveid);
  }

  if(isDefined(self.gameobject)) {
    self.gameobject thread gameobjects::destroy_object(1, 1);
  }

  self.var_1ba7e28e = 1;
  level.var_c9404b0a.medpacks[self.objectiveid] = undefined;
  self function_134ae768();

  if(var_7497ba51 && self.var_8d834202 === 1) {
    wait(isDefined(level.var_c9404b0a.bundle.var_fd663ee0) ? level.var_c9404b0a.bundle.var_fd663ee0 : 0) / 1000;
  }

  profilestart();
  function_897b13a9();
  profilestop();
}

function function_897b13a9() {
  if(!isDefined(self)) {
    return;
  }

  player = self.owner;

  if(isDefined(self.var_846acfcf) && isDefined(player) && self.var_846acfcf != player) {
    self battlechatter::function_d2600afc(self.var_846acfcf, player, level.var_c9404b0a.weapon, self.var_d02ddb8e);
  }

  if(game.state == # "playing") {
    if(self.health <= 0) {
      if(isDefined(level.var_c9404b0a.bundle.destructionaudio)) {
        self playSound(level.var_c9404b0a.bundle.destructionaudio);
      }
    }

    playcommanderaudio(level.var_c9404b0a.bundle.var_10c9ba2d);
  }

  if(self.var_8d834202 === 1) {
    function_263be969();
  } else {
    playdeathfx();
  }

  if(isDefined(level.var_c9404b0a.bundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(level.var_c9404b0a.bundle.var_bb6c29b4, self.origin);
  }

  deployable::function_81598103(self);

  if(isDefined(self.var_2d045452)) {
    self.var_2d045452 delete();
  }

  self stoploopsound();
  self notify(#"hash_5f25f60b7159ac0f");
  self deletedelay();
}

function playcommanderaudio(soundbank) {
  if(!isDefined(soundbank)) {
    return;
  }

  if(!isDefined(level.var_c9404b0a.audiothrottletracker[soundbank])) {
    level.var_c9404b0a.audiothrottletracker[soundbank] = 0;
  }

  lasttimeplayed = level.var_c9404b0a.audiothrottletracker[soundbank];

  if(lasttimeplayed != 0 && gettime() < int(5 * 1000) + lasttimeplayed) {
    return;
  }

  level.var_c9404b0a.audiothrottletracker[soundbank] = gettime();
}
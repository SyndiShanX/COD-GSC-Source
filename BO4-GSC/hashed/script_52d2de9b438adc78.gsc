/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_52d2de9b438adc78.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\helicopter_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_util;

#namespace ir_strobe;

init_shared() {
  if(!isDefined(level.var_860c22f0)) {
    level.var_860c22f0 = {};
    clientfield::register("toplayer", "marker_state", 1, 2, "int");
  }
}

function_8806675d(ksweap, activatefunc) {
  if(!isDefined(level.var_d2c88dc5)) {
    level.var_d2c88dc5 = [];
  } else if(isDefined(level.var_d2c88dc5[ksweap])) {
    return;
  }

  level.var_d2c88dc5[ksweap] = activatefunc;
  level.var_d2c88dc5["inventory_" + ksweap] = activatefunc;
}

function_c5d20b5c(owner, context, position) {
  self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);

  if(isDefined(context.killstreaktype) && isDefined(level.var_d2c88dc5[context.killstreaktype])) {
    [[level.var_d2c88dc5[context.killstreaktype]]](owner, context, position);
  }
}

function_f625256f(killstreak_id, context) {
  player = self;
  self endon(#"disconnect", #"spawned_player");
  var_9eb4725b = level.weaponnone;
  currentweapon = self getcurrentweapon();
  prevweapon = currentweapon;

  if(currentweapon.issupplydropweapon) {
    var_9eb4725b = currentweapon;
  }

  if(var_9eb4725b.isgrenadeweapon) {
    trigger_event = "grenade_fire";
  } else {
    trigger_event = "weapon_fired";
  }

  self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 3);
  self thread function_ef6c4a46(killstreak_id, trigger_event, var_9eb4725b, context);

  while(true) {
    player allowmelee(0);
    notifystring = self waittill(#"weapon_change", trigger_event, #"disconnect", #"spawned_player");
    player allowmelee(1);

    if(trigger_event != "none") {
      if(notifystring._notify != trigger_event) {
        cleanup(context, player);
        return false;
      }
    }

    if(isDefined(player.markerposition)) {
      break;
    }
  }

  self notify(#"trigger_weapon_shutdown");

  if(var_9eb4725b == level.weaponnone) {
    cleanup(context, player);
    return false;
  }

  return true;
}

cleanup(context, player) {
  if(isDefined(context) && isDefined(context.marker)) {
    context.marker delete();
    context.marker = undefined;

    if(isDefined(context.markerfxhandle)) {
      context.markerfxhandle delete();
      context.markerfxhandle = undefined;
    }

    if(isDefined(player)) {
      player clientfield::set_to_player("marker_state", 0);
      player clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
    }
  }

  if(isDefined(context) && isDefined(context.var_597ac911) && isDefined(context.var_43dc1011)) {
    [[context.var_597ac911]](context);
    context.var_597ac911 = undefined;
  }
}

markercleanupthread(context) {
  player = self;
  player waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"cleanup_marker", #"changed_specialist");

  if(player flagsys::get(#"marking_done")) {
    return;
  }

  cleanup(context, player);
}

markerupdatethread(context) {
  player = self;
  player endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"weapon_change", #"death");
  markermodel = spawn("script_model", (0, 0, 0));
  context.marker = markermodel;

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](markermodel, 0);
  }

  player thread markercleanupthread(context);

  while(true) {
    if(player flagsys::get(#"marking_done")) {
      break;
    }

    ksbundle = killstreak_bundles::get_bundle(context);
    minrange = 20;
    maxrange = 500;

    if(isDefined(ksbundle) && isDefined(ksbundle.var_3307f79d)) {
      minrange = ksbundle.var_3307f79d;
      maxrange = ksbundle.var_ffbb43eb;
    }

    forwardvector = vectorscale(anglesToForward(player getplayerangles()), maxrange);
    mask = 1;

    if(isDefined(context.tracemask)) {
      mask = context.tracemask;
    }

    angles = player getplayerangles();

    if(isDefined(level.var_4970b0af) && level.var_4970b0af) {
      mask = 1;
      radius = 10;
      eyepos = player getEye();
      forwardvector = vectorscale(anglesToForward(angles), 300);
      results = bulletTrace(eyepos, eyepos + forwardvector, 0, player, 1);

      if(results[#"fraction"] >= 1) {
        results = bulletTrace(results[#"position"], results[#"position"] + (0, 0, -1000), 0, player, 1);
      }
    } else {
      weapon = getweapon("ir_strobe");
      eye = player getweaponmuzzlepoint();
      results = projectiletrace(weapon, eye, angles, player);
    }

    markermodel.origin = results[#"position"] + (0, 0, 6);
    node = helicopter::getvalidrandomstartnode(markermodel.origin);
    var_6aa266d6 = undefined;

    if(isDefined(node)) {
      var_6aa266d6 = node.origin;
    }

    tooclose = distancesquared(markermodel.origin, player.origin) < minrange * minrange;
    waterheight = getwaterheight(markermodel.origin);
    inwater = markermodel.origin[2] < waterheight;

    if(isDefined(var_6aa266d6) && !tooclose && !inwater && isDefined(context.islocationgood) && [
        [context.islocationgood]
      ](markermodel.origin, context)) {
      player.markerposition = markermodel.origin;
      player clientfield::set_to_player("marker_state", 1);
      player function_bf191832(1, markermodel.origin, markermodel.angles);
    } else {
      player clientfield::set_to_player("marker_state", 2);
      iskillstreakallowed = 1;

      if(isDefined(context) && isDefined(context.killstreakref)) {
        if(!self killstreakrules::iskillstreakallowed(context.killstreakref, self.team, 1)) {
          iskillstreakallowed = 0;
        }
      }

      if(getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
        player.markerposition = markermodel.origin;

        if(iskillstreakallowed) {
          player function_bf191832(1, markermodel.origin, markermodel.angles);
        } else {
          player.markerposition = undefined;
          player function_bf191832(0, (0, 0, 0), (0, 0, 0));
        }
      } else {
        player.markerposition = undefined;
        player function_bf191832(0, (0, 0, 0), (0, 0, 0));
      }
    }

    waitframe(1);
  }
}

function_ef6c4a46(killstreak_id, trigger_event, supplydropweapon, context) {
  player = self;
  self notify(#"hash_27be2db04a0908d5");
  self endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"weapon_change");
  team = self.team;

  if(isDefined(killstreak_id) && killstreak_id == -1) {
    return;
  }

  context.killstreak_id = killstreak_id;
  player flagsys::clear(#"marking_done");
  self thread checkforemp();

  if(trigger_event != "none") {
    self thread markerupdatethread(context);
  }

  self thread cleanupwatcherondeath(killstreak_id, supplydropweapon);

  while(true) {
    waitframe(1);

    if(trigger_event == "none") {
      weapon = supplydropweapon;
      weapon_instance = weapon;
    } else {
      waitresult = self waittill(trigger_event);
      weapon = waitresult.weapon;
      weapon_instance = waitresult.projectile;
    }

    if(isDefined(weapon_instance)) {
      if(isDefined(level.var_14151f16)) {
        [
          [level.var_14151f16]
        ](weapon_instance, 0);
      }
    }

    if(isDefined(weapon_instance)) {
      if(isDefined(level.var_48c30195)) {
        [
          [level.var_48c30195]
        ](weapon_instance, 0);
      }
    }

    issupplydropweapon = 1;

    if(trigger_event == "grenade_fire") {
      issupplydropweapon = weapon.issupplydropweapon;
    }

    if(isDefined(self) && issupplydropweapon) {
      if(isDefined(context)) {
        var_9fdd755d = !isDefined(player.markerposition) || !(isDefined(context.islocationgood) && [
          [context.islocationgood]
        ](player.markerposition, context));

        if(!getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
          if(var_9fdd755d) {
            if(isDefined(level.killstreakcorebundle.ksinvalidlocationsound)) {
              player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
            }

            if(isDefined(level.killstreakcorebundle.ksinvalidlocationstring)) {
              player iprintlnbold(level.killstreakcorebundle.ksinvalidlocationstring);
            }

            continue;
          }

          if(isDefined(context.validlocationsound)) {
            player playsoundtoplayer(context.validlocationsound, player);
          }
        } else if(var_9fdd755d) {
          if(isDefined(level.killstreakcorebundle.ksinvalidlocationsound)) {
            player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
          }
        } else if(isDefined(context.validlocationsound)) {
          player playsoundtoplayer(context.validlocationsound, player);
        }

        ksbundle = killstreak_bundles::get_bundle(context);

        if(isDefined(ksbundle)) {
          context.time = ksbundle.kstime;
          context.fx_name = ksbundle.var_3af79d7e;
        }

        var_ca7e0817 = player.markerposition;
        player flagsys::set(#"marking_done");
        player clientfield::set_to_player("marker_state", 0);
        self thread function_c5d20b5c(self, context, var_ca7e0817);
      }

      self killstreaks::switch_to_last_non_killstreak_weapon();
    }

    break;
  }

  player flagsys::set(#"marking_done");

  if(isDefined(supplydropweapon) && isDefined(context.killstreakref)) {
    self killstreakrules::iskillstreakallowed(context.killstreakref, self.team);
  }

  player clientfield::set_to_player("marker_state", 0);
}

cleanupwatcherondeath(killstreak_id, var_b57ab85c) {
  player = self;
  self endon(#"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change");
  self waittill(#"death", #"joined_team", #"joined_spectators", #"changed_specialist");
  self notify(#"cleanup_marker");
}

checkforemp() {
  self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change", #"death", #"trigger_weapon_shutdown");
  self waittill(#"emp_jammed");
  self killstreaks::switch_to_last_non_killstreak_weapon();
}

event_handler[grenade_fire] function_cb63f633(eventstruct) {
  if(!isDefined(level.var_d2c88dc5)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;

  if(grenade util::ishacked()) {
    return;
  }

  weapon = eventstruct.weapon;

  if(!isDefined(level.var_d2c88dc5[weapon.rootweapon.name])) {
    return;
  }

  if(isDefined(self.markerposition)) {
    grenade thread function_d5ca3f62(self);
    return;
  }

  grenade notify(#"death");
  waittillframeend();
  grenade delete();
}

function_d5ca3f62(player) {
  self endon(#"death");
  self.team = player.team;
  self waittill(#"rolling");

  if(!isDefined(player)) {
    return;
  }

  player notify(#"strobe_marked");

  if(!isDefined(self)) {
    return;
  }

  self function_2cbae477();
  player waittilltimeout(90, #"strobe_marked", #"payload_delivered", #"payload_fail", #"disconnect");

  if(!isDefined(self)) {
    return;
  }

  self.sndent delete();
  self delete();
}

private function_2cbae477(var_babebdbc = #"weapon/fx8_equip_swat_smk_signal", var_76361c1a = "tag_flash") {
  playFXOnTag(var_babebdbc, self, var_76361c1a);
  self playSound(#"hash_6c91edfde8408dad");
  self.sndent = spawn("script_origin", self.origin);
  self.sndent linkto(self);
  self.sndent playLoopSound(#"hash_63e34e1932c25073");
}

function_284b1d4c(origin, model, timeout = undefined, var_babebdbc = undefined, var_76361c1a = undefined) {
  strobe = spawn("script_model", origin);
  strobe setModel(model);
  strobe function_2cbae477(var_babebdbc, var_76361c1a);
  strobe thread function_f61c0c1(timeout);
  return strobe;
}

private function_f61c0c1(timeout) {
  if(isDefined(timeout)) {
    self waittilltimeout(timeout, #"death", #"strobe_stop");
  } else {
    self waittill(#"death", #"strobe_stop");
  }

  if(!isDefined(self)) {
    return;
  }

  self.sndent delete();
  self delete();
}
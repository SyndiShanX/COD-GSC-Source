/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_smart_cover.gsc
****************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\deployable;
#include scripts\weapons\weaponobjects;

#namespace smart_cover;

init_shared() {
  level.smartcoversettings = spawnStruct();

  if(sessionmodeismultiplayergame()) {
    if(getgametypesetting(#"competitivesettings") === 1) {
      level.smartcoversettings.bundle = getscriptbundle(#"smartcover_custom_settings_comp");
    } else {
      level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_mp");
    }
  } else if(sessionmodeiswarzonegame()) {
    level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_wz");
  } else if(sessionmodeiscampaigngame()) {
    level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_cp");
  }

  level.smartcoversettings.var_ac3f76c7 = "smart_cover_objective_full";
  level.smartcoversettings.var_546a220c = "smart_cover_objective_open";
  level.smartcoversettings.smartcoverweapon = getweapon("ability_smart_cover");
  level.smartcoversettings.var_4115bb3a = getweapon(#"hash_34575452eba07c65");
  level.smartcoversettings.objectivezones = [];
  setupdvars();
  ability_player::register_gadget_should_notify(27, 1);
  weaponobjects::function_e6400478(#"ability_smart_cover", &function_21e722f6, 1);
  callback::on_spawned(&on_player_spawned);
  level.smartcoversettings.var_f115c746 = [];
  deployable::register_deployable(level.smartcoversettings.smartcoverweapon, &function_b7f5b1cc, &function_a47ce1c2, undefined, undefined, 1);
  level.smartcoversettings.var_357db326 = 10000;
  level.smartcoversettings.var_ff1a491d = level.smartcoversettings.bundle.var_76d79155 * level.smartcoversettings.bundle.var_76d79155;

  if(!sessionmodeiswarzonegame()) {
    globallogic_score::register_kill_callback(level.smartcoversettings.smartcoverweapon, &function_92112113);
    globallogic_score::function_86f90713(level.smartcoversettings.smartcoverweapon, &function_92112113);
  }

  clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int");
  clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float");
  clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int");
  callback::on_end_game(&on_end_game);
  setdvar(#"hash_4d17057924212aa9", 20);
  setdvar(#"hash_686a676b28ae0af4", 0);
  setdvar(#"hash_7f893c50ae5356c8", -15);
  setdvar(#"hash_70ce44b2b0b4005", 30);
  setdvar(#"hash_477cc29b988c0b75", -10);
  setdvar(#"hash_41cfd0e34c53ef02", 30);
  callback::on_finalize_initialization(&function_1c601b99);
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](level.smartcoversettings.smartcoverweapon, &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](level.smartcoversettings.smartcoverweapon, &function_127fb8f3);
  }
}

function_716c6c70() {
  self endon(#"death", #"cancel_timeout");
  util::wait_network_frame(1);

  if(isDefined(self) && self getentitytype() == 6) {
    self clientfield::set("start_smartcover_microwave", 0);
  }

  util::wait_network_frame(1);

  if(isDefined(self) && self getentitytype() == 6) {
    self clientfield::set("start_smartcover_microwave", 1);
  }
}

function_bff5c062(smartcover, attackingplayer) {
  smartcover.owner weaponobjects::hackerremoveweapon(smartcover);
  smartcover notify(#"hacked");

  if(isDefined(smartcover.grenade)) {
    smartcover.grenade notify(#"hacked");
  }

  smartcover notify(#"cancel_timeout");
  function_375cfa56(smartcover, smartcover.owner);
  smartcover.owner = attackingplayer;
  smartcover setowner(attackingplayer);
  smartcover.team = attackingplayer.team;

  if(isDefined(smartcover.var_40bfd9cf)) {
    smartcover influencers::remove_influencer(smartcover.var_40bfd9cf);
  }

  smartcover.var_40bfd9cf = smartcover influencers::create_entity_enemy_influencer("turret_close", attackingplayer.team);
  smartcover thread function_37f1dcd1();
  smartcover thread function_d82c03d4(attackingplayer);
  array::add(attackingplayer.smartcover.var_19e1ea69, smartcover);
  var_26c9fcc2 = function_57f553e9(attackingplayer.smartcover.var_19e1ea69, level.smartcoversettings.bundle.var_a0b69d8b);

  if(isDefined(var_26c9fcc2)) {
    var_26c9fcc2 function_2a494565(1);
  }

  smartcover thread function_716c6c70();

  if(isDefined(level.var_f1edf93f)) {
    var_eb79e7c3 = [[level.var_f1edf93f]]();
    smartcover thread function_b397b517(var_eb79e7c3);
  }

  if(isDefined(smartcover.smartcoverjammed) && smartcover.smartcoverjammed) {
    smartcover startmicrowave();
    smartcover.smartcoverjammed = 0;

    if(isDefined(level.var_fc1bbaef)) {
      [
        [level.var_fc1bbaef]
      ](smartcover);
    }

    smartcover.smartcoverjammed = 0;
  }
}

on_end_game() {
  if(!isDefined(level.smartcoversettings) || !isDefined(level.smartcoversettings.smartcoverweapon)) {
    return;
  }

  foreach(player in level.players) {
    var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
    player gadgetdeactivate(var_9d063af9, level.smartcoversettings.smartcoverweapon);
    player function_48e08b4(var_9d063af9, level.smartcoversettings.smartcoverweapon);
  }

  if(!isDefined(level.smartcoversettings.var_f115c746)) {
    return;
  }

  var_73137502 = arraycopy(level.smartcoversettings.var_f115c746);

  foreach(smartcover in var_73137502) {
    if(!isDefined(smartcover)) {
      continue;
    }

    smartcover function_2a494565(1);
  }
}

setupdvars() {
  setdvar(#"hash_4f4ce3cb18b004bc", 8);
  setdvar(#"hash_417afa70d515fba5", isDefined(level.smartcoversettings.bundle.var_76d79155) ? level.smartcoversettings.bundle.var_76d79155 : 0);
  setdvar(#"hash_1d8eb304f5cf8033", 1);
  setdvar(#"hash_71f8bd4cd30de4b3", isDefined(level.smartcoversettings.bundle.var_e35fc674) ? level.smartcoversettings.bundle.var_e35fc674 : 0);
  setdvar(#"hash_39a564d4801c4b2e", isDefined(level.smartcoversettings.bundle.var_1f0ae388) ? level.smartcoversettings.bundle.var_1f0ae388 : 0);
}

function_649f8cbe(func) {
  level.onsmartcoverplaced = func;
}

function_a9427b5c(func) {
  level.var_a430cceb = func;
}

function_b397b517(timeoutoverride) {
  self endon(#"death", #"cancel_timeout");
  timeouttime = isDefined(timeoutoverride) ? timeoutoverride : level.smartcoversettings.bundle.timeout;

  if((isDefined(timeouttime) ? timeouttime : 0) == 0) {
    return;
  }

  wait timeouttime;

  if(isDefined(self)) {
    self thread function_2a494565(1);
  }
}

function_b11be5dc() {
  if(!isDefined(self.smartcover)) {
    return;
  }

  foreach(smartcover in self.smartcover.var_58e8b64d) {
    if(isDefined(smartcover)) {
      smartcover function_2a494565(1);
    }
  }
}

function_bd071599(player, smartcover) {
  level endon(#"game_ended");
  player notify(#"hash_53db5f084a244a94");
  player endon(#"hash_53db5f084a244a94");
  player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
  smartcover endon(#"death");
  var_f5929597 = gettime() + int((isDefined(level.smartcoversettings.bundle.var_fee887dc) ? level.smartcoversettings.bundle.var_fee887dc : 0) * 1000);
  player.var_622765b5 = 1;
  currenttime = gettime();
  timeelapsed = 0;

  while(var_f5929597 > gettime()) {
    if(!player gamepadusedlast()) {
      break;
    }

    if(!player offhandspecialbuttonpressed()) {
      player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
      player.var_622765b5 = 0;
      return;
    }

    timeelapsed = gettime() - currenttime;
    var_1cf1ae8b = timeelapsed / int((isDefined(level.smartcoversettings.bundle.var_fee887dc) ? level.smartcoversettings.bundle.var_fee887dc : 0) * 1000);
    player clientfield::set_player_uimodel("huditems.abilityDelayProgress", var_1cf1ae8b);
    waitframe(1);
  }

  player thread gestures::function_f3e2696f(player, level.smartcoversettings.var_4115bb3a, undefined, 0.75, undefined, undefined, undefined);

  if(isDefined(level.smartcoversettings.bundle.var_d47e600f)) {
    smartcover playSound(level.smartcoversettings.bundle.var_d47e600f);
  }

  player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
  player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
  wait isDefined(level.smartcoversettings.bundle.detonationtime) ? level.smartcoversettings.bundle.detonationtime : 0;
  player.var_622765b5 = 0;
  player.var_d3bf8986 = 1;
  smartcover function_2a494565(1);
}

function_7ecb04ff(player) {
  level endon(#"game_ended");
  player notify(#"hash_51faf1a32d7e36b0");
  player endon(#"hash_51faf1a32d7e36b0");
  player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");

  while(true) {
    waitframe(1);

    while(level.inprematchperiod) {
      waitframe(1);
      continue;
    }

    if(!player hasweapon(level.smartcoversettings.smartcoverweapon)) {
      return;
    }

    var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);

    if(!isDefined(var_9d063af9) || var_9d063af9 == -1) {
      continue;
    }

    ammocount = player getammocount(level.smartcoversettings.smartcoverweapon);
    gadgetpower = player gadgetpowerget(var_9d063af9);

    if(gadgetpower >= 100 || ammocount > 0) {
      player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
      player clientfield::set_player_uimodel("hudItems.smartCoverState", 0);
      continue;
    }

    if(player.smartcover.var_19e1ea69.size == 0) {
      continue;
    }

    if(isDefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) {
      player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
      player clientfield::set_player_uimodel("hudItems.smartCoverState", 1);

      if((isDefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) && player offhandspecialbuttonpressed() && (!isDefined(player.var_622765b5) || !player.var_622765b5) && !(isDefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0)) {
        foreach(smartcover in player.smartcover.var_58e8b64d) {
          if(!isDefined(smartcover)) {
            continue;
          }

          smartcover thread function_bd071599(player, smartcover);
          break;
        }

        continue;
      }

      if(!player offhandspecialbuttonpressed() && (isDefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0)) {
        player.var_d3bf8986 = 0;
      }
    }
  }
}

on_player_spawned() {
  if(!isDefined(self.smartcover)) {
    self.smartcover = spawnStruct();
    self.smartcover.var_58e8b64d = [];
    self.smartcover.var_19e1ea69 = [];
    self.smartcover.var_d5258d02 = [];
  }

  if(!self hasweapon(level.smartcoversettings.smartcoverweapon) && self.smartcover.var_58e8b64d.size > 0) {
    self function_b11be5dc();
  }

  self clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
  self.var_622765b5 = 0;
  self reset_being_microwaved();
}

function_b7f5b1cc(origin, angles, player) {
  if(isDefined(level.var_b57c1895)) {
    return [[level.var_b57c1895]](origin, angles, player);
  }

  return 1;
}

function_a47ce1c2(player) {
  var_b43e8dc2 = player function_287dcf4b(level.smartcoversettings.bundle.var_63aab046, level.smartcoversettings.bundle.maxwidth, 1, 1, level.smartcoversettings.smartcoverweapon);
  player.smartcover.lastvalid = var_b43e8dc2;
  var_9e596670 = 0;

  if(isDefined(var_b43e8dc2) && isDefined(var_b43e8dc2.origin)) {
    var_9e596670 = function_bf4c81d2(var_b43e8dc2.origin, level.smartcoversettings.var_ff1a491d);
  }

  var_2b68b641 = function_54267517(var_b43e8dc2.origin);
  candeploy = isDefined(var_b43e8dc2) && var_b43e8dc2.isvalid && !var_9e596670 && !var_2b68b641;

  if(candeploy && (isDefined(var_b43e8dc2.width) ? var_b43e8dc2.width : 0) >= level.smartcoversettings.bundle.maxwidth) {
    player function_bf191832(candeploy, var_b43e8dc2.origin, var_b43e8dc2.angles);
  } else {
    player function_bf191832(candeploy, (0, 0, 0), (0, 0, 0));
  }

  return var_b43e8dc2;
}

function_408a9ea8(var_bf2bf1a) {
  var_bf2bf1a endon(#"death");
  var_bf2bf1a useanimtree("generic");
  var_bf2bf1a setanim(level.smartcoversettings.bundle.deployanim);
  animtime = 0;

  while(animtime < 1) {
    var_bf2bf1a clientfield::set("smartcover_placed", 1 - animtime);
    animtime = var_bf2bf1a getanimtime(level.smartcoversettings.bundle.deployanim);
    waitframe(1);
  }
}

function_548a710a(traceresults) {
  if(!traceresults.var_e2543923 && !traceresults.var_e18fd6c3) {
    return traceresults.origin;
  }

  halfwidth = level.smartcoversettings.bundle.maxwidth * 0.5;
  var_93cd60ae = halfwidth * halfwidth;
  var_b80b6889 = distance2d(traceresults.origin, traceresults.var_c0e006dc);
  var_65ea35de = distance2d(traceresults.origin, traceresults.var_44cf251d);

  if(traceresults.var_e2543923 && traceresults.var_e18fd6c3) {
    pointright = traceresults.var_c0e006dc;
    pointleft = traceresults.var_44cf251d;
  } else if(traceresults.var_e2543923 && var_b80b6889 < halfwidth) {
    pointright = traceresults.var_c0e006dc;
    directionleft = vectornormalize(traceresults.var_44cf251d - traceresults.var_c0e006dc);
    pointleft = traceresults.var_c0e006dc + level.smartcoversettings.bundle.maxwidth * directionleft;
  } else if(traceresults.var_e2543923 && var_b80b6889 >= halfwidth) {
    return traceresults.origin;
  } else if(traceresults.var_e18fd6c3 && var_65ea35de < halfwidth) {
    pointleft = traceresults.var_44cf251d;
    directionright = vectornormalize(traceresults.var_c0e006dc - traceresults.var_44cf251d);
    pointright = traceresults.var_44cf251d + level.smartcoversettings.bundle.maxwidth * directionright;
  } else if(traceresults.var_e18fd6c3 && var_65ea35de >= halfwidth) {
    return traceresults.origin;
  }

  direction = vectornormalize(pointright - pointleft);
  origin = (pointleft[0], pointleft[1], traceresults.origin[2]) + level.smartcoversettings.bundle.maxwidth * 0.5 * direction;
  return origin;
}

function_3b96637(watcher, owner) {
  self endon(#"death");
  player = owner;
  self.canthack = 1;
  self hide();

  if(!isDefined(player.smartcover.lastvalid) || !player.smartcover.lastvalid.isvalid) {
    player deployable::function_416f03e6(level.smartcoversettings.smartcoverweapon);
    return;
  }

  profilestart();
  var_bf2bf1a = player createsmartcover(watcher, self, player.smartcover.lastvalid.var_83050ca1, player.smartcover.lastvalid.angles, 1);
  profilestop();
  var_bf2bf1a.angles = player.angles;
  var_bf2bf1a.var_8120c266 = [];
  var_bf2bf1a.var_9a3bd50f = 0;
  array::add(player.smartcover.var_19e1ea69, var_bf2bf1a);
  var_26c9fcc2 = function_57f553e9(player.smartcover.var_19e1ea69, level.smartcoversettings.bundle.var_a0b69d8b);

  if(isDefined(var_26c9fcc2)) {
    var_26c9fcc2 function_2a494565(1);
  }

  if(isDefined(level.onsmartcoverplaced)) {
    owner[[level.onsmartcoverplaced]](self);
  }

  self thread function_d82c03d4(player);

  if(isDefined(level.smartcoversettings.bundle.deployanim)) {
    thread function_408a9ea8(var_bf2bf1a);
  }

  if(isDefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) {
    player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
  }

  var_bf2bf1a.var_40bfd9cf = var_bf2bf1a influencers::create_entity_enemy_influencer("turret_close", owner.team);
  var_bf2bf1a util::make_sentient();

  if(isDefined(level.smartcoversettings.smartcoverweapon.var_414fa79e)) {
    player playrumbleonentity(level.smartcoversettings.smartcoverweapon.var_414fa79e);
  }

  thread function_7ecb04ff(player);
  var_bf2bf1a thread function_670cd4a3();
  var_bf2bf1a thread function_b397b517();
}

function_670cd4a3() {
  self endon(#"death");
  self.var_19fde5b7 = [];

  while(true) {
    waitresult = self waittill(#"grenade_stuck");

    if(isDefined(waitresult.projectile)) {
      array::add(self.var_19fde5b7, waitresult.projectile);
    }
  }
}

function_21e722f6(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &function_3b96637;
  watcher.deleteonplayerspawn = 0;
}

function_d82c03d4(player) {
  self endon(#"death", #"hacked");
  player waittill(#"joined_team", #"disconnect");
  player function_b11be5dc();
}

function_37f1dcd1() {
  level endon(#"game_ended");
  self.owner endon(#"disconnect", #"joined_team", #"changed_specialist", #"hacked");
  self endon(#"hash_5de1fc3780ea0eaa");
  waitresult = self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  self thread onkilled(waitresult);
}

ondamage() {
  self endon(#"death");
  level endon(#"game_ended");

  while(true) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
      if(waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
        waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
      }
    }
  }
}

function_375cfa56(smartcover, owner) {
  if(isDefined(owner)) {
    arrayremovevalue(owner.smartcover.var_19e1ea69, smartcover);
  }
}

function_2a494565(isselfdestruct) {
  smartcover = self;
  smartcover notify(#"hash_5de1fc3780ea0eaa");
  smartcover clientfield::set("enemyequip", 0);
  smartcover clientfield::set("friendlyequip", 0);

  if(isDefined(smartcover.objectiveid)) {
    objective_delete(smartcover.objectiveid);
    gameobjects::release_obj_id(smartcover.objectiveid);
  }

  if(isDefined(level.smartcoversettings.bundle.destructionfx)) {
    if(isDefined(isselfdestruct) && isselfdestruct) {
      var_415135a0 = level.smartcoversettings.bundle.selfdestructfx;
      var_72db9941 = level.smartcoversettings.bundle.selfdestructaudio;
    } else {
      var_415135a0 = level.smartcoversettings.bundle.destructionfx;
      var_72db9941 = level.smartcoversettings.bundle.destructionaudio;
    }

    var_b0e81be9 = isDefined(self gettagorigin("tag_cover_base_d0")) ? self gettagorigin("tag_cover_base_d0") : self.origin;
    var_505e3308 = isDefined(self gettagangles("tag_cover_base_d0")) ? self gettagangles("tag_cover_base_d0") : self.angles;
    var_8fec56c4 = anglesToForward(var_505e3308);
    var_61753233 = anglestoup(var_505e3308);
    playFX(var_415135a0, var_b0e81be9, var_8fec56c4, var_61753233);

    if(isDefined(var_72db9941)) {
      smartcover playSound(var_72db9941);
    }
  }

  if(isDefined(level.smartcoversettings.bundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(level.smartcoversettings.bundle.var_bb6c29b4, smartcover.origin);
  }

  removeindex = -1;
  arrayremovevalue(level.smartcoversettings.var_f115c746, smartcover);

  if(isDefined(smartcover.owner)) {
    arrayremovevalue(smartcover.owner.smartcover.var_58e8b64d, smartcover);
    arrayremovevalue(smartcover.owner.smartcover.var_19e1ea69, smartcover);
  }

  if(isDefined(level.smartcoversettings.bundle.var_f4e0e7d7) && level.smartcoversettings.bundle.var_f4e0e7d7) {
    smartcover stopmicrowave();
    smartcover notify(#"microwave_turret_shutdown");
  }

  if(isDefined(smartcover.owner)) {
    smartcover.owner globallogic_score::function_d3ca3608(#"hash_78cb6a053f51a857");
  }

  deployable::function_81598103(smartcover);

  if(isDefined(smartcover.killcament)) {
    smartcover.killcament thread util::deleteaftertime(5);
  }

  if(isDefined(smartcover.grenade)) {
    smartcover.grenade thread util::deleteaftertime(1);
  }

  if(isDefined(smartcover.trigger)) {
    smartcover.trigger delete();
  }

  smartcover delete();
}

onkilled(var_c946c04c) {
  smartcover = self;

  if(var_c946c04c.attacker != smartcover.owner) {
    smartcover.owner globallogic_score::function_5829abe3(var_c946c04c.attacker, var_c946c04c.weapon, smartcover.weapon);

    if(isDefined(level.var_d2600afc)) {
      self[[level.var_d2600afc]](var_c946c04c.attacker, smartcover.owner, smartcover.weapon, var_c946c04c.weapon);
    }

    if(isDefined(self.owner)) {
      self.owner thread killstreaks::play_taacom_dialog("smartCoverWeaponDestroyedFriendly");
    }
  }

  smartcover.var_d02ddb8e = var_c946c04c.weapon;

  if(isDefined(level.var_a430cceb)) {
    smartcover[[level.var_a430cceb]](var_c946c04c.attacker, smartcover.var_d02ddb8e);
  }

  smartcover thread function_2a494565(0);
}

function_884d0700(var_796be15d) {
  return self.team == #"allies" ? level.smartcoversettings.bundle.var_ee0c73a5 : level.smartcoversettings.bundle.var_d3ea02d6;
}

getmodel(var_796be15d) {
  return self.team == #"allies" ? level.smartcoversettings.bundle.var_397ed90c : level.smartcoversettings.bundle.var_b256e3da;
}

function_d2368084(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
  if(weapon === getweapon(#"shock_rifle") && smeansofdeath === "MOD_DOT") {
    return 0;
  }

  bundle = level.smartcoversettings.bundle;
  startinghealth = isDefined(self.startinghealth) ? self.startinghealth : 0;

  if((isDefined(self.health) ? self.health : 0) < startinghealth * 0.5 && !(self.var_2cf2e843 === 1) && isDefined(self.owner) && isplayer(self.owner) && !(eattacker === self.owner)) {
    self.owner thread killstreaks::play_taacom_dialog("smartCoverWeaponDamaged");
    self.var_2cf2e843 = 1;
  }

  if(isDefined(bundle.rocketstokill) && weapon == getweapon(#"launcher_standard")) {
    idamage = startinghealth / bundle.rocketstokill;
  }

  if(isDefined(bundle.kshero_annihilator) && weapon == getweapon(#"hero_annihilator")) {
    idamage = startinghealth / bundle.kshero_annihilator;
  } else if(isDefined(bundle.var_2e48926e) && weapon == getweapon(#"hero_flamethrower")) {
    idamage = startinghealth / bundle.var_2e48926e;
  } else if(isDefined(bundle.kshero_gravityspikes) && weapon == getweapon(#"eq_gravityslam")) {
    idamage = startinghealth / bundle.kshero_gravityspikes;
  } else if(isDefined(bundle.var_4be7d629) && weapon == getweapon(#"shock_rifle") && smeansofdeath == "MOD_IMPACT") {
    idamage = startinghealth / bundle.var_4be7d629;
  } else if(isDefined(bundle.var_843b7bd3) && weapon.statname == #"planemortar") {
    idamage = startinghealth / bundle.var_843b7bd3;
  } else if(isDefined(bundle.ksdartstokill) && (weapon == getweapon(#"dart_blade") || weapon == getweapon(#"dart_turret"))) {
    idamage = startinghealth / bundle.ksdartstokill;
  } else if(isDefined(bundle.var_8eca21ba) && weapon.statname == #"recon_car") {
    idamage = startinghealth / bundle.var_8eca21ba;
  } else if(isDefined(bundle.ksremote_missile_missile) && weapon.statname == #"remote_missile_missile") {
    idamage = startinghealth / bundle.ksremote_missile_missile;
  } else if(isDefined(bundle.kshero_pineapplegun) && weapon == getweapon(#"hero_pineapplegun")) {
    idamage = startinghealth / bundle.kshero_pineapplegun;
  } else if(isDefined(bundle.kshero_bowlauncher) && weapon.statname == #"sig_bow_quickshot" && (smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE_SPLASH")) {
    idamage = startinghealth / bundle.kshero_bowlauncher;
  }

  return int(idamage);
}

function_20be77a3(smartcover) {
  smartcover.var_eda9690f = [];
  forwardangles = anglesToForward(smartcover.angles);
  rightangles = anglestoright(smartcover.angles);
  var_526ec5aa = smartcover.origin + (0, 0, 1) * getdvarfloat(#"hash_4d17057924212aa9", 1);
  smartcover.var_eda9690f[smartcover.var_eda9690f.size] = var_526ec5aa + forwardangles * getdvarfloat(#"hash_477cc29b988c0b75", 1);
  smartcover.var_eda9690f[smartcover.var_eda9690f.size] = smartcover.var_eda9690f[0] + (0, 0, 1) * getdvarfloat(#"hash_41cfd0e34c53ef02", 1);
  backpoint = var_526ec5aa + forwardangles * getdvarfloat(#"hash_7f893c50ae5356c8", 1);
  smartcover.var_eda9690f[smartcover.var_eda9690f.size] = backpoint + rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
  smartcover.var_eda9690f[smartcover.var_eda9690f.size] = backpoint - rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
}

createsmartcover(watcher, var_5ebbec19, origin, angles, var_796be15d) {
  player = self;
  var_89b6fd44 = spawn("script_model", origin);
  var_89b6fd44.targetname = "smart_cover";
  var_5ebbec19.smartcover = var_89b6fd44;
  var_89b6fd44.grenade = var_5ebbec19;
  var_89b6fd44 setModel(player getmodel(var_796be15d));
  watcher.objectarray[watcher.objectarray.size] = var_89b6fd44;
  var_c6f47ca9 = getdvarint(#"hash_1d8eb304f5cf8033", 0);

  if(var_c6f47ca9 == 1) {
    var_89b6fd44 setdestructibledef(player function_884d0700(var_796be15d));
  }

  var_89b6fd44.angles = angles;
  var_89b6fd44.owner = player;
  var_89b6fd44.takedamage = 1;
  var_89b6fd44.startinghealth = isDefined(level.smartcoversettings.bundle.var_4d358e2d) ? level.smartcoversettings.bundle.var_4d358e2d : var_796be15d ? isDefined(level.smartcoversettings.bundle.var_d9317c6b) ? level.smartcoversettings.bundle.var_d9317c6b : 100 : 100;
  var_89b6fd44.health = var_89b6fd44.startinghealth;
  var_89b6fd44 solid();

  if(sessionmodeiswarzonegame()) {
    var_89b6fd44 disconnectpaths(0);
  } else {
    var_89b6fd44 disconnectpaths(1);
  }

  var_89b6fd44 setteam(player getteam());
  var_89b6fd44.var_86a21346 = &function_d2368084;
  var_89b6fd44.weapon = level.smartcoversettings.smartcoverweapon;
  var_89b6fd44 setweapon(var_89b6fd44.weapon);
  array::add(player.smartcover.var_58e8b64d, var_89b6fd44);
  var_c892a9a = var_796be15d ? level.smartcoversettings.var_546a220c : level.smartcoversettings.var_ac3f76c7;

  if(isDefined(var_c892a9a)) {
    var_89b6fd44.objectiveid = gameobjects::get_next_obj_id();
    objective_add(var_89b6fd44.objectiveid, "active", var_89b6fd44, var_c892a9a);
    function_da7940a3(var_89b6fd44.objectiveid, 1);
    objective_setteam(var_89b6fd44.objectiveid, player.team);
  }

  var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);

  if(!sessionmodeiswarzonegame()) {
    self gadgetpowerset(var_9d063af9, 0);
  }

  var_89b6fd44 setteam(player.team);
  array::add(level.smartcoversettings.var_f115c746, var_89b6fd44);
  function_20be77a3(var_89b6fd44);
  var_89b6fd44 clientfield::set("friendlyequip", 1);
  var_89b6fd44 clientfield::set("enemyequip", 1);
  var_89b6fd44 thread ondamage();
  var_89b6fd44 thread function_37f1dcd1();
  thread function_18dd6b22(var_89b6fd44);
  player deployable::function_6ec9ee30(var_89b6fd44, level.smartcoversettings.smartcoverweapon);
  var_89b6fd44.victimsoundmod = "vehicle";

  if(isDefined(level.smartcoversettings.bundle.var_f4e0e7d7) && level.smartcoversettings.bundle.var_f4e0e7d7) {
    var_89b6fd44 thread startmicrowave();
  }

  killcament = spawn("script_model", var_89b6fd44.origin + (isDefined(level.smartcoversettings.bundle.var_eb9150a5) ? level.smartcoversettings.bundle.var_eb9150a5 : 0, isDefined(level.smartcoversettings.bundle.var_26a346c8) ? level.smartcoversettings.bundle.var_26a346c8 : 0, isDefined(level.smartcoversettings.bundle.var_d0fb9b7a) ? level.smartcoversettings.bundle.var_d0fb9b7a : 0));
  killcament.targetname = "smart_cover_killcament";
  var_89b6fd44.killcament = killcament;
  watcher.objectarray[watcher.objectarray.size] = killcament;
  return var_89b6fd44;
}

function_127fb8f3(smartcover, attackingplayer) {
  if(!(isDefined(smartcover.smartcoverjammed) && smartcover.smartcoverjammed)) {
    smartcover stopmicrowave();
    smartcover clientfield::set("enemyequip", 0);
  }

  smartcover.smartcoverjammed = 1;

  if(isDefined(level.var_86e3d17a)) {
    smartcover notify(#"cancel_timeout");
    var_77b9f495 = [[level.var_86e3d17a]]();
    smartcover thread function_b397b517(var_77b9f495);
  }

  if(isDefined(level.var_1794f85f)) {
    [[level.var_1794f85f]](attackingplayer, "disrupted_barricade");
  }

  return true;
}

function_18dd6b22(smartcover) {
  level endon(#"game_ended");
  smartcover endon(#"death");

  while(true) {
    waitresult = smartcover waittill(#"broken");

    if(waitresult.type == "base_piece_broken") {
      smartcover function_2a494565(0);
    }
  }
}

function_bf4c81d2(origin, maxdistancesq) {
  foreach(smartcover in level.smartcoversettings.var_f115c746) {
    if(!isDefined(smartcover)) {
      continue;
    }

    if(distancesquared(smartcover.origin, origin) < maxdistancesq) {
      return true;
    }
  }

  return false;
}

watchweaponchange() {
  player = self;
  self notify(#"watchweaponchange_singleton");
  self endon(#"watchweaponchange_singleton");

  while(true) {
    if(self weaponswitchbuttonpressed()) {
      if(isDefined(player.smartcover)) {
        player.smartcover.var_5af6633b = 1;
      }
    }

    waitframe(1);
  }
}

function_57f553e9(&coverlist, maxallowed) {
  if(coverlist.size <= maxallowed) {
    return undefined;
  }

  outstayed_spawner = array::pop_front(coverlist, 0);
  coverlist = array::remove_undefined(coverlist, 0);
  return outstayed_spawner;
}

function_92112113(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(level.smartcoversettings) || !isDefined(level.smartcoversettings.var_f115c746) || !isDefined(victim) || !isDefined(attacker) || !isDefined(attackerweapon) || !isDefined(weapon)) {
    return false;
  }

  if(isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](attackerweapon) || attackerweapon == weapon) {
    return false;
  }

  foreach(smartcover in level.smartcoversettings.var_f115c746) {
    if(!isDefined(smartcover)) {
      continue;
    }

    if(!isDefined(victim) || !isDefined(victim.team) || !isDefined(smartcover.owner)) {
      continue;
    }

    if(victim == smartcover.owner || level.teambased && !util::function_fbce7263(victim.team, smartcover.owner.team)) {
      continue;
    }

    var_583e1573 = distancesquared(smartcover.origin, attacker.origin);

    if(var_583e1573 > level.smartcoversettings.var_357db326) {
      continue;
    }

    var_eb870c = distancesquared(victim.origin, smartcover.origin);
    var_ae30f518 = distancesquared(victim.origin, attacker.origin);
    var_d9ecf725 = var_ae30f518 > var_583e1573;
    var_1d1ca33b = var_ae30f518 > var_eb870c;

    if(var_d9ecf725 && var_1d1ca33b) {
      var_a3aba5a9 = 1;
      var_71eedb0b = smartcover.owner;
      break;
    }
  }

  if(isDefined(var_71eedb0b) && isDefined(var_a3aba5a9) && var_a3aba5a9) {
    if(smartcover.owner == attacker) {
      return true;
    } else {
      scoreevents::processscoreevent(#"deployable_cover_assist", var_71eedb0b, victim, level.smartcoversettings.smartcoverweapon);
    }
  }

  return false;
}

private function_4e6d9621(smartcover, origins, radii) {
  assert(isarray(origins));
  assert(!isarray(radii) || origins.size == radii.size);
  assert(isDefined(smartcover.var_eda9690f) && smartcover.var_eda9690f.size > 0);

  foreach(var_592587c3 in smartcover.var_eda9690f) {
    for(index = 0; index < origins.size; index++) {
      distance = distancesquared(origins[index], var_592587c3);
      radius = isarray(radii) ? radii[index] : radii;
      combinedradius = radius + getdvarfloat(#"hash_4d17057924212aa9", 1);

      if(getdvarint(#"hash_686a676b28ae0af4", 0) == 1) {
        sphere(origins[index], radius, (0, 0, 1), 0.5, 0, 10, 500);
        sphere(var_592587c3, getdvarfloat(#"hash_4d17057924212aa9", 1), (1, 0, 0), 0.5, 0, 10, 500);

      }

      radiussqr = combinedradius * combinedradius;

      if(distance < radiussqr) {
        return true;
      }
    }
  }

  return false;
}

function_e3a901c(origins, radii) {
  if(!isDefined(level.smartcoversettings.var_f115c746)) {
    return false;
  }

  foreach(smartcover in level.smartcoversettings.var_f115c746) {
    if(!isDefined(smartcover)) {
      continue;
    }

    if(function_4e6d9621(smartcover, origins, radii)) {
      return true;
    }
  }

  return false;
}

reset_being_microwaved() {
  self.lastmicrowavedby = undefined;
  self.beingmicrowavedby = undefined;
}

startmicrowave() {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self clientfield::set("start_smartcover_microwave", 1);
  self.trigger = spawn("trigger_radius", self.origin + (0, 0, (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0, (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * 2);
  self thread turretthink();

  self thread turretdebugwatch();
}

stopmicrowave() {
  if(!isDefined(self)) {
    return;
  }

  self playSound(#"mpl_microwave_beam_off");

  if(self getentitytype() == 6) {
    self clientfield::set("start_smartcover_microwave", 0);
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self notify(#"stop_turret_debug");
}

turretdebugwatch() {
  turret = self;
  turret endon(#"stop_turret_debug");

  for(;;) {
    if(getdvarint(#"scr_microwave_turret_debug", 0) != 0) {
      turret turretdebug();
      waitframe(1);
      continue;
    }

    wait 1;
  }
}

turretdebug() {
  turret = self;
  angles = turret gettagangles("tag_flash");
  origin = turret gettagorigin("tag_flash");
  cone_apex = origin;
  forward = anglesToForward(angles);
  dome_apex = cone_apex + vectorscale(forward, isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0);

  util::debug_spherical_cone(cone_apex, dome_apex, isDefined(level.smartcoversettings.bundle.var_cbd5f27c) ? level.smartcoversettings.bundle.var_cbd5f27c : 0, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
}

turretthink() {
  turret = self;
  turret endon(#"microwave_turret_shutdown");
  turret endon(#"death");
  turret.trigger endon(#"death");
  turret.turret_vehicle_entnum = turret getentitynumber();

  while(true) {
    waitresult = turret.trigger waittill(#"trigger");
    ent = waitresult.activator;

    if(ent == turret) {
      continue;
    }

    if(!isDefined(ent.beingmicrowavedby)) {
      ent.beingmicrowavedby = [];
    }

    if(turret microwaveturretaffectsentity(ent) && !isDefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum])) {
      turret thread microwaveentity(ent);
    }
  }
}

microwaveentitypostshutdowncleanup(entity) {
  entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
  self endon(#"death");
  turret = self;
  turret_vehicle_entnum = turret.turret_vehicle_entnum;
  turret waittill(#"microwave_turret_shutdown");

  if(isDefined(entity)) {
    if(isDefined(entity.beingmicrowavedby) && isDefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
      entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
    }
  }
}

microwaveentity(entity) {
  turret = self;
  turret endon(#"microwave_turret_shutdown", #"death");
  entity endon(#"disconnect", #"death");

  if(isplayer(entity)) {
    entity endon(#"joined_team", #"joined_spectators");
  }

  turret thread microwaveentitypostshutdowncleanup(entity);
  entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
  entity.microwavedamageinitialdelay = 1;
  entity.microwaveeffect = 0;
  shellshockscalar = 1;
  viewkickscalar = 1;
  damagescalar = 1;

  if(isplayer(entity) && entity hasperk(#"specialty_microwaveprotection")) {
    shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
    viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
    damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
  }

  if(getgametypesetting(#"competitivesettings") === 1) {
    var_756fda07 = getstatuseffect(#"hash_4571e9bb8d1be2af");
    var_2b29cf8c = getstatuseffect(#"hash_13ef8ef2acaa9aec");
  } else {
    var_756fda07 = getstatuseffect(#"microwave_slowed");
    var_2b29cf8c = getstatuseffect(#"microwave_dot");
  }

  turret_vehicle_entnum = turret.turret_vehicle_entnum;
  var_2b29cf8c.killcament = turret;

  while(true) {
    if(!isDefined(turret) || !isDefined(turret.trigger) || !turret microwaveturretaffectsentity(entity)) {
      if(!isDefined(entity)) {
        return;
      }

      if(isDefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
        entity thread status_effect::function_408158ef(var_756fda07.setype, var_756fda07.var_18d16a6b);
        entity thread status_effect::function_408158ef(var_2b29cf8c.setype, var_2b29cf8c.var_18d16a6b);

        if(isDefined(entity.var_553267c8)) {
          entity stoprumble(entity.var_553267c8);
          entity.var_553267c8 = undefined;
        }
      }

      entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;

      if(isDefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
        entity.microwavepoisoning = 0;
      }

      entity notify(#"end_microwaveentitypostshutdowncleanup");
      return;
    }

    damage = (isDefined(level.smartcoversettings.bundle.microwavedamage) ? level.smartcoversettings.bundle.microwavedamage : 0) * damagescalar;

    if(level.hardcoremode) {
      damage *= isDefined(level.smartcoversettings.bundle.var_78c1e37b) ? level.smartcoversettings.bundle.var_78c1e37b : 0.25;
    }

    if(!isai(entity) && entity util::mayapplyscreeneffect()) {
      if(!isDefined(entity.microwavepoisoning) || !entity.microwavepoisoning) {
        entity.microwavepoisoning = 1;
        entity.microwaveeffect = 0;
      }
    }

    if(isDefined(entity.microwavedamageinitialdelay)) {
      wait randomfloatrange(0.1, 0.3);
      entity.microwavedamageinitialdelay = undefined;
    }

    entity thread status_effect::status_effect_apply(var_2b29cf8c, level.smartcoversettings.smartcoverweapon, self, 0);
    entity.microwaveeffect++;
    entity.lastmicrowavedby = turret.owner;
    time = gettime();

    if(isplayer(entity) && isDefined(entity.clientid)) {
      entity playsoundtoplayer(#"hash_5eecc78116b1fc85", entity);

      if(!entity isremotecontrolling() && time - (isDefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950) {
        if(entity.microwaveeffect % 2 == 1) {
          entity viewkick(int(25 * viewkickscalar), turret.origin);
          entity.microwaveshellshockandviewkicktime = time;
          entity thread status_effect::status_effect_apply(var_756fda07, level.smartcoversettings.smartcoverweapon, self, 0);
          var_83cd8106 = level.smartcoversettings.bundle.var_5223868e;

          if(isDefined(var_83cd8106)) {
            entity playrumbleonentity(var_83cd8106);
            entity.var_553267c8 = var_83cd8106;
          }
        }
      }

      if(!isDefined(turret.playersdamaged)) {
        turret.playersdamaged = [];
      }

      turret.playersdamaged[entity.clientid] = 1;

      if(!(isDefined(level.smartcoversettings.bundle.var_74dcfa31) ? level.smartcoversettings.bundle.var_74dcfa31 : 0) && entity.microwaveeffect % 3 == 2) {
        scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, level.smartcoversettings.smartcoverweapon, turret.playersdamaged.size);
      }
    }

    wait 0.5;
  }
}

microwaveturretaffectsentity(entity) {
  turret = self;

  if(!isalive(entity)) {
    return false;
  }

  if(!isplayer(entity) && !isai(entity)) {
    return false;
  }

  if(entity.ignoreme === 1) {
    return false;
  }

  if(isDefined(turret.carried) && turret.carried) {
    return false;
  }

  if(turret weaponobjects::isstunned()) {
    return false;
  }

  if(isDefined(turret.owner) && entity == turret.owner) {
    return false;
  }

  if(!damage::friendlyfirecheck(turret.owner, entity, 0)) {
    return false;
  }

  if(isplayer(entity) && entity getEye()[2] < turret.origin[2]) {
    return false;
  }

  if(isai(entity)) {
    entityheight = entity.maxs[2] - entity.mins[2] + entity.origin[2];

    if(entityheight < turret.origin[2]) {
      return false;
    }
  }

  if((isDefined(level.smartcoversettings.bundle.var_7ba68eb6) ? level.smartcoversettings.bundle.var_7ba68eb6 : 0) > 0 && entity.origin[2] > turret.origin[2] + level.smartcoversettings.bundle.var_7ba68eb6) {
    return false;
  }

  if(distancesquared(entity.origin, turret.origin) > (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0)) {
    return false;
  }

  angles = turret getangles();
  realorigin = turret.origin + (0, 0, 30);
  forward = anglesToForward(angles);
  origin = realorigin - forward * 50;
  shoot_at_pos = entity getshootatpos(turret);
  var_29d7e93f = vectornormalize(shoot_at_pos - realorigin);
  var_2d95367c = vectordot(var_29d7e93f, forward);

  if(var_2d95367c < 0) {
    return false;
  }

  entdirection = vectornormalize(shoot_at_pos - origin);
  dot = vectordot(entdirection, forward);

  if(dot < cos(isDefined(level.smartcoversettings.bundle.var_cbd5f27c) ? level.smartcoversettings.bundle.var_cbd5f27c : 0)) {
    return false;
  }

  if(entity damageconetrace(origin, turret, forward) <= 0) {
    return false;
  }

  return true;
}
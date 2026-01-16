/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_concertina_wire.gsc
********************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\gadgets\gadget_smart_cover;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\deployable;
#include scripts\weapons\weapon_utils;
#include scripts\weapons\weaponobjects;

#namespace concertina_wire;

init_shared(var_4b51853b) {
  level.var_87226c31 = spawnStruct();
  level.var_87226c31.bundle = getscriptbundle(var_4b51853b);
  level.var_87226c31.concertinawireweapon = getweapon(#"eq_concertina_wire");
  level.var_87226c31.var_546a220c = "concertina_wire_objective_default";
  level.var_87226c31.var_925bbb2 = [];
  level.var_87226c31.objectivezones = [];
  level.var_94029383 = &function_4ee7d46a;
  setdvar(#"hash_430cc236fe8b2561", 8);
  ability_player::register_gadget_should_notify(37, 1);
  weaponobjects::function_e6400478(#"eq_concertina_wire", &function_57955e51, 1);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed_with_params(&onplayerkilled);
  callback::on_start_gametype(&startgametype);
  deployable::register_deployable(level.var_87226c31.concertinawireweapon, &function_e5fdca70, &function_6fe5a945, undefined, undefined, 1);
  level.var_87226c31.var_357db326 = 10000;
  clientfield::register("scriptmover", "concertinaWire_placed", 1, 5, "float");
  clientfield::register("scriptmover", "concertinaWireDestroyed", 1, 1, "int");
  clientfield::register("scriptmover", "concertinaWireDroopyBits", 1, 3, "int");
  level.var_87226c31.var_ff1a491d = level.var_87226c31.bundle.var_76d79155 * level.var_87226c31.bundle.var_76d79155;
  level.var_87226c31.bucklerweapon = getweapon(#"sig_buckler_turret");
  setdvar(#"hash_753335900deb89ea", 25);
}

startgametype() {
  thread function_b842eab8();
}

function_ef1137ae(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(victim) || !isDefined(victim.var_c6a21b50) || (isDefined(victim.var_cd7665dd) ? victim.var_cd7665dd : 0) + 500 < gettime()) {
    return false;
  }

  if(isDefined(attacker) && (!isDefined(victim.var_c6a21b50.owner) || attacker != victim.var_c6a21b50.owner)) {
    return false;
  }

  return true;
}

onplayerkilled(s_params) {
  if(!isDefined(s_params.weapon)) {
    return;
  }

  if(!function_ef1137ae(s_params.eattacker, self)) {
    return;
  }

  if(s_params.weapon != level.var_87226c31.concertinawireweapon) {
    killstreaks::processscoreevent(#"concertina_wire_snared_kill", s_params.eattacker, self, level.var_87226c31.concertinawireweapon);
  }

  if(s_params.weapon != level.var_87226c31.concertinawireweapon) {
    return;
  }

  weapon = s_params.weapon;
  var_4fd6205f = isDefined(self.var_c6a21b50.owner) ? self.var_c6a21b50.owner == s_params.eattacker : 0;

  if(!isDefined(s_params.eattacker) || !isplayer(s_params.eattacker)) {
    return;
  }

  var_8e797a67 = s_params.eattacker loadout::function_18a77b37("primarygrenade");
  var_a66b455e = s_params.eattacker loadout::function_18a77b37("specialgrenade");
  ultimateweapon = s_params.eattacker loadout::function_18a77b37("ultimate");
  var_bc9c6fcb = 0;

  if(isDefined(var_8e797a67) && var_8e797a67.statname == weapon.statname || isDefined(var_a66b455e) && var_a66b455e.statname == weapon.statname || isDefined(ultimateweapon) && ultimateweapon.statname == weapon.statname) {
    var_bc9c6fcb = 1;
  }

  if(var_bc9c6fcb) {
    killstreaks::processscoreevent(#"hash_152856ae19af395b", self.var_c6a21b50.owner, self, level.var_87226c31.concertinawireweapon);
  }

  if(isDefined(level.playgadgetsuccess) && var_4fd6205f) {
    relativepos = vectornormalize(self.origin - s_params.eattacker.origin);
    dir = anglesToForward(s_params.eattacker getplayerangles());
    dotproduct = vectordot(dir, relativepos);

    if(dotproduct > 0 && sighttracepassed(s_params.eattacker getEye(), self getEye(), 1, s_params.eattacker, self)) {
      s_params.eattacker[[level.playgadgetsuccess]](level.var_87226c31.concertinawireweapon, undefined, self, undefined);
    }
  }
}

function_c5f0b9e7(func) {
  level.onconcertinawireplaced = func;
}

function_d700c081(func) {
  level.var_c560f03 = func;
}

function_42b34d5a() {
  if(!isDefined(self.concertinawire)) {
    return;
  }

  foreach(concertinawire in self.concertinawire.var_a3aac76c) {
    if(isDefined(concertinawire)) {
      concertinawire function_4ee7d46a(1);
    }
  }
}

function_e4f3f17() {
  self endon(#"death");

  if((isDefined(level.var_87226c31.bundle.timeout) ? level.var_87226c31.bundle.timeout : 0) == 0) {
    return;
  }

  wait level.var_87226c31.bundle.timeout;

  if(isDefined(self)) {
    self function_4ee7d46a(1);
  }
}

on_player_spawned() {
  if(!isDefined(self.concertinawire)) {
    self.concertinawire = spawnStruct();
    self.concertinawire.var_a3aac76c = [];
    self.concertinawire.activelist = [];
  }

  if(!self hasweapon(level.var_87226c31.concertinawireweapon) && self.concertinawire.var_a3aac76c.size > 0) {
    self function_42b34d5a();
  }
}

function_e5fdca70(origin, angles, player) {
  if(isDefined(level.var_d1ae43e3)) {
    return [[level.var_d1ae43e3]](origin, angles, player);
  }

  return 1;
}

function_6fe5a945(player) {
  assert(isDefined(level.var_87226c31.bundle.var_63aab046));

  if(!isDefined(player) || !isDefined(player.concertinawire)) {
    return 0;
  }

  var_b43e8dc2 = player function_287dcf4b(level.var_87226c31.bundle.var_63aab046, level.var_87226c31.bundle.maxwidth, 0, 0, level.var_87226c31.concertinawireweapon);

  if(!var_b43e8dc2.isvalid) {
    player.concertinawire.lastvalid = undefined;
    player function_bf191832(0, (0, 0, 0), (0, 0, 0));
    return var_b43e8dc2;
  }

  player.concertinawire.lastvalid = var_b43e8dc2;
  var_2b68b641 = function_54267517(var_b43e8dc2.origin);
  var_1167a9ce = function_6541080b(var_b43e8dc2.origin, level.var_87226c31.var_ff1a491d);
  playerright = anglestoright(player.angles);
  origins = [];

  if(!isDefined(origins)) {
    origins = [];
  } else if(!isarray(origins)) {
    origins = array(origins);
  }

  origins[origins.size] = var_b43e8dc2.origin;
  var_e5da702e = var_b43e8dc2.origin + playerright * getdvarfloat(#"hash_753335900deb89ea", 1);

  if(!isDefined(origins)) {
    origins = [];
  } else if(!isarray(origins)) {
    origins = array(origins);
  }

  origins[origins.size] = var_e5da702e;
  var_62e3ee6f = var_b43e8dc2.origin - playerright * getdvarfloat(#"hash_753335900deb89ea", 1);

  if(!isDefined(origins)) {
    origins = [];
  } else if(!isarray(origins)) {
    origins = array(origins);
  }

  origins[origins.size] = var_62e3ee6f;

  if(smart_cover::function_e3a901c(origins, getdvarfloat(#"hash_753335900deb89ea", 1))) {
    var_b43e8dc2.isvalid = 0;
    return var_b43e8dc2;
  }

  candeploy = !var_1167a9ce && !var_2b68b641;

  if(!candeploy) {
    var_b43e8dc2.isvalid = 0;
    player function_bf191832(candeploy, (0, 0, 0), (0, 0, 0));
    return var_b43e8dc2;
  }

  player function_bf191832(candeploy, var_b43e8dc2.origin, var_b43e8dc2.angles);
  return var_b43e8dc2;
}

function_5ea6e77d(point, upangles) {
  var_2fa728ff = point + upangles * -10;
  var_71fcd06b = point + upangles * 10;
  mins = (-10, -10, -10);
  maxs = (10, 10, 10);
  var_e07c7e8 = physicstrace(var_71fcd06b, var_2fa728ff, mins, maxs, self, 1);
  return var_e07c7e8[#"fraction"] < 1;
}

private function_2562ba62(var_637dcf3d, startlocation, var_a4e8554b) {
  var_b43e8dc2 = spawnStruct();
  var_b43e8dc2.var_e74f7cdd = 1;
  var_b43e8dc2.var_8e37de72 = 1;
  var_b43e8dc2.var_b78da7c7 = var_a4e8554b;
  dirright = anglestoright(var_637dcf3d.angles);
  var_16482870 = 0;
  lasttime = gettime();
  var_97dd8ca1 = 1 / level.var_87226c31.bundle.deploytime;
  var_28cd159a = 0;
  var_ea8ed4c6 = 0;

  while(var_16482870 <= var_a4e8554b) {
    var_637dcf3d clientfield::set("concertinaWire_placed", 1 - var_16482870);
    var_300fb0d2 = level.var_87226c31.bundle.maxwidth * var_16482870 * 0.5;
    rightpoint = startlocation + dirright * var_300fb0d2;
    upangles = anglestoup(var_637dcf3d.angles);

    if(!var_637dcf3d function_5ea6e77d(rightpoint, upangles)) {
      var_b43e8dc2.var_e74f7cdd = 0;
    }

    leftpoint = startlocation - dirright * var_300fb0d2;

    if(!var_637dcf3d function_5ea6e77d(leftpoint, upangles)) {
      var_b43e8dc2.var_8e37de72 = 0;
    }

    var_28cd159a = var_16482870;

    if(var_ea8ed4c6 || !var_b43e8dc2.var_8e37de72 || !var_b43e8dc2.var_e74f7cdd) {
      break;
    }

    waitframe(1);
    var_32c844bb = gettime() - lasttime;
    var_16482870 += var_32c844bb * var_97dd8ca1;

    if(var_16482870 >= var_a4e8554b) {
      var_ea8ed4c6 = 1;
      var_16482870 = min(var_16482870, var_a4e8554b);
    }

    var_637dcf3d.var_80cf41a4 = var_16482870;
    lasttime = gettime();
  }

  var_b43e8dc2.var_b78da7c7 = max(var_a4e8554b - var_28cd159a, 0);
  return var_b43e8dc2;
}

private function_4e7c57c1(var_637dcf3d, startorigin, direction, var_16482870, var_a4e8554b, movedirection, var_3140daee) {
  var_b26653b3 = var_16482870 * level.var_87226c31.bundle.maxwidth;
  lasttime = gettime();
  var_97dd8ca1 = 1 / level.var_87226c31.bundle.deploytime;

  while(var_16482870 <= var_a4e8554b) {
    var_637dcf3d clientfield::set("concertinaWire_placed", 1 - var_16482870);

    if(var_16482870 == var_a4e8554b) {
      break;
    }

    var_300fb0d2 = level.var_87226c31.bundle.maxwidth * var_16482870;
    var_dbd651f9 = var_300fb0d2 - var_b26653b3;
    var_637dcf3d.origin = startorigin + vectorscale(direction, var_dbd651f9 * 0.5);
    var_f49249d7 = startorigin + direction * var_300fb0d2;
    upangles = anglestoup(var_637dcf3d.angles);

    if(!var_637dcf3d function_5ea6e77d(var_f49249d7, upangles)) {
      if(movedirection == 0) {
        var_3140daee.var_e74f7cdd = 0;
      } else {
        var_3140daee.var_8e37de72 = 1;
      }

      break;
    }

    waitframe(1);
    var_32c844bb = gettime() - lasttime;
    var_16482870 += var_32c844bb * var_97dd8ca1;
    var_16482870 = min(var_16482870, 1);
    var_637dcf3d.var_80cf41a4 = var_16482870;
    lasttime = gettime();
  }

  return var_3140daee;
}

function_8d89605(var_637dcf3d, traceresults) {
  var_637dcf3d endon(#"death");
  var_637dcf3d useanimtree("generic");
  var_637dcf3d setanim(level.var_87226c31.bundle.deployanim, 1, 0, 0);
  var_637dcf3d clientfield::set("concertinaWire_placed", 1);
  waitframe(1);
  var_a4e8554b = traceresults.width / level.var_87226c31.bundle.maxwidth;
  var_97dd8ca1 = 1 / level.var_87226c31.bundle.deploytime;
  var_2ba378bd = var_a4e8554b * level.var_87226c31.bundle.deploytime;
  lasttime = gettime();
  moveamount = 0;
  var_16482870 = 0;
  var_b80b6889 = distance2d(traceresults.origin, traceresults.var_c0e006dc);
  var_65ea35de = distance2d(traceresults.origin, traceresults.var_44cf251d);
  dirright = vectornormalize(traceresults.var_c0e006dc - traceresults.origin);
  dirleft = vectornormalize(traceresults.var_44cf251d - traceresults.origin);

  if(var_b80b6889 < var_65ea35de) {
    var_a66e2af8 = var_b80b6889;
    movementdirection = vectornormalize(traceresults.var_44cf251d - traceresults.origin);
    movedirection = 1;
  } else {
    var_a66e2af8 = var_65ea35de;
    movementdirection = vectornormalize(traceresults.var_c0e006dc - traceresults.origin);
    movedirection = 0;
  }

  var_de26b48c = min(var_a66e2af8 * 2 / level.var_87226c31.bundle.maxwidth, 1);
  var_3140daee = function_2562ba62(var_637dcf3d, traceresults.origin, var_de26b48c);
  var_300fb0d2 = (var_de26b48c - var_3140daee.var_b78da7c7) * level.var_87226c31.bundle.maxwidth;
  var_16482870 = var_de26b48c - var_3140daee.var_b78da7c7;
  var_891f9499 = 0;
  distanceremaining = traceresults.width - var_300fb0d2;

  if(!var_3140daee.var_e74f7cdd && !var_3140daee.var_8e37de72) {
    var_891f9499 = 0;
  } else if(!var_3140daee.var_e74f7cdd || !var_3140daee.var_8e37de72) {
    var_891f9499 = 1;

    if(!var_3140daee.var_e74f7cdd) {
      movementdirection = dirleft;
      distanceremaining = min(var_65ea35de - var_300fb0d2, distanceremaining);
      movedirection = 1;
    } else {
      movementdirection = dirright;
      distanceremaining = min(var_b80b6889 - var_300fb0d2, distanceremaining);
      movedirection = 0;
    }

    var_a4e8554b = (distanceremaining + var_300fb0d2) / level.var_87226c31.bundle.maxwidth;
  }

  if(var_a4e8554b - var_16482870 > 0.05) {
    var_3140daee = function_4e7c57c1(var_637dcf3d, traceresults.origin, movementdirection, var_16482870, var_a4e8554b, movedirection, var_3140daee);
  }

  if(!var_3140daee.var_e74f7cdd && !var_3140daee.var_8e37de72) {
    var_637dcf3d clientfield::set("concertinaWireDroopyBits", 3);
  } else if(!var_3140daee.var_e74f7cdd) {
    var_637dcf3d clientfield::set("concertinaWireDroopyBits", 1);
  } else if(!var_3140daee.var_8e37de72) {
    var_637dcf3d clientfield::set("concertinaWireDroopyBits", 2);
  }

  if(isDefined(var_637dcf3d.var_80cf41a4)) {
    var_3dd315d6 = var_637dcf3d.var_80cf41a4;

    if(var_3dd315d6 < 0.85) {
      var_3dd315d6 *= 0.9;
    }

    var_637dcf3d setanimtime(level.var_87226c31.bundle.deployanim, var_3dd315d6);
  }

  var_637dcf3d.trigger = spawn("trigger_box_new", var_637dcf3d.origin + (0, 0, 30), getvehicletriggerflags() | getaitriggerflags(), 20, int(var_16482870 * traceresults.width * 0.8), 60);
  var_637dcf3d.trigger.angles = var_637dcf3d.angles;
  thread function_f067d867(var_637dcf3d);
}

function_fc4df41e(watcher, owner) {
  self endon(#"death");
  player = owner;
  self.canthack = 1;
  self hide();

  if(!isDefined(player.concertinawire.lastvalid) || !player.concertinawire.lastvalid.isvalid) {
    player deployable::function_416f03e6(level.var_87226c31.concertinawireweapon);
    return;
  }

  var_637dcf3d = player function_34d706ae(watcher, self, player.concertinawire.lastvalid.origin, player.concertinawire.lastvalid.angles, 1, player.concertinawire.lastvalid.width);
  array::add(player.concertinawire.activelist, var_637dcf3d);
  var_26c9fcc2 = function_57f553e9(player.concertinawire.activelist, level.var_87226c31.bundle.var_a0b69d8b);

  if(isDefined(var_26c9fcc2)) {
    var_26c9fcc2 function_4ee7d46a(1);
  }

  if(isDefined(level.onconcertinawireplaced)) {
    owner[[level.onconcertinawireplaced]](self);
  }

  self thread function_d82c03d4(player);
  var_637dcf3d clientfield::set("concertinaWire_placed", 1);
  assert(isDefined(level.var_87226c31), "<dev string:x38>");
  assert(isDefined(level.var_87226c31.bundle), "<dev string:x66>");
  var_637dcf3d influencers::create_entity_enemy_influencer("grenade", owner.team);
  var_637dcf3d util::make_sentient();

  if(isDefined(level.var_87226c31.bundle.deployanim)) {
    thread function_8d89605(var_637dcf3d, player.concertinawire.lastvalid);
  }

  var_637dcf3d function_e4f3f17();
}

function_57955e51(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &function_fc4df41e;
  watcher.deleteonplayerspawn = 0;
}

function_d82c03d4(player) {
  self endon(#"death");
  player waittill(#"joined_team", #"disconnect");
  player function_42b34d5a();
}

function_dd007be2() {
  level endon(#"game_ended");
  self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
  self endon(#"hash_c72d58e3d4735b");
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

    if(isDefined(waitresult.attacker) && isplayer(waitresult.attacker) && getdvarint(#"survival_prototype", 0) == 0) {
      if(waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
        waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
      }
    }
  }
}

function_cbc97710() {
  wait 10;
  self delete();
}

function_a1253947() {
  self clientfield::set("concertinaWireDestroyed", 1);
}

function_4ee7d46a(isselfdestruct) {
  concertinawire = self;
  concertinawire notify(#"hash_c72d58e3d4735b");
  concertinawire clientfield::set("enemyequip", 0);
  concertinawire clientfield::set("friendlyequip", 0);

  if(isDefined(concertinawire.objectiveid)) {
    objective_delete(concertinawire.objectiveid);
    gameobjects::release_obj_id(concertinawire.objectiveid);
  }

  if(isDefined(level.var_87226c31.bundle.destructionfx)) {
    if(isDefined(isselfdestruct) && isselfdestruct) {
      var_415135a0 = level.var_87226c31.bundle.selfdestructfx;
      var_72db9941 = level.var_87226c31.bundle.selfdestructaudio;
    } else {
      var_415135a0 = level.var_87226c31.bundle.destructionfx;
      var_72db9941 = level.var_87226c31.bundle.destructionaudio;
    }

    playFX(var_415135a0, concertinawire.origin, anglesToForward(concertinawire.angles), anglestoup(concertinawire.angles));

    if(isDefined(var_72db9941)) {
      concertinawire playSound(var_72db9941);
    }
  }

  if(isDefined(level.var_87226c31.bundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(level.var_87226c31.bundle.var_bb6c29b4, concertinawire.origin);
  }

  removeindex = -1;

  for(index = 0; index < level.var_87226c31.var_925bbb2.size; index++) {
    if(level.var_87226c31.var_925bbb2[index] == concertinawire) {
      array::remove_index(level.var_87226c31.var_925bbb2, index, 0);
      break;
    }
  }

  if(isDefined(concertinawire.owner)) {
    for(index = 0; index < concertinawire.owner.concertinawire.activelist.size; index++) {
      if(concertinawire.owner.concertinawire.activelist[index] == concertinawire) {
        arrayremovevalue(concertinawire.owner.concertinawire.activelist, concertinawire);
        concertinawire.owner.concertinawire.activelist = array::remove_undefined(concertinawire.owner.concertinawire.activelist, 0);
        break;
      }
    }
  }

  if(isDefined(concertinawire.var_2ee191cc)) {
    foreach(zoneid in concertinawire.var_2ee191cc) {
      deployable::function_b20df196(zoneid);
    }
  }

  deployable::function_81598103(concertinawire);

  if(isDefined(concertinawire.var_3b0688ef)) {
    badplace_delete(concertinawire.var_3b0688ef);
  }

  if(isDefined(concertinawire.killcament)) {
    concertinawire.killcament thread util::deleteaftertime(5);
  }

  if(isDefined(concertinawire.grenade)) {
    concertinawire.grenade thread util::deleteaftertime(1);
  }

  if(isDefined(concertinawire.trigger)) {
    concertinawire.trigger delete();
  }

  concertinawire delete();
}

onkilled(var_c946c04c) {
  concertinawire = self;

  if(var_c946c04c.attacker != concertinawire.owner) {
    concertinawire.owner globallogic_score::function_5829abe3(var_c946c04c.attacker, var_c946c04c.weapon, concertinawire.weapon);

    if(isDefined(level.var_d2600afc)) {
      concertinawire[[level.var_d2600afc]](var_c946c04c.attacker, concertinawire.owner, concertinawire.weapon, var_c946c04c.weapon);
    }
  }

  concertinawire.var_d02ddb8e = var_c946c04c.weapon;

  if(isDefined(level.var_c560f03)) {
    concertinawire[[level.var_c560f03]](var_c946c04c.attacker, concertinawire.var_d02ddb8e);
  }

  concertinawire thread function_4ee7d46a(0);
}

getmodel(var_796be15d) {
  return self.team == #"allies" ? level.var_87226c31.bundle.var_397ed90c : level.var_87226c31.bundle.var_b256e3da;
}

function_dac69ad1(player, concertinawire) {
  speed = length(player getvelocity());
  var_1c365dd = !(isDefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && player status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;

  if(speed <= (isDefined(level.var_87226c31.bundle.speedthreshold) ? level.var_87226c31.bundle.speedthreshold : 0)) {
    if(isDefined(player.var_fc55d553) ? player.var_fc55d553 : 0) {
      return;
    }

    if(var_1c365dd) {
      damageamount = isDefined(level.var_87226c31.bundle.var_81601340) ? level.var_87226c31.bundle.var_81601340 : 0;
    } else {
      damageamount = isDefined(level.var_87226c31.bundle.var_acadc685) ? level.var_87226c31.bundle.var_acadc685 : 0;
    }

    if(player getstance() == "prone") {
      if(var_1c365dd) {
        damageamount *= isDefined(level.var_87226c31.bundle.var_39717932) ? level.var_87226c31.bundle.var_39717932 : 0;
      } else {
        damageamount *= isDefined(level.var_87226c31.bundle.var_9095a88f) ? level.var_87226c31.bundle.var_9095a88f : 0;
      }
    }

    player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
    player.var_fc55d553 = 1;
  } else {
    if(isDefined(player.var_fee1c0df) && player.var_fee1c0df > gettime()) {
      return;
    }

    params = getstatuseffect(level.var_87226c31.bundle.var_1a6488fe);
    assert(isDefined(params), "<dev string:x9b>");
    duration = params.seduration;
    player.var_fee1c0df = gettime() + duration;

    if(var_1c365dd) {
      damageamount = isDefined(level.var_87226c31.bundle.var_24458de7) ? level.var_87226c31.bundle.var_24458de7 : 0;
    } else {
      damageamount = isDefined(level.var_87226c31.bundle.stoppeddamage) ? level.var_87226c31.bundle.stoppeddamage : 0;
    }

    if(level.hardcoremode) {
      damageamount *= isDefined(level.var_87226c31.bundle.var_78c1e37b) ? level.var_87226c31.bundle.var_78c1e37b : 0.25;
    }

    player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
    player status_effect::status_effect_apply(params, level.var_87226c31.concertinawireweapon, concertinawire.owner, 0, undefined, undefined, player.origin);
  }

  concertinawire function_a9160578(damageamount, player);
}

function_b842eab8() {
  level endon(#"game_ended");
  params = getstatuseffect(level.var_87226c31.bundle.var_f6fdbda7);

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isDefined(player.var_cd7665dd) || !(isDefined(player.var_85c3882d) ? player.var_85c3882d : 0)) {
        continue;
      }

      timesincelast = gettime() - player.var_cd7665dd;

      if(timesincelast > 250) {
        player.var_85c3882d = 0;
        player status_effect::function_408158ef(params.setype, params.var_18d16a6b);
      }
    }

    waitframe(1);
  }
}

function_f067d867(concertinawire) {
  level endon(#"game_ended");
  concertinawire endon(#"death");

  while(true) {
    waitresult = concertinawire.trigger waittill(#"trigger");
    player = waitresult.activator;

    if(!isplayer(player)) {
      isenemy = isDefined(concertinawire.owner) && isDefined(player.owner) && (!level.teambased || util::function_fbce7263(player.team, concertinawire.owner.team)) && player.owner != concertinawire.owner;

      if(isDefined(player.killstreaktype) && (player.killstreaktype == "recon_car" || player.killstreaktype == "inventory_recon_car") && isenemy) {
        player dodamage(1, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
      }

      if(isDefined(player.archetype) && player.archetype == #"robot" && util::function_fbce7263(player.team, concertinawire.owner.team)) {
        player.var_85c3882d = 1;
        continue;
      }

      if(isDefined(player.archetype) && player.archetype == #"wasp" && util::function_fbce7263(player.team, concertinawire.owner.team)) {
        continue;
      }

      if(isDefined(concertinawire.owner) && util::function_fbce7263(player.team, concertinawire.owner.team)) {
        if(!(isDefined(player.var_65e57a10) && player.var_65e57a10)) {
          if(getdvarint(#"survival_prototype", 0)) {
            damageamount = 10;
          } else {
            damageamount = isDefined(level.var_87226c31.bundle.var_acadc685) ? level.var_87226c31.bundle.var_acadc685 : 0;
          }

          concertinawire dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
        }

        player callback::callback(#"hash_3bb51ce51020d0eb", {
          #wire: concertinawire
        });
      }

      continue;
    }

    player.var_cd7665dd = gettime();
    player.var_c6a21b50 = concertinawire;
    player.var_85c3882d = 1;
    var_50487836 = isDefined(concertinawire.owner) && (!level.teambased || util::function_fbce7263(player.team, concertinawire.owner.team)) && player != concertinawire.owner;
    var_da47eedd = 0;

    if(level.var_87226c31.bucklerweapon === player.currentweapon) {
      var_da47eedd = 1;
    }

    var_434fa90d = var_da47eedd || player isslamming() || player isjuking();

    if(var_50487836 && !var_434fa90d) {
      concertinawire function_2dd4aa9d(player);
    }

    var_e8c58890 = 0;

    if(isDefined(player.prevposition)) {
      distancemoved = distance2d(player.prevposition, player.origin);

      if(distancemoved < 0.0001) {} else if(!isDefined(player.var_45650309) || gettime() > player.var_45650309 + 350 && distancemoved > 0.5) {
        var_e8c58890 = 1;
      }
    } else {
      var_e8c58890 = 1;
    }

    if(var_e8c58890) {
      player playSound(#"hash_4b5965717e4efc71");
      player.var_45650309 = gettime();

      if((isDefined(var_50487836) ? var_50487836 : 0) && !var_434fa90d) {
        player gestures::function_56e00fbf(#"hash_3e06c757e4b20f4f", undefined, 0);
      }
    }

    player.prevposition = player.origin;

    if(var_50487836 && !var_434fa90d) {
      function_dac69ad1(player, concertinawire);
    }

    if(var_da47eedd && isDefined(level.var_87226c31.bundle.var_2aa7241e)) {
      if(!isDefined(concertinawire.var_2dd485d4[player.clientid]) || concertinawire.var_2dd485d4[player.clientid] + 500 < gettime()) {
        if(!isDefined(concertinawire.var_2dd485d4[player.clientid])) {
          concertinawire.var_2dd485d4[player.clientid] = gettime();
        }

        var_33ecfd86 = level.var_87226c31.bundle.var_2aa7241e * 0.5;
        concertinawire dodamage(var_33ecfd86, player.origin, player, undefined, undefined, "MOD_IMPACT", 0, player.currentweapon);
        concertinawire.var_2dd485d4[player.clientid] = gettime();
      }
    }
  }
}

private jumpcooldown(player, var_16505949) {
  player endon(#"death");
  player allowjump(0);
  player.var_10fb4c3d = 0;
  wait var_16505949;
  player allowjump(1);
  player.var_10fb4c3d = 1;
}

private function_2dd4aa9d(player) {
  concertinawire = self;
  var_1c365dd = !(isDefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && player status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;

  if(player jumpbuttonpressed() && (isDefined(player.var_10fb4c3d) ? player.var_10fb4c3d : 1)) {
    if(!isDefined(player.var_357edf99) || !player.var_357edf99) {
      if(var_1c365dd) {
        damageamount = isDefined(level.var_87226c31.bundle.var_24458de7) ? level.var_87226c31.bundle.var_24458de7 : 0;
        var_30df0193 = isDefined(level.var_87226c31.bundle.var_2ec8f744) ? level.var_87226c31.bundle.var_2ec8f744 : 0;
      } else {
        damageamount = isDefined(level.var_87226c31.bundle.stoppeddamage) ? level.var_87226c31.bundle.stoppeddamage : 0;
        var_30df0193 = isDefined(level.var_87226c31.bundle.jumpcooldown) ? level.var_87226c31.bundle.jumpcooldown : 0;
      }

      player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
      player.var_357edf99 = 1;
      thread jumpcooldown(player, var_30df0193);
      concertinawire function_a9160578(damageamount, player);
    }
  } else {
    player.var_357edf99 = 0;
  }

  if(player isdoublejumping()) {
    player setdoublejumpenergy(0);
  }

  if(!isDefined(player.var_673f6995) || player.var_673f6995 < gettime()) {
    params = getstatuseffect(level.var_87226c31.bundle.var_f6fdbda7);
    assert(isDefined(params), "<dev string:x9b>");
    duration = params.seduration;
    player.var_673f6995 = gettime() + duration;
    player.var_fc55d553 = 0;
  }

  if(!isDefined(player.var_13d8a85d) || player.var_13d8a85d < gettime()) {
    params = getstatuseffect(level.var_87226c31.bundle.var_f6fdbda7);
    assert(isDefined(params), "<dev string:x9b>");
    player status_effect::status_effect_apply(params, level.var_87226c31.concertinawireweapon, concertinawire.owner, 1, undefined, undefined, player.origin);
    endtime = player status_effect::function_2ba2756c(params.var_18d16a6b);
    player.var_13d8a85d = endtime - 75;
  }
}

function_a9160578(damagedealt, player) {
  if(!isDefined(player) || !isDefined(damagedealt) || !isDefined(self)) {
    return;
  }

  damagedealt = int(damagedealt);
  self.damagedealt = (isDefined(self.damagedealt) ? self.damagedealt : 0) + damagedealt;

  if(!isDefined(self.playersdamaged)) {
    self.playersdamaged = [];
  }

  entnumb = player getentitynumber();
  self.playersdamaged[entnumb] = 1;

  if(isDefined(level.var_87226c31.bundle.var_89ee8a9) && self.damagedealt >= level.var_87226c31.bundle.var_89ee8a9) {
    scoreevents::processscoreevent(#"hash_6024b59ca1d3b641", self.owner, undefined, self.weapon, self.playersdamaged.size);
    self.damagedealt -= level.var_87226c31.bundle.var_89ee8a9;
  }
}

function_82c4beb0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
  if(isDefined(self.owner)) {
    myteam = self.owner.team;
  }

  if(!isDefined(myteam)) {
    return 0;
  }

  if(isDefined(eattacker)) {
    otherteam = eattacker.team;
  }

  var_1133e6dc = util::function_fbce7263(myteam, otherteam);

  if(weapon_utils::ismeleemod(smeansofdeath) && isDefined(level.var_87226c31.bundle.var_7f93f9c) && isDefined(var_1133e6dc) && var_1133e6dc) {
    var_1c365dd = !(isDefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && eattacker status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;

    if(var_1c365dd) {
      damageamount = isDefined(level.var_87226c31.bundle.var_d5eccf80) ? level.var_87226c31.bundle.var_d5eccf80 : 0;
    } else {
      damageamount = isDefined(level.var_87226c31.bundle.var_7f93f9c) ? level.var_87226c31.bundle.var_7f93f9c : 0;
    }

    if(weapon == getweapon("sig_blade")) {
      damageamount = 0;
    }

    if(damageamount > 0) {
      eattacker dodamage(damageamount, self.origin, self.owner, self, undefined, "MOD_IMPACT", 0, level.var_87226c31.concertinawireweapon);
      self function_a9160578(damageamount, eattacker);
    }
  }

  if(weapon_utils::isexplosivedamage(smeansofdeath)) {
    idamage = int(idamage * (isDefined(level.var_87226c31.bundle.var_7a4fd57b) ? level.var_87226c31.bundle.var_7a4fd57b : 0));
  }

  shotstokill = killstreak_bundles::get_shots_to_kill(weapon, smeansofdeath, level.var_87226c31.bundle);

  if(shotstokill == 0) {} else if(shotstokill > 0) {
    idamage = self.startinghealth / shotstokill + 1;
  } else {
    idamage = 0;
  }

  return int(idamage);
}

function_639cb9da() {
  self endon(#"death");
  level waittill(#"game_ended");

  if(!isDefined(self)) {
    return;
  }

  self function_4ee7d46a(1);
}

function_34d706ae(watcher, var_db52b808, origin, angles, var_796be15d, width) {
  player = self;
  var_bf8e4260 = spawn("script_model", origin);
  var_bf8e4260.targetname = "concertina_wire";
  var_db52b808.concertinawire = var_bf8e4260;
  var_bf8e4260.grenade = var_db52b808;
  var_bf8e4260 setModel(level.var_87226c31.concertinawireweapon.var_22082a57);
  watcher.objectarray[watcher.objectarray.size] = var_bf8e4260;
  var_bf8e4260.var_2ee191cc = [];
  var_bf8e4260.var_2dd485d4 = [];
  rightangles = anglestoright(angles);
  var_8a455f75 = origin - width * 0.5 * rightangles;
  var_2d71f8ca = int(width / 32);

  for(index = 0; index < var_2d71f8ca; index++) {
    zoneid = deployable::function_d60e5a06(var_8a455f75, 32);
    array::add(var_bf8e4260.var_2ee191cc, zoneid);
    var_8a455f75 += rightangles * 64;
  }

  var_bf8e4260.var_86a21346 = &function_82c4beb0;
  var_bf8e4260.angles = angles;
  var_bf8e4260.owner = player;
  var_bf8e4260.takedamage = 1;
  var_bf8e4260.startinghealth = isDefined(level.var_87226c31.bundle.var_d9317c6b) ? level.var_87226c31.bundle.var_d9317c6b : 0;
  var_bf8e4260.health = var_bf8e4260.startinghealth;
  var_bf8e4260.var_3b0688ef = "concertina_wire_badplace" + var_bf8e4260 getentitynumber();
  badplace_box(var_bf8e4260.var_3b0688ef, 0, var_bf8e4260.origin, width / 2, "all");
  var_bf8e4260 setteam(player getteam());
  var_bf8e4260 setweapon(level.var_87226c31.concertinawireweapon);
  var_bf8e4260.weapon = level.var_87226c31.concertinawireweapon;
  array::add(player.concertinawire.var_a3aac76c, var_bf8e4260);

  if(isDefined(level.var_87226c31.var_546a220c)) {
    var_bf8e4260.objectiveid = gameobjects::get_next_obj_id();
    objective_add(var_bf8e4260.objectiveid, "active", var_bf8e4260, level.var_87226c31.var_546a220c);
    function_da7940a3(var_bf8e4260.objectiveid, 1);
    objective_setteam(var_bf8e4260.objectiveid, player.team);
  }

  var_35c2e583 = player gadgetgetslot(level.var_87226c31.concertinawireweapon);

  if(!sessionmodeiswarzonegame()) {
    self gadgetpowerset(var_35c2e583, 0);
  }

  var_bf8e4260 setteam(player.team);
  array::add(level.var_87226c31.var_925bbb2, var_bf8e4260);
  var_bf8e4260 clientfield::set("friendlyequip", 1);
  var_bf8e4260 clientfield::set("enemyequip", 1);
  var_bf8e4260 thread ondamage();
  var_bf8e4260 thread function_dd007be2();
  var_bf8e4260 thread function_639cb9da();
  var_bf8e4260.victimsoundmod = "vehicle";
  killcament = spawn("script_model", var_bf8e4260.origin + (isDefined(level.var_87226c31.bundle.var_eb9150a5) ? level.var_87226c31.bundle.var_eb9150a5 : 0, isDefined(level.var_87226c31.bundle.var_26a346c8) ? level.var_87226c31.bundle.var_26a346c8 : 0, isDefined(level.var_87226c31.bundle.var_d0fb9b7a) ? level.var_87226c31.bundle.var_d0fb9b7a : 0));
  killcament.targetname = "concertina_wire_killcament";
  var_bf8e4260.killcament = killcament;
  player deployable::function_6ec9ee30(var_bf8e4260, level.var_87226c31.concertinawireweapon);
  watcher.objectarray[watcher.objectarray.size] = killcament;
  return var_bf8e4260;
}

function_18dd6b22(concertinawire) {
  level endon(#"game_ended");
  concertinawire endon(#"death");

  while(true) {
    waitresult = concertinawire waittill(#"broken");

    if(waitresult.type == "base_piece_broken") {
      concertinawire function_4ee7d46a(0);
    }
  }
}

function_6541080b(origin, maxdistancesq) {
  foreach(concertinawire in level.var_87226c31.var_925bbb2) {
    if(!isDefined(concertinawire)) {
      continue;
    }

    if(distancesquared(concertinawire.origin, origin) < maxdistancesq) {
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
      if(isDefined(player.concertinawire)) {
        player.concertinawire.var_5af6633b = 1;
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
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6281e493de3ff80b.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_79cafc73107dd980;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a204c0f4;

function init() {
  namespace_250e9486::function_252dff4d("margwa", 8, &function_e9608fd3);
  spawner::add_archetype_spawn_function(#"margwa", &archetypemargwablackboardinit);
  clientfield::register("actor", "margwa_head_left", 1, 2, "int");
  clientfield::register("actor", "margwa_head_mid", 1, 2, "int");
  clientfield::register("actor", "margwa_head_right", 1, 2, "int");
  clientfield::register("actor", "margwa_fx_in", 1, 1, "counter");
  clientfield::register("actor", "margwa_fx_out", 1, 1, "counter");
  clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter");
  clientfield::register("actor", "margwa_smash", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter");
  clientfield::register("actor", "margwa_head_killed", 1, 2, "int");
  clientfield::register("actor", "margwa_jaw", 1, 6, "int");
  clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter");
  clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int");
  clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int");
  clientfield::register("actor", "supermargwa", 1, 1, "int");
  registerbehaviorscriptfunctions();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&margwatargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTargetService", &margwatargetservice);
  assert(isscriptfunctionptr(&margwashouldsmashattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSmashAttack", &margwashouldsmashattack);
  assert(isscriptfunctionptr(&margwashouldswipeattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSwipeAttack", &margwashouldswipeattack);
  assert(isscriptfunctionptr(&margwashouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldShowPain", &margwashouldshowpain);
  assert(isscriptfunctionptr(&margwashouldreactstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactStun", &margwashouldreactstun);
  assert(isscriptfunctionptr(&margwashouldspawn));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSpawn", &margwashouldspawn);
  assert(isscriptfunctionptr(&margwashouldreset));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReset", &margwashouldreset);
  assert(!isDefined(&margwareactstunaction) || isscriptfunctionptr(&margwareactstunaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction("margwaReactStunAction", &margwareactstunaction, undefined, undefined);
  assert(!isDefined(&margwaswipeattackaction) || isscriptfunctionptr(&margwaswipeattackaction));
  assert(!isDefined(&margwaswipeattackactionupdate) || isscriptfunctionptr(&margwaswipeattackactionupdate));
  assert(!isDefined(&function_9f21d288) || isscriptfunctionptr(&function_9f21d288));
  behaviortreenetworkutility::registerbehaviortreeaction("margwaSwipeAttackAction", &margwaswipeattackaction, &margwaswipeattackactionupdate, &function_9f21d288);
  assert(isscriptfunctionptr(&margwaidlestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaIdleStart", &margwaidlestart);
  assert(isscriptfunctionptr(&margwamovestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaMoveStart", &margwamovestart);
  assert(isscriptfunctionptr(&margwatraverseactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTraverseActionStart", &margwatraverseactionstart);
  assert(isscriptfunctionptr(&margwapainstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainStart", &margwapainstart);
  assert(isscriptfunctionptr(&margwapainterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainTerminate", &margwapainterminate);
  assert(isscriptfunctionptr(&margwareactstunstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunStart", &margwareactstunstart);
  assert(isscriptfunctionptr(&margwareactstunterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunTerminate", &margwareactstunterminate);
  assert(isscriptfunctionptr(&margwaspawnstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSpawnStart", &margwaspawnstart);
  assert(isscriptfunctionptr(&margwasmashattackstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackStart", &margwasmashattackstart);
  assert(isscriptfunctionptr(&margwasmashattackterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackTerminate", &margwasmashattackterminate);
  assert(isscriptfunctionptr(&margwaswipeattackstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackStart", &margwaswipeattackstart);
  assert(isscriptfunctionptr(&margwaswipeattackterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackTerminate", &margwaswipeattackterminate);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_smash_attack", &margwanotetracksmashattack);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_bodyfall large", &margwanotetrackbodyfall);
  animationstatenetwork::registernotetrackhandlerfunction("margwa_melee_fire", &margwanotetrackpainmelee);
}

function function_e9608fd3() {
  profilestart();
  self namespace_250e9486::function_25b2c8a9();
  self namespace_250e9486::function_db744d28();
  self.maxhealth = 3 * (70000 + int(50000 * namespace_ec06fe4a::function_ef369bae()) + level.doa.var_6c58d51 * 150000);
  self.health = self.maxhealth;
  self collidewithactors(1);
  self function_11578581(70);
  self setavoidancemask("avoid none");
  self disableaimassist();
  self.goalradius = 60;
  self.animrate = 1.2;
  self.meleedistsq = sqr(100);
  self.var_3adc3f4a = 0;
  self.disableammodrop = 1;
  self.no_gib = 1;
  self.zombie_move_speed = "walk";
  self.non_zombie = 1;
  self.overrideactordamage = &margwadamage;
  self.candamage = 1;
  self.headattached = 3;
  self.headopen = 0;

  if(randomint(100) > 50) {
    self margwainithead("c_zom_margwa_chunks_le", "j_chunk_head_bone_le");
    self margwainithead("c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri");
  } else {
    self margwainithead("c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri");
    self margwainithead("c_zom_margwa_chunks_le", "j_chunk_head_bone_le");
  }

  self margwainithead("c_zom_margwa_chunks_mid", "j_chunk_head_bone");
  self.headhealthmax = 600;
  self margwadisablestun();
  self thread margwadeath();
  self.updatesight = 0;
  self.var_cccb0ad2 = 1;
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_margwa_spawn");
  self thread doa_sound::function_ba33d23d(#"zmb_vocals_margwa_ambient", #"zmb_vocals_margwa_ambient", #"");
  profilestop();
}

function private archetypemargwablackboardinit() {
  blackboard::createblackboardforentity(self);
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
  self.___archetypeonanimscriptedcallback = &archetypemargwaonanimscriptedcallback;
}

function private archetypemargwaonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypemargwablackboardinit();
}

function private margwanotetracksmashattack(entity) {
  players = getPlayers();

  foreach(player in players) {
    smashpos = entity.origin + vectorscale(anglesToForward(self.angles), 60);
    distsq = distancesquared(smashpos, player.origin);

    if(distsq < 20736) {
      if(!isgodmode(player)) {
        if(is_true(player.hasriotshield)) {
          damageshield = 0;
          attackdir = player.origin - self.origin;

          if(is_true(player.hasriotshieldequipped)) {
            if(player shieldfacing(attackdir, 0.2)) {
              damageshield = 1;
            }
          } else if(player shieldfacing(attackdir, 0.2, 0)) {
            damageshield = 1;
          }

          if(damageshield) {
            self clientfield::increment("margwa_smash");
            shield_damage = level.weaponriotshield.weaponstarthitpoints;

            if(isDefined(player.weaponriotshield)) {
              shield_damage = player.weaponriotshield.weaponstarthitpoints;
            }

            player[[player.player_shield_apply_damage]](shield_damage, 0);
            continue;
          }
        }

        if(isDefined(level.margwa_smash_damage_callback) && isfunctionptr(level.margwa_smash_damage_callback)) {
          if(player[[level.margwa_smash_damage_callback]](self)) {
            continue;
          }
        }

        self clientfield::increment("margwa_smash");
        player dodamage(166, self.origin, self);
      }
    }
  }

  if(isDefined(self.smashattackcb)) {
    self[[self.smashattackcb]]();
  }
}

function private margwanotetrackbodyfall(entity) {
  if(self.archetype == #"margwa") {
    entity ghost();

    if(isDefined(self.bodyfallcb)) {
      self[[self.bodyfallcb]]();
    }
  }
}

function private margwanotetrackpainmelee(entity) {
  entity melee();
}

function margwashouldsmashattack(entity) {
  if(self.zombie_move_speed != "walk") {
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!isDefined(entity.var_bec33427)) {
    entity.var_bec33427 = 0;
  }

  return gettime() > entity.var_bec33427;
}

function margwashouldswipeattack(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_5065f112 = isDefined(entity.meleedistsq) ? entity.meleedistsq : 16384;

  if(distancesquared(entity.origin, entity.enemy.origin) > var_5065f112) {
    return false;
  }

  yaw = abs(namespace_ec06fe4a::getyawtoenemy());

  if(yaw > 45) {
    entity orientmode("face point", entity.enemy.origin);
    return false;
  }

  return true;
}

function private margwashouldshowpain(entity) {
  if(isDefined(entity.headdestroyed)) {
    headinfo = entity.head[entity.headdestroyed];

    switch (headinfo.cf) {
      case #"margwa_head_left":
        self setblackboardattribute("_margwa_head", "left");
        break;
      case #"margwa_head_mid":
        self setblackboardattribute("_margwa_head", "middle");
        break;
      case #"margwa_head_right":
        self setblackboardattribute("_margwa_head", "right");
        break;
    }

    return true;
  }

  return false;
}

function private margwashouldreactstun(entity) {
  if(is_true(entity.reactstun)) {
    return true;
  }

  return false;
}

function private margwashouldspawn(entity) {
  if(is_true(entity.needspawn)) {
    return true;
  }

  return false;
}

function private margwashouldreset(entity) {
  if(isDefined(entity.headdestroyed)) {
    return true;
  }

  if(is_true(entity.reactidgun)) {
    return true;
  }

  if(is_true(entity.reactstun)) {
    return true;
  }

  return false;
}

function private margwareactstunaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  stunactionast = entity astsearch(asmstatename);
  stunactionanimation = animationstatenetworkutility::searchanimationmap(entity, stunactionast[#"animation"]);
  closetime = int(getanimlength(stunactionanimation) * 1000);
  entity margwacloseallheads(closetime);
  margwareactstunstart(entity);
  return 5;
}

function private margwaswipeattackaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(!isDefined(entity.var_514cf595)) {
    swipeactionast = entity astsearch(asmstatename);
    swipeactionanimation = animationstatenetworkutility::searchanimationmap(entity, swipeactionast[#"animation"]);
    entity.var_514cf595 = int(getanimlength(swipeactionanimation) * 1000);
  }

  if(!isDefined(entity.swipe_end_time)) {
    entity.swipe_end_time = gettime() + entity.var_514cf595;
  }

  return 5;
}

function private margwaswipeattackactionupdate(entity, asmstatename) {
  if(isDefined(asmstatename.swipe_end_time) && gettime() > asmstatename.swipe_end_time) {
    return 4;
  }

  return 5;
}

function private function_9f21d288(entity, asmstatename) {
  asmstatename.swipe_end_time = undefined;
  return 4;
}

function private margwaidlestart(entity) {
  entity orientmode("face enemy");

  if(entity shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 1);
  }
}

function private margwamovestart(entity) {
  entity orientmode("face motion");

  if(entity shouldupdatejaw()) {
    if(entity.zombie_move_speed == "run") {
      entity clientfield::set("margwa_jaw", 13);
      return;
    }

    entity clientfield::set("margwa_jaw", 7);
  }
}

function private margwadeathaction(entity) {}

function private margwatraverseactionstart(entity) {
  entity setblackboardattribute("_traversal_type", entity.traversestartnode.animscript);

  if(isDefined(entity.traversestartnode.animscript)) {
    if(entity shouldupdatejaw()) {
      switch (entity.traversestartnode.animscript) {
        case #"jump_down_36":
          entity clientfield::set("margwa_jaw", 21);
          break;
        case #"jump_down_96":
          entity clientfield::set("margwa_jaw", 22);
          break;
        case #"jump_up_36":
          entity clientfield::set("margwa_jaw", 24);
          break;
        case #"jump_up_96":
          entity clientfield::set("margwa_jaw", 25);
          break;
      }
    }
  }
}

function private margwapainstart(entity) {
  entity notify(#"stop_head_update");

  if(entity shouldupdatejaw()) {
    head = self getblackboardattribute("_margwa_head");

    switch (head) {
      case #"left":
        entity clientfield::set("margwa_jaw", 3);
        break;
      case #"middle":
        entity clientfield::set("margwa_jaw", 4);
        break;
      case #"right":
        entity clientfield::set("margwa_jaw", 5);
        break;
    }
  }

  entity.headdestroyed = undefined;
  entity.canstun = 0;
  entity.candamage = 0;
}

function private margwapainterminate(entity) {
  entity.headdestroyed = undefined;
  entity.canstun = 1;
  entity.candamage = 1;
  entity margwacloseallheads(5000);
  entity clearpath();
}

function private margwareactstunstart(entity) {
  entity.reactstun = undefined;
  entity.canstun = 0;

  if(entity shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 6);
  }
}

function margwareactstunterminate(entity) {
  entity.canstun = 1;
}

function private margwaspawnstart(entity) {
  entity.needspawn = 0;
}

function function_729da05c() {
  self notify("11ab4b546d040b17");
  self endon("11ab4b546d040b17");
  self endon(#"death");
  self endon(#"hash_2b106aceb73a448d");
  self waittill(#"margwa_smash_attack");
  zombies = arraysortclosest(getaiteamarray("axis"), self.origin, undefined, 0, 150);
  var_31a419e0 = [];

  foreach(zombie in zombies) {
    if(is_true(zombie.basic)) {
      if(!isDefined(var_31a419e0)) {
        var_31a419e0 = [];
      } else if(!isarray(var_31a419e0)) {
        var_31a419e0 = array(var_31a419e0);
      }

      var_31a419e0[var_31a419e0.size] = zombie;
    }
  }

  foreach(zombie in var_31a419e0) {
    zombie namespace_250e9486::setup_zombie_knockdown(self);
  }

  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  spot = self.origin + forward * 100;
  groundpos = namespace_ec06fe4a::function_65ee50ba(spot);
  self radiusdamage(groundpos, 55, 2000, 500, self, "MOD_MELEE");
  trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", groundpos, 2 | 1 | 512, 72, 60);

  if(isDefined(trigger)) {
    trigger thread namespace_ec06fe4a::function_52afe5df(10);
    trigger thread namespace_f6712ec9::function_86555fba();
  }

  obj = namespace_ec06fe4a::spawnmodel(groundpos);

  if(isDefined(obj)) {
    obj thread namespace_ec06fe4a::function_52afe5df(10);
    obj doa_fx::function_3ecfde67("nova_crawler_burst");
    util::wait_network_frame();
    obj thread function_66a5466d(spot, 72);
  }
}

function function_66a5466d(origin, radius) {
  self endon(#"death");

  while(true) {
    currentangle = randomint(360);
    var_5ccd914d = rotatepointaroundaxis((randomintrange(12, radius), 0, 0), (0, 0, 1), currentangle);
    self.origin = origin + var_5ccd914d;
    self doa_fx::function_3ecfde67("nova_crawler_burst");
    wait 0.5;
  }
}

function private margwasmashattackstart(entity) {
  entity.var_bec33427 = gettime() + randomintrange(3000, 10000);
  entity margwaheadsmash();
  entity thread function_729da05c();

  if(entity shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 14);
  }
}

function margwasmashattackterminate(entity) {
  entity notify(#"hash_2b106aceb73a448d");
  entity margwacloseallheads();
}

function margwaswipeattackstart(entity) {
  if(entity shouldupdatejaw()) {
    entity clientfield::set("margwa_jaw", 16);
  }
}

function private margwaswipeattackterminate(entity) {
  entity margwacloseallheads();
}

function private margwadeath() {
  self waittill(#"death");

  if(isDefined(self.e_head_attacker)) {
    self.e_head_attacker notify(#"margwa_kill");
  }
}

function margwaenablestun() {
  self.canstun = 1;
}

function private margwadisablestun() {
  self.canstun = 0;
}

function private margwainithead(headmodel, headtag) {
  model = headmodel;
  model_gore = undefined;
  self attach(model);

  if(!isDefined(self.head)) {
    self.head = [];
  }

  self.head[model] = spawnStruct();
  self.head[model].model = model;
  self.head[model].tag = headtag;
  self.head[model].health = 70000 + int(50000 * namespace_ec06fe4a::function_ef369bae()) + level.doa.var_6c58d51 * 150000;
  self.head[model].candamage = 0;
  self.head[model].open = 1;
  self.head[model].closed = 2;
  self.head[model].smash = 3;

  switch (headmodel) {
    case #"c_zom_margwa_chunks_le":
      self.head[model].cf = "margwa_head_left";
      self.head[model].impactcf = "margwa_head_left_hit";
      self.head[model].gore = "c_zom_margwa_gore_le";

      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }

      self.head[model].killindex = 1;
      self.head_left_model = model;
      break;
    case #"c_zom_margwa_chunks_mid":
      self.head[model].cf = "margwa_head_mid";
      self.head[model].impactcf = "margwa_head_mid_hit";
      self.head[model].gore = "c_zom_margwa_gore_mid";

      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }

      self.head[model].killindex = 2;
      self.head_mid_model = model;
      break;
    case #"c_zom_margwa_chunks_ri":
      self.head[model].cf = "margwa_head_right";
      self.head[model].impactcf = "margwa_head_right_hit";
      self.head[model].gore = "c_zom_margwa_gore_ri";

      if(isDefined(model_gore)) {
        self.head[model].gore = model_gore;
      }

      self.head[model].killindex = 3;
      self.head_right_model = model;
      break;
  }

  self thread margwaheadupdate(self.head[model]);
}

function margwasetheadhealth(health) {
  self.headhealthmax = health;

  foreach(head in self.head) {
    head.health = health;
  }
}

function private margwaresetheadtime(min, max) {
  time = gettime() + randomintrange(min, max);
  return time;
}

function private margwaheadcanopen() {
  if(self.headattached > 1) {
    if(self.headopen < self.headattached - 1) {
      return true;
    }
  } else {
    return true;
  }

  return false;
}

function private margwaheadupdate(headinfo) {
  self endon(#"death", #"stop_head_update");
  headinfo notify(#"stop_head_update");
  headinfo endon(#"stop_head_update");

  while(true) {
    if(self ispaused()) {
      util::wait_network_frame();
      continue;
    }

    if(!isDefined(headinfo.closetime)) {
      if(self.headattached == 1) {
        headinfo.closetime = margwaresetheadtime(500, 1000);
      } else {
        headinfo.closetime = margwaresetheadtime(1500, 3500);
      }
    }

    if(gettime() > headinfo.closetime && self margwaheadcanopen()) {
      self.headopen++;
      headinfo.closetime = undefined;
    } else {
      util::wait_network_frame();
      continue;
    }

    self margwaheaddamagedelay(headinfo, 1);
    self clientfield::set(headinfo.cf, headinfo.open);

    if(namespace_ec06fe4a::function_a8975c67()) {
      self playsoundontag("zmb_vocals_margwa_ambient", headinfo.tag);
    }

    while(true) {
      if(!isDefined(headinfo.opentime)) {
        headinfo.opentime = margwaresetheadtime(3000, 5000);
      }

      if(gettime() > headinfo.opentime) {
        self.headopen--;
        headinfo.opentime = undefined;
        break;
      }

      util::wait_network_frame();
      continue;
    }

    self margwaheaddamagedelay(headinfo, 0);
    self clientfield::set(headinfo.cf, headinfo.closed);
  }
}

function private margwaheaddamagedelay(headinfo, candamage) {
  self endon(#"death");
  wait 0.1;
  headinfo.candamage = candamage;
}

function private margwaheadsmash() {
  self notify(#"stop_head_update");
  headalive = [];

  foreach(head in self.head) {
    if(head.health > 0) {
      headalive[headalive.size] = head;
    }
  }

  headalive = array::randomize(headalive);
  open = 0;

  foreach(head in headalive) {
    if(!open) {
      head.candamage = 1;
      self clientfield::set(head.cf, head.smash);
      open = 1;
      continue;
    }

    self margwaclosehead(head);
  }
}

function private margwaclosehead(headinfo) {
  headinfo.candamage = 0;
  self clientfield::set(headinfo.cf, headinfo.closed);
}

function private margwacloseallheads(closetime) {
  if(self ispaused()) {
    return;
  }

  foreach(head in self.head) {
    if(head.health > 0) {
      head.closetime = undefined;
      head.opentime = undefined;

      if(isDefined(closetime)) {
        head.closetime = gettime() + closetime;
      }

      self.headopen = 0;
      self margwaclosehead(head);
      self thread margwaheadupdate(head);
    }
  }
}

function margwakillhead(modelhit, attacker) {
  headinfo = self.head[modelhit];

  if(is_true(headinfo.killed)) {
    return;
  }

  headinfo.health = 0;
  headinfo.killed = 1;
  headinfo notify(#"stop_head_update");

  if(is_true(headinfo.candamage)) {
    self margwaclosehead(headinfo);
    self.headopen--;
  }

  self margwaupdatemovespeed();
  self clientfield::set("margwa_head_killed", headinfo.killindex);
  self detach(headinfo.model);
  self attach(headinfo.gore);
  self.headattached--;

  if(self.headattached <= 0) {
    self.e_head_attacker = attacker;
    return 1;
  } else {
    self.headdestroyed = modelhit;
  }

  return 0;
}

function margwacandamageanyhead() {
  foreach(head in self.head) {
    if(isDefined(head) && head.health > 0 && is_true(head.candamage)) {
      return true;
    }
  }

  return false;
}

function margwacandamagehead() {
  if(isDefined(self) && self.health > 0 && is_true(self.candamage)) {
    return true;
  }

  return false;
}

function margwadamage(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(is_true(self.marked_for_death)) {
    self namespace_ec06fe4a::function_2f4b0f9(self.health - boneindex);
    return boneindex;
  }

  headalive = [];

  foreach(head in self.head) {
    if(head.health > 0) {
      headalive[headalive.size] = head;
    }
  }

  if(headalive.size) {
    headclosest = headalive[0];
    headclosest.health -= boneindex;
    self clientfield::increment(headclosest.impactcf);

    if(headclosest.health <= 0) {
      if(self margwakillhead(headclosest.model, offsettime)) {
        return self.health;
      }
    }
  }

  if(boneindex > self.health) {
    foreach(head in self.head) {
      self margwakillhead(head.model, offsettime);
    }
  }

  var_799e18e5 = modelindex;
  var_5f32808d = 1;

  if(boneindex >= 1000) {
    var_5f32808d = 2;
  }

  self namespace_ec06fe4a::function_2f4b0f9(self.health - boneindex, offsettime, var_799e18e5, boneindex, var_5f32808d);
  return boneindex;
}

function private margwaheadhit(entity, partname) {
  switch (partname) {
    case #"j_chunk_head_bone_le":
    case #"j_jaw_lower_1_le":
      return self.head_left_model;
    case #"j_jaw_lower_1":
    case #"j_chunk_head_bone":
      return self.head_mid_model;
    case #"j_chunk_head_bone_ri":
    case #"j_jaw_lower_1_ri":
      return self.head_right_model;
  }

  return undefined;
}

function private margwaupdatemovespeed() {
  if(self.zombie_move_speed == "walk") {
    self.zombie_move_speed = "run";
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    return;
  }

  if(self.zombie_move_speed == "run") {
    self.zombie_move_speed = "sprint";
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  }
}

function margwaforcesprint() {
  self.zombie_move_speed = "sprint";
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
}

function private margwadestroyhead(modelhit) {}

function shouldupdatejaw() {
  if(!is_true(self.jawanimenabled)) {
    return false;
  }

  if(self.headattached < 3) {
    return true;
  }

  return false;
}

function shieldfacing(vdir, limit, front = 1) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);

  if(!front) {
    forwardvec *= -1;
  }

  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectorNormalize(forwardvec2d);
  tofaceevec = vdir * -1;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectorNormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > limit;
}

function private insmashattackrange(enemy) {
  smashpos = self.origin;
  heightoffset = abs(self.origin[2] - enemy.origin[2]);

  if(heightoffset > 48) {
    return false;
  }

  distsq = distancesquared(smashpos, enemy.origin);

  if(distsq > 2500 && distsq < 10000) {
    return true;
  }

  return false;
}

function private margwatargetservice(entity) {}
/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_avogadro.gsc
*************************************************/

#using script_2c5daa95f8fec03c;
#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace archetype_avogadro;

function private autoexec __init__system__() {
  system::register(#"archetype_avogadro", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  registerbehaviorscriptfunctions();
  clientfield::register("missile", "" + # "avogadro_bolt_fx", 1, 2, "int");
  clientfield::register("actor", "" + # "avogadro_phase_fx", 1, 1, "int");
  clientfield::register("actor", "" + # "avogadro_health_fx", 1, 2, "int");
  clientfield::register("scriptmover", "" + # "hash_183ef3538fd62563", 1, 1, "int");
  clientfield::register("scriptmover", "avogadro_phase_beam", 1, getminbitcountfornum(3), "int");
  spawner::add_archetype_spawn_function(#"avogadro", &function_ee579eb5);
  spawner::function_89a2cd87(#"avogadro", &function_d1359818);
  zm_weapons::function_76403f51(getweapon(#"avogadro_bolt"));
  callback::on_player_damage(&function_99ce086a);
  function_5ca95b95();
}

function private postinit() {
  level.var_2ea60515 = getstatuseffect(#"avogadro_shock_slowed");
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_f8e8c129));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_520d52c557d9427", &function_f8e8c129);
  assert(isscriptfunctionptr(&function_7e5905cd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a8b7da6a91d85f3", &function_7e5905cd);
  assert(isscriptfunctionptr(&function_1169b184));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e8335833e76fa0e", &function_1169b184);
  assert(isscriptfunctionptr(&function_afa4bed6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34a6a91002379d9e", &function_afa4bed6);
  assert(isscriptfunctionptr(&function_e7e003b0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_351e1f4e4e8beb5", &function_e7e003b0);
  assert(isscriptfunctionptr(&function_14e1e2c8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e90b07558cc9b1b", &function_14e1e2c8);
  assert(isscriptfunctionptr(&function_9ab1c000));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d3ff4cb570ac40", &function_9ab1c000);
  assert(isscriptfunctionptr(&function_3b8d314c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_75ba4163e4512e01", &function_3b8d314c);
  assert(isscriptfunctionptr(&function_ceeb405));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2cca123cff468ca8", &function_ceeb405);
  assert(isscriptfunctionptr(&function_b57de57a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2992bf38eb0ecb9c", &function_b57de57a);
  assert(isscriptfunctionptr(&function_36f6a838));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14db413a212246df", &function_36f6a838);
  assert(isscriptfunctionptr(&function_d58f8483));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42901d14fb88f316", &function_d58f8483);
  assert(isscriptfunctionptr(&function_5ce54900));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_177974191a99d4ac", &function_5ce54900);
  assert(isscriptfunctionptr(&function_1ad43460));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1b632346ef84251c", &function_1ad43460);
  assert(isscriptfunctionptr(&function_77788917));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6220b20470033c72", &function_77788917);
  assert(isscriptfunctionptr(&function_c83209ee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ebc4b27b9d85561", &function_c83209ee);
  assert(isscriptfunctionptr(&function_f14292cf));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6955957f9e1d47a3", &function_f14292cf);
  assert(isscriptfunctionptr(&function_b411d93));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4bb168e1b80acaed", &function_b411d93);
  assert(isscriptfunctionptr(&function_a495d71f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_49880776aa68a310", &function_a495d71f, 1);
  assert(isscriptfunctionptr(&function_a495d71f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b76cd8d945e7de7", &function_a495d71f, 1);
  animationstatenetwork::registernotetrackhandlerfunction("avogadro_shoot_bolt", &shoot_bolt_wait);
  animationstatenetwork::registeranimationmocomp("avogadro_tactical_walk@avogadro", &function_bc2f2686, &function_bc2f2686, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_traversal_teleport@avogadro", &function_9f3a10a4, &function_4cf6a31d, &function_7b70bdbe);
}

function function_ee579eb5() {
  self callback::function_d8abfc3d(#"on_actor_damage", &function_50a86206);
  self.shield = 1;
  self.hit_by_melee = 0;
  self.phase_time = 0;
  self.var_1ce249af = 0;

  if(!isDefined(self.var_15aa1ae0)) {
    self.var_15aa1ae0 = 0;
  }

  self.var_f3bbe853 = 1;
  self.var_fc782c29 = 0;
  self.var_b4ca9f11 = gettime();
  self.var_7fde19e8 = 0;
  self.var_9bff71aa = 0;
  self.var_696e2d53 = 0;
  self.var_e3b6f14a = 1;
  self.var_58c4c69b = 1;
  self.var_28621cf4 = "j_head";
  self.var_e5365d8a = (0, 0, 0);
  self thread function_f6aed42d();
  self function_8a404313();
  self ghost();
}

function private function_8a404313() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_c7791d22;
}

function private function_c7791d22(entity) {
  entity.__blackboard = undefined;
  entity function_8a404313();
}

function function_d1359818() {
  function_dbc638a8(self);
  namespace_81245006::initweakpoints(self);
  self attach("c_t9_zmb_avogadro_ribcage");
  self destructserverutils::togglespawngibs(self, 1);
  self.var_318a0ac8 = &function_29c1ba76;
  self show();
  function_905d3c1a(self);
}

function function_905d3c1a(entity) {
  entity endon(#"death");

  if(is_true(entity.var_83fa6083) || entity isragdoll()) {
    return;
  }

  delta = getmovedelta("ai_t9_zm_avogadro_arrival", 0, 1);
  new_origin = (entity.origin[0], entity.origin[1], entity.origin[2] - delta[2]);
  entity animscripted("avogadro_arrival_finished", new_origin, (0, entity.angles[1], 0), "ai_t9_zm_avogadro_arrival", "normal", "root", 1, 0);
}

function function_99ce086a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {}

function function_dbc638a8(entity) {
  health_ratio = entity.health / entity.maxhealth;
  health_ratio = int(health_ratio * 100);
  var_f8c4006a = 3;

  if(health_ratio <= 33) {
    var_f8c4006a = 1;
  } else if(health_ratio <= 67 && health_ratio > 33) {
    var_f8c4006a = 2;
  }

  entity clientfield::set("" + # "avogadro_health_fx", var_f8c4006a);
}

function function_50a86206(params) {
  if(!isDefined(self.var_fc782c29) || !isDefined(self.var_b4ca9f11) || self.var_b4ca9f11 < gettime()) {
    self.var_fc782c29 = 0;
    self.var_b4ca9f11 = gettime() + 2000;
  }

  self.var_fc782c29 += params.idamage;
  function_dbc638a8(self);

  if(params.smeansofdeath === "MOD_BURNED") {
    self.var_d444767 = gettime();
  }

  if(!isDefined(params.smeansofdeath) || params.smeansofdeath !== "MOD_BURNED") {
    self notify(#"hash_114f53e963b59106");
  }
}

function function_ec39f01c(amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon, var_fd90b0bb) {
  if(!isDefined(self)) {
    return;
  }

  if(!self zombie_utility::zombie_should_gib(type, tagname, partname, weapon)) {
    return;
  }

  if(self zombie_utility::head_should_gib(tagname, partname, modelname, weapon) && partname != "MOD_BURNED") {
    self zombie_utility::zombie_head_gib(weapon, var_fd90b0bb, tagname, partname);
    return;
  }

  if(!is_true(self.gibbed) && !isDefined(self.damagelocation)) {
    if(type >= self.maxhealth * 0.5 && (partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH")) {
      self function_fe84424f(weapon, var_fd90b0bb, modelname, 0);
    }
  }

  if(!is_true(self.gibbed) && isDefined(self.damagelocation)) {
    if(self zombie_utility::damagelocationisany("head", "helmet", "neck")) {
      return;
    }

    if(self zombie_utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot", "left_leg_upper", "left_leg_lower", "left_foot") && type < self.maxhealth * 0.5 && (partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH")) {
      return;
    }

    self.stumble = undefined;
    b_gibbed = 1;
    var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

    switch (self.damagelocation) {
      case # "right_leg_upper":
      case # "right_leg_lower":
      case # "right_foot":
        if(gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
          break;
        }

        gibserverutils::gibrightleg(self, var_c3317960);

        if(randomint(100) > 75) {
          gibserverutils::gibleftleg(self, var_c3317960);
        }

        break;
      case # "left_leg_lower":
      case # "left_foot":
      case # "left_leg_upper":
        if(gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
          break;
        }

        gibserverutils::gibleftleg(self, var_c3317960);

        if(randomint(100) > 75) {
          gibserverutils::gibrightleg(self, var_c3317960);
        }

        break;
      default:
        if(self.damagelocation == "none") {
          if(partname == "MOD_GRENADE" || partname == "MOD_GRENADE_SPLASH" || partname == "MOD_PROJECTILE" || partname == "MOD_PROJECTILE_SPLASH") {
            self function_fe84424f(weapon, var_fd90b0bb, modelname);
            break;
          }
        }

        break;
    }
  }
}

function function_fe84424f(weapon, var_fd90b0bb, point, var_87a07ff5 = 1) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(point)) {
    return;
  }

  if(!isDefined(level.gib_tags)) {
    zombie_utility::init_gib_tags();
  }

  closesttag = "tag_origin";
  var_19874b3 = [];

  for(i = 0; i < level.gib_tags.size; i++) {
    if(self haspart(level.gib_tags[i])) {
      var_19874b3[var_19874b3.size] = {
        #tag: level.gib_tags[i], #origin: self gettagorigin(level.gib_tags[i])
      };
    }
  }

  var_6844367f = arraygetclosest(point, var_19874b3);

  if(isDefined(var_6844367f)) {
    closesttag = var_6844367f.tag;
  }

  var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

  if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
    if(gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
      return;
    }

    gibserverutils::gibleftleg(self, var_c3317960);

    if(var_87a07ff5) {
      if(randomint(100) > 75) {
        gibserverutils::gibrightleg(self, var_c3317960);
      }
    }

    return;
  }

  if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
    if(gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
      return;
    }

    gibserverutils::gibrightleg(self, var_c3317960);

    if(var_87a07ff5) {
      if(randomint(100) > 75) {
        gibserverutils::gibleftleg(self, var_c3317960);
      }
    }
  }
}

function function_29c1ba76(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self.var_426947c4 = undefined;
  var_ebcff177 = 1;

  if(namespace_81245006::hasarmor(self) && (shitloc === "MOD_PROJECTILE_SPLASH" || shitloc === "MOD_GRENADE_SPLASH" || shitloc == "MOD_EXPLOSIVE")) {
    var_3cddb028 = 0.5 * vdir;

    if(isDefined(level.var_56f626bc)) {
      var_3cddb028 *= [[level.var_56f626bc]](self, psoffsettime, vpoint);
    }

    var_31e96b81 = int(var_3cddb028);

    foreach(weakpoint in self.var_5ace757d) {
      if(weakpoint.type === # "armor" && weakpoint.currstate === 1) {
        namespace_81245006::damageweakpoint(weakpoint, var_31e96b81);

        if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
          destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
          self.var_426947c4 = 1;
        }
      }
    }
  }

  weakpoint = namespace_81245006::function_3131f5dd(self, surfacetype, 1);

  if(!isDefined(weakpoint)) {
    weakpoint = namespace_81245006::function_73ab4754(self, boneindex, 1);
  }

  if(isDefined(weakpoint) && weakpoint.type === # "armor" && namespace_81245006::function_f29756fe(weakpoint) !== 3) {
    var_ebcff177 = 3;
    vdir = 0.5 * vdir;

    if(isDefined(level.var_56f626bc)) {
      vdir *= [[level.var_56f626bc]](self, psoffsettime, vpoint);
    }

    namespace_81245006::damageweakpoint(weakpoint, vdir);

    if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
      self.var_426947c4 = 1;
    }
  }

  if(isDefined(weakpoint) && weakpoint.var_3765e777 === 1 && aiutility::function_e2278a4b(psoffsettime, shitloc)) {
    var_ebcff177 = 2;
  }

  if(isDefined(level.var_1b01acb4)) {
    vdir *= [[level.var_1b01acb4]](self, psoffsettime, vpoint);
  }

  return {
    #damage: vdir, #weakpoint: weakpoint, #var_ebcff177: var_ebcff177
  };
}

function get_target_ent(entity) {
  if(isDefined(entity.attackable)) {
    return entity.attackable;
  }

  return zm_ai_utility::function_825317c(entity);
}

function function_80fc1a78(time) {
  self notify("1a2a01405b0af7f6");
  self endon("1a2a01405b0af7f6");
  self endon(#"death", #"hash_7d29584dcbbe7d67");
  self show();
  wait time;
}

function private function_f8e8c129(entity) {
  if(is_false(entity.can_shoot)) {
    return false;
  }

  enemy = get_target_ent(entity);

  if(!isDefined(enemy)) {
    return false;
  }

  if(isPlayer(enemy) && !zm_utility::is_player_valid(enemy, 1)) {
    return false;
  }

  if(!function_aa6fbf56(entity)) {
    return false;
  }

  if(isDefined(level.var_a35afcb2) && ![[level.var_a35afcb2]](entity)) {
    return false;
  }

  if(isDefined(enemy)) {
    vec_enemy = enemy.origin - self.origin;
    dist_sq = lengthsquared(vec_enemy);

    if((dist_sq > 14400 || is_false(entity.can_phase)) && dist_sq < 2250000) {
      vec_facing = anglesToForward(self.angles);
      var_482d3bba = (vec_facing[0], vec_facing[1], 0);
      var_45ed4f50 = vectornormalize((vec_facing[0], vec_facing[1], 0));
      var_9743030a = vectornormalize((vec_enemy[0], vec_enemy[1], 0));
      var_5e958f82 = vectordot(var_45ed4f50, var_9743030a);

      if(var_5e958f82 > 0.99) {
        var_f6a4b2f3 = enemy getcentroid();
        eye_pos = self getEye();
        traceresult = bulletTrace(eye_pos, var_f6a4b2f3, 0, isentity(enemy) ? enemy : undefined);

        if(traceresult[#"fraction"] == 1) {
          return true;
        }
      }
    }
  }

  return false;
}

function private function_aa6fbf56(entity) {
  var_99387d40 = blackboard::getblackboardevents(#"hash_27bee30b37f7debe");

  if(isDefined(var_99387d40) && var_99387d40.size) {
    foreach(var_9fb4c4cc in var_99387d40) {
      if(var_9fb4c4cc.data.entity === entity) {
        return false;
      }
    }
  }

  return true;
}

function private function_afa4bed6(entity) {
  decision = randomint(2);
  entity setblackboardattribute("_ranged_attack_variant", decision);
}

function private function_7e5905cd(entity) {
  enemy = self.favoriteenemy;

  if(isDefined(enemy)) {
    self.shield = 1;
    self notify(#"hash_7d29584dcbbe7d67");
    self show();
  }

  var_8706203c = randomintrange(2000, 3000);

  if(isDefined(entity.var_64099fad) && isDefined(enemy) && distancesquared(entity.origin, enemy.origin) < sqr(entity.var_64099fad)) {
    var_8706203c = 100;
  }

  blackboard::addblackboardevent(#"hash_27bee30b37f7debe", {
    #entity: self
  }, var_8706203c);
}

function private function_e7e003b0(entity) {
  if(!isDefined(self.var_8f78592b)) {
    return false;
  }

  var_aa313325 = entity[[entity.var_8f78592b]](entity);

  if(!var_aa313325) {
    return false;
  }

  var_a430e28e = blackboard::getblackboardevents(#"hash_71e87bb4fbe53c16");

  if(isDefined(var_a430e28e) && var_a430e28e.size) {
    foreach(var_73fafdf0 in var_a430e28e) {
      if(var_73fafdf0.data.entity === entity) {
        return false;
      }
    }
  }

  return true;
}

function private function_14e1e2c8(entity) {
  blackboard::addblackboardevent(#"hash_71e87bb4fbe53c16", {
    #entity: self
  }, randomintrange(2000, 3000));
}

function private shoot_bolt_wait(entity) {
  if(!isDefined(get_target_ent(entity))) {
    return;
  }

  enemy = get_target_ent(entity);
  target_pos = enemy getcentroid();

  if(issentient(enemy)) {
    target_pos = enemy getEye();
  }

  target_velocity = (0, 0, 0);

  if(!enemy scene::function_c935c42()) {
    target_velocity = enemy getvelocity();

    if(isPlayer(enemy)) {
      target_pos += (0, 0, -12);

      if(enemy isinvehicle()) {
        target_velocity = enemy getvehicleoccupied() getvelocity();
      }
    }
  }

  source_pos = self gettagorigin("tag_weapon_right");

  if(!isDefined(source_pos)) {
    source_pos = self gettagorigin("tag_weapon_left");
  }

  velocity = target_pos - source_pos;
  var_cfca9f29 = length(velocity) / 800;
  target_pos += target_velocity * var_cfca9f29 * randomfloatrange(0, 1);

  recordsphere(target_pos, 10, (0, 1, 0), "<dev string:x38>");

  velocity = target_pos - source_pos;
  velocity = vectornormalize(velocity);
  velocity *= 800;
  bolt = entity magicmissile(getweapon(#"avogadro_bolt"), source_pos, velocity);

  if(!isDefined(bolt)) {
    return;
  }

  bolt function_b1b41f33(entity);
}

function function_b1b41f33(owner) {
  self endon(#"death");
  self.owner = owner;
  self clientfield::set("" + # "avogadro_bolt_fx", 1);
  self thread function_dec8144d();
  waitresult = self function_5f86757d();

  if(!isDefined(owner) || !isDefined(waitresult)) {
    return;
  }

  if((waitresult._notify == # "explode" || waitresult._notify == # "projectile_impact_explode") && isDefined(waitresult.position)) {
    owner callback::callback(#"hash_c1d64b00f1dc607", {
      #origin: waitresult.position, #radius: self.weapon.explosionradius, #jammer: self
    });
  }
}

function function_dec8144d() {
  self endon(#"death", #"explode");
  self.takedamage = 1;
  self.maxhealth = 50;
  self.health = 50;

  if(isDefined(self.owner) && isDefined(self.owner.maxhealth)) {
    self.maxhealth = int(0.05 * self.owner.maxhealth);
    self.health = self.maxhealth;
  }

  while(isDefined(self)) {
    waitresult = self waittill(#"damage");

    if(waitresult.mod === "MOD_PISTOL_BULLET" || waitresult.mod === "MOD_RIFLE_BULLET" || waitresult.mod === "MOD_PROJECTILE") {
      if(self.health <= 0) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: waitresult.attacker, #scoreevent: "avogadro_projectile_destroyed_zm"});
        var_5fae82a9 = spawn("script_model", self.origin);
        var_5fae82a9 setModel("tag_origin");
        var_5fae82a9 thread function_5f54a393();
        self deletedelay();
      }
    }
  }
}

function function_5f54a393() {
  self clientfield::set("" + # "hash_183ef3538fd62563", 1);
  wait 5;
  self deletedelay();
}

function function_5f86757d() {
  level endon(#"game_ended");
  waitresult = self waittill(#"explode", #"death", #"projectile_impact_explode");

  if(!isDefined(self)) {
    return waitresult;
  }

  playsoundatposition(#"hash_525786cd7853a7a0", self.origin);
  self clientfield::set("" + # "avogadro_bolt_fx", 0);
  return waitresult;
}

function function_5ce54900(entity) {
  function_dbc638a8(entity);
  self.phase_time = gettime() - 1;
}

function function_b7ba7211(timeout) {
  self notify("56572da130b2805e");
  self endon("56572da130b2805e");
  self endon(#"death");
  self endoncallback(&function_e4fda91d, #"hash_114f53e963b59106");
  self.blockingpain = 1;
  wait timeout;
  self.blockingpain = 0;
}

function function_e4fda91d(notifyhash) {
  if(isDefined(self)) {
    self.blockingpain = 0;
  }
}

function function_5ca95b95() {
  level.var_be622b90 = [];

  for(i = 0; i < 2; i++) {
    level.var_be622b90[i] = array(util::spawn_model(#"tag_origin"), util::spawn_model(#"tag_origin"));
  }
}

function function_205c9932(entity) {
  foreach(index, array in level.var_be622b90) {
    if(isDefined(array[0].owner) || isDefined(array[1].owner)) {
      continue;
    }

    foreach(ent in array) {
      ent.owner = entity;
    }

    return {
      #id: index + 1, #array: array
    };
  }
}

function function_c6e09354(var_78dd7804) {
  foreach(ent in var_78dd7804.array) {
    ent clientfield::set("avogadro_phase_beam", 0);
    ent.owner = undefined;
  }
}

function function_2e3c588(notifyhash) {
  if(isDefined(self) && isDefined(self.var_78dd7804)) {
    function_c6e09354(self.var_78dd7804);
  }
}

function function_d979c854(entity) {
  entity endoncallback(&function_2e3c588, #"death");
  var_78dd7804 = entity.var_78dd7804;

  foreach(ent in var_78dd7804.array) {
    ent clientfield::set("avogadro_phase_beam", var_78dd7804.id);
  }

  util::wait_network_frame();
  function_c6e09354(var_78dd7804);

  if(isDefined(entity)) {
    entity.var_78dd7804 = undefined;
  }
}

function function_a495d71f(entity) {
  if(!function_2eb165a4(entity)) {
    return 0;
  }

  entity.var_78dd7804 = function_205c9932(entity);

  if(!isDefined(entity.var_78dd7804)) {
    return 0;
  }

  endpoint = function_c3ceb539(entity);

  if(!isDefined(endpoint)) {
    function_c6e09354(entity.var_78dd7804);
    entity.var_78dd7804 = undefined;
    return 0;
  }

  if(!isDefined(entity.var_8d847303)) {
    entity.var_8d847303 = 0;
  }

  if(isDefined(entity.var_54fc34a3) && entity.var_54fc34a3 + 6000 < gettime()) {
    entity.var_8d847303 = 0;
  }

  entity.var_8d847303++;
  entity.var_54fc34a3 = gettime();
  entity.endpoint = endpoint;
  tag_offset = entity gettagorigin("j_spine4") - entity.origin;
  entity.var_1d95f284 = gettime();
  entity.var_78dd7804.array[0].origin = entity.origin + tag_offset;
  entity.var_78dd7804.array[1].origin = entity.endpoint + tag_offset;
}

function function_2eb165a4(entity) {
  if(is_true(entity.var_10552fac)) {
    return true;
  }

  if(isDefined(level.var_8791f7c5) && ![[level.var_8791f7c5]](entity)) {
    return false;
  }

  if(is_true(self.var_958cf9c5)) {
    return false;
  }

  if(entity.phase_time > gettime()) {
    return false;
  }

  if(isDefined(entity.var_78dd7804)) {
    return false;
  }

  if(isDefined(entity.var_8d847303) && isDefined(entity.var_54fc34a3) && entity.var_8d847303 >= 3 && gettime() < entity.var_54fc34a3 + 18000) {
    return false;
  }

  target = get_target_ent(entity);
  var_c5504ae5 = 1 / 4;
  health_ratio = entity.health / entity.maxhealth;

  if(!isDefined(entity.var_f89ee7ac)) {
    entity.var_f89ee7ac = 1 - var_c5504ae5;
  }

  if(health_ratio <= entity.var_f89ee7ac) {
    entity.var_f89ee7ac = health_ratio - var_c5504ae5;
    return true;
  }

  if(isDefined(entity.favoriteenemy)) {
    if(isPlayer(entity.favoriteenemy) && !zombie_utility::is_player_valid(entity.favoriteenemy, 1, 0)) {
      return false;
    }

    if(isPlayer(entity.favoriteenemy) && entity.favoriteenemy isinvehicle()) {
      return false;
    }

    var_bec89360 = distancesquared(entity.favoriteenemy.origin, entity.origin);

    if(var_bec89360 <= sqr(200)) {
      return true;
    }

    if(var_bec89360 >= sqr(entity.var_724ec089)) {
      return true;
    }

    if(target === entity.favoriteenemy && !entity seerecently(entity.favoriteenemy, 1)) {
      return true;
    }

    if(is_true(entity.var_5f134efa) && isPlayer(entity.favoriteenemy)) {
      player_forward = anglesToForward(entity.favoriteenemy getplayerangles());
      to_self = entity.origin - entity.favoriteenemy.origin;

      if(vectordot(player_forward, to_self) < 0) {
        return true;
      }
    }
  }

  if(isDefined(entity.attackable)) {
    var_bec89360 = distancesquared(entity.attackable.origin, entity.origin);

    if(var_bec89360 <= sqr(200)) {
      return true;
    }

    if(var_bec89360 >= sqr(entity.var_724ec089)) {
      return true;
    }

    var_f5f64fa2 = entity getEye();
    var_ac89c6e3 = entity.attackable getcentroid();

    if(target === entity.attackable && !sighttracepassed(var_f5f64fa2, var_ac89c6e3, 0, entity.attackable)) {
      return true;
    }
  }

  return false;
}

function function_c3ceb539(entity) {
  test_points = [];
  target = get_target_ent(entity);
  var_5494b2e9 = 0;
  self.can_phase = 0;

  var_db7c302f = getdvarstring(#"hash_2bb93ebd2eab9e57", "<dev string:x42>");

  if(var_db7c302f != "<dev string:x42>") {
    tokens = strtok(var_db7c302f, "<dev string:x46>");

    if(tokens.size == 3) {
      self.can_phase = 1;
      return (float(tokens[0]), float(tokens[1]), float(tokens[2]));
    }
  }

  if(isDefined(entity.attackable) && entity.attackable === target) {
    var_5494b2e9 = 1;
    test_points = array();
    slots = array::randomize(entity.attackable.var_b79a8ac7.slots);
    point_count = int(min(slots.size, 3));

    for(i = 0; i < point_count; i++) {
      slot = slots[i];
      angles = vectortoangles(slot.origin - entity.attackable.origin);
      test_points[test_points.size] = entity.attackable.origin + anglesToForward((0, angles[1], 0)) * randomfloatrange(150, 500);
    }
  } else if(isPlayer(entity.favoriteenemy) && entity.favoriteenemy === target) {
    var_5494b2e9 = 1;
    var_529624a4 = entity.favoriteenemy getplayerangles();
    var_168f9987 = entity.var_946951ef;
    var_90b4cb5d = entity.var_36221cb6;
    test_points = array(entity.favoriteenemy.origin + anglesToForward((0, angleclamp180(var_529624a4[1] + randomfloatrange(entity.var_533dbb42, entity.var_7654fbc7) / 2), 0)) * randomfloatrange(var_168f9987, var_90b4cb5d), entity.favoriteenemy.origin + anglesToForward((0, angleclamp180(var_529624a4[1] - randomfloatrange(entity.var_533dbb42, entity.var_7654fbc7) / 2), 0)) * randomfloatrange(var_168f9987, var_90b4cb5d));

    if(isDefined(entity.var_42a18a37)) {
      var_2fa931bb = 0;

      foreach(test_point in test_points) {
        dist_sq = distancesquared(test_point, entity.origin);

        if(dist_sq > sqr(entity.var_42a18a37)) {
          test_points[var_2fa931bb] = vectornormalize(test_point - entity.origin) * entity.var_42a18a37 + entity.origin;
        }

        var_2fa931bb++;
      }
    }
  } else if(isalive(entity.favoriteenemy) && entity.favoriteenemy === target) {
    var_5494b2e9 = 1;
    test_points = array(entity.favoriteenemy.origin + anglesToForward((0, randomfloat(180), 0)) * randomfloatrange(entity.var_946951ef, entity.var_36221cb6), entity.favoriteenemy.origin + anglesToForward((0, randomfloat(180) * -1, 0)) * randomfloatrange(entity.var_946951ef, entity.var_36221cb6));
  } else {
    return undefined;
  }

  enemy = target;
  test_points = array::randomize(test_points);

  if(var_5494b2e9) {
    bestpoint = undefined;

    foreach(point in test_points) {
      bestpoint = function_3d3ee1a4(entity, point, enemy);

      if(isDefined(bestpoint)) {
        break;
      }
    }
  } else {
    bestpoint = test_points[0];
  }

  if(isDefined(bestpoint)) {
    recordsphere(bestpoint, 15, (0, 0, 1), "<dev string:x38>");
    recordline(entity.origin, bestpoint, (0, 0, 1), "<dev string:x38>");
  }

  if(isPlayer(entity.favoriteenemy)) {
    player_angles = entity.favoriteenemy getplayerangles();

    if(isDefined(player_angles) && isDefined(bestpoint)) {
      var_891a94cf = anglesToForward(player_angles);
      var_e4529f5f = acos(vectordot(var_891a94cf, vectornormalize(bestpoint - entity.favoriteenemy.origin)));
      distsqrd = distancesquared(bestpoint, entity.favoriteenemy.origin);
      dist = sqrt(distsqrd);
    }
  }

  self.can_phase = isDefined(bestpoint);
  return bestpoint;
}

function function_77788917(entity) {
  self playSound(#"hash_64bb457a8c6f828c");
  self clientfield::set("" + # "avogadro_health_fx", 120);
  self ghost();
  self notsolid();

  if(isDefined(self.var_78dd7804)) {
    function_c6e09354(self.var_78dd7804);
    self.var_78dd7804 = undefined;
  }
}

function function_3d3ee1a4(entity, point, enemy) {
  if(!function_9f1d0b0d(entity, point)) {
    return undefined;
  }

  groundpos = groundtrace(point + (0, 0, 500) + (0, 0, 8), point + (0, 0, 500) + (0, 0, -100000), 0, entity)[#"position"];

  if(groundpos[2] < point[2] - 2000) {
    recordsphere(point, 10, (1, 0, 0), "<dev string:x38>", entity);

    return undefined;
  }

  nextpos = getclosestpointonnavmesh(groundpos, 128, entity getpathfindingradius());

  if(!isDefined(nextpos)) {
    recordsphere(point, 10, (1, 0, 0), "<dev string:x38>", entity);

    return undefined;
  }

  if(isDefined(enemy)) {
    var_94324c7a = getclosestpointonnavmesh(enemy.origin, 128, entity getpathfindingradius());

    if(isDefined(var_94324c7a)) {
      nextpos = checknavmeshdirection(var_94324c7a, nextpos - var_94324c7a, distance(nextpos, var_94324c7a), entity getpathfindingradius());

      if(isDefined(entity.favoriteenemy) && distancesquared(var_94324c7a, nextpos) <= sqr(entity.var_946951ef)) {
        recordsphere(nextpos, 10, (1, 0, 0), "<dev string:x38>", entity);

        return undefined;
      }
    }
  }

  groundpos = groundtrace(nextpos + (0, 0, 500) + (0, 0, 8), nextpos + (0, 0, 500) + (0, 0, -100000), 0, entity)[#"position"];

  if(abs(nextpos[2] - groundpos[2]) > 5) {
    return undefined;
  }

  if(isDefined(nextpos) && distancesquared(entity.origin, nextpos) < sqr(entity.var_168f9987)) {
    return undefined;
  }

  if(isDefined(level.var_c8827250) && ![[level.var_c8827250]](nextpos)) {
    return undefined;
  }

  return nextpos;
}

function function_9ab1c000(entity) {
  return isDefined(entity.var_78dd7804);
}

function function_3b8d314c(entity) {
  entity.blockingpain = 1;
}

function function_ceeb405(entity) {
  entity.blockingpain = 0;

  if(isDefined(entity.var_78dd7804)) {
    entity thread function_d979c854(entity);
  }
}

function function_36f6a838(entity) {
  entity.phase_time = gettime() + entity.var_15aa1ae0;
  entity.var_7fde19e8 = gettime();
}

function function_b57de57a(entity) {
  entity setentitypaused(1);
  entity dontinterpolate();
  angles = entity.angles;
  target = get_target_ent(entity);

  if(isDefined(target) && isDefined(entity.endpoint)) {
    angles = vectortoangles(target.origin - entity.endpoint);
    var_db2921e1 = zm_utility::is_classic();
    entity forceteleport(entity.endpoint, (0, angles[1], 0), !var_db2921e1);
  }

  entity endoncallback(&function_55bc7283, #"death");
  util::wait_network_frame();
  entity setentitypaused(0);
}

function function_55bc7283(notifyhash) {
  if(self ispaused()) {
    self setentitypaused(0);
  }
}

function function_c83209ee(entity) {
  if(!function_f14292cf(entity)) {
    return false;
  }

  var_d06fc215 = getdvarfloat(#"hash_6911e1fbdc75c93", 3000);

  if(isDefined(entity.var_de2d38ae) && gettime() - entity.var_de2d38ae <= var_d06fc215) {
    return false;
  }

  return true;
}

function function_f14292cf(entity) {
  if(!isDefined(entity.var_d444767) || gettime() - entity.var_d444767 > 500) {
    return false;
  }

  return true;
}

function function_b411d93(entity) {
  entity.var_de2d38ae = gettime();
}

function function_1169b184(entity) {
  function_dbc638a8(entity);
}

function function_d58f8483(entity) {
  target = get_target_ent(entity);
  var_bd4e4e13 = !isPlayer(target) || zm_utility::is_player_valid(target, 1);

  if(isDefined(target) && distancesquared(entity.origin, target.origin) <= sqr(entity.var_724ec089) && var_bd4e4e13) {
    assert(isDefined(entity.var_696e2d53) && isDefined(entity.var_e3b6f14a), "<dev string:x4b>");

    if(gettime() < entity.var_696e2d53) {
      return entity.var_e3b6f14a;
    }

    entity.var_696e2d53 = gettime();
    var_32eb9058 = isentity(target) ? target getcentroid() : target.origin;
    traceresult = bulletTrace(entity getEye(), var_32eb9058, 0, isentity(target) ? target : undefined);

    if(traceresult[#"fraction"] == 1) {
      entity.var_e3b6f14a = 1;
      return 1;
    }
  }

  entity.var_e3b6f14a = 0;
  entity.var_696e2d53 = gettime() + randomintrangeinclusive(800, 1000);
  return 0;
}

function function_bc2f2686(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("normal", 0);
  target = get_target_ent(mocompduration);

  if(isDefined(mocompduration.attackable) && mocompduration.attackable === target) {
    mocompduration orientmode("face point", mocompduration.attackable getcentroid());
    return;
  }

  if(isDefined(target)) {
    mocompduration orientmode("face point", target.origin);
    return;
  }

  mocompduration orientmode("face default");
}

function function_9f3a10a4(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompanimflag animmode("normal", 0);
  mocompanimflag.blockingpain = 1;
  mocompanimflag.var_78dd7804 = function_205c9932(mocompanimflag);

  if(isDefined(mocompanimflag.var_78dd7804)) {
    mocompanimflag.var_78dd7804.array[0].origin = mocompanimflag.traversalstartpos;
    mocompanimflag.var_78dd7804.array[1].origin = mocompanimflag.traversalendpos;
  }

  mocompanimflag.var_d39541c9 = {
    #var_deb95e3f: getnotetracktimes(mocompduration, "phase_start")[0], #var_c970f455: getnotetracktimes(mocompduration, "phase_end")[0]
  };
}

function function_4cf6a31d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(mocompanimflag getanimtime(mocompduration) >= mocompanimflag.var_d39541c9.var_deb95e3f && !is_true(mocompanimflag.var_d39541c9.var_50524dbd)) {
    if(isDefined(mocompanimflag.var_78dd7804)) {
      mocompanimflag thread function_d979c854(mocompanimflag);
    }

    mocompanimflag.var_d39541c9.var_50524dbd = 1;
  }

  if(mocompanimflag getanimtime(mocompduration) >= mocompanimflag.var_d39541c9.var_c970f455 && !is_true(mocompanimflag.var_d39541c9.var_90a731c)) {
    mocompanimflag dontinterpolate();
    mocompanimflag forceteleport(mocompanimflag.traversalendpos, mocompanimflag.angles, 0);
    mocompanimflag.var_d39541c9.var_90a731c = 1;
  }
}

function function_7b70bdbe(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.blockingpain = 0;
  mocompduration.var_78dd7804 = undefined;
  mocompduration.var_d39541c9 = undefined;
  mocompduration.var_7fde19e8 = gettime();

  if(isactor(mocompduration)) {
    mocompduration finishtraversal();
  }
}

function function_f6aed42d() {
  self.var_b467f3a1 = &function_17be9890;
  self thread function_7ce6b06d();
}

function function_17be9890(eventstruct) {
  if(!is_true(level.var_2356dff1)) {
    return;
  }

  notify_string = eventstruct.action;
  str_alias = notify_string;
  var_6281c93d = 0;
  n_priority = 1;
  var_c8109157 = 0;

  switch (notify_string) {
    case # "death":
      var_6281c93d = 1;
      n_priority = 4;
      break;
    case # "pain":
      var_6281c93d = 1;
      n_priority = 3;
      break;
    case # "summon":
      var_6281c93d = 1;
      n_priority = 3;
      var_c8109157 = 1;
      break;
    case # "attack":
    case # "teleport":
      var_6281c93d = 1;
      n_priority = 2;
      var_c8109157 = 1;
      break;
    case # "ambient":
    case # "ambient_alert":
      n_priority = 1;
      break;
    case # "attack_melee":
      return;
    default:
      n_priority = 2;
      break;
  }

  level thread zm_audio::zmbaivox_playvox(self, str_alias, var_6281c93d, n_priority, var_c8109157);
}

function function_7ce6b06d() {
  self endon(#"death");
  str_notify = "ambient";

  while(true) {
    min_wait = 2;
    max_wait = 5;

    if(isDefined(self.awarenesslevelcurrent) && self.awarenesslevelcurrent === "combat") {
      str_notify = "ambient_alert";
    } else {
      str_notify = "ambient";
    }

    bhtnactionstartevent(self, str_notify);
    self notify(#"bhtn_action_notify", {
      #action: str_notify
    });
    wait randomfloatrange(min_wait, max_wait);
  }
}

function function_33237109(entity, var_2d449c92, var_c33af938) {
  entity.var_6ec16f15 = var_2d449c92;
  entity.var_591c9ab9 = var_c33af938;
}

function function_9f1d0b0d(entity, position) {
  if(isDefined(entity.var_6ec16f15) && isDefined(entity.var_591c9ab9)) {
    if(distancesquared(position, entity.var_6ec16f15) > sqr(entity.var_591c9ab9)) {
      return false;
    }
  }

  return true;
}

function function_1ad43460(entity) {
  goal_info = entity function_4794d6a3();

  if(isDefined(goal_info.goalpos) && !function_9f1d0b0d(entity, goal_info.goalpos)) {
    return false;
  }

  if(!btapi_locomotionbehaviorcondition(entity)) {
    return false;
  }

  return true;
}

function function_de781d41(entity) {
  if(!isDefined(entity.var_e8a7f45d)) {
    entity.var_e8a7f45d = {
      #state: # "hash_24e69bf779de4940", #var_a5afe5a1: gettime()
    };
  }

  if(!isDefined(entity.var_e8a7f45d.center_point)) {
    entity.var_e8a7f45d.center_point = entity.origin;
  }

  if(gettime() < entity.var_e8a7f45d.var_a5afe5a1) {
    return;
  }

  entity.var_e8a7f45d.var_a5afe5a1 = gettime() + 2000;
  strafe_goal = function_598bf886(self);

  if(isDefined(strafe_goal)) {
    entity setgoal(strafe_goal);
  }
}

function function_598bf886(entity) {
  nextstate = # "hash_24e69bf779de4940";

  switch (entity.var_e8a7f45d.state) {
    case # "hash_24e69bf779de4940":
      random = randomint(100);

      if(random < 33) {
        nextstate = # "hash_a69905121714d7c";
      } else if(random < 66) {
        nextstate = # "hash_46c85a951b2258a9";
      }

      break;
    case # "hash_a69905121714d7c":
    case # "hash_46c85a951b2258a9":
      nextstate = # "hash_24e69bf779de4940";
      break;
    default:
      break;
  }

  target = get_target_ent(entity);

  if(nextstate != entity.var_e8a7f45d.state) {
    dirtoenemy = vectornormalize(target.origin - entity.origin);
    angles = vectortoangles(dirtoenemy);
    angles = (0, angles[1], 0);

    if(nextstate == # "hash_a69905121714d7c") {
      dir = anglestoright(angles) * -1;
      movepos = entity.origin + dir * randomintrange(100, 300);
    } else if(nextstate == # "hash_46c85a951b2258a9") {
      dir = anglestoright(angles);
      movepos = entity.origin + dir * randomintrange(100, 300);
    } else {
      movepos = entity.var_e8a7f45d.center_point;
    }

    if(isDefined(movepos)) {
      var_37c56a35 = getclosestpointonnavmesh(movepos, 128, entity getpathfindingradius() * 1.2);
    }

    if(isDefined(var_37c56a35)) {
      var_9b482dc3 = checknavmeshdirection(entity.origin, var_37c56a35 - entity.origin, distance(entity.origin, var_37c56a35), entity getpathfindingradius());

      recordline(entity.origin, var_9b482dc3, (0, 1, 0), "<dev string:x38>", entity);

      recordline(entity.origin + (0, 0, 3), var_37c56a35 + (0, 0, 3), (1, 0.5, 0), "<dev string:x38>", entity);

      if(distancesquared(entity.origin, var_9b482dc3) >= 100 || is_false(entity.can_phase)) {
        entity.var_e8a7f45d.state = nextstate;
        return var_9b482dc3;
      }
    }
  }
}
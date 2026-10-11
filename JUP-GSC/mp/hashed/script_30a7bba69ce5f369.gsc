/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30a7bba69ce5f369.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_1bfe8e965532ee8a;
#using script_21cf081b320a9938;
#using script_38c251115537f16e;
#using script_3b78d23dad7ec5be;
#using script_3badb8914eb5ac16;
#using script_40510196b9a59795;
#using script_5133812eb5db429a;
#using script_516de9f009ec5f26;
#using script_60dd6e3992c1f29;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\bt_util;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace zombie_mimic;

function precache(params) {
  level._effect["player_grabbed_by_mimic_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_mimic_grab_cam.vfx");
  level._effect["player_bitten_by_mimic_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_mimic_water_cam.vfx");
  level._effect["player_body_bitten_by_mimic_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_mimic_grab_bite_player.vfx");
  level._effect["player_hit_by_mimic_ranged_attack_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_mimic_ranged_spit_attack_cam.vfx");
  level._effect["mimic_weakspot_impact_fx"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_mimic_weak_point_impact.vfx");
  function_4417babebd3bada7(params);
}

function private function_51470bb89e9a816(params) {
  function_62acb9a556ab5175();
  function_8e401d26d58bc32d();
  function_dfad208433b79ddf();
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_d18ca757733c1f7f);
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &function_c8c10b313b3fcf09);
  callback::get_template(self.animsetname) callback::add("on_ai_killed", &function_a295306038aa1d4e);
  callback::get_template(self.animsetname) callback::add("on_entity_revealed", &function_88950ad5e3ce8e13);
  callback::get_template(self.animsetname) callback::add("on_turned", &function_84a9a40f78a814cd);
  callback::get_template(self.animsetname) callback::add("shocked", &function_c8bbb80c04cd9a37);
  callback::get_template(self.animsetname) callback::add("shocked_end", &function_deadba29b36b687d);
  callback::get_template(self.animsetname) callback::add("burned", &function_bf0fe7b30fa14180);
  callback::get_template(self.animsetname) callback::add("burned_end", &function_788a3fa28ef17f52);
  callback::get_template(self.animsetname) callback::add("napalm_burned", &function_dbb5710ec418627e);
  callback::get_template(self.animsetname) callback::add("napalm_burned_end", &function_afa5ec2deb3f62a0);
  callback::get_template(self.animsetname) callback::add("zombie_melee_pre", &function_b5764abaf3c1c8de);
}

function function_25dabcda59af1c66(taskid) {
  assert(isDefined(self.zombieaisetting));
  zombie_init_ai(self.zombieaisetting);
  assert(isDefined(self.zombieaisettings.var_e58a65b7a8f5973c));
  callback::add("on_first_ai_init", &function_51470bb89e9a816);
  self.allowpain = 0;
  self.var_b0c83727eacd1810 = 0;
  self.var_51adc6933a819c35 = squared(self.zombieaisettings.var_e58a65b7a8f5973c.grabattackdistance);
  self.grab_damage = self.zombieaisettings.var_e58a65b7a8f5973c.grabattackdamage;
  self.var_7286eb804434f596 = self.zombieaisettings.var_e58a65b7a8f5973c.var_94b56832fc7f394e * 1000;
  self.var_858ebdfa6952957a = self.zombieaisettings.var_e58a65b7a8f5973c.var_e0d6ba528eaf90b2;
  self.var_57f944bef3fa055f = tan(self.zombieaisettings.var_e58a65b7a8f5973c.var_267f8518b498347a);
  function_1fc0eb1eb90c8dd0("walk", 100);
  function_1fc0eb1eb90c8dd0("run", 120);
  self.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  callback::add("on_zombie_ai_spawned", &function_9ae856c35fa71be8);
  callback::add("on_entity_hidden_in_prop", &function_b735f24952147af);
  function_265e0e58c950559();
  function_a45d79b43b8a55d7(self.zombieaisettings.var_e58a65b7a8f5973c.var_742446c248f92636);
  function_1e388b876cdce171();
  function_ea94f43e92438867();
  thread initscriptable();
  return anim.success;
}

function private initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();
  utility::function_3ab9164ef76940fd("base", "base_on");
  utility::function_3ab9164ef76940fd("mouth", "mouth_on");
}

function private function_a295306038aa1d4e(params) {
  if(isPlayer(params.eattacker) && !istrue(self.var_5a242d06b1ccb893)) {
    params.eattacker doscoreeventsharedfunc(#"hash_9c49bcb8084d6327");
  }
}

function private function_c8c10b313b3fcf09(params) {
  body = function_d8853db47f5b98e4(params);

  if(isDefined(body)) {
    body utility::function_3ab9164ef76940fd("gib_head", "gibbed");
    wait 1.5;
    body = function_d8853db47f5b98e4(params);

    if(isDefined(body)) {
      body hide();
    }

    wait 1;
    body = function_d8853db47f5b98e4(params);

    if(isDefined(body)) {
      body delete();
    }
  }
}

function function_a33c1ed9fb3e400e(notename, endonnotify, custom_func, flagname) {
  self endon("death");

  if(isDefined(endonnotify)) {
    self endon(endonnotify);
  }

  if(!isDefined(flagname)) {
    flagname = self asmgetcurrentstate(self.asmname);
  }

  while(true) {
    self waittill(flagname, notetracks);
    b_ended = 0;

    if(isarray(notetracks)) {
      foreach(note in notetracks) {
        if(notename == note) {
          if(isDefined(custom_func)) {
            self[[custom_func]]();
          } else {
            return 1;
          }
        }

        if(note == "end") {
          b_ended = 1;
        }
      }
    }

    if(b_ended) {
      return 1;
    }
  }
}

function private function_c8bbb80c04cd9a37(var_a21093610d4de2ed) {
  utility::function_3ab9164ef76940fd("shocked", "shocked_on");
}

function private function_deadba29b36b687d(var_a21093610d4de2ed) {
  utility::function_3677f2be30fdd581("shocked", "shocked_off");
}

function private function_bf0fe7b30fa14180(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("burned", "burned_on");
}

function private function_788a3fa28ef17f52(var_12c084a213d7ad2) {
  utility::function_3677f2be30fdd581("burned", "burned_off");
}

function private function_dbb5710ec418627e(var_12c084a213d7ad2) {
  utility::function_3ab9164ef76940fd("napalm_burned", "napalm_burned_on");
}

function private function_afa5ec2deb3f62a0(var_12c084a213d7ad2) {
  utility::function_3677f2be30fdd581("napalm_burned", "napalm_burned_off");
}

function private function_84a9a40f78a814cd(attacker) {
  self.never_hide = 1;
  self.var_dec41e66d2f7fffd = self.maxhealth * 0.2;
  function_f1e5805da192a1ef("sprint", "turned", 25);
  utility::function_3ab9164ef76940fd("brainrot", "brainrot_on");
  utility::function_3ab9164ef76940fd("mouth", "mouth_turned");
  self._blackboard.var_8d19c6ba087e7a86 = 1;
}

function private function_d18ca757733c1f7f(params) {
  if(isDefined(params.metabonename) && params.metabonename == "weakspot_mouth") {
    playFXOnTag(getfx("mimic_weakspot_impact_fx"), self, "tag_weakpoint_mouth");
  }
}

function function_a8c9248308033e4e() {
  if(istrue(self.var_f8a44d7cde24460a)) {
    return false;
  }

  return true;
}

function function_b5764abaf3c1c8de(params) {
  e_target = params.meleetarget;
  n_damage = isDefined(self.var_dec41e66d2f7fffd) ? self.var_dec41e66d2f7fffd : params.meleedamage;

  if(isai(e_target) && n_damage >= e_target.health) {
    e_target.ragdollimpactvector = (anglesToForward(self.angles) + (0, 0, 0.4)) * 6000;
    e_target.ragdollhitloc = "torso_lower";
    e_target.do_immediate_ragdoll = 1;
  }
}

function function_f407dae1f3f118e8(taskid, params) {
  if(!isDefined(self.prop_array) || !self.prop_array.size) {
    function_cfa8ac2b4b30b60(self);
  }

  function_7ada97e01329f789();
  return anim.success;
}

function function_97872f112975e7a5(taskid, params) {
  if(asm_ephemeraleventfired("finish_hide", "end")) {
    return anim.success;
  }

  return anim.running;
}

function function_972fb80508bb6bdb(taskid, params) {
  self hide();
  function_bdcc0a0ca6396e2a();
  function_758159430083e297(self);
}

function function_4582540b7ff726e1() {
  if(istrue(level.var_46382c5eecf4baf3) && !istrue(self.never_hide) && (isDefined(self.prop_array) || function_48b1349a9ec06480(1))) {
    self function_3e89eb3d8e3f1811("should_hide", 1);
    return true;
  }

  return false;
}

function function_bdcc0a0ca6396e2a() {
  self function_3e89eb3d8e3f1811("should_hide", 0);

  if(isDefined(self.prop_array)) {
    self.prop_array = array_removeundefined(self.prop_array);
  }

  props = self.prop_array;
  trap_prop = self.trap_prop;
  var_20fe7f5e3d45448e = !isDefined(trap_prop);

  if(isDefined(trap_prop) && isDefined(trap_prop.lure_prop_type)) {
    level thread clean_up_prop(trap_prop);
    props = array_remove(props, trap_prop);
    trap_prop = undefined;
    var_20fe7f5e3d45448e = props.size == 0;
  }

  if(var_20fe7f5e3d45448e && function_48b1349a9ec06480(1, self)) {
    function_232cabbc43f9536(self.origin, self);
    return;
  }

  if(isDefined(trap_prop)) {
    trap_prop.origin = self.origin;
  } else if(isDefined(props)) {
    trap_prop = props[0];
  } else {
    return;
  }

  function_f9d849950dd83510(props, self, trap_prop);
}

function private function_9ae856c35fa71be8(params) {
  callback::callback("mimic_spawned");
  self endon("death");
  waitframe();

  if(istrue(level.var_46382c5eecf4baf3) && !istrue(self.hidden_in_prop) && istrue(self.var_1ae467607bbe5da2)) {
    function_cfa8ac2b4b30b60(self);
    function_bdcc0a0ca6396e2a();
    function_758159430083e297(self);
  }
}

function private function_b735f24952147af(prop) {
  self clearpath();
  self function_3e89eb3d8e3f1811("hidden_in_prop", 1);
  self.b_ignore_cleanup = 1;
  val::set("mimic", "damage", 0);
  val::set("mimic", "ignoreme", 1);
}

function private function_88950ad5e3ce8e13(params) {
  self endon("death");
  self function_3e89eb3d8e3f1811("hidden_in_prop", 0);
  val::reset("mimic", "ignoreme");
  self.b_ignore_cleanup = undefined;
  random_activator = random(params.activators);
  self.favoriteenemy = random_activator;
  prop = self.trap_prop;
  angles = default_to(prop.angles, self.angles);
  origin = default_to(prop.origin, self.origin);
  activator = undefined;

  if(isDefined(params.activators) && isent(params.activators[0])) {
    activator = params.activators[0];
    angles = vectortoangles(activator.origin - origin);
  }

  playFX(getfx("mimic_prop_emerge_fx"), origin, anglesToForward(angles));
  self forceteleport(origin, angles, 10000, 1);
  wait 0.5;
  val::reset("mimic", "damage");
  self setsolid(1);
  self show();
  self.hidden_in_prop = undefined;
  dist_sq = 0;

  if(isDefined(activator)) {
    dist_sq = distancesquared(activator.origin, self.origin);
  }

  if(isPlayer(activator) && dist_sq < self.var_51adc6933a819c35 && !function_479960c6dfffd9c6(self gettagorigin("j_spine4"), self.angles)) {
    thread mimic_emerge_grab(activator);
  } else {
    animname = "emerge";

    if(dist_sq > squared(200)) {
      if(isDefined(activator)) {
        var_bddb21e15cb0f0cf = self getcentroid();
        end_point = var_bddb21e15cb0f0cf + vectorNormalize(activator getcentroid() - var_bddb21e15cb0f0cf) * 200;

        if(ray_trace_passed(var_bddb21e15cb0f0cf, end_point, undefined, create_default_contents(1))) {
          animname = "emerge_sprint";
        }
      }
    }

    thread animscripted_sharedfunc(animname, animname, origin, angles);
  }

  function_6bdfe7a8ca9c56ba();
}

function function_6bdfe7a8ca9c56ba() {
  players = getplayersinradiussharedfunc(self.origin, 200);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player knockback_flat(player.origin - self.origin, 400);
  }
}

function function_a45d79b43b8a55d7(b_multiple) {
  thread function_abafe9cd03c2c0ab();

  if(istrue(b_multiple)) {
    thread function_17bed982df752ea9();
  }

  self._blackboard.var_d182b3cdaa8e3be7 = 2000;
  self._blackboard.var_d1a5a1cdaab45c09 = 2000;
  self._blackboard.var_4a850e88a81da5f9 = 7;
}

function private function_abafe9cd03c2c0ab() {
  self endon("death");

  while(true) {
    self waittill("unreachable_attack_start");
    self.var_c24f43a7d0d8d195 = self.enemy;
    function_306feec3952fc2ef();
  }
}

function private function_17bed982df752ea9() {
  self endon("death");
  self.var_3e5886b1679d1980 = 0;

  while(true) {
    wait 0.5;

    if(istrue(self.hidden_in_prop) || !isDefined(self.enemy)) {
      continue;
    }

    if(self.var_3e5886b1679d1980 > gettime() || distancesquared(self.enemy.origin, self.origin) < 90000) {
      continue;
    }

    if(!function_e0bf32008879b3fd(self.enemy, 15)) {
      continue;
    }

    ranged_targets = [self.enemy];
    target_query = physics_querypoint(self.enemy.origin, 500, physics_createcontents(["physicscontents_characterproxy"]), [self, self.enemy], "physicsquery_all");

    foreach(potential_target in target_query) {
      target_ent = potential_target["entity"];

      if(function_e0bf32008879b3fd(target_ent, 60)) {
        ranged_targets[ranged_targets.size] = target_ent;
      }
    }

    self.var_c24f43a7d0d8d195 = self.enemy;
    function_306feec3952fc2ef(ranged_targets);
    self.var_3e5886b1679d1980 = gettime() + 10000;
  }
}

function private function_e0bf32008879b3fd(ranged_target, var_5345a087e822b319) {
  if(!isalive(ranged_target) || self.team == ranged_target.team) {
    return false;
  }

  if(distancesquared(ranged_target.origin, self.origin) > 2000000) {
    return false;
  }

  var_7ed16081706dd7d0 = vectortoyaw(ranged_target.origin - self.origin);

  if(absangleclamp180(self.angles[1] - var_7ed16081706dd7d0) > var_5345a087e822b319) {
    return false;
  }

  var_d501156f1d47a825 = vectortopitch(ranged_target.origin - self.origin);

  if(absangleclamp180(var_d501156f1d47a825) > 50) {
    return false;
  }

  if(!self cansee(ranged_target)) {
    return false;
  }

  return true;
}

function function_479960c6dfffd9c6(origin, angles) {
  v_forward = anglesToForward(angles);
  end_origin = origin + v_forward * 202;
  ignore_ents = array_add(level.players, self);
  content = create_contents(1, 1, 1, 1, 0, 1, 1);
  b_passed = capsule_trace_passed(origin, end_origin, 35, 70, undefined, ignore_ents, content);

  if(getdvarint(@ "hash_e71f45f0a0cebdbe", 0)) {
    debugstar(end_origin, (1, 0, 1), 40);
    line(origin, end_origin, (1, 0, 1), 1, 1, 40);

    if(!b_passed) {
      print3d(end_origin, "<dev string:x1c>", (1, 0, 0), 1, 1, 40);
    }
  }

  if(!b_passed) {
    return true;
  }

  var_d0dff10eaee857d1 = origin + vectorNormalize((v_forward[0], v_forward[1], self.var_57f944bef3fa055f)) * 80;
  b_passed = capsule_trace_passed(origin, var_d0dff10eaee857d1, 35, 70, undefined, ignore_ents, content);

  if(getdvarint(@ "hash_e71f45f0a0cebdbe", 0)) {
    debugstar(var_d0dff10eaee857d1, (1, 0, 1), 40);
    line(origin, var_d0dff10eaee857d1, (1, 0, 1), 1, 1, 40);

    if(!b_passed) {
      print3d(var_d0dff10eaee857d1, "<dev string:x38>", (1, 0, 0), 1, 1, 40);
    }
  }

  return !b_passed;
}

function mimic_emerge_grab(player) {
  self endon("death");
  level endon("game_ended");
  thread animscripted_sharedfunc("emerge_attack", "emerge_attack", self.origin, self.angles, "mimic_emerge_grab");
  ent_flag_waitopen("mimic_emerge_grab");

  if(isalive(player) && distancesquared(self.origin, player.origin) < self.var_51adc6933a819c35 && absangleclamp180(vectortoyaw(player.origin - self.origin) - self.angles[1]) < 30) {
    thread animscripted_sharedfunc("emerge_attack_hit", "emerge_attack_hit", self.origin, self.angles, "grab_end");
    player thread function_4744995ac583c880("ai_jup_zm_mimic_com_emerge_prop_atk_bite_f_01_hit_player", self, self.origin, self.angles);
  } else {
    thread animscripted_sharedfunc("emerge_attack_miss", "emerge_attack_miss", self.origin, self.angles);
  }

  self.var_b0c83727eacd1810 = gettime() + self.var_7286eb804434f596;
}

function function_4744995ac583c880(player_anim, mimic, origin, angles) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  e_model = utility::spawn_model("tag_origin", mimic gettagorigin("tag_player"), mimic gettagangles("tag_player"));
  e_model linkTo(mimic, "tag_player", (0, 0, -40), (0, 0, 0));
  thread delete_on_death(e_model);
  mimic thread delete_on_death(e_model);
  params = spawnStruct();
  params.attacker = mimic;
  callback::callback("on_mimic_player_grab_start", params);
  set("ai_mimic_grab", "ignoreme", 1);
  set("ai_mimic_grab", "freezecontrols", 1);
  set("ai_mimic_grab", "weapon", 0);
  mimic.grabbed_player = self;
  mimic.var_5a242d06b1ccb893 = 1;
  self setstance("stand", 1, 1);

  if(!self islinked()) {
    self playerlinktoblend(e_model, "tag_origin", 0.3, 0.1, 0.05);
  }

  if(!self getcamerathirdperson()) {
    playfxontagforclients(getfx("player_grabbed_by_mimic_fx"), self, "j_head", self);
  }

  if(isnullweapon(self gethighpriorityweapon())) {
    self playviewmodelanim(player_anim);
  }

  waitframe();

  if(isalive(mimic)) {
    mimic thread function_a33c1ed9fb3e400e("mimic_bite", "grab_end", &function_c97059c441653141);
    b_ended = mimic function_a33c1ed9fb3e400e("mimic_throw", "grab_end");
  } else {
    b_ended = 1;
  }

  if(isDefined(self)) {
    if(self isviewmodelanimplaying()) {
      self stopviewmodelanim();
    }

    if(isDefined(e_model) && self islinked() && self getlinkedparent() == e_model) {
      self unlink();
    }

    callback::callback("on_mimic_player_grab_end", params);

    if(isalive(mimic) && istrue(b_ended)) {
      mimic.grabbed_player = undefined;
      to_player = vectornormalize2(self.origin - mimic.origin);
      self setOrigin(self.origin + (0, 0, 5));
      self knockback((to_player[0], to_player[1], mimic.var_57f944bef3fa055f), mimic.var_858ebdfa6952957a);
      playFXOnTag(getfx("player_body_bitten_by_mimic_fx"), self, "j_spine4");
      mimic notify("vox_pushback_scream");
      noself_delaycall(0.8, &function_afe5cda1a4ed9d11, "custom", self, self.origin + to_player * 100, 500);
      thread function_95c7e0ea826c97ea();
    }

    self earthquakeforplayer(0.5, 0.8, self.origin, 500);
    delaythread(0.5, &reset_all, "ai_mimic_grab");
  }

  if(isDefined(e_model)) {
    e_model delete();
  }
}

function function_95c7e0ea826c97ea() {
  self endon("death_or_disconnect");

  while(true) {
    wait 0.1;
    a_zombies = getaiarrayinradius(self.origin, 64);

    foreach(zombie in a_zombies) {
      if(isalive(zombie) && is_equal(zombie.aicategory, "normal") && !zombie function_e67a89537ae7d4b7()) {
        zombie knockdown_ai(self.origin);
      }
    }

    if(self isonground()) {
      break;
    }
  }
}

function function_c97059c441653141() {
  if(isPlayer(self.grabbed_player)) {
    playfxontagforclients(getfx("player_bitten_by_mimic_fx"), self.grabbed_player, "j_head", self.grabbed_player);
    self.grabbed_player dodamage(self.grab_damage, self.origin, self, self, "MOD_MELEE", self.weapon);
    self.grabbed_player earthquakeforplayer(0.5, 0.8, self.grabbed_player.origin, 500);
  }
}

function function_5aeb3ae4ed6135f9() {
  player = getclosest(self gettagorigin("j_tentacle_01_ri"), level.players);

  if(isalive(player) && !isDefined(player.vehicle) && !player ishanging() && distancesquared(self.origin, player.origin) < self.var_51adc6933a819c35 && absangleclamp180(vectortoyaw(player.origin - self.origin) - self.angles[1]) < 30) {
    player thread function_4744995ac583c880("ai_jup_zm_mimic_com_stn_atk_grab_01_hit_player", self, self.origin, self.angles);
    return true;
  }

  return false;
}

function function_df0b176709835ef4(taskid, params) {
  if(self.var_b0c83727eacd1810 > gettime() || !isPlayer(self.enemy) || distancesquared(self.enemy.origin, self.origin) > squared(130)) {
    return false;
  }

  if(isDefined(self.var_79c4b60a90941f65) && ![[self.var_79c4b60a90941f65]](self.enemy)) {
    return false;
  }

  if(function_479960c6dfffd9c6(self.origin + (0, 0, 40), self.angles)) {
    return false;
  }

  return true;
}

function function_e9e7acaf7ce05aba(taskid, params) {
  self notify("vox_interrupt_amb_3");
  function_668f4c9fbe0b7df();
}

function function_17b5cbf9f7aba1fb(taskid, params) {
  if(self getaiblackboarddynamic("in_grab_attack") <= 0) {
    return anim.success;
  }

  return anim.running;
}

function function_2cbb5fa528d8c675(taskid, params) {
  self.var_b0c83727eacd1810 = gettime() + self.var_7286eb804434f596;
  self clearpath();
}
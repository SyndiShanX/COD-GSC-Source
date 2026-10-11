/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2b9373071eab7afc.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_68fa6b4ee60216ae;
#using scripts\anim\shared;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace namespace_640e6f453fd3818f;

function function_971bf83fc35c7d8d() {
  init_generic_human_anims();
  init_player_anims();
  contents = ["physicscontents_glass", "physicscontents_item", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_vehicle"];
  level.var_2ebb956b048b8bb7 = physics_createcontents(contents);
  level.var_797d34a3d8c0545a = 0;
}

#using_animtree("generic_human");

function init_generic_human_anims() {
  level.scr_anim["hvt"]["combat_2_ground_head"] = % jup_hostage_combat_2_ground_idle_head_shot;
  level.scr_anim["hvt"]["combat_2_ground_body"] = % jup_hostage_combat_2_ground_idle_body_shot;
  level.scr_anim["hvt"]["ground_idle_struggle"][0] = % jup_hostage_ground_idle_struggle;
  level.scr_goaltime["hvt"]["ground_idle_struggle"] = 0;
  level.scr_anim["hvt"]["pickup_ground_4"] = % jup_hostage_pickedup_stand_4;
  level.scr_anim["hvt"]["pickup_ground_6"] = % jup_hostage_pickedup_stand_6;
  level.scr_anim["hvt"]["pickup_ground_8"] = % jup_hostage_pickedup_stand_8;
  level.scr_anim["hvt"]["dropped_stand"] = % jup_hostage_dropped_stand;
  level.scr_goaltime["hvt"]["dropped_stand"] = 0;
}

#using_animtree("player");

function init_player_anims() {
  var_7907568326d674ab = "player_rig";
  level.scr_anim[var_7907568326d674ab]["pickup_ground_4"] = % jup_hostage_pickedup_stand_4_vm;
  level.scr_anim[var_7907568326d674ab]["pickup_ground_6"] = % jup_hostage_pickedup_stand_6_vm;
  level.scr_anim[var_7907568326d674ab]["pickup_ground_8"] = % jup_hostage_pickedup_stand_8_vm;
  level.scr_anim[var_7907568326d674ab]["dropped_stand"] = % jup_hostage_dropped_stand_vm;
}

function spawnhostage(spawner_targetname, var_cb4dfc3c8138f8aa, startpoint, var_6e3cca7456eaf23e) {
  spawner = getStruct(spawner_targetname, "targetname");
  var_44c998e27e126507 = spawner scripts\cp\spawning::spawn_ai();
  var_44c998e27e126507.spawner = spawner;
  var_44c998e27e126507 namespace_f07a91c6c17492be::init();
  scripts\cp\spawning::run_ai_post_spawn_init(undefined, var_44c998e27e126507, spawner, undefined, undefined, 0, 0);
  var_44c998e27e126507 function_5ff89151667b0690(var_cb4dfc3c8138f8aa, var_6e3cca7456eaf23e);

  if(isDefined(startpoint)) {
    start = getStruct(startpoint, "targetname");
    var_44c998e27e126507 forceteleport(start.origin, start.angles);
  }

  return var_44c998e27e126507;
}

function function_5ff89151667b0690(var_cb4dfc3c8138f8aa, var_6e3cca7456eaf23e) {
  ent_flag_set("hostage_ai");
  self.var_7cea08b66b2ad878 = 0;
  self.battlechatterallowed = 0;
  self notify("removed from battleChatter");
  thread function_5674766c9779586e(var_cb4dfc3c8138f8aa);
  self.grenadeweapon = makeweapon("molotov_mp");
  self.grenadeammo = 99;
  thread function_4e94a290b2aecd87(var_cb4dfc3c8138f8aa, var_6e3cca7456eaf23e);
}

function function_4e94a290b2aecd87(var_cb4dfc3c8138f8aa, var_6e3cca7456eaf23e) {
  ent_flag_wait("hostage_enter_downed_state");
  flag_set("hostage_enter_downed_state");
  self.animname = "hvt";
  self.invulnerable = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.dontevershoot = 1;
  self.cannotmelee = 1;
  self.var_b582b10663b5b2a9 = 0;
  self.pacifist = 1;
  self.dont_enter_combat = 1;
  self.allowpain = 0;
  self.scripted_mode = 1;
  scripts\asm\shared\mp\utility::animscripted_clear();

  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd show();
    level.var_8b3e280380afbbd.headmodel show();
  } else {
    self visiblenotsolid();
  }

  self disableaimassist();
  hashelmet = istrue(self.helmethealth) && self.helmethealth > 0;

  if(hashelmet) {
    scripts\cp_mp\armor::function_e71f062243ea8827(self.helmethealth, 0, level.player);
  }

  if(istrue(self.var_b3054dce8cc525f2)) {
    scripts\anim\shared::dropaiweapon(self.weapon);

    if(isDefined(var_6e3cca7456eaf23e)) {
      self thread[[var_6e3cca7456eaf23e]]();
    }

    self[[level.setagentteam]]("allies");
    enemiesarray = [self];
    level notify("visibilityTeamName", "allies", enemiesarray, 1);
    return;
  }

  if(!is_equal(var_cb4dfc3c8138f8aa, 1) && !is_equal(var_cb4dfc3c8138f8aa, 2)) {
    if(!function_26e853210b199ff2(72)) {
      span = function_d74b2fe7f6c2e20d();
      thread function_2c6efd419713d16a(span);
    } else {
      flag_set("hostage_moved");
    }

    scripts\anim\shared::dropaiweapon(self.weapon);

    if(ent_flag("hostage_killed_via_headshot")) {
      anim_single([self], "combat_2_ground_head");
    } else {
      anim_single([self], "combat_2_ground_body");
    }

    flag_wait("hostage_moved");
  } else {
    scripts\anim\shared::dropaiweapon(self.weapon);
  }

  scripts\common\visibility_mode::function_8ba05ef17e2b7d10(self, "allies");
  flag_set("hostage_downed");

  if(is_equal(var_cb4dfc3c8138f8aa, 2)) {
    return;
  }

  thread anim_loop_solo(self, "ground_idle_struggle");
  flag_wait("flag_dungeon_hostage_interact_enabled");
  thread hostage_enable_rescue();
}

function function_d74b2fe7f6c2e20d() {
  span = 18;

  while(!function_26e853210b199ff2(72 - span)) {
    span += 18;
  }

  return span;
}

function function_2c6efd419713d16a(span) {
  self.mover = spawn_tag_origin();
  self linkTo(self.mover);
  waitframe();
  self.mover moveTo(self.origin + anglesToForward(self.angles) * span, 1, 0.1, 0.1);
  wait 1;
  self unlink();
  self.mover delete();
  flag_set("hostage_moved");
}

function hostage_enable_rescue() {
  self endon("delete");
  function_fec66842cfeb54ee(1);
  childthread function_9c007c0bb2e0ec80();

  while(true) {
    self.interaction_handle waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(istrue(self.pickup_disabled) || level.player isswitchingweapon()) {
      continue;
    }

    self notify("hostage_stop_head_pickup_tracking");
    function_fec66842cfeb54ee(0);
    waitframe();
    hostage_onuse(player);
    break;
  }
}

function hostage_onuse(player, first_pickup, var_18ca380c68fe756f) {
  self endon("dropped");
  self endon("death");
  level endon("game_ended");
  player notify("hostage_started_pick_up");
  player setclientomnvar("ui_stop_armor_hint", 1);
  function_f0c2012ae22ca0d6(player);

  if(player isnightvisionon()) {
    player nightvisionviewoff();
  }

  self.angles = (0, self.angles[1], 0);
  function_98b73e796145b31c(player, first_pickup, var_18ca380c68fe756f);
  player notify("hostage_picked_up");

  if(isDefined(level.var_8b3e280380afbbd)) {
    anim_first_frame_solo(level.var_8b3e280380afbbd, "dropped_stand");
    level.var_8b3e280380afbbd hide();
    level.var_8b3e280380afbbd.headmodel hide();
  } else {
    self invisiblenotsolid();
  }

  anim_first_frame_solo(self, "dropped_stand");

  if(!isDefined(level.var_3befbfa70e58e8af)) {
    level.var_3befbfa70e58e8af = spawn_script_origin(player.origin, player.angles);
    level.var_3befbfa70e58e8af linkTo(level.player, "tag_origin", (-60, 0, 0), (0, 0, 0));
  }

  self linkTo(level.var_3befbfa70e58e8af);

  if(istrue(self.var_b3054dce8cc525f2)) {
    level.player setcarryobject("hostage_nolan");
  } else {
    level.player setcarryobject("hostage_tier_3_soldier");
  }

  thread hostage_watchdrop(player);
  player thread watchfordrophintstring(player, self);
  wait 0.3;
  level notify("player_picked_up_hostage", player);
  self notify("player_picked_up_hostage", player);
}

function function_d947d0b7bffa015e(player, var_5cae62a3d49c731e) {
  if(!isDefined(var_5cae62a3d49c731e)) {
    var_5cae62a3d49c731e = 0;
  }

  player endon("death");
  player endon("hostage_dropped");
  self endon("dropped");
  player notify("end_hostage_carry");
  self unlink();
  player.ability_invulnerable = 1;
  toggledrophintstring(0, player, self);
  function_e483413541e6f5cc();
  function_82a28c37a53c04f4(var_5cae62a3d49c731e);

  if(getdvarint(@ "hash_af1b2585f346f9f9", 1)) {
    player resetcarryobject();
  }

  if(!var_5cae62a3d49c731e) {
    player setstance("stand");
    level.player unlink();
    player allowmovement(1);
    player notify("remove_rig");
  }

  player.ability_invulnerable = undefined;

  if(!var_5cae62a3d49c731e) {
    droppos = self.origin;
    function_86292e1de168df69(player, self, droppos, undefined, 0, 0, 1);
    return;
  }

  function_4d2119264c4281d0();
}

function watchfordrophintstring(player, hostage) {
  player endon("death");
  player endon("hostage_dropped");
  hostage endon("dropped");
  player endon("end_hostage_carry");

  while(true) {
    if(candrophostage(player)) {
      toggledrophintstring(1, player, hostage);
    } else {
      toggledrophintstring(0, player, hostage);
    }

    waitframe();
  }
}

function function_86292e1de168df69(player, hostage, position, spawndrop, forcepos, preventuse, forceend) {
  self endon("delete");

  if(!isDefined(player)) {
    player = self.carrier;
  }

  if(!isDefined(position)) {
    position = hostage.origin;
  }

  if(!isDefined(hostage)) {
    hostage = self;
  }

  hostage.carried = 0;
  hostage.carrier = undefined;
  hostage unlink();
  player allownightvisiontoggle(1);
  toggledrophintstring(0, player, hostage);

  if(istrue(forcepos)) {
    hostage.origin = position;
  } else {
    if(hostage hostage_carrier_oob(player)) {
      if(isDefined(hostage.last_good_drop_pos)) {
        position = hostage.last_good_drop_pos;
      }
    }

    hostage.origin = _getphysicspointaboutnavmesh(position);

    if(hostage is_hostage_oob()) {
      if(isDefined(hostage.last_good_drop_pos)) {
        position = hostage.last_good_drop_pos;
        hostage.origin = _getphysicspointaboutnavmesh(position);
      }
    }

    hostage thread hostage_confirm_good_angles(player);
  }

  hostage.angles = getanglesfromsurfacenormal(hostage.origin, self);

  if(!isDefined(spawndrop) && isDefined(hostage.useobj)) {
    hostage.useobj.origin = hostage.origin;
  }

  function_4d2119264c4281d0();
  function_b7771cc818b41864(player);

  if(istrue(forceend)) {
    return hostage;
  }

  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_apt_skyhook_capture_nolan_struggle_loop");
    hostage thread anim_loop_solo(level.var_8b3e280380afbbd, "ground_idle_struggle_fake");
  }

  originoffset = (30.2201, 24.8, -0.790039);
  var_e9c5759074027530 = vectortoangles(originoffset);
  var_e9c5759074027530 = invertangles(var_e9c5759074027530);
  var_36b7429bd8bdede3 = combineangles(hostage.angles, var_e9c5759074027530);
  hostage.origin += rotatevector(originoffset, var_36b7429bd8bdede3);
  anglesoffset = invertangles((-1.8907, 16.947, 0.656898));
  hostage.angles = combineangles(hostage.angles, anglesoffset);
  hostage thread anim_loop_solo(hostage, "ground_idle_struggle");
  hostage thread hostage_enable_rescue();
  hostage thread watchfornewdrop();
  player setclientomnvar("ui_stop_armor_hint", 0);
  hostage notify("dropped");
  return hostage;
}

function function_6baa0edc8062fabc(time) {
  if(isDefined(time)) {
    wait time;
  }

  origin = self gettagorigin("J_MainRoot");
  angles = self gettagangles("J_MainRoot");
  println("<dev string:x1c>" + origin + "<dev string:x2c>" + angles);
}

function is_hostage_oob() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(self istouching(trigger)) {
        return true;
      }
    }
  }

  return false;
}

function watchfornewdrop() {
  self endon("deleted");
  self endon("death");
  self endon("player_picked_up_hostage");
  self notify("watchNewDrop");
  self endon("watchNewDrop");

  while(true) {
    wait 2.5;
    trace = ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    var_24a474d9ccb84218 = trace["fraction"];

    if(isDefined(var_24a474d9ccb84218) && var_24a474d9ccb84218 >= 1) {
      groundpoint = drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(groundpoint) + (0, 0, 2);
    }
  }
}

function hostage_confirm_good_angles(player) {
  var_8fdee444bf3f0305 = confirm_good_pickup_location(self.origin, self.angles, player);

  if(!istrue(var_8fdee444bf3f0305.failed)) {
    self.angles = var_8fdee444bf3f0305.angles;
    return;
  }

  var_72189ddd797f8bb2 = 0;
  var_2d86928904c0521c = [];
  var_2d86928904c0521c[var_2d86928904c0521c.size] = var_8fdee444bf3f0305.currentbestpos;

  if(isDefined(var_8fdee444bf3f0305.currentbestpos)) {
    currentbestdist = var_8fdee444bf3f0305.currentbestdist;
    currentbestpos = getclosestpointonnavmesh(var_8fdee444bf3f0305.currentbestpos);

    for(i = 0; i < 10; i++) {
      var_df814e82bd6814f8 = confirm_good_pickup_location(currentbestpos, self.angles, player);

      if(!istrue(var_df814e82bd6814f8.failed)) {
        self.origin = var_df814e82bd6814f8.origin;
        self.angles = var_df814e82bd6814f8.angles;
        return;
      } else {
        var_2d86928904c0521c[var_2d86928904c0521c.size] = currentbestpos;

        if(var_df814e82bd6814f8.currentbestdist > currentbestdist && !array_contains(var_2d86928904c0521c, getclosestpointonnavmesh(var_df814e82bd6814f8.currentbestpos))) {
          currentbestdist = var_df814e82bd6814f8.currentbestdist;
          currentbestpos = getclosestpointonnavmesh(var_df814e82bd6814f8.currentbestpos);
        } else {
          currentbestdist = 0;
          var_72189ddd797f8bb2 += 512;
          randompoint = getrandomnavpoint(self.origin, var_72189ddd797f8bb2);
          currentbestpos = getclosestpointonnavmesh(randompoint);
        }
      }

      wait 0.05;
    }
  }

  announcement("<dev string:x37>");

  if(isDefined(self.spawn_origin)) {
    self.origin = self.spawn_origin;
  }
}

function confirm_good_pickup_location(var_abbb4b8615510568, ref_angles, player, radius) {
  if(!isDefined(level.var_712a42cb53dc22c1)) {
    level.var_712a42cb53dc22c1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  }

  currentangles = ref_angles;
  var_79b0da6daa286045 = var_abbb4b8615510568 + (0, 0, 24);

  if(!isDefined(radius)) {
    radius = 36;
  }

  info = spawnStruct();
  info.currentbestdist = 0;

  for(i = 0; i < 12; i++) {
    var_4f1e8173f86258 = var_abbb4b8615510568 + anglesToForward(currentangles) * radius + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(var_79b0da6daa286045, var_4f1e8173f86258, self, level.var_712a42cb53dc22c1)) {
      var_647c8c4cc914e7d1 = var_4f1e8173f86258 - (0, 0, 4);
      var_647c9e4cc9150f67 = var_4f1e8173f86258 + (0, 0, 4);
      playertrace = undefined;

      if(isPlayer(player)) {
        playertrace = player scripts\engine\trace::player_trace(var_647c8c4cc914e7d1, var_647c9e4cc9150f67, player.angles, player, level.var_712a42cb53dc22c1);
      } else {
        playertrace = player scripts\engine\trace::capsule_trace(var_647c8c4cc914e7d1, var_647c9e4cc9150f67, 30, 60, player.angles, player, level.var_712a42cb53dc22c1);
      }

      var_bf43a05b1ee8acb6 = playertrace["fraction"];

      if(isDefined(var_bf43a05b1ee8acb6) && var_bf43a05b1ee8acb6 >= 1) {
        if(i > 0) {
          print3d(var_4f1e8173f86258, "<dev string:x68>", (0, 1, 0), 1, 1, 300, 1);
        }

        info.origin = var_abbb4b8615510568;
        info.angles = currentangles;
        var_311bf43e8fc0f6d8 = distancesquared(var_4f1e8173f86258, getclosestpointonnavmesh(var_4f1e8173f86258));

        if(var_311bf43e8fc0f6d8 > info.currentbestdist) {
          info.currentbestdist = var_311bf43e8fc0f6d8;
          info.currentbestpos = var_4f1e8173f86258;
        }

        return info;
      } else {
        print3d(var_4f1e8173f86258, "<dev string:x6a>", (1, 1, 0), 1, 1, 300, 1);

        var_311bf43e8fc0f6d8 = distancesquared(var_4f1e8173f86258, getclosestpointonnavmesh(var_4f1e8173f86258));

        if(var_311bf43e8fc0f6d8 > info.currentbestdist) {
          info.currentbestdist = var_311bf43e8fc0f6d8;
          info.currentbestpos = var_4f1e8173f86258;
        }
      }
    } else {
      print3d(var_4f1e8173f86258, "<dev string:x6a>", (1, 0, 0), 1, 1, 300, 1);
    }

    if(currentangles[1] + 30 >= 360) {
      currentangles = (currentangles[0], currentangles[1] - 360, currentangles[2]);
    }

    currentangles = (currentangles[0], currentangles[1] + 30, currentangles[2]);
  }

  info.failed = 1;
  return info;
}

function function_2ba20849a1fa31f4(toggle) {
  if(!isDefined(self.var_14376af5002738cf)) {
    self.var_14376af5002738cf = spawn("script_model", level.player.origin + (0, 0, 80));
    self.var_14376af5002738cf linkTo(level.player);
    self.var_14376af5002738cf makeusable();
  }

  if(toggle) {
    self.var_14376af5002738cf function_dfb78b3e724ad620(1);
    self.var_14376af5002738cf setCursorHint("HINT_NOICON");
    self.var_14376af5002738cf setHintString("");
    self.var_14376af5002738cf setuserange(100);
    self.var_14376af5002738cf sethintdisplayrange(100);
    self.var_14376af5002738cf sethintonobstruction("show");
    self.var_14376af5002738cf setuseholdduration("duration_short");
    self.var_14376af5002738cf sethintrequiresholding(1);
    return;
  }

  self.var_14376af5002738cf function_dfb78b3e724ad620(0);
}

function hostage_watchdrop(player) {
  self endon("death");
  player endon("last_stand");
  player endon("end_hostage_carry");
  self.carried = 1;
  self.carrier = player;
  function_2ba20849a1fa31f4(1);

  while(self.carried) {
    thread function_8e4423c6d1124d6f(player, self, self.var_14376af5002738cf);
    self.var_14376af5002738cf waittill("trigger");

    if(!istrue(candrophostage(player))) {
      waitframe();
      continue;
    }

    function_2ba20849a1fa31f4(0);
    player.ability_invulnerable = 1;
    player notify("hostage_dropped");
    toggledrophintstring(0, player, self);
    self unlink();
    function_84af4eb8a3d70517(player);
    player notify("hostage_drop_complete");
    droppos = self.origin;
    function_86292e1de168df69(player, self, droppos, undefined, 0, 0);
    player.ability_invulnerable = undefined;
    return;
  }
}

function private function_8e4423c6d1124d6f(player, hostage, var_2d2983907205f4b) {
  hostage endon("death");
  player endon("last_stand");
  player endon("end_hostage_carry");

  while(player useButtonPressed()) {
    waitframe();
  }

  player setclientomnvar("zm_hint_progress", 0);
  time_used = 0;
  var_f06bff905f2c77ee = var_2d2983907205f4b function_d215465537d119af() * 0.001;

  while(hostage.carried) {
    if(!player useButtonPressed()) {
      if(time_used > 0) {
        time_used = 0;
        player setclientomnvar("zm_hint_progress", time_used);
      }

      waitframe();
      continue;
    }

    if(candrophostage(player)) {
      time_used += level.framedurationseconds;
      player setclientomnvar("zm_hint_progress", time_used / var_f06bff905f2c77ee);
    } else if(time_used > 0) {
      time_used = 0;
      player setclientomnvar("zm_hint_progress", 0);
    }

    if(time_used >= var_f06bff905f2c77ee) {
      wait 0.1;
      player setclientomnvar("zm_hint_progress", 0);
      break;
    }

    wait level.framedurationseconds;
  }
}

function candrophostage(player) {
  if(gettime() - level.var_797d34a3d8c0545a < 0.05) {
    return level.var_797d34a3d8c0545a;
  }

  level.var_dde548a1be5af683 = function_6756c37167ee0b53(player);
  level.var_797d34a3d8c0545a = gettime();
  return level.var_dde548a1be5af683;
}

function function_6756c37167ee0b53(player) {
  if(!player isonground()) {
    return false;
  }

  if(isDefined(player getmovingplatformparent())) {
    return false;
  }

  if(function_12cac240ccbc1e8d(player.origin)) {
    return false;
  }

  steps = 4;
  inc = 72 / steps;

  for(i = 1; i <= steps; i++) {
    dist = i * inc;

    if(!function_9c40506b0b199a30(player, dist)) {
      return false;
    }
  }

  return true;
}

function function_9c40506b0b199a30(player, dist) {
  var_30ee65724920b3ca = player.origin + anglesToForward(player.angles) * dist + (0, 0, 24);
  trace = capsule_trace(player.origin + (0, 0, 24), var_30ee65724920b3ca, 16, 40, (0, 0, 0), player, level.var_2ebb956b048b8bb7);

  if(trace["fraction"] >= 1) {
    groundpoint = drop_to_ground(var_30ee65724920b3ca, 24);

    if(abs(groundpoint[2] - var_30ee65724920b3ca[2]) > 40) {
      return 0;
    }

    if(abs(groundpoint[2] - var_30ee65724920b3ca[2]) < 20) {
      return 0;
    } else if(function_12cac240ccbc1e8d(groundpoint)) {
      return 0;
    } else {
      return 1;
    }

    return;
  }

  return 0;
}

function function_12cac240ccbc1e8d(pos) {
  trace = playerphysicstrace(pos + (0, 0, 4), pos + (0, 0, -8), undefined, undefined, [level.player], 1);

  if(istrue(trace["stairs"])) {
    return true;
  }

  return false;
}

function function_26e853210b199ff2(span) {
  var_d652689d2a01d5d2 = self.origin + anglesToForward(self.angles) * span * -1 + (0, 0, 12);
  trace = ray_trace(self.origin + (0, 0, 12), var_d652689d2a01d5d2);

  if(trace["fraction"] >= 1) {
    return 1;
  }

  return 0;
}

function getanglesfromsurfacenormal(position, hostage) {
  starttrace = position + (0, 0, 30);
  endtrace = position;
  trace = ray_trace(starttrace, endtrace, undefined);
  surfacenormal = trace["normal"];
  upangles = vectortoangles(surfacenormal);

  if(!isDefined(surfacenormal) || surfacenormal == (0, 0, 0)) {
    return self.angles;
  }

  var_e76c0c29a4590aeb = generateaxisanglesfromupvector(surfacenormal, self.angles);

  iprintlnbold(var_e76c0c29a4590aeb);

  return var_e76c0c29a4590aeb;
}

function function_f0c2012ae22ca0d6(player) {
  player val::reset_all("carry");
  player val::set("carry", "prone", 0);
  player val::set("carry", "slide", 0);
  player val::set("carry", "sprint", 0);
  player val::set("carry", "supersprint", 0);
  player val::set("carry", "mount_side", 0);
  player val::set("carry", "mount_top", 0);
  player val::set("carry", "mantle", 0);
  player val::set("carry", "equipment_secondary", 0);
  player val::set("carry", "equipment_primary", 0);
  player val::set("carry", "supers", 0);
  player val::set("carry", "melee", 0);
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "swimming_underwater", 0);
  player val::set("carry", "dtp", 0);
  player val::set("carry", "ladder", 0);
  player val::set("carry", "weapon_pickup", 0);
  player val::set("carry", "weapon_switch_clip", 0);
  player val::set("carry", "killstreaks", 0);
  player val::set("carry", "execution_attack", 0);
  player val::set("carry", "ascender_use", 0);
  player val::set("carry", "gesture", 0);
  player val::set("carry", "spotter_scope", 0);
  player val::set("carry", "backpack_inventory", 0);
  player val::set("carry", "ads", 1);
  player val::set("carry", "nvg", 0);
  player.playerstreakspeedscale = -0.25;
  player setmovespeedscale(0.75);
  player.var_859654e0445a36d9 = 1;
}

function function_b7771cc818b41864(player) {
  player val::reset_all("carry");
  player.playerstreakspeedscale = 0;
  player setmovespeedscale(1);
  player.var_859654e0445a36d9 = undefined;
}

function function_98b73e796145b31c(player, first_pickup, var_18ca380c68fe756f) {
  if(!isDefined(var_18ca380c68fe756f)) {
    var_18ca380c68fe756f = 0;
  }

  player.ability_invulnerable = 1;
  var_fb4e7aacfb225799 = spawnStruct();
  var_fb4e7aacfb225799.origin = self.origin;
  var_fb4e7aacfb225799.angles = self.angles;
  tmporigin = (self.origin[0], self.origin[1], player.origin[2]);
  directionvector = vectorNormalize(player.origin - tmporigin);
  var_82b4f01ce94ed444 = vectordot(directionvector, anglesToForward(self.angles));
  var_8288e81ce91e5c46 = vectordot(directionvector, anglestoright(self.angles));
  var_14aea8523fa938ba = (player.origin[0], player.origin[1], self.origin[2]);
  anime = "";
  anime = "pickup_ground_8";

  if(!isDefined(first_pickup) || !first_pickup) {
    if(var_82b4f01ce94ed444 <= -0.4) {
      anime = "pickup_ground_8";
    } else if(var_8288e81ce91e5c46 >= 0) {
      anime = "pickup_ground_4";
    } else if(var_8288e81ce91e5c46 <= 0) {
      anime = "pickup_ground_6";
    }
  }

  if(!var_18ca380c68fe756f) {
    while(!scripts\cp\weapon::isvalidweapon(player getcurrentweapon())) {
      waitframe();
    }

    player.switchweapon = player getcurrentweapon();
    player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
    player setstance("stand");
    level.player_rig = spawn_anim_model("player_rig");
    var_fb4e7aacfb225799 link_player_to_rig(anime, "stand", 1, 0.25, 0, 0, 0, 0, 0);

    if(isDefined(level.var_8b3e280380afbbd)) {
      var_fb4e7aacfb225799 anim_first_frame_solo(level.var_8b3e280380afbbd, anime);
      var_fb4e7aacfb225799 anim_first_frame_solo(level.player_rig, anime);
    }

    function_e483413541e6f5cc();
  }

  if(isDefined(level.var_8b3e280380afbbd)) {
    actors = [level.player_rig, self, level.var_8b3e280380afbbd];
  } else {
    actors = [level.player_rig, self];
  }

  change_fov(65, 1);

  if(var_18ca380c68fe756f) {
    level.var_8b3e280380afbbd thread anim_single(actors, anime);
  } else {
    var_fb4e7aacfb225799 thread anim_single(actors, anime);
  }

  if(isDefined(level.var_8b3e280380afbbd)) {
    var_dde43fd66e074b9 = anime + "_head";
    level.var_8b3e280380afbbd.headmodel scriptmodelplayanim(getanim(var_dde43fd66e074b9));
  }

  wait getanimlength(level.scr_anim["player_rig"][anime]);
  level.player notify("allow_movement");

  if(var_18ca380c68fe756f) {
    level.var_8b3e280380afbbd unlink_player_from_rig(undefined, undefined, undefined, 1);
  } else {
    var_fb4e7aacfb225799 unlink_player_from_rig(undefined, undefined, undefined, 1);
  }

  level.player_rig hide();
  groundpos = gettruegroundposition(player, self);
  player setOrigin(groundpos);
  player notify("remove_rig");
  player.ability_invulnerable = undefined;

  if(!var_18ca380c68fe756f) {
    player scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  function_d759e2d814a8e38e();
}

function function_84af4eb8a3d70517(player) {
  level.player giveweapon(level.player.switchweapon);
  player unlink();
  player allowmovement(1);
  player setstance("stand");
  var_fb4e7aacfb225799 = spawnStruct();
  var_fb4e7aacfb225799.origin = level.player.origin;
  var_fb4e7aacfb225799.angles = (0, level.player.angles[1], 0);
  var_f4d4222e6f428bbb = 0.4;
  var_fb4e7aacfb225799 link_player_to_rig("dropped_stand", "stand", 1, var_f4d4222e6f428bbb, 0, 0, 0, 0, 0);
  level.player_rig dontcastshadows();

  if(getdvarint(@ "hash_af1b2585f346f9f9", 1)) {
    player resetcarryobject();
  }

  if(isDefined(level.var_8b3e280380afbbd)) {
    actors = [level.player_rig, self, level.var_8b3e280380afbbd];
  } else {
    actors = [level.player_rig, self];
  }

  function_e483413541e6f5cc();
  self dontinterpolate();

  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd dontinterpolate();
    level.var_8b3e280380afbbd show();
    level.var_8b3e280380afbbd.headmodel show();
  } else {
    self visiblenotsolid();
  }

  var_fb4e7aacfb225799 thread anim_single(actors, "dropped_stand");

  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd.headmodel scriptmodelplayanim("jup_hostage_dropped_stand_head");
  }

  var_619e0dcfd0d06880 = 1;
  wait getanimlength(%jup_hostage_dropped_stand_vm) - var_619e0dcfd0d06880 + 0.05;
  change_fov(undefined, var_619e0dcfd0d06880);
  wait var_619e0dcfd0d06880;
  var_fb4e7aacfb225799 unlink_player_from_rig(undefined, undefined, undefined, 1);
  level.player_rig hide();

  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd show();
    level.var_8b3e280380afbbd.headmodel show();
  } else {
    self visiblenotsolid();
  }

  player.ability_invulnerable = undefined;
  player notify("remove_rig");
}

function function_82a28c37a53c04f4(var_5cae62a3d49c731e) {
  if(isDefined(level.var_8b3e280380afbbd)) {
    level.var_8b3e280380afbbd hide();
    level.var_8b3e280380afbbd.headmodel hide();
  } else {
    self invisiblenotsolid();
  }

  if(var_5cae62a3d49c731e) {
    return;
  }

  thread anim_loop_solo(level.var_8b3e280380afbbd, "ground_idle_struggle");
  thread anim_loop_solo(self, "ground_idle_struggle");
}

function function_d759e2d814a8e38e() {
  level.player ent_flag_set("hostage_carry_default_weapon");
  level.player delaythread(0.5, &hidehudenable);
  level.player.restoreweaponlist = [];
  level.player.var_52ff0dd15b00f663 = [];
  level.player.var_e5cd4d6ad6017a31 = [];
  level.player scripts\cp\utility::store_weapons_status();
  var_3f9d64d45f14c2db = function_bc15c8dd6359a806();
  pistolobj = undefined;

  if(isDefined(var_3f9d64d45f14c2db)) {
    pistolobj = var_3f9d64d45f14c2db;
  } else {
    pistolobj = scripts\cp\weapon::function_768c9a047aed19f4("iw9_pi_golf17_mp");
  }

  level.player takeallweapons();
  level.player giveweapon(pistolobj, 0, 0, 0, 1);
  level.player switchtoweaponimmediate(pistolobj);
  function_2f7384dd991ac4b6();
  level.player.var_ada0c13107e9c202 = pistolobj;
  level.player thread function_9a6059e0c1dfdcfa();
}

function function_2f7384dd991ac4b6() {
  var_d0a7594214ec5121 = undefined;

  foreach(weapon in level.player.copy_fullweaponlist) {
    if(weapon.basename == "armorplate") {
      var_d0a7594214ec5121 = weapon;
      break;
    }
  }

  if(isDefined(var_d0a7594214ec5121)) {
    level.player.copy_fullweaponlist = array_remove(level.player.copy_fullweaponlist, var_d0a7594214ec5121);
    level.player giveweapon(var_d0a7594214ec5121);
    weaponname = getcompleteweaponname(var_d0a7594214ec5121);

    if(isDefined(level.player.copy_weapon_ammo_clip[weaponname])) {
      level.player setweaponammoclip(var_d0a7594214ec5121, level.player.copy_weapon_ammo_clip[weaponname]);
    }

    if(isDefined(level.player.copy_weapon_ammo_stock[weaponname])) {
      level.player setweaponammostock(var_d0a7594214ec5121, level.player.copy_weapon_ammo_stock[weaponname]);
    }

    level.player.var_6fc446be666b979e = [var_d0a7594214ec5121];
    level.player.copy_fullweaponlist = array_remove(level.player.copy_fullweaponlist, var_d0a7594214ec5121);
  }
}

function function_bc15c8dd6359a806() {
  weapons = level.player getweaponslistprimaries();

  foreach(weapon in weapons) {
    weaponclasstoken = scripts\cp_mp\weapon::getweaponclasstoken(weapon.basename);

    if(weaponclasstoken == "pi") {
      return weapon;
    }
  }

  return undefined;
}

function function_9a6059e0c1dfdcfa() {
  level.player endon("hostage_end_unlimited_ammo");
  wait 1;
  var_4f681613a70ec93c = weaponclipsize(level.player.var_ada0c13107e9c202) * 2;

  while(true) {
    level.player setweaponammostock(level.player.var_ada0c13107e9c202, var_4f681613a70ec93c);
    waitframe();
  }
}

function function_4d2119264c4281d0() {
  level.player hidehuddisable();

  if(!level.player ent_flag("hostage_carry_default_weapon")) {
    return;
  }

  level.player notify("hostage_end_unlimited_ammo");

  if(!isDefined(level.player.var_6fc446be666b979e)) {
    armorobj = level.equipment.table["equip_armorplate"].objweapon;

    if(level.player hasweapon(armorobj)) {
      level.player.var_6fc446be666b979e = [armorobj];
    }
  }

  level.player scripts\cp\utility::restore_weapons_status(level.player.var_6fc446be666b979e);
  level.player.var_6fc446be666b979e = undefined;
  level.player switchtoweaponimmediate(level.player.switchweapon);
  level.player ent_flag_clear("hostage_carry_default_weapon");
}

function function_fec66842cfeb54ee(toggle) {
  if(!isDefined(self.interaction_handle)) {
    interaction_pos = self.origin + (0, 0, 32);
    self.interaction_handle = spawn("script_model", interaction_pos);
    self.interaction_handle linkTo(self);
    self.interaction_handle makeusable();
  }

  if(toggle) {
    self.pickup_disabled = 0;
    self.interaction_handle function_dfb78b3e724ad620(1);

    if(!isDefined(self.interaction_handle.pickuphintstring)) {
      if(istrue(self.var_b3054dce8cc525f2)) {
        self.interaction_handle.pickuphintstring = &"CP_JUP_APT/PICK_UP_NOLAN_INTERACT";
      } else {
        self.interaction_handle.pickuphintstring = &"DUNGEONS/PICKUP_HOSTAGE_INTERACT";
      }
    }

    self.interaction_handle setCursorHint("HINT_BUTTON");
    self.interaction_handle setHintString(self.interaction_handle.pickuphintstring);
    self.interaction_handle setuserange(64);
    self.interaction_handle sethintdisplayrange(128);
    self.interaction_handle sethintdisplayfov(80);
    self.interaction_handle sethintonobstruction("show");
    self.interaction_handle setuseholdduration("duration_short");
    self.interaction_handle sethintrequiresholding(0);
  } else {
    self.pickup_disabled = 1;
    self.interaction_handle function_dfb78b3e724ad620(0);
  }

  self notify("hvt_interaction_updated");
}

function function_9c007c0bb2e0ec80() {
  self endon("hostage_stop_head_pickup_tracking");
  var_e3cfccc74ffbd867 = 0;

  while(true) {
    tmporigin = (self.origin[0], self.origin[1], level.player.origin[2]);
    directionvector = vectorNormalize(level.player.origin - tmporigin);
    var_82b4f01ce94ed444 = vectordot(directionvector, anglesToForward(self.angles));
    canpickup = function_adcec6d9047e4e62();

    if(var_82b4f01ce94ed444 <= 0.8 && var_e3cfccc74ffbd867 && canpickup) {
      self.interaction_handle function_dfb78b3e724ad620(1);
      var_e3cfccc74ffbd867 = 0;
    } else if(var_82b4f01ce94ed444 > 0.8 && !var_e3cfccc74ffbd867 || !canpickup) {
      self.interaction_handle function_dfb78b3e724ad620(0);
      var_e3cfccc74ffbd867 = 1;
    }

    waitframe();
  }
}

function function_adcec6d9047e4e62() {
  if(level.player getstance() == "prone") {
    return false;
  }

  return true;
}

#using_animtree("script_model");

function create_player_rig(player, animname, rig_model) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }

  player.animname = animname;

  if(!isDefined(rig_model)) {
    rig_model = "viewhands_base_iw8";
  }

  player function_b88c89bb7cd1ab8e(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  waittill_any_3("remove_rig", "death", "disconnect");
  remove_player_rig(player);
}

function remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

function gettruegroundposition(player, hostage) {
  if(!isDefined(player)) {
    return;
  }

  currentz = player.origin[2];
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  startpos = player.origin + 12 * (0, 0, 1);
  endpos = player.origin - 24 * (0, 0, 1);
  ignorearray = [player];
  groundpos = player scripts\engine\trace::player_trace(startpos, endpos, player.angles, ignorearray, contents)["shape_position"];
  return groundpos;
}

function function_ebcf1bca5253f3f() {
  self endon("delete");
  self notify("monitor_good_droppos");
  self endon("monitor_good_droppos");
  self.last_good_drop_pos = self.origin;

  while(true) {
    wait 1;

    if(hostage_carrier_oob()) {
      continue;
    }

    self.last_good_drop_pos = self.origin;
  }
}

function hostage_carrier_oob(player) {
  if(isDefined(self.carrier)) {
    player = self.carrier;
  }

  if(isDefined(player) && isPlayer(player)) {
    if(scripts\cp\cp_outofbounds::isoob(player, 0)) {
      return true;
    }
  }

  return false;
}

function _getphysicspointaboutnavmesh(pt) {
  contents = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_bc1fb594d8a6e68a = physics_raycast(pt + (0, 0, 48), pt - (0, 0, 48), contents, undefined, 0, "physicsquery_closest");
  hit = isDefined(var_bc1fb594d8a6e68a) && var_bc1fb594d8a6e68a.size > 0;

  if(hit) {
    hitpos = var_bc1fb594d8a6e68a[0]["position"];
    return hitpos;
  }

  return pt;
}

function toggledrophintstring(toggle, player, hostage) {
  player hint_prompt("drop_dungeon_hostage", toggle);
}

function function_5674766c9779586e(var_cb4dfc3c8138f8aa) {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  if(is_equal(var_cb4dfc3c8138f8aa, 1) || is_equal(var_cb4dfc3c8138f8aa, 2)) {
    ent_flag_set("hostage_enter_downed_state");
    return;
  }

  while(!isDefined(level.agent_funcs[self.agent_type]) || !isDefined(level.agent_funcs[self.agent_type]["on_damaged_finished"])) {
    wait 1;
  }

  level.agent_funcs[self.agent_type]["on_damaged_finished"] = &function_aea4fdd76a700bfd;
}

function function_aea4fdd76a700bfd(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, armorhit) {
  if(!ent_flag("hostage_ai")) {
    scripts\mp\mp_agent::default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, armorhit);
    return;
  }

  if(self.health == 1 && idamage >= 0) {
    idamage = 0;
  } else if(idamage >= self.health) {
    idamage = self.health - 1;
  }

  if(self.health == 1 && !ent_flag("hostage_enter_downed_state")) {
    ent_flag_set("hostage_enter_downed_state");

    if(is_equal(partname, "j_helmet") || is_equal(partname, "j_head")) {
      ent_flag_set("hostage_killed_via_headshot");
    }
  }

  scripts\mp\mp_agent::default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, armorhit);
}
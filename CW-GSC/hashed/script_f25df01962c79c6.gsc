/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_f25df01962c79c6.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5133d88c555e460;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b7d49cfd;

function init() {
  level.doa.var_cb342cbc = &function_258d537d;

  if(!isDefined(level.doa.var_258d537d)) {
    level.doa.var_258d537d = spawnStruct();
    level.doa.var_258d537d.camera = struct::get("podium_camera_shot3");
    level.doa.var_258d537d.props = struct::get_array("podium_prop");
    level.doa.var_258d537d.var_ba1ebafb = struct::get_array("podium_zombie_spot");
    level.doa.var_258d537d.var_b969d349 = struct::get_array("podium_playerpos");
    assert(level.doa.var_258d537d.var_b969d349.size == 4);
  }
}

function function_eb32ec24(var_a5cecef6) {
  self endon(#"death");
  self clientfield::set("set_name_bubble", 1);
  wait 1;
  level notify(#"hash_3a5e52bbc39e1c91");
  wait 2;
  self clientfield::set("set_name_bubble", 0);
  level flag::wait_till_timeout(7, "doa_podium_showPlaces");
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 3;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 12;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 4;
  level notify(#"gem_drop");
  level notify(#"hash_7ac935b0f48034c9");
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 3;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 6;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
}

function function_ae2b7e13(var_a5cecef6) {
  self endon(#"death");
  level waittill(#"hash_3a5e52bbc39e1c91");
  self clientfield::set("set_name_bubble", 1);
  wait 2;
  level notify(#"hash_7d5c782c9416b38d");
  self clientfield::set("set_name_bubble", 0);

  if(level.doa.var_89d17662.size == 2) {
    wait 5;
    level flag::set("doa_podium_showPlaces");
  } else {
    level flag::wait_till_timeout(5, "doa_podium_showPlaces");
  }

  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 5;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 7;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 11;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 3;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  level waittill(#"hash_691cb7b4a4340202");
  wait 1.25;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
}

function function_2a2af1eb(var_a5cecef6) {
  self endon(#"death");
  level waittill(#"hash_7d5c782c9416b38d");
  self clientfield::set("set_name_bubble", 1);
  wait 2;
  level notify(#"hash_2a4a15e11b70b32");
  self clientfield::set("set_name_bubble", 0);

  if(level.doa.var_89d17662.size == 3) {
    wait 3;
    level flag::set("doa_podium_showPlaces");
  } else {
    level flag::wait_till_timeout(3, "doa_podium_showPlaces");
  }

  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 9;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 12;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  level waittill(#"hash_2179bacb8f689956");
  wait 2;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  level waittill(#"hash_691cb7b4a4340202");
  wait 1;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
}

function function_14456228(var_a5cecef6) {
  self endon(#"death");
  level waittill(#"hash_2a4a15e11b70b32");
  wait 1;
  self clientfield::set("set_name_bubble", 1);
  wait 2;
  level flag::set("doa_podium_showPlaces");
  self clientfield::set("set_name_bubble", 0);
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 1, 1);
  wait 1;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 5;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 5;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 3;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
  wait 8;
  self thread namespace_6e90e490::function_47e11416(var_a5cecef6, 2, 1);
}

function function_4ec353f8(var_a5cecef6, idx) {
  self endon(#"death");
  level waittill(#"hash_325409ae06db4c42");

  switch (idx) {
    case 0:
      self thread function_eb32ec24(var_a5cecef6);
      break;
    case 1:
      self thread function_ae2b7e13(var_a5cecef6);
      break;
    case 2:
      self thread function_2a2af1eb(var_a5cecef6);
      break;
    case 3:
      self thread function_14456228(var_a5cecef6);
      break;
    default:
      assert(0);
      break;
  }
}

function function_879d4ceb(idx) {
  self endon(#"death");
  self.ignoreall = 1;
  self useanimtree("generic");
  var_52305af3 = undefined;
  angles = self.angles;
  origin = self.origin;
  myanim = [];

  switch (idx) {
    case 0:
      myanim[0] = "ai_t9_civ_victory_celebration_01";
      myanim[1] = "ai_t9_civ_victory_celebration_05";
      myanim[2] = "ai_t9_civ_victory_celebration_06";
      myanim[3] = "ai_t9_civ_victory_celebration_03";
      var_c8b84175 = 43;
      break;
    case 1:
      myanim[0] = "t9_doa_ai_civ_base_cover_stn_pointidle";
      var_c8b84175 = 44;
      break;
    case 2:
      myanim[0] = "t9_doa_ai_civ_base_standidle_officer";
      var_c8b84175 = 45;
      break;
    case 3:
      myanim[0] = "t9_doa_vign_sitting_civs_right_civ01_loop";
      var_c8b84175 = 46;
      break;
  }

  self thread function_4ec353f8(var_c8b84175, idx);
  self.var_85fab561 = 0;
  self.myanim = myanim[self.var_85fab561];
  self.var_f9b5545b = getanimlength(self.myanim);

  while(true) {
    self.angles = angles;
    self.origin = origin;
    self thread animation::play(self.myanim);
    wait self.var_f9b5545b;

    if(myanim.size > 1) {
      if(is_true(var_52305af3)) {
        self.var_85fab561 = randomint(myanim.size);
      } else {
        self.var_85fab561++;

        if(self.var_85fab561 >= myanim.size) {
          self.var_85fab561 = 0;
        }
      }

      self.myanim = myanim[self.var_85fab561];
      self.var_f9b5545b = getanimlength(self.myanim);
    }
  }
}

function function_13281cbd(var_ae2e8e1f) {
  self endon(#"death");
  self useanimtree("generic");
  self thread function_1e962dea();
  self thread function_d32e5650();
  self thread function_1f6e2084();
  self thread function_6d378d86(var_ae2e8e1f);
}

function function_1f6e2084() {
  self endon(#"death");
  self notify("21b85cf319cbf6a8");
  self endon("21b85cf319cbf6a8");
  angles = self.angles;
  origin = self.origin;

  while(true) {
    self.angles = angles;
    self.origin = origin;
    idleanim = self.animarray[randomint(self.animarray.size)];
    animlength = getanimlength(idleanim);
    self thread animation::play(idleanim);
    wait animlength;
  }
}

function function_1e962dea() {
  self endon(#"death");

  while(true) {
    if(!isDefined(level.doa.var_e3c3fa5a)) {
      wait randomfloatrange(0.1, 2);
      continue;
    }

    anim_ang = vectortoangles(level.doa.var_e3c3fa5a.origin - self.origin);
    self rotateto((0, anim_ang[1], 0), randomfloatrange(0.5, 2));
    self waittill(#"rotatedone");
  }
}

function function_d32e5650() {
  self endon(#"death");
  var_1159929c = array("bo3_ai_zombie_attack_v1", "bo3_ai_zombie_attack_v2", "bo3_ai_zombie_attack_v3", "bo3_ai_zombie_attack_v4", "bo3_ai_zombie_attack_v6", "ai_zombie_base_idle_au_v1", "ai_zombie_base_idle_au_v1_high", "ai_zombie_base_au_attack_v1", "ai_zombie_base_au_attack_v2", "ai_zombie_base_au_attack_v3", "ai_zombie_base_au_attack_v4");
  var_b64682f2 = array("ai_zombie_doa_cheer_v1", "ai_zombie_doa_cheer_v2", "ai_zombie_doa_cheer_v3");
  self.animarray = var_1159929c;
  self.var_2cbcf8e2 = "zombie_outro_mood_angry";

  while(true) {
    result = level waittill(#"zombie_outro_mood_angry", #"hash_6b71fd0ed387fe82", #"hash_749ca0969fe37f63");

    if(!isDefined(self)) {
      return;
    }

    self.var_2cbcf8e2 = result._notify;

    if(result._notify == "zombie_outro_mood_angry") {
      self.animarray = var_1159929c;
    } else {
      self.animarray = var_b64682f2;
    }

    self thread function_1f6e2084();
  }
}

function function_6d378d86(var_ae2e8e1f) {
  self endon(#"death");
  wait randomfloatrange(1, 4);

  if(isDefined(var_ae2e8e1f)) {
    wait var_ae2e8e1f;
  }

  while(true) {
    if(randomint(100) <= 1) {
      switch (self.var_2cbcf8e2) {
        case # "zombie_outro_mood_angry":
          var_b6373ec2 = 40;
          break;
        case # "hash_6b71fd0ed387fe82":
          var_b6373ec2 = 41;
          break;
        case # "hash_749ca0969fe37f63":
          var_b6373ec2 = 42;
          break;
      }

      self thread namespace_6e90e490::function_47e11416(var_b6373ec2, 2);
      wait 2;
    }

    wait 1;
  }
}

function function_ac2a1e0f() {
  level endon(#"podiumalldone");
  level waittill(#"gem_drop");
  var_b7b96881 = struct::get("podium_gem_spot");
  gems = 50;

  if(isDefined(level.doa.var_258d537d.var_b969d349[0].var_6c5d23f4)) {
    level.doa.var_258d537d.var_b969d349[0].var_6c5d23f4 namespace_e32bb68::function_3a59ec34("evt_doa_outro_gem_shower");
  }

  while(gems) {
    gems--;
    spawner::global_spawn_throttle();
    spot = var_b7b96881.origin + (randomintrange(-256, 256), randomintrange(-256, 256), 0);
    gem = namespace_dfc652ee::function_b8f6a8cd(undefined, spot, 1, 1, randomfloatrange(0.75, 2.2));

    if(isDefined(gem)) {
      gem notify(#"hash_2a866f50cc161ca8");
    }
  }
}

function function_52be2241() {
  level endon(#"podiumalldone");
  var_9ef53658 = struct::get("podium_mamaback_introspot", "targetname");
  var_48fff83e = struct::get("podium_mamaback_roofspot", "targetname");
  var_3cc1c35e = struct::get_array("podium_playerpos", "targetname");
  var_dde0062d = var_3cc1c35e[0];
  weapon = getweapon("zombietron_ray_gun");
  org = namespace_ec06fe4a::spawnmodel(var_9ef53658.origin, "tag_origin", var_9ef53658.angles, "outromamaback org");
  org thread namespace_ec06fe4a::function_d55f042c(level, "podiumAllDone");
  level waittill(#"hash_7ac935b0f48034c9");
  org namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
  org namespace_83eb6304::function_3ecfde67("lightningStrike");
  wait 1;
  org namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
  org namespace_83eb6304::function_3ecfde67("lightningStrike");
  silverback = namespace_58e19d6::function_6ae08d6c(var_9ef53658.origin, 1);
  silverback endon(#"death");
  silverback forceteleport(silverback.origin, var_9ef53658.angles);
  silverback thread namespace_ec06fe4a::function_d55f042c(level, "podiumAllDone");
  silverback.takedamage = 0;
  silverback.ignoreall = 1;
  silverback linkto(org);
  wait 0.5;
  org namespace_83eb6304::function_3ecfde67("lightningStrike");
  org namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  wait 3;
  silverback.var_ba88972 = 1;
  silverback waittilltimeout(3, #"taunt_end", #"death");
  level notify(#"hash_6b71fd0ed387fe82");
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  wait 2;
  org moveto(org.origin + (0, 0, 1500), 2);
  org namespace_83eb6304::function_3ecfde67("turret_impact");
  org namespace_e32bb68::function_3a59ec34("evt_doa_outro_mamaback_takeoff");
  wait 2;
  org.origin = var_48fff83e.origin + (0, 0, 1500);
  org.angles = var_48fff83e.angles;
  org moveto(var_48fff83e.origin, 2);
  wait 2;
  org namespace_83eb6304::function_3ecfde67("turret_impact");
  org namespace_e32bb68::function_3a59ec34("evt_doa_outro_mamaback_land");

  if(namespace_ec06fe4a::function_a8975c67()) {
    silverback playSound("zmb_doa_ai_silverback_vocal_roar_short");
  }

  level notify(#"hash_2179bacb8f689956");
  wait 4;
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  wait 2;
  silverback.var_ba88972 = 1;
  silverback waittilltimeout(3, #"taunt_end", #"death");
  wait 2;
  level notify(#"hash_691cb7b4a4340202");
  org namespace_83eb6304::function_3ecfde67("turret_impact");
  org namespace_e32bb68::function_3a59ec34("evt_doa_outro_mamaback_takeoff");
  org moveto(var_48fff83e.origin + (0, 0, 1500), 2);
  wait 1;
  level thread function_c6630cce(weapon, org, level.doa.var_258d537d.var_b969d349[3]);
  wait 0.25;
  level thread function_c6630cce(weapon, org, level.doa.var_258d537d.var_b969d349[2]);
  wait 0.25;
  level thread function_c6630cce(weapon, org, level.doa.var_258d537d.var_b969d349[1]);
  wait 0.25;
  level thread function_c6630cce(weapon, org, level.doa.var_258d537d.var_b969d349[0], "momaBackWinner");
  wait 0.25;
  level notify(#"hash_749ca0969fe37f63");
  org.origin = var_dde0062d.origin + (0, 0, 1500);
  org moveto(var_dde0062d.origin, 2);
  org namespace_83eb6304::function_3ecfde67("turret_impact");

  if(namespace_ec06fe4a::function_a8975c67()) {
    silverback playSound("zmb_doa_ai_silverback_vocal_roar_short");
  }

  wait 2;
  org namespace_e32bb68::function_3a59ec34("evt_doa_outro_mamaback_land_last");
  level notify(#"momabackwinner");
  silverback.var_ba88972 = 1;
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  wait 3;
  silverback.var_ba88972 = 1;
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  silverback waittilltimeout(3, #"taunt_end", #"death");
  silverback thread namespace_6e90e490::function_47e11416(47, 3, 1);
  level notify(#"hash_4d2c57d2dceff63e");
}

function function_ecfe3016(note) {
  self endon(#"death");
  level waittill(note);
  self namespace_83eb6304::function_3ecfde67("zombie_generator_die");
  util::wait_network_frame();
  self namespace_ec06fe4a::function_8c808737();
  wait 1;
  self namespace_83eb6304::function_3ecfde67("chicken_explode");
  wait 1;
  self namespace_83eb6304::function_3ecfde67("chicken_explode");
  wait 0.5;
  self namespace_83eb6304::function_3ecfde67("chicken_explode");
  util::wait_network_frame();
  self delete();
}

function function_c6630cce(weapon, org, var_ec941905, killnote) {
  level endon(#"podiumalldone");

  if(!isDefined(var_ec941905.var_6c5d23f4)) {
    return;
  }

  glow = "glow_" + var_ec941905.var_6c5d23f4.color;
  projectile = magicbullet(weapon, org.origin, var_ec941905.var_6c5d23f4.origin);
  var_ec941905.var_6c5d23f4 namespace_e32bb68::function_3a59ec34("evt_doa_outro_raygun_fire");
  wait 0.1;
  var_ec941905.var_6c5d23f4 namespace_83eb6304::function_3ecfde67("zombie_generator_die");
  var_ec941905.var_6c5d23f4 namespace_83eb6304::function_3ecfde67("chicken_explode");
  var_ec941905.var_6c5d23f4 namespace_e32bb68::function_3a59ec34("evt_doa_outro_raygun_impact");
  util::wait_network_frame();
  var_ec941905.var_6c5d23f4 hide();
  chicken = namespace_ec06fe4a::spawnmodel(var_ec941905.origin, "zombietron_chicken", var_ec941905.angles, "chickenBlast chicken");
  var_ec941905.chicken = chicken;
  chicken.angles += (0, randomintrange(-90, 90), 0);
  chicken thread namespace_ec06fe4a::function_d55f042c(level, "podiumAllDone");
  chicken setscale(3);
  chicken useanimtree("generic");
  curanim = "a_chicken_idle_a";
  chicken namespace_83eb6304::function_3ecfde67("chicken_explode");
  chicken namespace_83eb6304::function_3ecfde67(glow);
  chicken endon(#"death");

  if(isDefined(killnote)) {
    chicken thread namespace_6e90e490::function_47e11416(1, 2, 1);
    chicken thread function_ecfe3016(killnote);
  }

  while(true) {
    if(!is_true(self.var_cd7dffa1) && randomint(100) < 25) {
      chicken thread namespace_6e90e490::function_47e11416(48, 2);
    }

    chicken.origin = var_ec941905.origin;
    animlength = getanimlength(curanim);
    chicken thread animation::play(curanim);
    wait animlength;

    switch (randomint(3)) {
      case 0:
        curanim = "a_chicken_idle_peck";
        break;
      case 1:
        curanim = "a_chicken_idle_a";
        break;
      case 2:
        curanim = "a_chicken_idle";
        break;
    }
  }
}

function function_258d537d() {
  if(getplayers().size == 1) {
    return;
  }

  namespace_4dae815d::function_9ad4988();
  namespace_9fc66ac::function_5e3127a5(undefined, "winners_circle");
  level thread namespace_ec06fe4a::function_87612422(level.doa.var_258d537d.camera.origin, level.doa.var_258d537d.camera.angles, 1, 6, 0);

  foreach(prop in level.doa.var_258d537d.props) {
    streamermodelhint(prop.model, 10);
  }

  level namespace_7f5aeb59::function_67f054d7();
  var_564dda4 = level.lighting_state;
  level clientfield::set("setTOD", 0);
  level util::set_lighting_state(0, 0);
  level clientfield::set("banner_event", 0);
  level.var_7dcdbe16 = 1;

  foreach(player in getplayers()) {
    if(!isDefined(player)) {
      continue;
    }

    player notify(#"hash_7893364bd228d63e");
    player clientfield::set_to_player("cutscene", 2);
    util::wait_network_frame();

    if(isDefined(player)) {
      level clientfield::set_world_uimodel(player.doa.score.var_d252ca7f, 0);
      player clientfield::increment_to_player("setCompassVis");
    }
  }

  foreach(prop in level.doa.var_258d537d.props) {
    assert(!isDefined(prop.scriptmodel));
    prop.scriptmodel = namespace_ec06fe4a::spawnmodel(prop.origin, prop.model, prop.angles, "podium prop");

    if(isDefined(prop.script_noteworthy)) {
      prop.scriptmodel setscale(float(prop.script_noteworthy));
    }
  }

  foreach(guy in level.doa.var_258d537d.var_ba1ebafb) {
    assert(!isDefined(guy.scriptmodel));
    guy.scriptmodel = namespace_ec06fe4a::spawnmodel(guy.origin, guy.model, guy.angles, "podium crowd");
    guy.scriptmodel thread function_13281cbd(guy.script_int);
  }

  players = function_29309b72();
  winner = players[0];
  idx = 0;
  level.doa.var_89d17662 = [];

  foreach(spot in level.doa.var_258d537d.var_b969d349) {
    if(idx >= players.size) {
      break;
    }

    player = players[idx];
    clone = namespace_7f5aeb59::function_f98b7b5f(player);

    if(isDefined(clone)) {
      clone.origin = spot.origin;
      clone.angles = spot.angles;
      clone.color = player.doa.color;
      level.doa.var_89d17662[level.doa.var_89d17662.size] = clone;
      clone clientfield::set("setPlayerOwner", player.entnum + 1);
      clone thread function_879d4ceb(idx);
    }

    idx++;
    spot.var_6c5d23f4 = clone;
  }

  level namespace_7f5aeb59::function_836aeb74();
  namespace_4dae815d::function_21cd3890(3);
  level notify(#"hash_325409ae06db4c42");
  level thread function_ac2a1e0f();
  level thread function_4dc9990(winner);
  level thread function_52be2241();
  level waittilltimeout(60, #"podium_abort");

  if(isDefined(level.doa.var_a5e5c622)) {
    level thread namespace_ec06fe4a::function_87612422([[level.doa.var_a5e5c622]] - > function_ffcf1d1());
  }

  level namespace_7f5aeb59::function_67f054d7();

  foreach(prop in level.doa.var_258d537d.props) {
    assert(isDefined(prop.scriptmodel));
    prop.scriptmodel delete();
    prop.scriptmodel = undefined;
  }

  foreach(guy in level.doa.var_258d537d.var_ba1ebafb) {
    guy.scriptmodel delete();
    guy.scriptmodel = undefined;
  }

  foreach(spot in level.doa.var_258d537d.var_b969d349) {
    if(isDefined(spot.var_6c5d23f4)) {
      spot.var_6c5d23f4 delete();
      spot.var_6c5d23f4 = undefined;
    }

    if(isDefined(spot.chicken)) {
      spot.chicken delete();
      spot.chicken = undefined;
    }
  }

  level.var_7dcdbe16 = undefined;

  foreach(player in getplayers()) {
    player clientfield::set_to_player("cutscene", 0);
    player clientfield::increment_to_player("resetCamera");
    level clientfield::set_world_uimodel(player.doa.score.var_d252ca7f, 1);
  }

  level clientfield::set("setTOD", var_564dda4);
  level util::set_lighting_state(var_564dda4, 0);
  level notify(#"podiumalldone");
  namespace_4dae815d::function_21cd3890(1);
  level namespace_7f5aeb59::function_836aeb74();
}

function function_4dc9990(winner) {
  level endon(#"podiumalldone");

  while(isDefined(winner)) {
    if(winner useButtonPressed()) {
      level notify(#"podium_abort");
      return;
    }

    waitframe(1);
  }
}

function function_29309b72() {
  players = namespace_7f5aeb59::function_23e1f90f();

  for(i = 1; i < players.size; i++) {
    for(j = i; j > 0 && int(players[j - 1] namespace_eccff4fb::function_5ce79923()) < int(players[j] namespace_eccff4fb::function_5ce79923()); j--) {
      array::swap(players, j, j - 1);
    }
  }

  return players;
}
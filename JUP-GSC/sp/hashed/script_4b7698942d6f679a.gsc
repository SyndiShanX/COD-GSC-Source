/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4b7698942d6f679a.gsc
*************************************************/

#using script_54110734a7546551;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\autosave;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_9c93a5b828db4a4b;

function spawn_allies(var_67d71594e67a344a) {
  level.var_be6774d0f9d79daf = make_weapon("jup_jp02_ar_bromeo805", ["fourx02", "silencer01_ar", "laserbox_ads01"]);
  level.var_c63685a4fe1d55fa = make_weapon("jup_jp02_ar_bromeo805", ["fourx02", "silencer01_ar"]);
  var_db60882af0742d19 = getspawner("ally1", "targetname");
  level.ally1 = var_db60882af0742d19 spawn_ai(1, 1);
  level.ally1 scripts\anim\shared::forceuseweapon(level.var_be6774d0f9d79daf, "primary");
  level.ally1.sidearm = nullweapon();
  level.ally1.name = "Ivan";
  level.ally1.callsign = "Alpha-1";
  level.ally1.pushable = 0;
  level.ally1.animname = "ally1";
  level.ally1.disableplayeradsloscheck = 1;
  level.ally1 thread function_ccdf2af631e1d150();
  level.ally1 set_strict_ff(1);
  level.ally1.friend_kill_points = 1300;
  level.ally1 utility::add_damage_function(&function_568c4909ef587d84);

  if(!istrue(var_67d71594e67a344a)) {
    var_4b76cb41c47757a8 = getspawner("ally2", "targetname");
    level.ally2 = var_4b76cb41c47757a8 spawn_ai(1, 1);
    level.ally2 scripts\anim\shared::forceuseweapon(level.var_be6774d0f9d79daf, "primary");
    level.ally2.sidearm = nullweapon();
    level.ally2.name = "Rook";
    level.ally2.callsign = "Alpha-3";
    level.ally2.pushable = 0;
    level.ally2.animname = "ally2";
    level.ally2.disableplayeradsloscheck = 1;
    level.ally2 thread function_ccdf2af631e1d150();
    level.ally2 set_strict_ff(1);
    level.ally2.friend_kill_points = 1300;
    level.ally2 utility::add_damage_function(&function_568c4909ef587d84);
  }

  function_4f1b7657a4c9d1e(var_67d71594e67a344a);
  thread function_139ac603db948842();
}

function function_52b5aaee35540c0b(push_player) {
  if(!isDefined(push_player)) {
    push_player = 1;
  }

  level.ally1.pushable = !push_player;
  level.ally2.pushable = !push_player;
  level.ally1 pushplayer(push_player);
  level.ally2 pushplayer(push_player);
}

function function_139ac603db948842() {
  if(!utils::array_contains(["<dev string:x1c>", "<dev string:x34>", "<dev string:x3a>", "<dev string:x3f>", "<dev string:x45>", "<dev string:x51>"], level.start_point)) {
    waitframe();
    function_37f2a21dd7f9971(0);
  }
}

function function_5ab38289fd2ee60a() {
  level.ally1 setModel("body_c_jup_sp_enemy_pmc_scuba_02");
  level.ally2 setModel("body_c_jup_sp_enemy_pmc_scuba_04");
  level.ally1 detach(level.ally1.headmodel);
  level.ally1.headmodel = "head_c_jup_sp_enemy_pmc_scuba_02";
  level.ally1 attach(level.ally1.headmodel);
  level.ally2 detach(level.ally2.headmodel);
  level.ally2.headmodel = "head_c_jup_sp_enemy_pmc_scuba_04";
  level.ally2 attach(level.ally2.headmodel);
}

function function_4f1b7657a4c9d1e(var_67d71594e67a344a) {
  level.ally1 setModel("body_c_jup_sp_villain_ivan_urban");
  level.ally1 detach(level.ally1.headmodel);
  level.ally1.headmodel = "c_jup_head_hero_ivan_urban";
  level.ally1 attach(level.ally1.headmodel);

  if(!istrue(var_67d71594e67a344a)) {
    level.ally2 setModel("body_c_jup_sp_enemy_pmc_rook");
    level.ally2 detach(level.ally2.headmodel);
    level.ally2.headmodel = "head_c_jup_sp_enemy_pmc_rook";
    level.ally2 attach(level.ally2.headmodel);
  }
}

function function_6eaedee2074c6366() {
  level.ally1 set_stayahead_values(1, 200, 0, 0.1);
  level.ally1 set_stayahead_values(2, 180, -50, 0.1);
  level.ally1 set_stayahead_values(3, 120, -140, 0.1);
  level.ally1 set_stayahead_values(4, 100, -245, 0.1);
  level.ally2 set_stayahead_values(1, 200, 0, 0.1);
  level.ally2 set_stayahead_values(2, 180, -50, 0.1);
  level.ally2 set_stayahead_values(3, 120, -140, 0.1);
  level.ally2 set_stayahead_values(4, 100, -245, 0.1);
  level.ally1 thread enable_stayahead(level.player);
  level.ally2 thread enable_stayahead(level.player);
}

function function_b2c16545d363192c() {
  flag_wait("flag_descend_start_anim");
  level.var_736d1988aa88efc6 = make_weapon("iw9_ar_mike4", ["silencer01_ar", "laserbox_ads05"]);
  var_db60882af0742d19 = getspawner("ally1", "targetname");
  level.ally1 scripts\anim\shared::forceuseweapon(level.var_736d1988aa88efc6, "primary");
  level.ally1.sidearm = nullweapon();
  var_4b76cb41c47757a8 = getspawner("ally2", "targetname");
  level.ally2 scripts\anim\shared::forceuseweapon(level.var_736d1988aa88efc6, "primary");
  level.ally2.sidearm = nullweapon();
}

function stop_talking(ai) {
  if(!isDefined(ai)) {
    return;
  }

  if(isDefined(ai.function_stack)) {
    ai function_stack_clear();
  }

  ai stopsounds();
  waitframe();
}

function temp_dialogue(speaker, text, duration, color_value) {
  level notify("temp_dialogue", speaker, text, duration);
  level endon("temp_dialogue");

  if(!isDefined(color_value)) {
    color_value = 2;
  }

  if(!isDefined(duration)) {
    duration = 4;
  }

  if(isDefined(level.var_e1dec5807616ebbb)) {
    level.var_e1dec5807616ebbb destroy();
    level.var_e1dec5807616ebbb = undefined;
  }

  level.var_e1dec5807616ebbb = newhudelem();
  level.var_e1dec5807616ebbb.x = 0;
  level.var_e1dec5807616ebbb.y = -64;
  level.var_e1dec5807616ebbb settext("^" + color_value + speaker + ": ^7" + text);
  level.var_e1dec5807616ebbb.fontscale = 1.46;
  level.var_e1dec5807616ebbb.alignx = "center";
  level.var_e1dec5807616ebbb.aligny = "middle";
  level.var_e1dec5807616ebbb.horzalign = "center";
  level.var_e1dec5807616ebbb.vertalign = "bottom";
  level.var_e1dec5807616ebbb.sort = 1;
  wait duration;
  thread function_21bbf0b607eef131();
}

function function_21bbf0b607eef131() {
  level endon("temp_dialogue");
  alpha = 1;

  while(alpha > 0) {
    level.var_e1dec5807616ebbb.alpha = alpha;
    wait 0.05;
    alpha -= 0.1;
  }

  level.var_e1dec5807616ebbb destroy();
}

function function_4123dffadf56e313(flag_string) {
  self waittill("trigger");
  flag_set(flag_string);
}

function function_14f79dbffccd10cb(var_81efc2bbfbf0442) {
  function_7c7d840719489953(var_81efc2bbfbf0442);
  level.var_2d68df56a7dae25.var_f0b2812c9ef48b1f = 1;
}

function function_2ff829ac71af5e1f() {
  flag_wait("flag_bottom_of_gulag_wall");

  while(level.player isswimunderwater()) {
    waitframe();
  }

  flag_wait("flag_player_raised_line_launcher");
  structs = getStructArray("rappel_anchor_interact_v2", "targetname");

  foreach(struct in structs) {
    struct thread interact_listener();
  }

  level.connection_interact = getStruct("rappel_anchor", "targetname");
  level.connection_interact waittill("trigger");

  foreach(struct in structs) {
    struct remove_cursor_hint();
  }

  flag_set("flag_wait_attach");
  flag_set("flag_wait_lights_out");
  struct = getStruct("rappel_interact", "targetname");
  struct remove_cursor_hint();
}

function function_cb259d347f82260f() {
  anime = "rappel1_enter";
  animnode = getStruct("rappel_attach_animnode", "targetname");
  rig = function_bc1dd8a02e7bedcb();
  rig hide();
  rig unlink();
  animnode anim_first_frame_solo(rig, anime);
  level.player disableweapons();
  level.player allowmelee(0);
  level.player allowfire(0);
  level.player allowads(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  blendtime = 0.4;
  level.player playerlinktoblend(rig, "tag_player", blendtime);
  level.player thread delaycall(blendtime + 0.05, &playerlinktodelta, rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player thread delaycall(blendtime + 0.1, &lerpviewangleclamp, 2, 0, 0, 20, 30, 30, 20);
  rig thread delaycall(blendtime + 0.1, &show);
  rope = spawn_anim_model("short_rope");
  animnode anim_first_frame_solo(rope, anime);
  rig.rope = rope;
  ents = [rig, rope];
  animnode thread anim_single(ents, anime);
  animation = rig getanim(anime);

  while(rig getanimtime(animation) < 0.85) {
    waitframe();
  }

  while(rig getanimtime(animation) < 0.95) {
    waitframe();
  }

  array = rig getanim("toeup_idle");
  rig setanim(array[0], 1, 0.5);
  level.player lerpviewangleclamp(0.5, 0.2, 0.2, 0, 0, 0, 0);
  rig waittillmatch("single anim", "end");
  waitframe();
  anchors = getStructArray("rappel_anchor", "targetname");
  anchors = sortbydistance(anchors, level.player.origin);
  anchor = anchors[0];
  anchor.min_z = 8192;
  rig hide();
  level.var_2d68df56a7dae25 thread function_3512d347bbdea2e9(anchor);
  level.player enableweapons();
  level.player allowmelee(1);
  level.player allowfire(1);
  level.player allowads(1);
}

function function_14d1b3c1fc80c027(camera) {
  self.lasertag = spawn("script_model", self.origin);
  self.lasertag.angles = self.angles;
  self.lasertag setModel("misc_vm_handheld_green_laser");
  self.lasertag notsolid();
  temp = makeweapon("iw8_green_beam_ir_scripted");
  self.lasertag setmoverlaserweapon(temp);
  self.lasertag linkTo(self);
  self.lasertag laserforceon();
  camera waittill("destroyed");
  self.lasertag laserforceoff();
}

function interact_listener() {
  create_cursor_hint(undefined, (0, 0, 6), &"SP_JUP_VIP/INTERACT_FIRE_LINE_LAUNCHER", undefined, 5000, 5000, 1, undefined, undefined, undefined, "duration_none", "+attack");
  level.player val::set("vip_infil", "fire", 1);
  level.player waittill("weapon_fired");
  level.connection_interact notify("trigger");
}

function function_dc2aa213aa5830aa(spawnlocation) {
  if(!isDefined(level.makarov)) {
    level.makarov = spawn_targetname("makarov_spawner", 1);
    level.makarov set_name("Makarov");
    level.makarov.name = "";
    level.makarov.callsign = "";
    level.makarov magic_bullet_shield();
    level.makarov enableavoidance(0, 1);
    level.makarov.disableplayeradsloscheck = 1;
    level.makarov.pushable = 0;
    level.makarov.animname = "Makarov";
    level.makarov set_strict_ff(1);
    level.makarov utility::add_damage_function(&function_568c4909ef587d84);
    waitframe();

    if(flag("flag_makarov_pcap_complete")) {
      level.makarov.name = "Makarov";
      level.makarov.callsign = "Czar-9-0";
      level.makarov setModel("body_c_jup_sp_villain_makarov_vip");
      level.makarov detach(level.makarov.headmodel);
      level.makarov.headmodel = "c_jup_head_hero_makarov_comm";
      level.makarov attach(level.makarov.headmodel);
    } else {
      level.makarov setModel("body_c_jup_sp_villain_makarov_prisoner");
      level.makarov detach(level.makarov.headmodel);
      level.makarov.headmodel = "c_jup_head_hero_makarov";
      level.makarov attach(level.makarov.headmodel);
    }
  }

  if(isDefined(spawnlocation)) {
    level.makarov forceteleport(spawnlocation.origin, spawnlocation.angles, 100000);
  }
}

function function_2aeeab38857ad8fe(fx) {
  flashlight_fx = getfx("vfx_flashlight_npc_perf_short_vip");
  var_e47f8a7629b4cd8 = "tag_laser_attach";
  self waittill("death");

  if(isDefined(fx)) {
    fx delete();
  }
}

function function_dfd16174f3e3cd29(targetname, end_targetname, delay, var_6a856aaa6ed967d7, endon_notif) {
  if(isDefined(endon_notif)) {
    level endon(endon_notif);
  }

  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(targetname)) {
    object = getEnt(targetname, "targetname");
  } else {
    object = self;
  }

  end = undefined;

  if(isDefined(end_targetname)) {
    end = getStruct(end_targetname, "targetname");
  } else {
    end = getStruct(object.target, "targetname");
  }

  while(true) {
    if(!isDefined(end)) {
      break;
    }

    end_ease = 0;
    speed = 120;

    if(isDefined(end.script_noteworthy)) {
      num_val = float(end.script_noteworthy);

      if(!isnumber(num_val)) {
        switch (end.script_noteworthy) {
          case #"hash_fd151a3694ec335":
            speed = 12000;
            break;
          case #"hash_24da4a3cf8d69647":
            speed = 2000;
            break;
          case #"hash_fde9200bb250ca8e":
            speed = 1000;
            break;
          case #"hash_50b13b06e3c137e0":
            speed = 480;
            break;
          case #"hash_9c8ed152deb360f":
            speed = 240;
            break;
          case #"hash_e8f0758a10ec7618":
            speed = 60;
            break;
          default:
            break;
        }
      } else {
        speed = float(end.script_noteworthy);
      }
    }

    if(isDefined(end.script_flag_true)) {
      flag_wait(end.script_flag_true);
    }

    if(isDefined(end.script_delay)) {
      wait end.script_delay;
    }

    time = distance(object.origin, end.origin) / speed;

    if(time > 0) {
      object rotateTo(end.angles, time, 0, end_ease);
      object moveTo(end.origin, time, 0, end_ease);

      if(time - 0.1 > 0) {
        wait time - 0.1;
      } else {
        wait time;
      }
    }

    if(isDefined(end.script_flag)) {
      flag_set(end.script_flag);
    }

    if(isDefined(end.target)) {
      end = getStruct(end.target, "targetname");
      continue;
    }

    break;
  }

  if(istrue(var_6a856aaa6ed967d7)) {
    object delete();
  }
}

function door_mover(destination_node, time) {
  dest = destination_node.origin;
  self moveTo(dest, time, time / 3, time / 3);
}

function function_319c2f097ede51e0(targetname, entities, shot, time_fraction) {
  animnode = getStruct(targetname, "targetname");
  animnode scene::play(entities, shot, undefined, time_fraction);
}

function function_57ac36ea7abb5af4(targetname, entities, shots, time_fraction) {
  if(isDefined(targetname)) {
    function_319c2f097ede51e0(targetname, entities, shots, time_fraction);
  } else {
    scene::play(entities, shots, undefined, time_fraction);
  }

  self notify("scene_complete");
}

function function_54376d79bb3d20f5(targetname, entities, shots, time_fraction) {
  if(isDefined(targetname)) {
    function_319c2f097ede51e0(targetname, entities, shots, time_fraction);
  } else {
    scene::play(entities, shots, undefined, time_fraction);
  }

  self notify("scene_secondary_complete");
}

function function_96cef8a436875213(targetname, entities) {
  if(isDefined(targetname)) {
    animnode = getStruct(targetname, "targetname");
  } else {
    animnode = self;
  }

  animnode function_57ac36ea7abb5af4(undefined, entities, "enter");
  animnode thread scene::play(entities, "loop");
}

function function_9aef32121efc580c() {
  if(false) {
    nvg_on = 0;

    while(true) {
      if(scripts\sp\nvg\nvg_player::is_nvg_on() && !nvg_on) {
        hudoutline_enable_new("jup_teammate_outline_nodistance", "default");
        nvg_on = 1;
      } else if(!isalive(self)) {
        hudoutline_disable("default");
        return;
      } else if(!scripts\sp\nvg\nvg_player::is_nvg_on() && nvg_on) {
        hudoutline_disable("default");
        nvg_on = 0;
      }

      waitframe();
    }
  }
}

function function_ccdf2af631e1d150() {
  if(false) {
    nvg_on = 0;

    while(true) {
      if(scripts\sp\nvg\nvg_player::is_nvg_on() && !nvg_on) {
        hudoutline_enable_new("jup_teammate_outline_nodistance", "default");
        nvg_on = 1;
      } else if(!scripts\sp\nvg\nvg_player::is_nvg_on() && nvg_on) {
        hudoutline_disable("default");
        nvg_on = 0;
      }

      waitframe();
    }
  }
}

function force_nvg(bool) {
  if(!is_equal(self.subclass, "regular")) {
    return;
  }

  self.visor_down = bool;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

function function_788f9abb20866779(ally_name, enable) {
  anim_alias = "helmet_visor_up_" + ally_name + "_instant";
  anim_name = scripts\asm\asm::asm_lookupanimfromaliasifexists("visor", anim_alias);

  if(isDefined(anim_name)) {
    var_14b3e98067f53c6e = asm_getxanim("visor", anim_name);

    if(isDefined(enable) && !enable) {
      self setanim(var_14b3e98067f53c6e, 1, 0, 1, 1);
      return;
    }

    self clearanim(var_14b3e98067f53c6e, 0);
  }
}

function function_37f2a21dd7f9971(enable) {
  level.ally1 function_788f9abb20866779("ivan", enable);

  if(isDefined(level.ally2)) {
    level.ally2 function_788f9abb20866779("rook", enable);
  }
}

function function_1308ec055ee61e28(cleanup_flag, var_2a5c5a253bd02908) {
  self endon("death");
  flag_wait(cleanup_flag);

  if(!is_dead_or_dying(self)) {
    self.nocorpse = 1;
    self.diequietly = 1;
    self notify("cleanup_flashlight");
    waitframe();

    if(isDefined(var_2a5c5a253bd02908)) {
      self kill(self.origin, var_2a5c5a253bd02908);
    } else {
      self kill();
    }

    waitframe();
    self delete();
  }
}

function function_672fd16c1e8480a4(very_low) {
  if(isDefined(very_low) && very_low) {
    self.health = 5;
    return;
  }

  self.health = 70;
}

function function_71ff564120e02eaa() {
  level.var_3852605ad0bf6b77 = [];
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_01";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_01_a";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_01_b";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_02";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_02_a";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_02_b";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_03";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_03_a";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_04";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_04_a";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_04_b";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_05";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_05_a";
  level.var_3852605ad0bf6b77[level.var_3852605ad0bf6b77.size] = "body_c_jup_sp_civ_prisoner_05_b";
  level.var_596ecec8e5f43705 = [];
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_vozhyuk";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_mrehin_beard";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "c_jup_head_sc_m_rosas";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_krotky";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_ahmadzai";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "c_jup_head_sc_m_bansal_beard";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_orlovszki_civ_tattoo";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "c_jup_head_sc_m_dunn_bg";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_savage";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "c_jup_head_sc_m_alexander";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_utnehmer";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_ferragamo";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_arakelyan";
  level.var_596ecec8e5f43705[level.var_596ecec8e5f43705.size] = "head_sc_m_vasquez";
  level.var_de927b7f1e2c83e1 = [];
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_01_b_riot";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_01";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_02_b_riot";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_02";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_03_b";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_03_b_riot";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_04_b_riot";
  level.var_de927b7f1e2c83e1[level.var_de927b7f1e2c83e1.size] = "body_c_jup_sp_civ_prisoner_05_b_riot";
  level.var_ddb31f09110a37df = [];
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "c_jup_head_sc_m_rosas";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_sc_m_vozhyuk_damage";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "c_jup_head_sc_m_bansal_beard";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_c_jup_sp_civ_prisoner_02";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_sc_m_sharipov";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_sc_m_sharipov";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_sc_m_utnehmer";
  level.var_ddb31f09110a37df[level.var_ddb31f09110a37df.size] = "head_sc_m_vasquez";
  level.var_ba03829002b63c46 = [];
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_01";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_01";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_02";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_02";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_04";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_04";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_06";
  level.var_ba03829002b63c46[level.var_ba03829002b63c46.size] = "body_c_jup_sp_civ_guard_06";
  level.var_ce03247bd9a9922c = [];
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_colvin";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_vasquez";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_yurteri";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_montano";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_savage";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_valladares";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_johnson";
  level.var_ce03247bd9a9922c[level.var_ce03247bd9a9922c.size] = "head_sc_m_sharipov";
  level.var_e1bc81c592a4e891 = [];
  level.var_e1bc81c592a4e891[level.var_e1bc81c592a4e891.size] = "body_c_jup_sp_civ_guard_03";
  level.var_e1bc81c592a4e891[level.var_e1bc81c592a4e891.size] = "body_c_jup_sp_civ_guard_03";
  level.var_3e0b054cda57aa2f = [];
  level.var_3e0b054cda57aa2f[level.var_3e0b054cda57aa2f.size] = "head_sc_m_alameer";
  level.var_3e0b054cda57aa2f[level.var_3e0b054cda57aa2f.size] = "head_sc_m_androsov";
  level.var_d64eb697f739aa19 = [];
  level.var_d64eb697f739aa19[level.var_d64eb697f739aa19.size] = "body_c_jup_sp_civ_guard_05";
  level.var_d64eb697f739aa19[level.var_d64eb697f739aa19.size] = "body_c_jup_sp_civ_guard_05";
  level.var_cdc2d8ada06975e7 = [];
  level.var_cdc2d8ada06975e7[level.var_cdc2d8ada06975e7.size] = "head_sc_m_kamalov_bald";
  level.var_cdc2d8ada06975e7[level.var_cdc2d8ada06975e7.size] = "head_sc_m_kargorgis_civ";
}

function function_9dbe83b3e459b76e(arrayindex) {
  if(!isDefined(arrayindex)) {
    arrayindex = randomintrange(0, level.var_ba03829002b63c46.size - 1);
  }

  var_44a0133272fb77ad = level.var_ba03829002b63c46[arrayindex];
  headmodel = level.var_ce03247bd9a9922c[arrayindex];
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);
}

function function_f46be527a8306552(var_f10bfdad5e18a115, var_3126c68476c00843, var_651d4d77c8dbbc44, var_d9c5a35b5f3e886b) {
  if(!flag("flag_ivan_nags_playing") && !flag(var_f10bfdad5e18a115)) {
    flag_set("flag_ivan_nags_playing");

    if(!isDefined(level.var_8ddb42a51c8872f7)) {
      level.var_8ddb42a51c8872f7 = ["dx_sp_jvip_fona_koa1_thisway21keepittight", "dx_sp_jvip_fona_koa1_onme", "dx_sp_jvip_fona_koa1_overhere", "dx_sp_jvip_fona_koa1_letsgo21", "dx_sp_jvip_fona_koa1_thisway", "dx_sp_jvip_fona_koa1_tightenuponme21", "dx_sp_jvip_fona_koa1_stayclose21", "dx_sp_jvip_fona_koa1_stickwithus21", "dx_sp_jvip_fona_koa1_bringitin21"];
    }

    if(!isDefined(level.var_1da7a7335c612f94)) {
      level.var_1da7a7335c612f94 = 0;
    }

    if(!isDefined(var_f10bfdad5e18a115)) {
      var_f10bfdad5e18a115 = "no_custom_flag";
    }

    if(!isDefined(var_3126c68476c00843)) {
      var_3126c68476c00843 = 10;
    }

    if(!isDefined(var_651d4d77c8dbbc44)) {
      var_651d4d77c8dbbc44 = 0;
    }

    if(!isDefined(var_d9c5a35b5f3e886b)) {
      var_d9c5a35b5f3e886b = 1;
    }

    var_300f0fc5e7589121 = 0;

    while(!flag(var_f10bfdad5e18a115) && !flag("flag_stop_ivan_nags")) {
      if(isDefined(level.ally1) && !is_dead_or_dying(level.ally1)) {
        level.ally1 dialogue::say(level.var_8ddb42a51c8872f7[level.var_1da7a7335c612f94]);
        var_300f0fc5e7589121++;
      }

      if(var_651d4d77c8dbbc44 && var_300f0fc5e7589121 == var_d9c5a35b5f3e886b) {
        var_82ffca40e5e330bb = [var_f10bfdad5e18a115, "flag_stop_ivan_nags"];
        display_hint("focus_hint", undefined, 0, level, var_82ffca40e5e330bb);
      }

      level.var_1da7a7335c612f94++;

      if(level.var_1da7a7335c612f94 == level.var_8ddb42a51c8872f7.size) {
        level.var_1da7a7335c612f94 = 0;
      }

      wait var_3126c68476c00843;
    }

    flag_clear("flag_ivan_nags_playing");
    flag_clear("flag_stop_ivan_nags");
  }
}

function stop_ivan_nags() {
  flag_set("flag_stop_ivan_nags");
}

function function_490f29409c2f4249(arrayindex) {
  if(!isDefined(arrayindex)) {
    arrayindex = randomintrange(0, level.var_e1bc81c592a4e891.size - 1);
  }

  var_44a0133272fb77ad = level.var_e1bc81c592a4e891[arrayindex];
  headmodel = level.var_3e0b054cda57aa2f[arrayindex];
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);
}

function function_b354ba9eb6a72549(arrayindex) {
  if(!isDefined(arrayindex)) {
    arrayindex = randomintrange(0, level.var_d64eb697f739aa19.size - 1);
  }

  var_44a0133272fb77ad = level.var_d64eb697f739aa19[arrayindex];
  headmodel = level.var_cdc2d8ada06975e7[arrayindex];
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);
}

function function_84972f5da4b3994b(arrayindex) {
  if(!isDefined(arrayindex)) {
    arrayindex = randomintrange(0, level.var_3852605ad0bf6b77.size - 1);
  }

  var_44a0133272fb77ad = level.var_3852605ad0bf6b77[arrayindex];
  headmodel = level.var_596ecec8e5f43705[arrayindex];
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);
}

function function_dfec397a9c5e2aab(arrayindex) {
  if(!isDefined(arrayindex)) {
    arrayindex = randomintrange(0, level.var_de927b7f1e2c83e1.size - 1);
  }

  var_44a0133272fb77ad = level.var_de927b7f1e2c83e1[arrayindex];
  headmodel = level.var_ddb31f09110a37df[arrayindex];
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);
}

function function_e3ef9d2f0513d055(position, fov, occlude) {
  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    waitframe();
  }
}

function function_238801b2923279cf(position, timeout, fov, occlude) {
  start_time = gettime();
  timeout *= 1000;

  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    if(timeout < gettime() - start_time) {
      return "timeout";
    }

    waitframe();
  }
}

function function_6342ec57ac648f0e(position, flag_name, fov, occlude) {
  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    if(flag(flag_name)) {
      return "flag_hit";
    }

    waitframe();
  }
}

function function_3c72aef86fe48dab(struct_name, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_e3ef9d2f0513d055(look_struct.origin, fov, occlude);
}

function function_777a76bee2b363ed(struct_name, timeout, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_238801b2923279cf(look_struct.origin, timeout, fov, occlude);
}

function function_c8431cc67f0b0824(struct_name, flag_name, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_6342ec57ac648f0e(look_struct.origin, flag_name, fov, occlude);
}

function function_e7c30095a6cdc3ef(position, fov, occlude) {
  if(!isDefined(level.player)) {
    return false;
  }

  if(!isDefined(fov)) {
    fov = getdvarint(@ "cg_fov");
  }

  if(!isDefined(occlude)) {
    occlude = 0;
  }

  in_fov = within_fov(level.player getEye(), level.player getplayerangles(), position, cos(fov));

  if(!in_fov) {
    return false;
  }

  if(!occlude) {
    return true;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(level.player getEye(), position, contents, undefined, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function function_4d3ad1d021710127(ai_array, goal_remaining, timeout) {
  assertex(isDefined(ai_array), "waittill_guys_remaining() called with undefined array");
  assertex(isDefined(goal_remaining), "waittill_guys_remaining() called with undefined goal_remaining");

  if(!isarray(ai_array)) {
    ai_array = [ai_array];
  }

  if(isDefined(timeout)) {
    start_time = gettime();
    timeout *= 1000;
  }

  while(true) {
    ai_array = array_removedead_or_dying(ai_array);

    if(ai_array.size <= goal_remaining) {
      return "goal_hit";
    }

    if(isDefined(timeout)) {
      if(timeout < gettime() - start_time) {
        return "timeout";
      }
    }

    waitframe();
  }
}

function function_b6000b715fed87e(ai_array, var_acba072b7e847a86) {
  function_4d3ad1d021710127(ai_array, 0);
  flag_set(var_acba072b7e847a86);
}

function function_111864c6ca2941be(array) {
  winner = undefined;
  var_40f23b9028e5d292 = -1;

  foreach(thing in array) {
    normal = vectorNormalize(thing.origin - level.player getEye());
    forward = anglesToForward(level.player getplayerangles());
    thing.dot = vectordot(forward, normal);

    if(thing.dot > var_40f23b9028e5d292) {
      var_40f23b9028e5d292 = thing.dot;
      winner = thing;
    }
  }

  return winner;
}

function function_5353f2029567d563(force_multiplier) {
  self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);

  if(isDefined(weapon) && weapon.classname == "grenade") {
    return;
  }

  if(tagname == "") {
    tagname = "head";
  }

  if(!isDefined(force_multiplier)) {
    force_multiplier = 3000;
  }

  self startragdollfromimpact(tagname, direction_vec * force_multiplier);
}

function function_e39d8a96b86719ce(var_fe02714fa9a00b24) {
  waitframe();

  if(var_fe02714fa9a00b24) {
    setsaveddvar(@ "hash_34925f75ae82f807", 1);
    transient_unload("sp_jup_vip_water_vista_tr");
    return;
  }

  setsaveddvar(@ "hash_34925f75ae82f807", 0);
  transient_load("sp_jup_vip_water_vista_tr");
}

function function_fcdbed0749727cd7() {
  door_interacts = getStructArray("fake_door", "targetname");

  foreach(node in door_interacts) {
    node thread function_7efbdca4273730db();
  }
}

function function_7efbdca4273730db() {
  self endon("remove_door_hint");
  hint_text = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
  locked_text = &"SCRIPT/DOOR_HINT_LOCKED";
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), hint_text, 45, 100, 55, 1);

  while(true) {
    self.cursor_hint_ent waittill("trigger");
    thread play_sound_in_space("scrpt_door_metal_open_locked", self.cursor_hint_ent.origin);
    level.player playRumbleOnEntity("damage_heavy");
    earthquake(0.17, 0.2, level.player.origin, 200);
    hint_text = locked_text;
    waitframe();
    scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), hint_text, 45, 100, 55, 1);
  }
}

function function_ec55b3dd58f10e7b() {
  self notify("remove_door_hint");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function say_flag(lineid, flag) {
  flag_wait(flag);
  say(lineid);
}

function function_94d47ea467072bfd() {
  level.var_184b0ed89d5601ec = create_deck(["prisoner_win04", "prisoner_win05"], 1, 1);
  level.var_542472f2a9fa3625 = create_deck(["guard_win02", "guard_win03"], 1, 1);
}

function function_d3a80fb8ce54bcb1(var_5de23c74ce01cca0, var_aa9670ac97d5dc8c, var_f914c1073d56aa25, var_9d6cf1d7e723c067) {
  animnode = self;

  if(istrue(var_5de23c74ce01cca0)) {
    animnode thread function_cb26b55010d72414(1);
    animnode thread function_f0d69a4d0144da57(animnode);
  } else {
    animnode thread play(undefined, "clinch_01");
    animnode thread function_cb26b55010d72414();
  }

  guard = animnode get_entity("guard");
  prisoner = animnode get_entity("prisoner");
  guard thread function_b2e35c0f7c362319(animnode, prisoner);
  prisoner thread function_ae737bfc2182fcfc(animnode, guard);

  if(isDefined(var_9d6cf1d7e723c067)) {
    guard childthread function_5328ef691ed507ad(prisoner, var_9d6cf1d7e723c067);
  }

  msg = waittill_any_ents_return(guard, "struggle_end_guard_win", prisoner, "struggle_end_prisoner_win");

  if(isDefined(var_f914c1073d56aa25) && msg == "struggle_end_guard_win") {
    guard[[var_f914c1073d56aa25]]();
    return;
  }

  if(isDefined(var_aa9670ac97d5dc8c) && msg == "struggle_end_prisoner_win") {
    prisoner thread[[var_aa9670ac97d5dc8c]]();
    wait 0.25;
    line_num = randomintrange(0, 2);

    if(line_num == 0) {
      prisoner say("dx_sp_jvip_copr_pri1_letsgoletsgo");
    }

    if(line_num == 1) {
      prisoner say("dx_sp_jvip_copr_pri2_werealmostfree");
    }
  }
}

function function_cb26b55010d72414(wait_frame) {
  if(istrue(wait_frame)) {
    waitframe();
  }

  guard = get_entity("guard");
  prisoner = get_entity("prisoner");
  actors = [guard, prisoner];

  foreach(guy in actors) {
    guy set_ignoreall(1);
    guy set_ignoreme(1);
    guy.script_longdeath = 0;
    guy context_melee_allow(0);
  }
}

function function_f0d69a4d0144da57(animnode) {
  animnode endon("struggle_clinch_end");
  animnode play(undefined, "enter");
  animnode thread play(undefined, "clinch_01");
}

function function_5328ef691ed507ad(prisoner, var_9d6cf1d7e723c067) {
  self endon("death");
  wait var_9d6cf1d7e723c067;

  if(isalive(prisoner)) {
    prisoner notify("damage");
  }
}

function function_b2e35c0f7c362319(animnode, prisoner) {
  self endon("struggle_end_guard_win");
  self waittill("damage");
  prisoner notify("struggle_win");
  animnode notify("struggle_clinch_end");
  prisoner thread function_341b10c0586ec480(animnode);
  var_33cad1fb06a32118 = level.var_184b0ed89d5601ec deck_draw();
  animnode play([self, prisoner], var_33cad1fb06a32118, "vip_1600_tower_redirect_rioters_clinch");
  prisoner notify("struggle_end_prisoner_win");
  prisoner set_ignoreall(0);
  prisoner set_ignoreme(0);
  prisoner context_melee_allow(1);

  if(isalive(self)) {
    iprintln("<dev string:x59>");

    self kill();
    return;
  }

  iprintln("<dev string:x64>");
}

function function_ae737bfc2182fcfc(animnode, guard) {
  self endon("struggle_end_prisoner_win");
  self waittill("damage");
  guard notify("struggle_win");
  animnode notify("struggle_clinch_end");
  guard thread function_341b10c0586ec480(animnode);
  var_33cad1fb06a32118 = level.var_542472f2a9fa3625 deck_draw();
  animnode play([self, guard], var_33cad1fb06a32118, "vip_1600_tower_redirect_rioters_clinch");
  guard notify("struggle_end_guard_win");
  guard set_ignoreall(0);
  guard set_ignoreme(0);
  guard context_melee_allow(1);

  if(isalive(self)) {
    iprintln("<dev string:x77>");

    self kill();
    return;
  }

  iprintln("<dev string:x85>");
}

function function_341b10c0586ec480(animnode) {
  self endon("struggle_end_guard_win");
  self endon("struggle_end_prisoner_win");
  self waittill("damage");
  animnode stop();

  if(isalive(self)) {
    self kill();
  }
}

function function_a533d8921f706b7e() {
  level.var_d4220219147ccddf = 0;
  level.var_d3dbdbe395cbe8e8 = ["dx_sp_jvip_desc_koa1_watchyourshots21dead", "dx_sp_jvip_desc_koa1_avoidtheprisoners21w", "dx_sp_jvip_desc_koa1_checkyourshots21dead", "dx_sp_jvip_desc_koa1_avoidtheprisoners21", "dx_sp_jvip_prkn_koa1_donthelptheguardssto", "dx_sp_jvip_prkn_koa1_checkyourfireprisone", "dx_sp_jvip_prkf_koa1_prisonerscantriotift", "dx_sp_jvip_prkf_koa1_21weneededthosepriso"];
  level.var_f4871eb35c524cb8 = ["dx_sp_jvip_desc_koa1_watchyourshots21dead_court", "dx_sp_jvip_desc_koa1_avoidtheprisoners21w_court", "dx_sp_jvip_desc_koa1_checkyourshots21dead_cout", "dx_sp_jvip_desc_koa1_avoidtheprisoners21_court", "dx_sp_jvip_prkn_koa1_donthelptheguardssto_court", "dx_sp_jvip_prkn_koa1_checkyourfireprisone_court", "dx_sp_jvip_prkf_koa1_prisonerscantriotift_court", "dx_sp_jvip_prkf_koa1_21weneededthosepriso_court"];
  level.var_9dff23bf262397b6 = 0;
  level.var_3ad32ba7bd551725 = ["dx_sp_jvip_prkn_maka_aimfortheguardsnotth", "dx_sp_jvip_prkn_maka_shootguardsnotthepri", "dx_sp_jvip_prkn_maka_lettheguardsfightthe", "dx_sp_jvip_prkf_maka_theinmatesareshields", "dx_sp_jvip_prkf_maka_leavetheinmatestothe"];
  level.var_297634727a5837e1 = ["dx_sp_jvip_prkn_maka_aimfortheguardsnotth_court", "dx_sp_jvip_prkn_maka_shootguardsnotthepri_court", "dx_sp_jvip_prkn_maka_lettheguardsfightthe_court", "dx_sp_jvip_prkf_maka_theinmatesareshields_court", "dx_sp_jvip_prkf_maka_leavetheinmatestothe_court"];

  while(!flag("flag_escape_cliff_start")) {
    vo_played = 0;
    flag_wait_any("prisoner_damaged_by_player_vo", "flag_escape_cliff_start");

    if(!flag("flag_makarov_pcap") && !flag("flag_escape_cliff_start")) {
      if(!flag("flag_end_descend")) {
        function_64f815da552ce8c6();

        if(!flag("flag_makarov_pcap")) {
          level.player.vo_handler dialogue::say(level.var_d3dbdbe395cbe8e8[level.var_d4220219147ccddf], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        } else {
          level.player.vo_handler dialogue::say(level.var_f4871eb35c524cb8[level.var_d4220219147ccddf], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        }
      } else if(isDefined(level.ally1)) {
        if(!flag("flag_makarov_pcap")) {
          level.ally1 dialogue::say(level.var_d3dbdbe395cbe8e8[level.var_d4220219147ccddf], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        } else {
          level.ally1 dialogue::say(level.var_297634727a5837e1[level.var_d4220219147ccddf], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        }
      }

      if(vo_played) {
        level.var_d4220219147ccddf++;

        if(level.var_d4220219147ccddf == level.var_d3dbdbe395cbe8e8.size) {
          level.var_d4220219147ccddf = 0;
        }
      }
    } else if(!flag("flag_escape_cliff_start")) {
      if(isDefined(level.makarov) && distance(level.makarov.origin, level.player.origin) < 800) {
        if(!flag("flag_makarov_pcap")) {
          level.makarov dialogue::say(level.var_3ad32ba7bd551725[level.var_9dff23bf262397b6], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        } else {
          level.makarov dialogue::say(level.var_297634727a5837e1[level.var_9dff23bf262397b6], undefined, undefined, undefined, 0.5);
          vo_played = 1;
        }

        level.var_9dff23bf262397b6++;

        if(level.var_9dff23bf262397b6 == level.var_3ad32ba7bd551725.size) {
          level.var_9dff23bf262397b6 = 0;
        }
      }
    }

    if(vo_played == 1 && !flag("flag_escape_cliff_start")) {
      wait 5;
    } else {
      waitframe();
    }

    flag_clear("prisoner_damaged_by_player_vo");
  }
}

function function_c6aecb595687f644() {
  level.var_38f3c31c69574f65 = 0;
  level.var_ceac822077495f9a = ["dx_sp_jvip_desc_koa1_checkyourtargets21", "dx_sp_jvip_prkn_koa1_saveyourammoforthegu"];
  level.var_483c6337d74e743a = ["dx_sp_jvip_desc_koa1_checkyourtargets21_court", "dx_sp_jvip_prkn_koa1_saveyourammoforthegu_court"];
  level.var_c9b7f7aa5ec2f26b = "dx_sp_jvip_prkf_maka_alphasaveyourbullets";
  level.var_8798099606f1fcaf = "dx_sp_jvip_prkf_maka_alphasaveyourbullets_court";
  var_ffa5f1e5cf6c9be8 = 0;

  while(!flag("flag_escape_cliff_slide_start")) {
    vo_played = 0;
    flag_wait("ally_damaged_by_player_vo");

    if(flag("flag_start_descend") && !flag("flag_end_descend")) {
      function_64f815da552ce8c6();

      if(!flag("flag_makarov_pcap")) {
        level.player.vo_handler dialogue::say(level.var_ceac822077495f9a[level.var_38f3c31c69574f65], undefined, undefined, undefined, 0.5);
        vo_played = 1;
      } else {
        level.player.vo_handler dialogue::say(level.var_483c6337d74e743a[level.var_38f3c31c69574f65], undefined, undefined, undefined, 0.5);
        vo_played = 1;
      }
    } else if(isDefined(level.makarov) && level.var_13136fd98a2e35a0 == level.makarov && var_ffa5f1e5cf6c9be8 == 0) {
      if(!flag("flag_makarov_pcap")) {
        level.makarov dialogue::say(level.var_c9b7f7aa5ec2f26b, undefined, undefined, undefined, 0.5);
        var_ffa5f1e5cf6c9be8 = 1;
      } else {
        level.makarov dialogue::say(level.var_8798099606f1fcaf, undefined, undefined, undefined, 0.5);
        var_ffa5f1e5cf6c9be8 = 1;
      }
    } else if(isDefined(level.ally1)) {
      if(!flag("flag_makarov_pcap")) {
        level.ally1 dialogue::say(level.var_ceac822077495f9a[level.var_38f3c31c69574f65], undefined, undefined, undefined, 0.5);
        vo_played = 1;
      } else {
        level.ally1 dialogue::say(level.var_483c6337d74e743a[level.var_38f3c31c69574f65], undefined, undefined, undefined, 0.5);
        vo_played = 1;
      }
    }

    if(vo_played) {
      level.var_38f3c31c69574f65++;

      if(level.var_38f3c31c69574f65 == level.var_ceac822077495f9a.size) {
        level.var_38f3c31c69574f65 = 0;
        var_ffa5f1e5cf6c9be8 = 0;
        vo_played = 1;
      }
    }

    if(vo_played || var_ffa5f1e5cf6c9be8) {
      wait 5;
    } else {
      waitframe();
    }

    flag_clear("ally_damaged_by_player_vo");
  }
}

function function_d799ec6e01836246(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  self endon("death");

  if(isPlayer(attacker)) {
    flag_set("prisoner_damaged_by_player_vo");
  }
}

function function_568c4909ef587d84(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  self endon("death");

  if(isPlayer(attacker)) {
    level.var_13136fd98a2e35a0 = self;
    flag_set("ally_damaged_by_player_vo");
  }
}

function function_64f815da552ce8c6() {
  if(!isDefined(level.player.vo_handler)) {
    level.player.vo_handler = utility::spawn_tag_origin(level.player.origin + (0, 0, 50), level.player.angles);
    level.player.vo_handler linkTo(level.player, "tag_origin", (0, 0, 100), (0, 0, 0));
  }
}

function function_e4f5a41bcb8bcb9d(var_180cb793b82152b4) {
  function_727515dc377769f3();
  thread function_b5bbe8dd5352a58a(var_180cb793b82152b4);
}

function function_727515dc377769f3() {
  if(flag_exist("autosave_tactical_player_nade")) {
    return;
  }

  flag_init("autosave_tactical_player_nade");
  level.autosave_tactical_player_nades = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  notifyoncommand("autosave_player_nade", "+semtex");
  utility_code::array_thread(level.players, &utility_code::autosave_tactical_grenade_check);
}

function function_b5bbe8dd5352a58a(var_180cb793b82152b4) {
  if(!isDefined(var_180cb793b82152b4)) {
    var_180cb793b82152b4 = 1;
  }

  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread notify_delay("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");

  if(flag("autosave_tactical_player_nade") || isDefined(level.player) && !level.player scripts\sp\autosave::function_58929539ece45ce1()) {
    flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);

    if(flag("autosave_tactical_player_nade") || isDefined(level.player) && !level.player scripts\sp\autosave::function_58929539ece45ce1()) {
      return;
    }
  }

  if(var_180cb793b82152b4) {
    enemies = getaiarray("axis");

    foreach(ai in enemies) {
      if(isDefined(ai.enemy) && isPlayer(ai.enemy) && !is_dead_or_dying(ai)) {
        return;
      }
    }
  }

  waittillframeend();
  thread autosave_now();
}

function function_7b2743af8410b08e() {
  wait 0.1;

  while(level.player isgestureplaying("ges_equip_nvg_puton")) {
    wait 0.1;
  }

  if(level.player isnightvisionon()) {
    level.player forceplaygestureviewmodel("ges_equip_nvg_takeoff");
    wait 0.2;

    while(level.player isgestureplaying("ges_equip_nvg_takeoff")) {
      wait 0.1;
    }
  }
}
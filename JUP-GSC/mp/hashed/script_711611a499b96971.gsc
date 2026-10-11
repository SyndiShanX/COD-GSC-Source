/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_711611a499b96971.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_18b61963cd1351ff;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_5753ba9c28794a65;
#using script_711820027508efbb;
#using script_7534b1d3ac3ea47a;
#using script_c6b9e8fb3a7de37;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\overlord;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace namespace_d77ab1c376d32e80;

function function_f7dcc50fd890c4d4() {
  function_89384091f7a2dbd("REV_OB_OUTLAST", 1, &function_dba0cc251fb7cd02);
  activityinstance = function_ebcfa8f0cbb5cbf1("OUTLAST_S2_5_MISSION_STADIUM");
  level.var_8f8084aa1811db12 = activityinstance;
  level thread function_53effb858b61823f();

  level thread function_cb2f75bbe6599394();
  level thread function_d06fc6bbaa45084();

  var_188701075f250315 = getStruct("stadium_pnd_location", "targetname");
  level.var_9c8d4369104706aa = spawn("script_model", var_188701075f250315.origin);
  level.var_9c8d4369104706aa.angles = var_188701075f250315.angles;
  level.var_9c8d4369104706aa setModel("jup_zm_pnd_device");
}

function function_53effb858b61823f() {
  level flag_wait("ai_spawn_director_initialized");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.var_e80226cc1c193b74 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("ob_s2_mission_stadium_boss_minions");

  if(!isDefined(level.var_e80226cc1c193b74)) {
    assert(0, "<dev string:x1c>");
    return;
  }

  scripts\cp_mp\agents\ai_spawn_director::function_bc5315dc37ae4cf(level.var_e80226cc1c193b74, &function_b3ceb7ebcb62e545);
  scripts\cp_mp\agents\ai_spawn_director::function_73147cdf5c28d10c(level.var_e80226cc1c193b74, &function_2ba3cd314ed965b8);
  function_fc38783a3da0bc71(level.var_e80226cc1c193b74, 1);
}

function function_b3ceb7ebcb62e545(requestid, userdata) {
  return istrue(level.var_45cbd577bdeb831b);
}

function function_2ba3cd314ed965b8(requestid, userdata) {
  return istrue(level.var_81cafec2c7b77aae);
}

function function_651b9e0cef8d1607() {
  if(!isDefined(level.var_8f8084aa1811db12)) {
    assert(isDefined(level.var_8f8084aa1811db12), "<dev string:x6d>");
    return;
  }

  level.var_9c8d4369104706aa delete();
  level.var_8f8084aa1811db12.var_6769b69c3916c8ed = 1;
  level.var_8f8084aa1811db12.var_6859ba01d375e401 = "QUEST_0_RIFT_S2_OUTLAST_ANALYSIS_PHASE";
  function_bbdcd857d0c2a65e(level.var_8f8084aa1811db12, level.players, "PlayerJoinedOther");
}

function function_cf50cdab18d075b0() {
  level endon("game_ended");
  activityinstance = function_ebcfa8f0cbb5cbf1("OUTLAST_S2_5_MISSION_STADIUM");

  if(!isDefined(activityinstance)) {
    return;
  }

  var_162a9e291756bf56 = activityinstance namespace_edd624734aa27359::function_2a735aa87f0f3b58();
  var_7e07db231d8b4432 = 0;
  var_d6a662ec5bbb9222 = 0;

  while(true) {
    if(isDefined(activityinstance.analysis_progress)) {
      var_9ff6c0226128aee5 = activityinstance.analysis_progress / var_162a9e291756bf56 * 100;

      if(var_9ff6c0226128aee5 < 25 && var_d6a662ec5bbb9222 == 0) {
        namespace_e82bfd865c02eb4b::goto_stage();
        level.var_59a5ab1b4256bb79.vo_ent playsoundonmovingent("dx_ob_st25_stry_rvnv_sty25stmjockrockchgstrt1");
        wait 0.5;
        scripts\cp_mp\overlord::playevent("s2_charging_rock_start", level.players);
        var_d6a662ec5bbb9222 += 1;
      } else if(var_9ff6c0226128aee5 > 25 && var_d6a662ec5bbb9222 == 1) {
        level.var_59a5ab1b4256bb79.vo_ent playsoundonmovingent("dx_ob_st25_stry_acve_sty25stmjockrockchg25");
        var_d6a662ec5bbb9222 += 1;
      } else if(var_9ff6c0226128aee5 > 50 && var_d6a662ec5bbb9222 == 2) {
        level.var_59a5ab1b4256bb79.vo_ent playsoundonmovingent("dx_ob_st25_stry_acve_sty25stmjockrockchg50");
        var_d6a662ec5bbb9222 += 1;
      } else if(var_9ff6c0226128aee5 > 75 && var_d6a662ec5bbb9222 == 3) {
        level.var_59a5ab1b4256bb79.vo_ent playsoundonmovingent("dx_ob_st25_stry_acve_sty25stmjockrockchg75");
        var_d6a662ec5bbb9222 += 1;
      }

      if(var_9ff6c0226128aee5 > 99) {
        activityinstance.analysis_progress = var_162a9e291756bf56 * 0.99;

        if(!istrue(var_7e07db231d8b4432)) {
          level.var_59a5ab1b4256bb79 thread function_3d552e74ee7e3dee(activityinstance);
          var_7e07db231d8b4432 = 1;
        }
      }
    }

    waitframe();
  }
}

function function_3d552e74ee7e3dee(activityinstance) {
  level.var_c831131ad79495ea setscriptablepartstate("body", "orb_laser");
  playsoundatpos(level.var_59a5ab1b4256bb79.origin, "dx_ob_st25_stry_acve_sty25stmjockrockchg100");
  wait 1.5;
  self.crystal = activityinstance.pnd_device;
  pnd_location = activityinstance.pnd_device.origin;
  thread function_47b4ba0d70f54cee();
  wait 2;
  activityinstance namespace_edd624734aa27359::function_465ff95e69b7340();
  wait 0.5;
  var_3c41e488c621880d = getaiarrayinradius(pnd_location, 1500);

  foreach(zombie in var_3c41e488c621880d) {
    if(isalive(zombie) && zombie.team != level.players[0].team) {
      zombie kill();
      corpse = zombie getcorpseentity();

      if(isDefined(corpse)) {
        var_a33d2a2c3ffecb81 = corpse.origin - pnd_location + (0, 0, 60);
        var_83fd98f3ac829176 = max(500 - distance2d(corpse.origin, pnd_location), 0) / 4;
        corpse startragdollfromimpact("torso_upper", var_a33d2a2c3ffecb81 * var_83fd98f3ac829176);
      }
    }
  }

  level.var_c831131ad79495ea setscriptablepartstate("body", "orb_idle");
  function_606642b946a01237("ambient_blocker_stadium_outlast_complete", activityinstance.pnd_device.origin, 1000, 1);
  self notify("cleansed");
  function_2497b358c23801f1();
  activityinstance namespace_34bf641998024ddb::function_b2d0fc97b77a18ab();
  endactivity(activityinstance, 0);
  waitframe();
  level thread namespace_68270f885c7fd3ef::spawn_portal();
  wait 3;
  level thread namespace_e82bfd865c02eb4b::betrayal();
}

function private function_47b4ba0d70f54cee() {
  self endon("cleansed");
  self endon("death");
  v_start = self gettagorigin("tag_fx_beam");
  v_angles = self gettagangles("tag_fx_beam");
  self setscriptablepartstate("maw", "beam_begin");

  if(isDefined(self.crystal)) {
    crystal = self.crystal;
    v_end = crystal.origin;
    self.ent_crystal = spawn("script_model", crystal.origin + (0, 0, 20));
    self.ent_crystal setModel("tag_origin");
    face_angles = vectortoangles(v_start - self.ent_crystal.origin);
    self.ent_crystal rotateTo(face_angles, 0.1);
    v_intersection = v_start + vectorNormalize(v_end - v_start) * 80;
    self.ent_beams = spawn("script_model", v_intersection);
    self.ent_beams setModel("tag_origin");
    self.ent_beams linkTo(self);
    waitframe();
    function_12b7811b08b56d63();
    self.var_5625eb112c7ab9e5 = playFXOnTag(getfx("escort_laser_glow_energy_point"), self.ent_beams, "tag_origin");
    wait 0.2;
    self.var_42e7c4e8d9aface2 = playfxontagsbetweenclients(getfx("escort_laser_ch"), self, "tag_fx_beam", self.ent_crystal, "tag_origin");

    if(isDefined(self.var_42e7c4e8d9aface2)) {
      self.var_42e7c4e8d9aface2 forcenetfieldhighlod(1);
    }

    self.var_67e3471db6796c74 = playFXOnTag(getfx("escort_laser_absorb"), self.ent_crystal, "tag_origin");

    while(true) {
      contents = scripts\engine\trace::create_character_contents();
      ignorelist = [];
      results = physics_spherecast(v_start, v_end, 20, contents, ignorelist, "physicsquery_all");

      foreach(cast in results) {
        ent = cast["entity"];

        if(isDefined(ent.team) && ent.team == "team_two_hundred") {
          if(9999 >= ent.health) {
            ent ent_flag_set("plasma_death");
          }

          ent dodamage(9999, self.origin, self, undefined, "MOD_ELEMENTAL_ELEC");
        }

        if(isPlayer(ent)) {
          ent dodamage(1, self.origin, self.markerattach, undefined, "MOD_ELEMENTAL_ELEC");
        }
      }

      sphere(self.ent_beams.origin, 20, (1, 0, 0), undefined, 1);

      wait 0.5;
    }
  }
}

function private function_2497b358c23801f1() {
  if(isDefined(self.var_42e7c4e8d9aface2)) {
    self.var_42e7c4e8d9aface2 delete();
  }

  if(isDefined(self.var_67e3471db6796c74)) {
    self.var_67e3471db6796c74 delete();
  }

  if(isDefined(self.var_5625eb112c7ab9e5)) {
    self.var_5625eb112c7ab9e5 delete();
  }

  stopFXOnTag(getfx("escort_laser_glow_energy_point"), self.ent_beams, "tag_origin");
  stopFXOnTag(getfx("escort_laser_absorb"), self.ent_crystal, "tag_origin");

  if(isDefined(self.small_beams)) {
    foreach(beam in self.small_beams) {
      if(isDefined(beam)) {
        beam delete();
      }
    }
  }
}

function private function_12b7811b08b56d63() {
  fx_tags = ["tag_fx_maw_laser_top", "tag_fx_maw_laser_bottom", "tag_fx_maw_laser_right", "tag_fx_maw_laser_left"];
  self.small_beams = [];

  foreach(fx_tag in fx_tags) {
    self.small_beams[self.small_beams.size] = playfxontagsbetweenclients(getfx("escort_laser_sm"), self, fx_tag, self.ent_beams, "tag_origin");
    self.small_beams[self.small_beams.size - 1] forcenetfieldhighlod(1);
  }
}

function function_dba0cc251fb7cd02() {
  self.difficulty_region = function_415547ee4122c2ca();
  self.on_mission = namespace_838b439602b3acc7::function_f578373042c34e16(17090, "quest_s0_a3t4_hold_start", self.playerparticipants);
  self.var_c3d4e3f8e48b7d3e = 0;

  if(!self.on_mission) {
    self.on_mission = namespace_838b439602b3acc7::function_f578373042c34e16(16822, "quest_s0a1t6_alab_outstart", self.playerparticipants);

    if(istrue(self.on_mission)) {
      self.var_c3d4e3f8e48b7d3e = 1;
    }
  }

  if(!self.var_c3d4e3f8e48b7d3e) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_outlast_start");
  }

  foreach(player in self.playerparticipants) {
    player scripts\common\callbacks::callback("on_outlast_start");
  }

  namespace_edd624734aa27359::function_f866d7d73436185e();
  thread namespace_edd624734aa27359::function_5db678d359c61a6f();
  function_318b48abdb777ed0();
  thread namespace_edd624734aa27359::function_888ea771ff731707();
  namespace_edd624734aa27359::function_bb8d279a3f7273c();
}

function function_318b48abdb777ed0() {
  var_a1edc937cb84ab35 = self.content_structs["pnd"][0];
  self.pnd_device = spawnscriptable("jup_ob_outlast_pnd_s2_5_mission", var_a1edc937cb84ab35.origin, var_a1edc937cb84ab35.angles);
  self.pnd_device setscriptablepartstate("body", "off");
  self.pnd_device.instance = self;
  namespace_29b5250e9959ea::function_3cec1b2981075936("jup_hacking_device_ob", self.pnd_device, &namespace_edd624734aa27359::pnd_activated);
}

function function_cb2f75bbe6599394() {
  while(true) {
    if(getdvarint(@ "hash_deda4c704fe042b5", 0) == 1) {
      activityinstance = function_ebcfa8f0cbb5cbf1("<dev string:xba>");
      level.var_8f8084aa1811db12 = activityinstance;

      if(isDefined(level.var_8f8084aa1811db12)) {
        function_651b9e0cef8d1607();
        level thread function_cf50cdab18d075b0();
      }

      setDvar(@ "hash_deda4c704fe042b5", 0);
    }

    waitframe();
  }
}

function function_d06fc6bbaa45084() {
  while(true) {
    if(getdvarint(@ "hash_9f06c86104770cc1", 0) == 1) {
      if(isDefined(level.var_59a5ab1b4256bb79)) {
        level.var_59a5ab1b4256bb79.origin = (-35732, -17266, 260);
        level.var_59a5ab1b4256bb79.angles = (0, 143, 0);
        level.var_59a5ab1b4256bb79 setscriptablepartstate("<dev string:xda>", "<dev string:xe1>");
        payload = spawn("<dev string:xed>", level.var_59a5ab1b4256bb79.origin + (0, 0, 31) + anglesToForward(level.var_59a5ab1b4256bb79.angles) * 47);
        payload.angles = level.var_59a5ab1b4256bb79.angles + (78, 0, 0);
        payload setModel("<dev string:xfd>");
        payload linkTo(level.var_59a5ab1b4256bb79);
      }

      setDvar(@ "hash_9f06c86104770cc1", 0);
    }

    waitframe();
  }
}

# /
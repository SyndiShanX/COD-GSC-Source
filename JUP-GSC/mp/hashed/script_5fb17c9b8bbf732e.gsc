/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5fb17c9b8bbf732e.gsc
*************************************************/

#using script_3b78d23dad7ec5be;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#namespace ob_launch_pad;

function private autoexec init() {
  callback::add("ob_content_process_create_script", &function_92b7e5b324465b68);
  callback::add("player_connect", &function_c917ac9167d1aec0);
  level._effect["crystal_impact"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/launch_pads/vfx_red_crystal_impact.vfx");
  level._effect["zombie_explosion"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_blast.vfx");
}

function function_92b7e5b324465b68(params) {
  setdvarifuninitialized(@ "hash_cb729b2d50151b5a", 0);
  setdvarifuninitialized(@ "hash_ef377c514d75b06f", 128);
  setdvarifuninitialized(@ "hash_cf4dacccd7acb0f6", 64);
  setdvarifuninitialized(@ "hash_163d35b2bfad5d11", 14);
  setdvarifuninitialized(@ "hash_393af4a8a9128536", 850);
  setdvarifuninitialized(@ "hash_b4e52282f217c0ae", 1000);
  setdvarifuninitialized(@ "hash_9025e7af6f59575d", 1);

  if(getdvarint(@ "hash_9025e7af6f59575d", 1)) {
    level.var_e75d27acd726fe9c = 1;
  } else {
    level.var_84956ead4b0ba962 = createentitytypemask(["etype_ai", "etype_vehicle", "etype_turret", "etype_scriptmover"]);
  }

  setdvarifuninitialized(@ "hash_a98666aab2a20f50", 1);
  setdvarifuninitialized(@ "hash_8c6980cc1eec0687", 750);
  setdvarifuninitialized(@ "hash_90a082c8af3ac59b", 1400);
  setdvarifuninitialized(@ "hash_82e34749b3f546a4", 1);
  setdvarifuninitialized(@ "hash_2e35fa4edb6c24ed", 0.15);
  setdvarifuninitialized(@ "hash_2e12e44edb45acd3", 1);
  setdvarifuninitialized(@ "hash_2770a0f3f75c755f", 1);
  setdvarifuninitialized(@ "hash_ce56b1cbc245ce62", 3);
  setdvarifuninitialized(@ "hash_d1b4357cefdb73fe", 3);
  setdvarifuninitialized(@ "hash_de3a12b335032b2f", 1024);
  level.var_cdec40a0d6ec935f = gettime();

  setdevdvarifuninitialized(@ "hash_be597103cc8aad5f", 0);
  setdevdvarifuninitialized(@ "hash_1ea16fecf27895e6", 0);
  setdevdvarifuninitialized(@ "hash_e6d0f35a459f1461", 0);
  level thread debug_init();

  flag_wait("scriptables_ready");
  var_e405301bcb385ef5 = getStructArray("launch_pad", "script_noteworthy");
  var_201462e035644875 = getnoentvolumearray("launch_pad", "script_noteworthy");
  var_a48e67061c191a79 = array_combine(var_e405301bcb385ef5, var_201462e035644875);
  var_762cb2950158b8be = getdvarint(@ "ob_rift_run", 0);

  foreach(pad in var_a48e67061c191a79) {
    level thread function_ffb92f39c6c65fa3(pad, var_762cb2950158b8be);
  }

  level.var_a48e67061c191a79 = var_a48e67061c191a79;
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_feb0aac1dbef2f07);
}

function function_c917ac9167d1aec0(params) {
  if(getdvarint(@ "hash_9025e7af6f59575d")) {
    thread function_4d1c61defe847197();
  }
}

function function_4d1c61defe847197() {
  self endon("death");
  self endon("disconnect");
  self.var_aae3feeeecfdc77f = [];

  while(true) {
    var_cd7cb9a43134951c = [];

    if(self.sessionstate != "playing") {
      if(self.var_aae3feeeecfdc77f.size > 0) {
        self.var_aae3feeeecfdc77f = var_cd7cb9a43134951c;
      }

      waitframe();
      continue;
    }

    tracedist = self playerads() ? 7500 : 2500;
    tracedistsq = squared(tracedist);

    foreach(pad in level.var_a48e67061c191a79) {
      if(istrue(pad.enabled)) {
        continue;
      }

      if(!isDefined(pad.crystal)) {
        continue;
      }

      if(distancesquared(self.origin, pad.crystal.origin) > tracedistsq) {
        continue;
      }

      var_cd7cb9a43134951c = array_add(var_cd7cb9a43134951c, pad.crystal);
    }

    self.var_aae3feeeecfdc77f = var_cd7cb9a43134951c;
    waitframe();
  }
}

function function_ffb92f39c6c65fa3(pad, var_762cb2950158b8be) {
  pad.can_chain = 0;
  pad.require_activate = 0;
  pad.no_air_control_boost = 0;
  pad.crystal_baked = 0;
  pad.destination = undefined;
  pad.crystal_str = undefined;
  pad.vfx_str = undefined;
  pad.base_str = undefined;
  pad.force_use_cs_crystal = 0;

  if(isDefined(pad.target)) {
    destinations = getStructArray(pad.target, "targetname");

    if(destinations.size == 0) {
      destinations = getnoentvolumearray(pad.target, "targetname");
    }

    if(destinations.size > 0) {
      pad.destination = destinations[0];
    }
  }

  if(isDefined(pad.targetname)) {
    var_1f24992830bc93d3 = getStructArray(pad.targetname, "target");

    foreach(str in var_1f24992830bc93d3) {
      if(is_equal(str.script_label, "crystal") || is_equal(str.script_noteworthy, "crystal")) {
        pad.crystal_str = str;
        continue;
      }

      if(is_equal(str.script_noteworthy, "vfx_pos")) {
        pad.vfx_str = str;
      }
    }
  }

  if(isDefined(pad.script_parameters)) {
    toks = strtok(pad.script_parameters, ",");

    foreach(tok in toks) {
      if(tok == "can_chain") {
        pad.can_chain = 1;
        continue;
      }

      if(tok == "require_activate") {
        pad.require_activate = 1;
        continue;
      }

      if(tok == "no_air_control_boost" || tok == "no_air_control_booster") {
        pad.no_air_control_boost = 1;
        pad.no_sprint_boost = 1;
        continue;
      }

      if(tok == "no_sprint_boost") {
        pad.no_sprint_boost = 1;
        continue;
      }

      if(tok == "no_ai_fling") {
        pad.no_ai_fling = 1;
        continue;
      }

      if(tok == "no_ai_damage_on_player_fling") {
        pad.no_ai_damage_on_player_fling = 1;
        continue;
      }

      if(tok == "force_use_cs_crystal") {
        pad.force_use_cs_crystal = 1;
      }
    }
  }

  if(getdvarint(@ "hash_1ea16fecf27895e6")) {
    pad.require_activate = 0;
  }

  if(1 && !istrue(pad.force_use_cs_crystal)) {
    if(!isDefined(pad.crystal_str) || isDefined(pad.crystal_str) && false) {
      var_d969bd0640ce4701 = getentitylessscriptablearray("launch_pad_crystal_baked", "script_noteworthy", pad.origin, 120);
      var_2e8606cf196a2a01 = [];

      if(isDefined(var_d969bd0640ce4701) && var_d969bd0640ce4701.size > 0) {
        if(var_d969bd0640ce4701.size > 1) {
          var_2c7301e750e84bca = sortbydistance(var_d969bd0640ce4701, pad.origin);

          foreach(crystal in var_2c7301e750e84bca) {
            crystal_mode = crystal.script_parameters;

            if(!isDefined(crystal_mode) || is_equal(crystal_mode, "boss") || is_equal(crystal_mode, "rr") && istrue(var_762cb2950158b8be) || is_equal(crystal_mode, "story") && !istrue(var_762cb2950158b8be)) {
              var_2e8606cf196a2a01 = array_add(var_2e8606cf196a2a01, crystal);
            }
          }
        } else {
          var_2e8606cf196a2a01 = var_d969bd0640ce4701;
        }

        if(var_2e8606cf196a2a01.size > 1) {
          assertmsg("<dev string:x1c>" + pad.origin);
        }

        pad.crystal_str = var_2e8606cf196a2a01[0];
        pad.crystal = pad.crystal_str;
        pad.crystal_baked = 1;
      }
    }
  }

  if(isstruct(pad)) {
    pad.radius = int(isDefined(pad.radius) ? pad.radius : getdvarint(@ "hash_ef377c514d75b06f", 128));
    pad.height = int(isDefined(pad.height) ? pad.height : getdvarint(@ "hash_cf4dacccd7acb0f6", 64));
    pad.trigger = spawn("noent_volume_trigger_radius", pad.origin, 0, pad.radius, pad.height);
  } else {
    pad.trigger = pad;

    if(isDefined(pad.struct) && isDefined(pad.struct.velocity)) {
      pad.velocity = int(pad.struct.velocity);
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.time)) {
      pad.time = float(pad.struct.time);
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.var_665ce2741465d5ea)) {
      pad.var_665ce2741465d5ea = float(pad.struct.var_665ce2741465d5ea);
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.var_8c3312a23a3b6bf4)) {
      pad.var_8c3312a23a3b6bf4 = float(pad.struct.var_8c3312a23a3b6bf4);
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.script_flag)) {
      pad.script_flag = pad.struct.script_flag;
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.script_flag_wait)) {
      pad.script_flag_wait = pad.struct.script_flag_wait;
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.script_flag_set)) {
      pad.script_flag_set = pad.struct.script_flag_set;
    }

    if(isDefined(pad.struct) && isDefined(pad.struct.script_flag_waitopen)) {
      pad.script_flag_waitopen = pad.struct.script_flag_waitopen;
    }
  }

  if(!isDefined(pad.destination)) {
    dest = spawnStruct();
    dest.origin = pad.origin + (0, 0, 1000);
    pad.destination = dest;
  }

  var_1883a3edc5b15f80 = getentitylessscriptablearray("launch_pad_base", "targetname", pad.origin, 300);

  if(isDefined(var_1883a3edc5b15f80) && var_1883a3edc5b15f80.size > 0) {
    pad.linked_base = var_1883a3edc5b15f80.size == 1 ? var_1883a3edc5b15f80[0] : getclosest(pad.origin, var_1883a3edc5b15f80);
    start_state = istrue(pad.require_activate) ? "inactive" : "active";
    pad.linked_base setscriptablepartstate("body", start_state);

    if(isDefined(pad.linked_base.target)) {
      vfx_pos = getStruct(pad.linked_base.target, "targetname");

      if(is_equal(vfx_pos.script_noteworthy, "vfx_pos")) {
        pad.vfx_str = vfx_pos;
      }
    }
  }

  vfx_org = isDefined(pad.vfx_str) && isDefined(pad.vfx_str.origin) ? pad.vfx_str.origin : pad.origin;
  vfx_ang = isDefined(pad.vfx_str) && isDefined(pad.vfx_str.angles) ? pad.vfx_str.angles : pad.angles;

  if(!isDefined(vfx_ang)) {
    vfx_ang = (0, 0, 0);
  }

  pad.var_ac5a476d3b686b35 = spawnscriptable("jup_zm_launch_pad_vfx", vfx_org, vfx_ang);
  pad.var_ac5a476d3b686b35 setscriptablepartstate("pad", "off");

  if(isDefined(pad.crystal_str)) {
    level thread function_7071d8c4fc9f0c3e(pad);
  }

  pad.enabled = !pad.require_activate;
  pad function_c7dfae8ed27c166();
  level thread function_7a4c5fa476b8c295(pad);

  level thread function_d0c3315a161351be(pad);
}

function private function_7a4c5fa476b8c295(pad) {
  pad endon("death");

  if(isDefined(pad.script_flag_wait)) {
    flag_wait(pad.script_flag_wait);
  }

  if(isDefined(pad.script_flag)) {
    flag_wait(pad.script_flag);
  }

  if(isDefined(pad.script_flag_waitopen)) {
    flag_waitopen(pad.script_flag_waitopen);
  }

  while(true) {
    pad.trigger waittill("trigger", ent);

    if(!isPlayer(ent) && !isagent(ent)) {
      continue;
    }

    if(!istrue(pad.enabled)) {
      continue;
    }

    if(isPlayer(ent)) {
      if(!scripts\mp\utility\player::isaliveandnotinlaststand(ent)) {
        continue;
      }

      if(!ent function_bef665ddd5cdfb93(pad)) {
        continue;
      }

      ent thread function_851c837c906cfd56(pad);

      if(isDefined(pad.script_flag_set) && !flag(pad.script_flag_set)) {
        flag_set(pad.script_flag_set);
      }

      continue;
    }

    if(istrue(pad.no_ai_fling)) {
      continue;
    }

    if(isDefined(ent.team) && ent.team != "team_two_hundred") {
      continue;
    }

    if(!isalive(ent) || istrue(ent.marked_for_death)) {
      continue;
    }

    if(isDefined(ent.subclass) && ent.subclass != "zombie_base" && ent.subclass != "zombie_base_armored_light") {
      continue;
    }

    if(!isDefined(ent.enemy)) {
      continue;
    }

    cooldown_time = getdvarfloat(@ "hash_d1b4357cefdb73fe", 3) * 1000;

    if(gettime() - level.var_cdec40a0d6ec935f <= cooldown_time) {
      continue;
    }

    if(!function_c1e510e4c0f48890(ent)) {
      continue;
    }

    level thread function_46370600079f45f1(pad, ent);
  }
}

function function_c1e510e4c0f48890(ent) {
  req_dist = getdvarfloat(@ "hash_de3a12b335032b2f", 1024);
  req_dist = squared(req_dist);

  foreach(player in level.players) {
    if(distancesquared(player.origin, ent.origin) <= req_dist) {
      return true;
    }
  }

  return false;
}

function function_b100b9f08fe3c844() {
  if(!isDefined(self.crystal)) {
    return;
  }

  if(istrue(self.crystal.destroyed)) {
    return;
  }

  function_fdd909210aed2c21(self);
  self.crystal.health = 0;
  level notify("crystal_shattered");
}

function function_28eb14a92896c8e7() {
  if(!isDefined(self.crystal)) {
    return;
  }

  if(!istrue(self.crystal.destroyed)) {
    return;
  }

  function_e28c755fe898008(self);
}

function function_d1b703c9ebf2b990(var_6273bae8074b4bf) {
  self.falldamageprotection = ter_op(var_6273bae8074b4bf, 1, undefined);
}

function private function_f36bcdcbdb462548() {}

function function_7071d8c4fc9f0c3e(pad) {
  if(!isDefined(pad)) {
    return;
  }

  require_activate = pad.require_activate;

  if(1 && istrue(pad.crystal_baked) && !istrue(pad.force_use_cs_crystal)) {} else if(getdvarint(@ "hash_cb729b2d50151b5a")) {
    pad.crystal = spawn("script_model", pad.crystal_str.origin);

    if(require_activate) {
      pad.crystal setModel("jup_gate_crystal_jump_pad_crystal_01_gameplay_ent");
    } else {
      pad.crystal setModel("jup_gate_crystal_jump_pad_crystal_01_broken_gp_ent");
    }

    pad.crystal.angles = pad.crystal_str.angles;
    pad.crystal.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_void_crystal_healthbar");
    pad.crystal.subclass_scriptbundle = getscriptbundle(%"hash_7dd4801342ba19c4");
    pad.crystal.var_1e0eb63ecb3f1e2 = 1;
    pad.crystal.var_4919d15787f01154 = 1;
    health = getdvarint(@ "hash_b4e52282f217c0ae");
    pad.crystal.fake_health = health;
    pad.crystal.max_fake_health = health;
    pad.crystal.health = health;
  } else {
    pad.crystal = spawnscriptable("jup_zm_launch_pad_crystal", pad.crystal_str.origin, pad.crystal_str.angles);
    wait 5;
  }

  pad.crystal.objname = pad.script_noteworthy;
  pad.crystal.struct = pad;

  if(require_activate) {
    pad.crystal setscriptablepartstate("body", "imbued");

    if(isent(pad.crystal)) {
      pad.crystal setCanDamage(1);
    } else {
      function_ed60b416bc63b926(pad);
    }
  } else {
    function_fdd909210aed2c21(pad, 1);
  }

  if(isDefined(pad.script_flag_wait)) {
    pad.crystal.script_flag = pad.script_flag_wait;
  } else if(isDefined(pad.script_flag)) {
    pad.crystal.script_flag = pad.script_flag;
  }

  pad.crystal.vulnerable = require_activate;
}

function function_ed60b416bc63b926(pad) {
  health = getdvarint(@ "hash_b4e52282f217c0ae");
  pad.crystal.health = health;

  if(getdvarint(@ "hash_9025e7af6f59575d")) {
    pad.crystal.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_void_crystal_healthbar");
    pad.crystal.subclass_scriptbundle = getscriptbundle(%"hash_7dd4801342ba19c4");
    pad.crystal.var_1e0eb63ecb3f1e2 = 1;
    pad.crystal.var_4919d15787f01154 = 1;
    pad.crystal.fake_health = health;
    pad.crystal.max_fake_health = health;
    return;
  }

  pad.crystal.invis = spawn("script_model", pad.crystal.origin);
  pad.crystal.invis setModel("jup_gate_crystal_jump_pad_crystal_01_gameplay_invis");
  pad.crystal.invis.angles = pad.crystal.angles;
  pad.crystal.invis.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_void_crystal_healthbar");
  pad.crystal.invis.subclass_scriptbundle = getscriptbundle(%"hash_7dd4801342ba19c4");
  pad.crystal.invis.var_1e0eb63ecb3f1e2 = 1;
  pad.crystal.invis.var_4919d15787f01154 = 1;
  pad.crystal.invis.fake_health = health;
  pad.crystal.invis.max_fake_health = health;
}

function function_83571c0607011124() {
  return isent(self) || getdvarint(@ "hash_9025e7af6f59575d");
}

function function_feb0aac1dbef2f07(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!is_equal(instance.type, "jup_zm_launch_pad_crystal") && !is_equal(instance.type, "jup_zm_launch_pad_crystal_merged")) {
    return;
  }

  if(isDefined(instance.entity)) {
    crystal = instance.entity;
  } else {
    crystal = instance;
  }

  if(crystal function_83571c0607011124()) {
    if(isDefined(crystal.fake_health) && crystal.health != crystal.fake_health) {
      crystal.health = int(crystal.fake_health);
    }
  }

  if(istrue(crystal.vulnerable) && !istrue(crystal.destroyed)) {
    max_health = getdvarint(@ "hash_b4e52282f217c0ae");

    if(weapon::iswonderweapon(objweapon)) {
      if(objweapon.basename == "jup_la_plasmagun_mp" || objweapon.basename == "jup_la_humangun_mp") {
        idamage = max_health;
      } else if(is_equal(crystal.last_damage_time, gettime())) {
        idamage = 0;
      } else {
        idamage = int(max_health / 3) + 1;
      }
    }

    if(is_equal(smeansofdeath, "MOD_MELEE")) {
      idamage = int(max_health / 3) + 1;
    }

    if(isDefined(crystal.health)) {
      crystal.health -= idamage;

      if(isPlayer(eattacker)) {
        instance.var_f49149402765ecae = function_6d6af8144a5131f1(instance.var_f49149402765ecae, eattacker);

        if(mp_agent_damage::function_87c3b43d00319847()) {
          mp_agent_damage::function_c54b2cc2e762c201(eattacker, crystal.eidentifier, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
        }

        eattacker damagefeedback::updatehitmarker("standard", crystal.health <= 0, 0, 0, undefined);
        playFX(level._effect["crystal_impact"], shitloc, vdir);
      }

      if(crystal function_83571c0607011124()) {
        crystal.fake_health = int(max(0, crystal.health));
      }

      if(crystal.health <= 0) {
        thread function_5b8e527be2dda1e8(crystal.origin, 256);
        thread function_fdd909210aed2c21(crystal.struct);

        if(crystal function_83571c0607011124()) {
          crystal.var_1e0eb63ecb3f1e2 = 0;
          crystal.var_15d70cf838211daf = 1;
        }

        level notify("crystal_shattered");
        return;
      }

      if(crystal function_83571c0607011124()) {
        crystal.fake_health = int(max(0, crystal.health));
      } else {
        crystal.invis.fake_health = crystal.health;
      }

      crystal.last_damage_time = gettime();
    }
  }
}

function function_e28c755fe898008(pad) {
  if(isent(pad.crystal)) {
    pad.crystal setModel("jup_gate_crystal_jump_pad_crystal_01_gameplay_ent");
    pad.crystal setCanDamage(1);
    pad.crystal.var_1e0eb63ecb3f1e2 = 1;
  } else if(getdvarint(@ "hash_9025e7af6f59575d")) {
    pad.crystal.var_1e0eb63ecb3f1e2 = 1;
  }

  pad.crystal setscriptablepartstate("body", "imbued");
  pad.crystal setscriptablepartstate("health", "damage_detect");

  if(isDefined(pad.var_ac5a476d3b686b35)) {
    pad.var_ac5a476d3b686b35 setscriptablepartstate("pad", "off");
  }

  if(!isDefined(pad.crystal.invis) && !isent(pad.crystal)) {
    function_ed60b416bc63b926(pad);
  }

  pad.crystal.destroyed = 0;
  pad.crystal.vulnerable = 1;
  pad.enabled = 0;
}

function function_fdd909210aed2c21(pad, pre_destroyed) {
  pad.crystal.destroyed = 1;
  pad.crystal.vulnerable = 0;

  if(pad.crystal function_83571c0607011124()) {
    pad.crystal.var_1e0eb63ecb3f1e2 = 0;

    if(!istrue(pre_destroyed) && !getdvarint(@ "hash_9025e7af6f59575d")) {
      waittillframeend();
      pad.crystal setModel("jup_gate_crystal_jump_pad_crystal_01_broken_gp_ent");
      pad.crystal setCanDamage(0);
    }
  }

  pad.crystal setscriptablepartstate("body", "destroyed");

  if(!isent(pad.crystal)) {
    pad.crystal setscriptablepartstate("health", "ignore_damage");
  }

  earthquake(0.4, 1, pad.crystal.origin, 384);

  if(isDefined(pad.var_ac5a476d3b686b35)) {
    pad.var_ac5a476d3b686b35 setscriptablepartstate("pad", "on");
  }

  pad.enabled = 1;

  if(!isent(pad.crystal) && isDefined(pad.crystal.invis)) {
    pad.crystal.invis.var_1e0eb63ecb3f1e2 = 0;
    waitframe();
    pad.crystal.invis delete();
  }

  if(isDefined(pad.linked_base)) {
    pad.linked_base setscriptablepartstate("body", "active");
  }
}

function private function_5b8e527be2dda1e8(location, radius) {
  level endon("game_ended");
  waitframe();
  explosionzombies = getaiarrayinradius(location, radius, "team_two_hundred");

  foreach(zombie in explosionzombies) {
    if(isalive(zombie)) {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie kill();
    }
  }
}

function private function_db1cce22f95a04fa() {}

function function_bef665ddd5cdfb93(pad) {
  is_sliding = 0;

  if(self isonascender()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(self ishanging()) {
    return false;
  }

  if(self isswimming()) {
    return false;
  }

  if(self function_c36cfe1c6acaef46()) {
    return false;
  }

  if(self isinfreefall()) {
    return false;
  }

  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    return false;
  }

  if(self isparachuting()) {
    if(!isDefined(self.var_7cae9150f1ef36d7) || isDefined(self.var_7cae9150f1ef36d7) && self.var_7cae9150f1ef36d7 != pad) {
      self.var_7cae9150f1ef36d7 = pad;
      thread function_f9e7516d6af85d6f(pad);
    }

    return false;
  }

  if(is_equal(self.var_7cae9150f1ef36d7, pad)) {
    return false;
  }

  if(!self isonground() && !istrue(pad.can_chain)) {
    return false;
  }

  if(self isinexecutionattack() || self isinexecutionvictim()) {
    return false;
  }

  if(self ismantling()) {
    return false;
  }

  if(self issprintsliding()) {
    is_sliding = 1;
  }

  if(!scripts\mp\utility\player::isaliveandnotinlaststand(self)) {
    return false;
  }

  if(self getstance() == "prone") {
    return false;
  }

  if(isDefined(self.carryobject)) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::function_b7869f6d9d4242e3(self)) {
    return false;
  }

  raystart = scripts\mp\utility\player::getstancetop();
  rayend = raystart + anglestoup(self.angles) * 100;
  radius = getdvarint(@ "hash_163d35b2bfad5d11", 14);
  contents = scripts\engine\trace::create_default_contents(1);

  if(getdvarint(@ "hash_be597103cc8aad5f") > 0) {
    level thread scripts\mp\utility\debug::drawsphere(raystart, radius, 10, (0, 1, 0));
    level thread scripts\mp\utility\debug::drawsphere(rayend, radius, 10, (0, 1, 0));
  }

  if(!scripts\engine\trace::sphere_trace_passed(raystart, rayend, radius, self, contents)) {
    return false;
  }

  if(is_sliding) {
    scripts\common\values::set("ob_launch_pad", "slide", 0);
  }

  return true;
}

function function_f9e7516d6af85d6f(pad) {
  self notify("launch_pad_para_cooldown");
  self endon("launch_pad_para_cooldown");
  self endon("fling_start");
  pad endon("fling_start");

  while(self istouching(pad.trigger) && !self isonground()) {
    waitframe();
  }

  if(!is_equal(self.var_7cae9150f1ef36d7, pad)) {
    return;
  }

  if(!self istouching(pad.trigger)) {
    self.var_7cae9150f1ef36d7 = undefined;
    return;
  }

  wait 0.5;

  if(is_equal(self.var_7cae9150f1ef36d7, pad)) {
    self.var_7cae9150f1ef36d7 = undefined;
  }
}

function function_851c837c906cfd56(pad) {
  if(isDefined(self.fling_data) && !istrue(pad.can_chain)) {
    return;
  }

  self.fling_data = undefined;
  self.fling_data = spawnStruct();
  self notify("fling_start");
  pad notify("fling_start");
  self.var_7cae9150f1ef36d7 = undefined;

  if(!ent_flag("used_launch_pad")) {
    ent_flag_set("used_launch_pad");
  }

  function_d1b703c9ebf2b990(1);
  self setscriptablepartstate("launchPadVfx", "jump_begin_lrg", 0);
  self playsoundtoplayer("evt_ob_story_launch_pad_whoosh", self);
  self playsoundtoteam("evt_ob_story_launch_pad_whoosh_npc", self.team, self, self);
  scripts\common\values::set("ob_launch_pad", "allow_jump", 0);
  self skydive_setdeploymentstatus(0);
  thread function_66d7e0a40cf7fec1();

  if(!istrue(self.no_ai_damage_on_player_fling)) {
    thread function_aa2c4d38046f6c4d(pad);
  }

  function_83e096e15c7127a2(pad);

  if(getdvarint(@ "hash_a98666aab2a20f50", 1) && !pad.no_air_control_boost) {
    thread function_65bbdbb02e708c66(pad);
  }

  function_9c5bc8ae78b3d9bc();
  self.fling_data = undefined;
  function_d1b703c9ebf2b990(0);
  self notify("fling_end");
}

function function_66d7e0a40cf7fec1() {
  self notify("flinger_delay_base_jump_allow");
  self endon("flinger_delay_base_jump_allow");
  self endon("death_or_disconnect");
  self endon("fling_end");
  wait 0.25;
  self skydive_setdeploymentstatus(1);
}

function function_aa2c4d38046f6c4d(pad) {
  knockdown = 1;
  var_6d2fd18830e36fde = 150;

  if(knockdown) {
    if(isDefined(pad.radius)) {
      var_6d2fd18830e36fde = pad.radius + 150;
    }
  }

  nearby_zombies = getaiarrayinradius(pad.origin, var_6d2fd18830e36fde, "team_two_hundred");

  foreach(zombie in nearby_zombies) {
    if(isDefined(zombie.team) && zombie.team == self.team) {
      continue;
    }

    if(!isalive(zombie)) {
      continue;
    }

    if(istrue(zombie.marked_for_death)) {
      continue;
    }

    if(isDefined(zombie.subclass) && zombie.subclass != "zombie_base" && zombie.subclass != "zombie_base_armored_light" && zombie.subclass != "zombie_base_armored_heavy") {
      continue;
    }

    if(knockdown) {
      zombie namespace_db1ce2c035564e2c::knockdown_ai(pad.origin);
      continue;
    }

    level thread function_46370600079f45f1(pad, zombie);
  }
}

function function_83e096e15c7127a2(pad) {
  time_override = isDefined(pad.time) ? pad.time : undefined;
  speed_override = isDefined(pad.velocity) ? pad.velocity : undefined;
  var_a78ffefa785281da = function_cac1f36baae94d71(self.origin, pad.destination.origin, time_override, speed_override);
  self setvelocity((0, 0, 0));
  self setOrigin(self.origin + (0, 0, 32), 1, 1);
  waittillframeend();
  self setvelocity(var_a78ffefa785281da);
}

function function_c7dfae8ed27c166() {
  pad = self;
  time_override = isDefined(pad.time) ? pad.time : undefined;
  speed_override = isDefined(pad.velocity) ? pad.velocity : undefined;
  var_a78ffefa785281da = function_cac1f36baae94d71(pad.origin, pad.destination.origin, time_override, speed_override);
  pad.var_dbeb9f1e480c9872 = var_a78ffefa785281da;
}

function function_cac1f36baae94d71(start_pos, end_pos, var_b5cfefcc1a4db88, speed_override) {
  gravity = getdvarint(@ "bg_gravity", 800) * -1;
  gravity_vec = (0, 0, gravity);
  max_speed = getdvarfloat(@ "hash_393af4a8a9128536", 850);
  fling_speed = float(isDefined(speed_override) ? speed_override : max_speed);
  dist = distance(start_pos, end_pos);
  time = isDefined(var_b5cfefcc1a4db88) ? var_b5cfefcc1a4db88 : dist / fling_speed;
  var_a78ffefa785281da = trajectorycalculateinitialvelocity(start_pos, end_pos, gravity_vec, time);
  return var_a78ffefa785281da;
}

function function_9c5bc8ae78b3d9bc() {
  self endon("death_or_disconnect");
  self endon("fling_end");
  level endon("game_ended");

  if(!isDefined(self.fling_data)) {
    return;
  }

  self.fling_data.airtime = 0;
  self.fling_data.in_air = 1;
  self.fling_data.var_bed7e3bad8b86623 = gettime();
  var_bb822bf25ecdbd33 = 0;
  var_62601c1642480674 = 0;
  tear_teleported = 0;
  chute_deployed = 0;
  waitframe();

  while(isDefined(self.fling_data)) {
    if(self isonground() || self isparachuting()) {
      if(!var_62601c1642480674) {
        var_62601c1642480674 = 1;
        scripts\common\values::set("ob_launch_pad", "usability", 1);
        scripts\common\values::set("ob_launch_pad", "allow_jump", 1);
        scripts\common\values::set("ob_launch_pad", "slide", 1);
      }

      if(self isparachuting() && !istrue(chute_deployed)) {
        chute_deployed = 1;
      }

      if(self isonground() && getdvarint(@ "hash_2770a0f3f75c755f", 1) && !istrue(tear_teleported) && !istrue(chute_deployed) && self.fling_data.airtime >= 0.25) {
        thread function_434f4f316f6b5984();
        self.fling_data.airtime = 0;
        break;
      }

      if(self.fling_data.airtime > 0 && var_bb822bf25ecdbd33 >= 3) {
        self.fling_data.airtime = 0;
        break;
      } else if(var_bb822bf25ecdbd33 >= 10) {
        break;
      } else {
        var_bb822bf25ecdbd33++;
      }

      waitframe();
      continue;
    } else if(ent_flag_exist("teleporting") && ent_flag("teleporting") && !istrue(tear_teleported)) {
      tear_teleported = 1;
    } else {
      var_bb822bf25ecdbd33 = 0;
      self.fling_data.airtime += level.framedurationseconds;

      if(var_62601c1642480674) {
        var_62601c1642480674 = 0;
        scripts\common\values::set("ob_launch_pad", "usability", 0);
        scripts\common\values::set("ob_launch_pad", "allow_jump", 0);
        scripts\common\values::set("ob_launch_pad", "slide", 0);
      }
    }

    waitframe();
  }

  scripts\common\values::set("ob_launch_pad", "usability", 1);
  scripts\common\values::set("ob_launch_pad", "allow_jump", 1);
  scripts\common\values::set("ob_launch_pad", "slide", 1);
  self skydive_setdeploymentstatus(1);
  self.fling_data.in_air = 0;
}

function function_65bbdbb02e708c66(pad) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("fling_aircontrol_boost_start");
  self endon("fling_aircontrol_boost_start");
  self endon("fling_end");
  var_4992594dd7ee57b6 = float(isDefined(pad.var_665ce2741465d5ea) ? pad.var_665ce2741465d5ea : getdvarfloat(@ "hash_8c6980cc1eec0687", 750));

  if(var_4992594dd7ee57b6 <= 0) {
    return;
  }

  maxspeed = float(isDefined(pad.var_8c3312a23a3b6bf4) ? pad.var_8c3312a23a3b6bf4 : getdvarfloat(@ "hash_90a082c8af3ac59b", 1400));
  wait 0.2;
  var_7c92c8000eb99c1a = getdvarint(@ "hash_82e34749b3f546a4", 1);
  max_scale = getdvarfloat(@ "hash_2e12e44edb45acd3", 1);
  min_scale = getdvarfloat(@ "hash_2e35fa4edb6c24ed", 0.15);

  while(isDefined(self.fling_data) && istrue(self.fling_data.in_air)) {
    movementinput = self getnormalizedmovement();

    if(length(movementinput) > 0) {
      worlddir = rotatevector((movementinput[0], -1 * movementinput[1], 0), self.angles);

      if(var_7c92c8000eb99c1a) {
        todest = pad.destination.origin - self.origin;
        var_cc9b94b9fe4f5772 = vectordot2(todest, worlddir, 1);
        var_67158aa7418fe400 = clamp(1 - abs(var_cc9b94b9fe4f5772), min_scale, max_scale);
      } else {
        var_67158aa7418fe400 = 1;
      }

      velocity = self getvelocity();
      speed = length(velocity);
      var_3b61b63c7e59f697 = worlddir * var_4992594dd7ee57b6 * level.framedurationseconds;
      newvel = velocity + var_3b61b63c7e59f697 * var_67158aa7418fe400;
      newspeed = length(newvel);

      if(newspeed <= maxspeed) {
        self setvelocity(newvel);
      } else if(speed < maxspeed) {
        newvel = vectorNormalize(newvel) * maxspeed;
        self setvelocity(newvel);
      }
    }

    waitframe();
  }
}

function function_434f4f316f6b5984() {
  self radiusdamage(self.origin, 256, function_52bbd31a09224e8e(), 50, self, "MOD_CRUSH", "high_jump_mp");
  thread function_79029536ae439038();
}

function function_52bbd31a09224e8e() {
  var_5712f5f091e168f4 = getdvarfloat(@ "hash_ce56b1cbc245ce62", 3);

  if(!isDefined(self.fling_data) || !isDefined(self.fling_data.airtime) || var_5712f5f091e168f4 == 0) {
    return 50;
  }

  multfactor = clamp(self.fling_data.airtime / var_5712f5f091e168f4, 0, 1);
  return 500 * multfactor;
}

function function_79029536ae439038() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("launchPadVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("launchPadVfx", "off", 0);
}

function private function_b1eab7c7fda1fb57() {}

function private debug_init() {
  level waittill("<dev string:x4c>");
  level thread function_db5c75f2a84ff03d();
  level thread function_8791d428b8124c1d();
}

function private function_db5c75f2a84ff03d() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x5e>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x71>", @ "hash_be597103cc8aad5f");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x7a>", @ "hash_1ea16fecf27895e6");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x92>", @ "hash_e6d0f35a459f1461");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:xac>", @ "hash_393af4a8a9128536");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:xbb>", @ "hash_163d35b2bfad5d11");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:xd2>", @ "hash_b4e52282f217c0ae");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:xe4>", @ "hash_a98666aab2a20f50");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x107>", @ "hash_8c6980cc1eec0687");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x129>", @ "hash_90a082c8af3ac59b");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x14e>", @ "hash_82e34749b3f546a4");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x183>", @ "hash_2e35fa4edb6c24ed");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x1b4>", @ "hash_2e12e44edb45acd3");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x1e5>", @ "hash_2770a0f3f75c755f");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x20a>", @ "hash_ce56b1cbc245ce62");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_8791d428b8124c1d() {
  while(true) {
    if(getdvarint(@ "hash_1ea16fecf27895e6")) {
      foreach(pad in level.var_a48e67061c191a79) {
        if(!istrue(pad.enabled)) {
          pad function_b100b9f08fe3c844();
        }
      }

      setDvar(@ "hash_1ea16fecf27895e6", 0);
    } else if(getdvarint(@ "hash_e6d0f35a459f1461")) {
      foreach(pad in level.var_a48e67061c191a79) {
        if(istrue(pad.enabled)) {
          pad function_28eb14a92896c8e7();
        }
      }

      setDvar(@ "hash_e6d0f35a459f1461", 0);
    }

    waitframe();
  }
}

function private function_d0c3315a161351be(pad) {
  pad.trigger endon("<dev string:x23f>");

  while(true) {
    if(getdvarint(@ "hash_be597103cc8aad5f") > 0) {
      if(getdvarint(@ "hash_be597103cc8aad5f") == 2) {
        if(isDefined(level.players[0]) && distancesquared(level.players[0].origin, pad.origin) > 9000000 && distancesquared(level.players[0].origin, pad.destination.origin) > 9000000) {
          wait 1;
          continue;
        }
      }

      enabled = 1;

      if(isDefined(pad.script_flag_wait) && !flag(pad.script_flag_wait) || isDefined(pad.script_flag) && !flag(pad.script_flag) || isDefined(pad.script_flag_waitopen) && flag(pad.script_flag_waitopen) || !istrue(pad.enabled)) {
        enabled = 0;
      }

      color = istrue(enabled) ? (0, 1, 0) : (1, 0, 0);
      drawtrigger(pad.trigger, color, undefined, 30);

      if(isDefined(pad.destination)) {
        function_a28332914799904(pad, enabled, 30);
      }
    }

    wait 1;
  }
}

function private function_a28332914799904(pad, enabled, frames) {
  start_pos = pad.origin + (0, 0, 20);
  end_pos = pad.destination.origin;
  color = istrue(enabled) ? (0, 1, 0) : (1, 0, 0);
  basic_draw = 0;
  sphere(end_pos, 4, color);

  if(basic_draw) {
    line(start_pos, end_pos, color);
    return;
  }

  gravity = getdvarint(@ "bg_gravity", 800) * 1;
  fling_speed = float(isDefined(pad.velocity) ? pad.velocity : getdvarfloat(@ "hash_393af4a8a9128536", 850));
  dist = distance(start_pos, end_pos);
  time = dist / fling_speed;

  if(isDefined(pad.time)) {
    time = float(pad.time);
  }

  var_d610f95947234a0e = trajectorycomputedeltaheightattime(pad.var_dbeb9f1e480c9872[2], gravity, 0.5 * time);
  num_lines = 32;
  time_interval = time / num_lines;
  prev_point = start_pos;

  for(i = 1; i <= num_lines; i++) {
    var_a2e3df99acffe2ec = i * time_interval / time;
    var_a20514fa823e804a = scripts\engine\math::get_point_on_parabola(start_pos, end_pos, abs(var_d610f95947234a0e), var_a2e3df99acffe2ec);

    if(getdvarint(@ "hash_be597103cc8aad5f") == 2 && isDefined(pad.radius)) {
      cylinder(prev_point, var_a20514fa823e804a, pad.radius, color, 0, frames);
    } else {
      line(prev_point, var_a20514fa823e804a, color, 1, 0, frames);
    }

    prev_point = var_a20514fa823e804a;
  }
}

function private function_4b22a2959a7c7bd3() {}

function function_e7464c84b604e286() {
  var_d0218d23e13f7b52 = randomintrange(0, 4);

  switch (var_d0218d23e13f7b52) {
    case 0:
      return "left_foot";
    case 1:
      return "right_foot";
    case 2:
      return "left_hand";
    case 3:
      return "right_hand";
  }
}

function function_46370600079f45f1(pad, ent) {
  var_6aae96c5753a676d = function_e7464c84b604e286();
  ent.no_powerups = 1;
  ent.marked_for_death = 1;
  ent kill();
  waitframe();
  corpse = ent getcorpseentity();

  if(isDefined(corpse)) {
    corpse startragdollfromimpact(var_6aae96c5753a676d, pad.var_dbeb9f1e480c9872 * 13000);
    level.var_cdec40a0d6ec935f = gettime();
    playsoundatpos(ent.origin + (0, 0, 40), "evt_ob_story_launch_pad_whoosh_npc");
  }
}